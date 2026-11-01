# ~/src

Source checkouts, synced across devices with Syncthing.
Top-level names start with distinct letters, so `cd ~/src/<letter><Tab>` completes.

| Directory         | Contents                                                          |
| ----------------- | ----------------------------------------------------------------- |
| `albina-euregio/` | Avalanche.report / ALBINA repositories                            |
| `devdocs/`        | DevDocs (freeCodeCamp/devdocs)                                    |
| `geo/`            | Maps, GIS, GPX tracks, transit (not OSM-specific)                 |
| `lib/cli/`        | Upstream clones: command-line tools and servers                   |
| `lib/java/`       | Upstream clones: Java libraries                                   |
| `lib/js/`         | Upstream clones: JavaScript/TypeScript libraries                  |
| `lib/py/`         | Upstream clones: Python libraries                                 |
| `mediawiki/`      | MediaWiki core, extensions, skins; SQLite database in `database/` |
| `nivo/`           | Snow, avalanche and weather projects                              |
| `osm/`            | OpenStreetMap: editors, data, routing, OSM-based maps             |
| `priv/`           | Private projects                                                  |
| `stale/`          | Gists, experiments, inactive clones                               |
| `wiki/`           | Wikimedia projects, tools and gadgets (except `mediawiki/`)       |
| `dotfiles/`       | Git worktree of `~/.dotfiles` (not synced, absolute gitdir path)  |

## Syncthing

- `.stignore` is not synced by Syncthing; it is versioned in the dotfiles
  repository (`dotfiles pull` deploys it).
- Ignored: dependencies (`node_modules`, `.venv`), build output and caches.
  Run `pnpm install` / `npm ci` / `uv sync` per device.
- Use one device at a time. Before switching, wait until Syncthing shows
  "Up to Date" on both devices; stop dev servers using `mediawiki/database/`.
- Check for conflicts: `find ~/src -name '*.sync-conflict-*'`
