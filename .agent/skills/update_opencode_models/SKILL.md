---
name: update_opencode_models
description: Fetch the latest free models from OpenCode Console (docs + API), sync the LaunchOpenCode bat/sh launchers, then sync project docs/version/release notes and commit + push.
---

# Update OpenCode Models

This skill keeps the OpenCode free-model lineup in the project launchers in sync with what
OpenCode actually offers, and carries the change all the way through documentation, versioning,
and publishing.

Use it whenever the user asks to "run the update_opencode_models skill", or when OpenCode adds /
retires free models.

---

## Canonical sources

| Purpose | URL |
| --- | --- |
| Docs (human-readable, authoritative for display names + "free" classification) | `https://opencode.ai/v2/docs/console/models/` |
| API (machine-readable model IDs) | `https://opencode.ai/inference/v1/models` |
| Legacy API fallback (identical payload) | `https://opencode.ai/zen/v1/models` |

Both sources **must** be fetched fresh every run — the lineup changes often.

---

## Step 1 — Verify availability and compile the free-model list

1. Fetch the Docs page and the API models endpoint (both, every run).
2. Treat a model as **free** when either:
   - its id ends in `-free`, or
   - it is a stealth/preview model that the docs list as free (e.g. `big-pickle`, `LL Alpha Free`).
3. Build the list as the **union** of both sources:
   - Present in API **only** → keep it and append ` [API]` to its display name.
   - Present in docs **only** → keep it (do *not* drop it); the skill only defines the
     API-only tagging direction.
   - Present in both → normal entry, no tag.
4. Ignore non-free models entirely. Ignore the API's `test` entry.
5. Where the docs are ambiguous, the `### Free models` bullet list and the `Pricing` table
   (rows whose Input/Output are `Free`) are the authoritative "free" signals; the
   `## Endpoints` table gives the canonical **display name → model ID** mapping.

Result is a list of `display name` + `opencode/<model-id>` pairs.

## Step 2 — Ordering rule

Order the selector **alphabetically by display name, with `Big Pickle` pinned first**.

- `Big Pickle` stays at `[1]` (long-standing stealth-first convention).
- Everything else is A→Z (case-insensitive) from `[2]` onward.

Sorting reference for edge cases: `Beam Free` < `Big Pickle` < `DeepSeek…`; `LL Alpha Free` <
`LongCat…`; `MiMo-V2.5` < `MiMo-V2.6`; `Nemotron 3 Ultra` < `Nemotron 3.5 Lightning` <
`Nemotron 3.5 Super VL`.

## Step 3 — Update `Batch Files/LaunchOpenCode.bat`

Locate the `:menu` block under the `OPENCODE CLI - MODEL SELECTOR` heading. Update **four** things:

1. **Menu lines** — replace the printed `[n]` list:
   ```batch
   echo    [1] Big Pickle
   echo    [2] Beam Free
   echo    [3] DeepSeek V4.1 Flash Free
   ```
2. **Prompt range** — the max index:
   ```batch
   set /p choice="  Enter your choice (0-15): "
   ```
3. **Mapping `if` lines** — one per option, `&`-separated:
   ```batch
   if "%choice%"=="1" set "model=opencode/big-pickle" & set "modelname=Big Pickle"
   if "%choice%"=="2" set "model=opencode/beam-free" & set "modelname=Beam Free"
   ```
4. **Invalid-choice message** (in the `if not defined model (` block):
   ```batch
   echo  [!] Invalid choice. Please enter a number between 0-15.
   ```

## Step 4 — Update `Shell Files/LaunchOpenCode.sh`

Mirror the `.bat` exactly. Inside the `while true; do` loop update **four** things:

1. **Menu lines** (three leading spaces inside the quotes):
   ```bash
   echo "   [1] Big Pickle"
   echo "   [2] Beam Free"
   echo "   [3] DeepSeek V4.1 Flash Free"
   ```
2. **Prompt range**:
   ```bash
   read -p " Enter your choice (0-15): " choice
   ```
3. **`case $choice` entries** — one per option:
   ```bash
   case $choice in
       0) exit 0 ;;
       1) model="opencode/big-pickle"; modelname="Big Pickle" ;;
       2) model="opencode/beam-free"; modelname="Beam Free" ;;
   ```
4. **Invalid-choice message**:
   ```bash
   echo " ❌ Invalid choice. Please enter a number between 0-15."
   ```

The two launchers must end up **byte-for-byte equivalent in menu order, labels, and IDs**.

## Step 5 — Sync docs and bump the version

The patch version increments by one (e.g. `v1.2.50` → `v1.2.51`).

1. **`CODE_DOCUMENTATION.md`**
   - Launcher table row (search for `LaunchOpenCode.bat`): update the count
     ("N verified free and preview models") and the full backticked model-ID list, in selector order.
   - Append a `## 🆕 Version X.Y.Z Updates` section at the **end** of the file (version history is
     chronological, newest last) summarising added/removed/reordered models.
2. **`README.md`** — bump the version in the intro line
   (`**AI CLI Manager (vX.Y.Z)** is a powerful command-line utility…`).
3. **`AI_CLI_Manager.bat`** — bump the banner (`echo           AI CLI TOOLS MANAGER (vX.Y.Z)`).
4. **`AI_CLI_Manager.sh`** — bump the banner (`… AI CLI TOOLS MANAGER (vX.Y.Z) (Linux/Mac)…`).
5. **`RELEASE_NOTES.md`** — insert a new `## [vX.Y.Z] - <YYYY-MM-DD>` entry at the **top**
   (below the `# AI CLI Manager - Release Notes` title) with a
   `### 🚀 New Features & Additions` block and a `### 🧹 Housekeeping` block.

> Historical entries (old release notes, old `Version X Updates` sections, dated `Note (vX.Y.Z)`
> callouts) are **never rewritten** — only appended to.

## Step 6 — Commit and push

Follow the repo commit convention (`vX.Y.Z - feat: …` / `- chore: …`) and stage everything:

```powershell
git add -A
git commit -m "vX.Y.Z - feat: sync OpenCode free models and bump version" -m "<bullet 1>" -m "<bullet 2>"
git push origin main
```

Bullets should cover: models added, models removed, reordering/pinning + new range, and the
version/docs sync. Use `--force-with-lease` (not `--force`) if a squash/amend is explicitly requested.

---

## Verification checklist

- [ ] Both sources fetched this run (not reused from a previous run).
- [ ] Free set = union of docs + API; API-only entries tagged `[API]`; docs-only entries retained.
- [ ] `.bat` and `.sh` menus, mappings, prompt range, and invalid-choice text all match.
- [ ] Highest menu index == prompt range max == invalid-choice max (`0-N`).
- [ ] `Big Pickle` is `[1]`; remainder A→Z.
- [ ] No stale IDs remain (`grep` the removed IDs and `0-<oldmax>` in both launchers).
- [ ] Docs table count + ID list updated; version bumped everywhere; release note added.
- [ ] `git status -sb` shows a clean tree and `main...origin/main` in sync after push.

## Notes & gotchas

- **Skill review gate**: Steps 1–4 change the launchers. Historically the skill stopped for user
  review after Step 4; run Steps 5–6 when the user asks for the "wrap-up" ("do the needful").
- **PowerShell false failure**: `git push` writes progress to stderr, so the shell may report
  `Exited with code 1`. It is **not** a failure — confirm with `git status -sb` /
  `git log --oneline -1 origin/main` (look for `main -> main`).
- **CRLF warnings** (`LF will be replaced by CRLF`) are harmless.
- `README.md` is tracked by git as lowercase `readme.md` (Windows FS is case-insensitive).
- Never drop a documented-but-not-yet-in-API free model without asking the user.

See `REFERENCE.md` in this folder for the current baseline lineup, version history, and templates.
