# update_opencode_models — Reference

Companion to `SKILL.md`. Snapshot state and copy-paste templates. **Refresh the baseline table on
every successful run** so the next agent can diff against it.

---

## Current baseline

**As of:** `v1.2.50` — 2026-10-17 · **Count:** 15 models · **Range:** `0-15`

Ordered alphabetically with `Big Pickle` pinned first (this is the on-disk selector order).

| # | Display name | Model ID | In API? |
| --- | --- | --- | --- |
| 1 | Big Pickle | `big-pickle` | yes |
| 2 | Beam Free | `beam-free` | yes |
| 3 | DeepSeek V4.1 Flash Free | `deepseek-v4.1-flash-free` | yes |
| 4 | Exo Free | `exo-free` | no (docs-only) |
| 5 | GLM-5.3-Flash Free | `glm-5.3-flash-free` | yes |
| 6 | Jev 1.13 Free | `jev-1.13-free` | yes |
| 7 | LL Alpha Free | `ll-alpha-free` | no (docs-only) |
| 8 | LongCat 2.5 Preview Free | `longcat-2.5-preview-free` | yes |
| 9 | MiMo-V2.5 Free | `mimo-v2.5-free` | no (docs-only) |
| 10 | MiMo-V2.6-Flash Free | `mimo-v2.6-flash-free` | yes |
| 11 | Muse Spark 1.3 Contributor Free | `muse-spark-1.3-contributor-free` | no (docs-only) |
| 12 | Nemotron 3 Ultra Free | `nemotron-3-ultra-free` | no (docs-only) |
| 13 | Nemotron 3.5 Lightning Free | `nemotron-3.5-lightning-free` | yes |
| 14 | Nemotron 3.5 Super VL Free | `nemotron-3.5-super-vl-free` | yes |
| 15 | Space Bunny Free | `space-bunny-free` | yes |

No `[API]`-tagged entries at this revision (every API-listed free model is also documented).
All model IDs are prefixed with `opencode/` when passed to the launcher.

---

## Lineup history

| Version | Date | Count | Change |
| --- | --- | --- | --- |
| `v1.2.50` | 2026-10-17 | 15 | Added `glm-5.3-flash-free`, `beam-free`, `ll-alpha-free`, `nemotron-3.5-super-vl-free`; removed `cat-jam-free`, `step-5-preview-free`, `muse-spark-1.2-contributor-free`; reordered A→Z with Big Pickle pinned; range `0-15`. |
| `v1.2.49` | 2026-10-15 | 14 | Skill/workflow source-URL refresh only (`/v2/docs/console/models/`, `/inference/v1/models`); lineup unchanged. |
| `v1.2.48` | 2026-10-15 | 14 | Added `deepseek-v4.1-flash-free`, `cat-jam-free`, `mimo-v2.5-free`; removed `ling-3.0-flash-fin-free`, `ling-3.1-flash-free`; range `0-14`. |

---

## Version bump locations

Bump the patch number in **all** of these:

- `README.md` — intro line: `**AI CLI Manager (vX.Y.Z)** …`
- `AI_CLI_Manager.bat` — banner: `echo           AI CLI TOOLS MANAGER (vX.Y.Z)`
- `AI_CLI_Manager.sh` — banner: `… AI CLI TOOLS MANAGER (vX.Y.Z) (Linux/Mac) …`
- `CODE_DOCUMENTATION.md` — append `## 🆕 Version X.Y.Z Updates` section
- `RELEASE_NOTES.md` — new `## [vX.Y.Z] - YYYY-MM-DD` entry at the top

---

## Commit message template

```
vX.Y.Z - feat: sync OpenCode free models and bump version

- Added <names> (<ids>) to the LaunchOpenCode launchers.
- Removed discontinued <names> (<ids>).
- Reordered the selector alphabetically with Big Pickle pinned first; range advanced to 0-N.
- Updated CODE_DOCUMENTATION.md launcher table and bumped version references to vX.Y.Z.
```

Use `- chore: …` instead when nothing user-facing changed (e.g. a URL-only refresh).

---

## Health check (run before finishing)

Search both launchers and fail if anything is stale:

```bash
grep -nE "0-1[0-9]|cat-jam|step-5-preview|muse-spark-1\.2" "Batch Files/LaunchOpenCode.bat" "Shell Files/LaunchOpenCode.sh"
```

Expect only the current range (e.g. `0-15`) and no removed IDs.
