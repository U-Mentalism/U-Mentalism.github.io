// =========================================================================
// cabula-datelines.js
//
// Retroactive dateline cheat-sheet for U-Mentalism Reflections.
//
// Purpose: list, for each reflections/NN.md, the commit history with
// SHA, date in Europe/Lisbon, Unix epoch, commit message and a direct
// link to the commit on GitHub. The author uses this output as a
// reference while manually inserting "**Lisbon, <date>** · Unix: <epoch>"
// datelines into the existing Reflections — preserving editorial control
// over which bursts belong to the same entry vs. separate entries
// (something a diff parser cannot infer).
//
// Usage:
//   1. Open https://www.u-mentalism.com in any browser where Sync is
//      configured (PAT present in localStorage under umentalism:gh-settings).
//   2. Open the browser console (F12 / Cmd+Option+I).
//   3. Paste the entire contents of this file and press Enter.
//   4. Output prints to the console, one section per tab. Right-click
//      the GitHub commit URL to open in a new tab and see the diff.
//
// Optional flags (edit before pasting if desired):
//   - ONLY_TAB_ID:   set to a number 1..8 to limit to a single tab.
//   - INCLUDE_PATCH: set to true to fetch each commit's patch and show
//                    the first 5 added lines. Slower (~1 extra API call
//                    per commit) but gives more context. Default: false.
//
// No data is written back to GitHub by this script. Read-only.
// =========================================================================

(async () => {
  const ONLY_TAB_ID   = null;   // e.g. 2 to limit to reflections/02.md
  const INCLUDE_PATCH = false;  // set true for "first lines added" preview

  const LS_PREFIX = 'umentalism:';
  const raw = localStorage.getItem(LS_PREFIX + 'gh-settings');
  if (!raw) {
    console.error('[cabula] No GitHub settings in localStorage. ' +
                  'Open ⚙ Sync, save your PAT and repo, then re-run.');
    return;
  }
  let settings;
  try { settings = JSON.parse(raw); }
  catch (e) { console.error('[cabula] gh-settings is not valid JSON'); return; }
  if (!settings.token || !settings.owner || !settings.repo) {
    console.error('[cabula] gh-settings is missing token/owner/repo');
    return;
  }

  const headers = {
    Authorization: `Bearer ${settings.token}`,
    Accept: 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28',
  };

  const fmtLisbon = (iso) => {
    const d = new Date(iso);
    // 13 May 2026, 14:32:08 WEST
    const date = d.toLocaleDateString('en-GB', {
      day: '2-digit', month: 'short', year: 'numeric',
      timeZone: 'Europe/Lisbon',
    });
    const time = d.toLocaleTimeString('en-GB', {
      hour: '2-digit', minute: '2-digit', second: '2-digit',
      timeZone: 'Europe/Lisbon',
    });
    // Detect WEST vs WET
    const tzName = new Intl.DateTimeFormat('en-GB', {
      timeZone: 'Europe/Lisbon', timeZoneName: 'short',
    }).formatToParts(d).find(p => p.type === 'timeZoneName').value;
    return `${date}, ${time} ${tzName}`;
  };

  const fmtDateline = (iso) => {
    // The exact string the author would paste into the .md
    const d = new Date(iso);
    const dateStr = d.toLocaleDateString('en-GB', {
      day: 'numeric', month: 'long', year: 'numeric',
      timeZone: 'Europe/Lisbon',
    });
    const unix = Math.floor(d.getTime() / 1000);
    return `**Lisbon, ${dateStr}** · Unix: ${unix}`;
  };

  const ids = ONLY_TAB_ID ? [ONLY_TAB_ID] : [1, 2, 3, 4, 5, 6, 7, 8];

  for (const id of ids) {
    const path = `reflections/${String(id).padStart(2, '0')}.md`;
    const commitsUrl = `https://api.github.com/repos/${settings.owner}/${settings.repo}` +
                       `/commits?path=${encodeURIComponent(path)}&per_page=100`;
    let commits;
    try {
      const r = await fetch(commitsUrl, { headers });
      if (!r.ok) {
        console.warn(`[cabula] ${path}: HTTP ${r.status} ${r.statusText}`);
        continue;
      }
      commits = await r.json();
    } catch (e) {
      console.warn(`[cabula] ${path}: fetch failed`, e);
      continue;
    }
    if (!Array.isArray(commits) || commits.length === 0) {
      console.log(`\n=== ${path} — no commits found ===`);
      continue;
    }

    // Chronological order (oldest first)
    commits.reverse();

    console.log(`\n=== ${path} (${commits.length} commit${commits.length === 1 ? '' : 's'}) ===`);

    for (const c of commits) {
      const iso = c.commit.author.date;
      const lisbon = fmtLisbon(iso);
      const unix = Math.floor(new Date(iso).getTime() / 1000);
      const sha7 = c.sha.substring(0, 7);
      const msg = (c.commit.message || '').split('\n')[0].substring(0, 80);
      const url = `https://github.com/${settings.owner}/${settings.repo}/commit/${c.sha}`;
      const dateline = fmtDateline(iso);

      console.log(
        `${lisbon}  ·  Unix ${unix}  ·  ${sha7}\n` +
        `  msg:      ${msg}\n` +
        `  commit:   ${url}\n` +
        `  dateline: ${dateline}`
      );

      if (INCLUDE_PATCH) {
        try {
          const r2 = await fetch(
            `https://api.github.com/repos/${settings.owner}/${settings.repo}/commits/${c.sha}`,
            { headers });
          if (r2.ok) {
            const detail = await r2.json();
            const file = (detail.files || []).find(f => f.filename === path);
            if (file && file.patch) {
              const added = file.patch.split('\n')
                .filter(l => l.startsWith('+') && !l.startsWith('+++'))
                .slice(0, 5)
                .map(l => '    ' + l.substring(1).substring(0, 100));
              if (added.length > 0) {
                console.log('  first added:\n' + added.join('\n'));
              }
            }
          }
        } catch (e) {
          // Non-fatal — skip patch preview for this commit.
        }
      }
    }
  }

  console.log('\n[cabula] Done. Copy the "dateline:" line for the entry you want to mark, ' +
              'and paste it into the corresponding reflections/NN.md in the site editor at ' +
              'the boundary where that entry begins.');
})();
