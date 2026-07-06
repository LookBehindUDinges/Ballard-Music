# Learning notes — from building Ballard.Music

A running reference of things that came up while building the artist site. Nothing here is required reading; just skim when a term looks familiar and you want the "what is this?" answer.

---

## File & folder concepts

**File path**
A file's full address on your computer. Windows uses backslashes: `C:\Users\Owner\.claude\Claude Code Projects\Development\Artist Website\index.html`. Everything before the last backslash is the folder; the last part is the file itself.

**Working directory**
The folder a program is "in" when it runs. When you open PowerShell it starts in one. When Claude Code starts, it treats one specific folder as home base — that affects what files it looks at by default.

**Hidden folders (start with `.`)**
Folders that begin with a dot (`.git`, `.claude`, `.gitignore`) are hidden by convention. File Explorer doesn't show them unless you turn on "Hidden items" in the View menu. They're usually for tools, not humans — you don't edit them directly.

**Temp folder**
`C:\Users\Owner\AppData\Local\Temp` — Windows' scratch pad for throwaway files. Programs write intermediate stuff here. Safe to ignore; Windows cleans it out eventually.

**File extensions (`.html`, `.css`, `.js`, `.md`, `.zip`, `.docx`)**
The letters after the dot in a filename. They tell your computer (and you) what kind of file it is. Renaming the extension doesn't change what's inside — a `.html` renamed to `.txt` is still HTML, just labeled wrong.

---

## Web basics

**HTML**
The skeleton of a webpage. Defines *what* is on the page: headings, paragraphs, links, images. Files end in `.html`.

**CSS**
The style layer. Defines *how* the HTML looks: colors, fonts, spacing, layout. Files end in `.css`.

**JavaScript (JS)**
The behavior layer. Adds interactivity: clicking a button, filling a form, animation. Files end in `.js`.

**Static site**
A website that's just pre-made HTML/CSS/JS files served as-is. No database, no server-side code, no logins. Ballard.Music is static. Fast, cheap, and hard to break.

**Dynamic site**
A site where pages are built on the fly based on data (like Facebook, or an online store). Requires a server that runs code and usually a database. More powerful, more moving parts.

**Domain name**
The address people type: `ballard.music`, `google.com`. You rent it from a registrar (Cloudflare, GoDaddy, Namecheap).

**DNS**
The phonebook of the internet. Translates a domain (`ballard.music`) into the actual server address (`123.45.67.89`). When you point a domain at Cloudflare Pages, you're editing DNS entries.

**pages.dev**
Cloudflare's "free subdomain" for Pages projects. Every project gets one automatically (`ballard-music.pages.dev`) even before you connect a custom domain. Great for testing.

---

## Hosting

**Cloudflare Pages**
Cloudflare's free static-site host. You upload HTML/CSS/JS files (either as a zip, a folder, or via a git connection) and it serves them worldwide from fast servers. What Ballard.Music runs on.

**Deploy**
The moment your code goes from your machine to the live server where the internet can see it. "Deploying" a site = pushing the current version live.

**Direct upload vs. Git integration**
Two ways to get a Pages site online:
- **Direct upload**: drag a zip/folder into Cloudflare. Simple; you re-upload every time you change something.
- **Git integration**: connect a GitHub repo. Every time you push a change to GitHub, Cloudflare rebuilds automatically. Slightly more setup, way easier long-term.

**Worker name / Project name**
The identifier Cloudflare uses for your project. Becomes part of the `pages.dev` URL. Pick something you'd type — `ballard-music` beats `solitary-paper-8e23`.

---

## Git & GitHub

**Git**
A tool that tracks every change to your files over time. Lets you go back to any past state, see what changed, work with others without stepping on each other. Runs locally on your machine.

**Repository (repo)**
A project folder that git is tracking. Contains a hidden `.git` folder that holds all the history.

**Commit**
A saved snapshot of your project at one moment, with a note about what changed. Building block of git history. Our site has three commits so far ("Initial scaffold", "Warm up the palette", "Add psychedelic tie-dye accent").

**GitHub**
An online home for git repositories. Lets you back up your project, share it, and connect it to services like Cloudflare Pages for auto-deploy. Git is the tool; GitHub is one popular place to store git repos.

**`.gitignore`**
A file that tells git "don't track these files." Used for junk you don't want in the history — temp files, personal settings, secrets.

---

## Terminal / command line

**Command line / terminal / shell / PowerShell**
Overlapping names for the text-based way to control your computer. Instead of clicking, you type commands. PowerShell is Windows' default. It's what Claude Code uses under the hood for a lot of tasks.

**Directory**
Old-school word for a folder. `cd` = "change directory" = move into a folder.

**`ls` / `dir`**
List the files in the current folder. `ls` on Mac/Linux, `dir` on Windows (both work in PowerShell).

---

## Text editors & IDEs

**Text editor**
A program for writing plain text and code (VS Code, Notepad, Sublime). Different from Word — it doesn't add formatting; every character is exactly what you see.

**IDE (Integrated Development Environment)**
A text editor plus extra tools built in (syntax highlighting, running code, git integration). VS Code is the most common one.

**Claude Code**
An AI assistant that runs in your terminal and can read/edit your project files, run commands, and preview websites. What we've been using.

---

## Files formats you've seen

**`.md` (Markdown)**
Plain text with light formatting shortcuts. Great for notes, READMEs, and anything you want readable both in a text editor and when converted to a webpage or Google Doc.

**`.zip`**
A single file that contains a whole folder's worth of files, compressed. Useful for sending or uploading many files at once (like the site upload to Cloudflare).

**`.json`**
A structured way to store settings and data. Looks like `{ "name": "value" }`. Machine-readable but reasonably human-friendly.

**`.ps1`**
A PowerShell script — instructions PowerShell can run. Our `serve.ps1` is a tiny one that spins up a local preview server.

---

## Concepts specific to this site

**Preview server**
A little program running on your own computer that serves the site at `http://localhost:8787` so you can view it in a browser during development. Only *you* can see it — nobody else on the internet. Cloudflare Pages replaces this once the site is live.

**Localhost**
Nickname for "this computer, right here." `http://localhost:8787` means "port 8787 on my own machine."

**Placeholder content**
Fake text/images left in the site as reminders of what to fill in later. Every "Track title" and "Placeholder — replace with…" note on the current site is placeholder content.

**Mailto link**
A link that opens the visitor's email app pre-filled with a recipient/subject/body. The commissions form uses one — no backend needed, but only works if the visitor has an email app configured.

---

## Rules of thumb

- **Files you'll interact with should live where you can find them.** Buried in `AppData\Local\Temp` is bad; sitting in your project folder is good.
- **Commit early, commit often.** Small git commits are easier to understand and undo than giant ones.
- **Never edit inside a hidden folder like `.git` by hand.** Let the tools do it.
- **When in doubt, take a screenshot and ask.** Faster than trying to describe a UI in words.
- **Placeholders are technical debt.** They're fine short-term, but replacing them is what makes a site feel real.

---

*This file lives at `Development/Artist Website/Learning Notes.md`. Ask Claude to add to it any time a new concept comes up.*
