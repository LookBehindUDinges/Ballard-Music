$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = 8787
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$port/"

$mime = @{
  ".html" = "text/html"; ".css" = "text/css"; ".js" = "application/javascript";
  ".json" = "application/json"; ".png" = "image/png"; ".jpg" = "image/jpeg";
  ".jpeg" = "image/jpeg"; ".svg" = "image/svg+xml"; ".ico" = "image/x-icon";
  ".webmanifest" = "application/manifest+json"
}

while ($listener.IsListening) {
  $context = $listener.GetContext()
  try {
    $request = $context.Request
    $response = $context.Response
    $path = $request.Url.LocalPath
    if ($path -eq "/") { $path = "/index.html" }
    $filePath = Join-Path $root $path.TrimStart("/")

    $isHead = $request.HttpMethod -eq "HEAD"

    if (Test-Path $filePath -PathType Leaf) {
      $ext = [System.IO.Path]::GetExtension($filePath)
      $contentType = $mime[$ext]
      if (-not $contentType) { $contentType = "application/octet-stream" }
      $bytes = [System.IO.File]::ReadAllBytes($filePath)
      $response.ContentType = $contentType
      $response.ContentLength64 = $bytes.Length
      if (-not $isHead) { $response.OutputStream.Write($bytes, 0, $bytes.Length) }
    } else {
      $notFound = [System.Text.Encoding]::UTF8.GetBytes("Not found: $path")
      $response.StatusCode = 404
      $response.ContentLength64 = $notFound.Length
      if (-not $isHead) { $response.OutputStream.Write($notFound, 0, $notFound.Length) }
    }
  } catch {
    Write-Host "Request error on $($request.HttpMethod) $($request.Url.LocalPath): $_"
  } finally {
    $context.Response.OutputStream.Close()
  }
}
