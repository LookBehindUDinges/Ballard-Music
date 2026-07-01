# Benjamin Ballard — artist site

Plain static HTML/CSS/JS, no build step. Deploys to Cloudflare Pages the same way as the komorebi site.

## Structure

- `index.html` — home
- `music.html` — music portfolio (swap the `.embed-frame` divs for real YouTube/Spotify/SoundCloud/Bandcamp iframes)
- `about.html` — bio
- `commissions.html` — commission request form (opens an email via `mailto:`, no backend)
- `blog.html` — updates (duplicate a `.post-item` block to add a new entry)
- `contact.html` — contact links
- `styles.css`, `script.js` — shared styles/behavior

Everything marked "Placeholder" in the pages is meant to be replaced with real content/images.

## Deploying to Cloudflare Pages

1. Create a new GitHub repo (e.g. `ballard-music-site`) and push this folder to it.
2. In the Cloudflare dashboard: **Workers & Pages → Create → Pages → Connect to Git**, select the repo.
3. Build settings: no build command, output directory `/` (this is a plain static site).
4. Deploy. Cloudflare gives you a `*.pages.dev` URL immediately.
5. To use `ballard.music`: **Pages project → Custom domains → Set up a custom domain**, then follow the DNS steps (if the domain's registrar isn't already Cloudflare, you'll need to add it as a Cloudflare zone first).

## Local preview

Just open `index.html` in a browser, or serve the folder with any static file server.
