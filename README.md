# U.M. — Research Notebook

A long-form research notebook for the U-Mentalism project.

## About

U-Mentalism (U.M.) is a new computer architecture and supercomputation model that proposes to replace the binary code with the (isomorphic) RGB colour model — processing typical digital images "frames" and "films" at the pixel level, in cinematic fashion, via networks of Universal Turing-machines on the Internet. It is the subject of an international patent (WO2021/235960 A2; priority 20 May 2020) and has received gold medals at international invention exhibitions in Geneva (2023), Macao (2023), Istanbul (2025), Ankara (2025), and others.

This repository hosts an in-browser research notebook organised around eight thematic sections of the project. Each section pairs a primary document (PDF or DOI) at the top with an editable reflections space below — supporting Markdown, LaTeX (via KaTeX), and one-click export to Overleaf for full LaTeX compilation. Reflections are auto-committed to this repo via the GitHub API (single-author setup), making the repo both site and archive of the project's evolving thought.

## Notebook structure

|   | Title | Subtitle |
|---|---|---|
| I | *Philosophia Naturalis / Philosophia Artificialis* | On nature and the artificial |
| II | Computer Architecture & Photonics | An advanced computational model |
| III | Universal Assembly Language | Universal Assembly Programming Language |
| IV | Blockchain Economy | Trust, ledger, and the form of value |
| V | Cities & Energy | Integrating solar energy, photonics, and computation |
| VI | Ethics & Neuroscience | The mind, the brain, and moral inquiry |
| VII | *Enlightenment / Cybernetica* | Cultural studies between the classical and the cybernetic |
| · | *Indice / Codex* | Addendum — frame, film, code |

The three Latin / hybrid pairs (I, VII, ·) form a deliberate progression: from the ontology of nature versus artifice, through the historical comparison of classical and cybernetic Enlightenments, to the semiotics of the indexical sign (the image as causal trace of light, after Peirce) and the discrete codex (the encoded text).

## Related repositories

- [`U-Mentalism/U.-M.-Assembly-Programming-Language`](https://github.com/U-Mentalism/U.-M.-Assembly-Programming-Language) — the Universal Assembly Programming Language. Linked from Tab III.

## How the notebook works

The site is a single HTML file. By default, reflections are stored in the browser's `localStorage`. Optional GitHub sync (configurable via the **⚙ Sync** button in the sidebar) commits each reflection to `reflections/NN.md` in this repo on every save, using a fine-grained Personal Access Token. See the **About** modal in the sidebar for full details.

The repository structure:

```
.
├── index.html              # the notebook
├── reflections/
│   ├── 01.md               # Tab I  — Philosophia Naturalis / Artificialis
│   ├── 02.md               # Tab II  — Computer Architecture & Photonics
│   ├── 03.md               # Tab III — Universal Assembly Language
│   ├── 04.md               # Tab IV  — Blockchain Economy
│   ├── 05.md               # Tab V   — Cities & Energy
│   ├── 06.md               # Tab VI  — Ethics & Neuroscience
│   ├── 07.md               # Tab VII — Enlightenment / Cybernetica
│   └── 08.md               # Tab · (Addendum) — Indice / Codex
├── assets/
│   └── logo.png            # U.M. logo (transparent, 1262×1805)
├── 404.html                # error page
├── README.md
└── LICENSE
```

## Patent and key publications

- Luís Homem, "U-Mentalism Patent: the beginning of cinematic supercomputation", *International Journal of Web & Semantic Technology* 12 (2021), pp. 1–18.
- Luís Homem, "What is U-Mentalism?", *Journal of Advances in Computer Networks* 7 (2019), pp. 18–24.
- International Patent Application: **WO2021/235960 A2** (priority 20 May 2020). National applications in Europe (EP21730302.3), USA (US17/997,391), Canada (CA3181799), India (IN202247061191), and Japan (JP2022-571258).

## License

This work is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/) (CC BY-NC-SA 4.0). See `LICENSE` for full terms.

## Acknowledgements

Inventor: **Luís Homem**.

Acknowledgements to IT Consultant Bruno Costa, and Science Managers Diogo Anjos and Flávio Azevedo, for their work, help and support.
