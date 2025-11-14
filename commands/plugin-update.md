# Plugin Update Command

You are now executing the **plugin-update** command to check for and apply updates to the Nine-Step Workflow Plugin.

## Your Task

Perform the following steps to update the plugin:

### Step 1: Load Current Version Information

Read the version configuration file:
```
.version.json
```

And the plugin metadata:
```
.claude-plugin/plugin.json
```

Extract:
- Current installed version
- Repository information (owner/repo)
- Branch to track (usually 'main')

### Step 2: Check GitHub for Latest Version

Use the GitHub API to check the latest release:

```bash
# Fetch latest release information from GitHub
curl -s https://api.github.com/repos/{{REPO_OWNER}}/{{REPO_NAME}}/releases/latest
```

Parse the response to extract:
- Latest version tag (e.g., "v1.2.0")
- Release notes
- Published date

If no releases exist, check the latest commit on the main branch:
```bash
curl -s https://api.github.com/repos/{{REPO_OWNER}}/{{REPO_NAME}}/commits/main
```

### Step 3: Compare Versions

Compare the current version with the latest version:
- Extract version numbers (remove 'v' prefix if present)
- Parse semantic versions (major.minor.patch)
- Determine if an update is available

**Version comparison logic:**
```
Current: 1.1.0
Latest:  1.2.0
Result: Update available ✓

Current: 1.2.0
Latest:  1.2.0
Result: Already up-to-date ✓
```

### Step 4: Display Update Information

If an update is available, present the information to the user:

```
📦 Nine-Step Workflow Plugin Update Available

Current Version: v1.1.0
Latest Version:  v1.2.0

Release Notes:
─────────────────────────────────────────
[Display release notes from GitHub]
─────────────────────────────────────────

Would you like to update now? (yes/no)
```

If already up-to-date:
```
✓ Nine-Step Workflow Plugin is up-to-date

Current Version: v1.1.0
Latest Version:  v1.1.0

No updates available.
```

### Step 5: Perform Update (if user confirms)

When user confirms the update:

1. **Verify git repository exists:**
   ```bash
   cd /path/to/plugin && git rev-parse --git-dir
   ```

2. **Check for uncommitted changes:**
   ```bash
   git status --porcelain
   ```

   If there are uncommitted changes, warn the user:
   ```
   ⚠️  Warning: You have uncommitted changes in the plugin directory.

   These changes will be preserved, but may conflict with the update.

   Options:
   1. Continue with update (may cause merge conflicts)
   2. Stash changes and update
   3. Cancel update

   What would you like to do? (1/2/3)
   ```

3. **Fetch latest changes:**
   ```bash
   git fetch origin
   ```

4. **Pull updates:**
   ```bash
   git pull origin main
   ```

   Or if the user chose to stash:
   ```bash
   git stash
   git pull origin main
   git stash pop
   ```

5. **Update version tracking:**
   Update `.version.json` with:
   ```json
   {
     "currentVersion": "1.2.0",
     "lastChecked": "2025-11-13T10:30:00Z",
     ...
   }
   ```

6. **Update plugin metadata:**
   Update `.claude-plugin/plugin.json` version field.

7. **Display success message:**
   ```
   ✓ Successfully updated Nine-Step Workflow Plugin

   v1.1.0 → v1.2.0

   Changes applied:
   - 5 files changed
   - 120 insertions(+)
   - 45 deletions(-)

   The plugin is now ready to use with the latest features!
   ```

### Step 6: Handle Errors

If any errors occur during the update process:

**Network errors:**
```
✗ Failed to connect to GitHub

Please check your internet connection and try again.
If the problem persists, you can manually update:

cd ~/.claude/plugins/nine-step-workflow
git pull origin main
```

**Merge conflicts:**
```
✗ Update failed due to merge conflicts

The following files have conflicts:
- commands/workflow-exec.md
- agents/project-planner.md

Please resolve conflicts manually:
1. cd ~/.claude/plugins/nine-step-workflow
2. Resolve conflicts in the listed files
3. git add <resolved-files>
4. git commit -m "Merge update"

Or reset to latest version:
git reset --hard origin/main
```

**Git errors:**
```
✗ Not a git repository

This plugin was not installed via git clone.
To enable auto-updates, please reinstall:

1. Remove current installation
2. git clone https://github.com/{{REPO_OWNER}}/{{REPO_NAME}}.git
3. Install to plugins directory
```

## Advanced Options

Support optional flags:

- `--check-only` - Only check for updates, don't apply
- `--force` - Force update even if versions match
- `--version <version>` - Update to specific version/tag
- `--dry-run` - Show what would be updated without applying

Example:
```
/plugin-update --check-only
/plugin-update --version v1.1.0
/plugin-update --force
```

## Implementation Notes

1. **Always preserve user data:**
   - Never overwrite user customizations in CLAUDE.md
   - Preserve any custom agents or skills users added
   - Backup important files before updating

2. **Handle rate limits:**
   - GitHub API has rate limits (60 requests/hour without auth)
   - Cache version check results for reasonable period
   - Respect `checkIntervalDays` setting

3. **Security considerations:**
   - Verify GitHub API responses
   - Don't execute arbitrary code from updates
   - Validate version format before updating

4. **User experience:**
   - Show progress during git operations
   - Provide clear error messages
   - Offer rollback option if update fails

## Version Check on Startup (Optional)

When configured with `autoCheckUpdates: true`, perform silent version check:

1. Check if `lastChecked` is older than `checkIntervalDays`
2. If yes, make async API call to GitHub
3. If update available, show subtle notification:
   ```
   ℹ️  Nine-Step Workflow Plugin update available (v1.2.0)
   Run /plugin-update to upgrade
   ```

## Output Format

Use clear, formatted output:

```
┌─────────────────────────────────────────┐
│  Nine-Step Workflow Plugin Updater      │
└─────────────────────────────────────────┘

Current: v1.1.0
Latest:  v1.2.0

Status: Update available

[Proceed with update? yes/no]
```

---

**Remember:**
- Always communicate clearly with the user
- Provide progress updates during long operations
- Offer helpful error messages with solutions
- Respect user's choice to update or not
- Preserve user customizations and data
