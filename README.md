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

### Operational note — log in to Overleaf first

The button submits a `POST` to `https://www.overleaf.com/docs` with the converted `.tex` as the request body. If you are not logged in to Overleaf when you click, Overleaf intercepts the request with a login redirect, and the body of the original `POST` is lost in the round-trip. The result is a project that is created but inconsistent — typically with the title preserved (taken from `\title{}` before the redirect consumed the body) but with body content missing or unrelated.

**Always make sure you are logged in to Overleaf in the same browser session before clicking ↗ Overleaf.** Open `overleaf.com` in another tab, confirm you are logged in, then click the button. The new tab will open the project directly without an auth detour.

### Known limitations of the Markdown→LaTeX converter

The converter is a bridge for Markdown + LaTeX math, not a full Markdown implementation. The following Markdown constructs are **not supported** and either render as literal text or render in a degraded way. For any of these, write your Markdown in the editor for the parts the converter handles, click ↗ Overleaf, and finish in Overleaf using full LaTeX:

- **Tables.** Markdown table syntax (`| col1 | col2 |`, etc.) is not parsed — the lines render as plain text with the pipes preserved. Use LaTeX `tabular` or `array` directly in Overleaf.
- **Images.** `![alt](url)` is not handled as an image — the leading `!` falls outside the link regex, so it appears literally and the rest is captured as a regular hyperlink. Use `\includegraphics` in Overleaf.
- **Inline HTML.** Tags like `<strong>`, `<em>`, `<br>` are not interpreted — they render as literal text (`[T1]{fontenc}` makes `<` and `>` print correctly).
- **URLs containing parentheses.** The link regex captures up to the first `)`, so `[text](https://example.com/path(with)parens)` truncates the URL at the inner `)` and leaves the rest as trailing text. Escape the parentheses in the URL or use `\href` in Overleaf.
- **Raw LaTeX commands outside math.** Anything like `\textbf{...}`, `\section{...}`, `\begin{...}` typed directly in the editor (outside `$...$` or `$$...$$`) is treated as plain text and escaped — `\textbf{x}` renders literally, not as bold. The bridge only passes LaTeX through inside math delimiters. For prose-level LaTeX, write Markdown in the editor and finish in Overleaf.
- **Nested lists.** Only top-level bullets (`- item` at column 0) and top-level enumerations (`1. item`) are recognised. Indented children (`  - child`) fall through as plain text. Use LaTeX `itemize`/`enumerate` nesting in Overleaf.
- **Adjacent mixed lists.** A bulleted list immediately followed by an enumerated list (no blank line between) renders as two separate environments adjacent without explicit visual separation.

What **is** supported and converts cleanly: headings (`#` to `####` → `\section` / `\subsection` / `\subsubsection` / `\paragraph`), bold (`**...**`), italic (`*...*`), inline code (`` `...` ``), fenced code blocks (` ```lang `), links (`[text](url)`) where the URL has no inner parentheses, top-level itemize and enumerate lists, blockquotes, horizontal rules (`---` on its own line), inline math (`$...$`), display math (`$$...$$`), Markdown-escaped dollar signs (`\$` → literal `$`), all Latin special characters via the `[T1]{fontenc}` preamble, and the standard escaped specials (`& % _ # ^ ~ \ { }`) inside paragraph text.

## Recommended workflow

- Publish papers on **Common Ground** (or arXiv, Zenodo, etc.) and copy the DOI.
- Paste the DOI(s) per tab via *Set source* — multiple documents can be added to the same tab.
- Write reflections, paste AI critiques, develop ideas in the editor below.
- Export periodically as a JSON backup.
