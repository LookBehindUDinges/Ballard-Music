Add-Type -AssemblyName System.Drawing

$srcDir = "C:\Users\Owner\Pictures\Images"
$destDir = "C:\Users\Owner\.claude\Claude Code Projects\Development\Artist Website\assets\photos"
$maxDim = 1600
$quality = 82L

$map = @{
  "ED366AB4-B9BE-4483-AB87-523A70527541_G1A0253.JPEG"                   = "portrait-sesame.jpg"
  "18A65687-EC7F-49F8-BC94-CEDD7C02952EIMG_3881.JPEG"                   = "live-fullers-guitar.jpg"
  "1EF0A6F5-0EEA-4BCD-8093-04C901EC82F3IMG_3883.JPEG"                   = "live-with-bandmate.jpg"
  "8CC2AA64-724C-4F1A-B87C-9998F5A0EDEDUntitled_2.10.1.JPEG"            = "live-blue-stage.jpg"
  "E5679833-3E8B-4404-AC3D-9E5CE804BC17IMG_3301.jpeg"                   = "candid-mint-guitar.jpg"
  "0C639839-FB74-4EAD-B415-F9AE0303B3C6JOJ XMAS-29.JPEG"                = "live-xmas-show.jpg"
}

$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, $quality)

foreach ($name in $map.Keys) {
  $srcPath = Join-Path $srcDir $name
  $destPath = Join-Path $destDir $map[$name]

  $img = [System.Drawing.Image]::FromFile($srcPath)

  # Respect EXIF orientation so photos aren't sideways
  if ($img.PropertyIdList -contains 0x0112) {
    $orientation = $img.GetPropertyItem(0x0112).Value[0]
    switch ($orientation) {
      3 { $img.RotateFlip([System.Drawing.RotateFlipType]::Rotate180FlipNone) }
      6 { $img.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone) }
      8 { $img.RotateFlip([System.Drawing.RotateFlipType]::Rotate270FlipNone) }
    }
  }

  $ratio = [Math]::Min([double]$maxDim / $img.Width, [double]$maxDim / $img.Height)
  if ($ratio -lt 1) {
    $newW = [int]($img.Width * $ratio)
    $newH = [int]($img.Height * $ratio)
  } else {
    $newW = $img.Width
    $newH = $img.Height
  }

  $bitmap = New-Object System.Drawing.Bitmap($newW, $newH)
  $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
  $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $graphics.DrawImage($img, 0, 0, $newW, $newH)
  $graphics.Dispose()
  $img.Dispose()

  $bitmap.Save($destPath, $jpegCodec, $encParams)
  $bitmap.Dispose()

  $origSize = [Math]::Round((Get-Item $srcPath).Length / 1MB, 2)
  $newSize = [Math]::Round((Get-Item $destPath).Length / 1KB, 0)
  Write-Output "$($map[$name]): ${origSize}MB -> ${newSize}KB ($newW x $newH)"
}
