# U-Mentalism — Research Notebook

Operational manual for the notebook hosted at **[www.u-mentalism.com](https://www.u-mentalism.com)**.

Maintained as an independent research project by Luís Homem, PhD ([ORCID 0000-0003-3520-1489](https://orcid.org/0000-0003-3520-1489)).

For the project's identification and scope, see the live site. This file documents how the notebook is built, configured, stored, and synced — material that previously lived in the in-site *About* panel and was moved here so the *About* could keep an institutional shape.

---

## How storage works

Reflections live in your browser's `localStorage`. PDF URLs are also stored there. Nothing is sent anywhere — everything stays on your device. To move data between machines, use **Export** / **Import**.

## PDFs & Repository at the top of each tab

Each tab can display one or more PDFs (configured by DOI or URL) and link to a GitHub repository or directory. The author hosts each document (**Common Ground**, own server, arXiv, Drive direct-link, etc.) and pastes its DOI via *Set source*. The site accepts:

- A bare DOI: `10.XXXX/XXXXX`
- A resolved DOI URL: `https://doi.org/10.XXXX/XXXXX`
- Any direct PDF URL
- An optional GitHub URL pointing to a repository, file, or directory (shows as **↗ Code**)

When two or more documents are attached to the same tab, a *chip strip* appears above the viewer; click a chip to switch the active document, or click the `×` on a chip to remove it. Visitors read the active document inline and use **↓ Download** to retrieve a copy. When a DOI is given, it is shown in the status line and resolves via `doi.org`.

## GitHub

The site footer links to [github.com/U-Mentalism](https://github.com/U-Mentalism). Per-tab repository links can point to any path within any repo there (e.g. `/U-Mentalism/assembly`, `/U-Mentalism/blockchain`, etc.). The notebook itself is hosted as a static file inside [U-Mentalism/U-Mentalism.github.io](https://github.com/U-Mentalism/U-Mentalism.github.io) via GitHub Pages.

## GitHub Sync (optional)

Reflections can be committed automatically to a chosen repo via the **⚙ Sync** button in the sidebar. Single-author setup using a [fine-grained Personal Access Token](https://github.com/settings/personal-access-tokens) scoped to a single repo, with *Contents: Read and write* only. Each tab is stored as `reflections/NN.md`; auto-push commits after every Save, or push/pull manually. The notebook works offline either way; sync just keeps a Git-versioned mirror.

The token is kept in the browser's `localStorage`. Revoke it from GitHub at any time. Single-user use only.

### Repository layout

The notebook expects (and will create) this structure on first push:

```
{repo}/
├── reflections/
│   ├── 01.md   ← Philosophia Naturalis / Artificialis
│   ├── 02.md   ← Computer Architecture & Photonics
│   ├── 03.md   ← Universal Assembly Language
│   ├── 04.md   ← Blockchain Economy
│   ├── 05.md   ← Cities & Energy
│   ├── 06.md   ← Ethics & Neuroscience
│   ├── 07.md   ← Enlightenment / Cybernetica
│   └── 08.md   ← Indice / Codex
└── (anything else you keep in the repo: site, docs, code, etc.)
```

## Markdown & LaTeX

Use standard Markdown for structure. Use `$...$` for inline math and `$$...$$` for display math. The in-browser engine is **KaTeX** — fast, but math-only (no `\usepackage`, no TikZ, no full LaTeX). Examples:

- `$E = mc^2$` renders inline
- `$$\int_0^\infty e^{-x^2}\,dx = \frac{\sqrt{\pi}}{2}$$` renders centered

## Full LaTeX via Overleaf

For real LaTeX with packages (TikZ, biblatex, etc.), each tab has an **↗ Overleaf** button. It converts the section to a complete `.tex` document with a standard preamble (amsmath, amssymb, mathtools, graphicx, hyperref, geometry, microtype, enumitem) and posts it to Overleaf, opening a new project pre-filled. From there, add any `\usepackage{...}` you need.

*Markdown→LaTeX conversion is approximate; review plain-text paragraphs for stray characters and clean up in Overleaf as needed.*

## Recommended workflow

- Publish papers on **Common Ground** (or arXiv, Zenodo, etc.) and copy the DOI.
- Paste the DOI(s) per tab via *Set source* — multiple documents can be added to the same tab.
- Write reflections, paste AI critiques, develop ideas in the editor below.
- Export periodically as a JSON backup.
