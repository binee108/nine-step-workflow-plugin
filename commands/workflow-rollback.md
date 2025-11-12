---
description: Rollback workflow to a previous phase or commit when issues are discovered
---

# Workflow Rollback Command

## Command Usage

```bash
/workflow-rollback [phase_number | commit_sha | "last"]
```

**Arguments**:
- `phase_number` (optional): Phase number to rollback to (e.g., 1, 2)
- `commit_sha` (optional): Specific commit to rollback to
- `"last"` (optional): Cancel last Phase commit
- Omit argument: Interactive mode to select rollback target

**Purpose**: Safely restore previous state when Phase implementation has critical issues

---

## When to Use

- Critical issue discovered after Phase implementation
- Problem in previous Phase discovered during later Phase
- Incorrect architecture decision requires restart
- Production issue after merge (emergency rollback)

---

## Rollback Scenarios

### Scenario 1: Last Phase Rollback

```bash
/workflow-rollback last
```

**Situation**: Problem in Phase 2 discovered after Phase 3 completion

**Actions**:
1. Find Phase 3 commit
2. Review Phase 3 changes
3. User confirmation
4. Revert Phase 3 commit
5. Reset workflow state to Phase 2 completion

### Scenario 2: Specific Phase Rollback

```bash
/workflow-rollback 2
```

**Situation**: Currently at Phase 4, want to return to Phase 2

**Actions**:
1. Confirm Phase 3, 4 commits
2. Analyze impact scope
3. User confirmation (warn Phase 3-4 work loss)
4. Revert Phase 3, 4 commits
5. Reset workflow state to Phase 2 completion

### Scenario 3: Specific Commit Rollback

```bash
/workflow-rollback a1b2c3d
```

**Situation**: Need exact restoration to specific commit point

**Actions**:
1. Validate commit SHA
2. Review changes after that commit
3. User confirmation
4. Execute git revert or reset
5. Sync workflow state

---

## Rollback Process

### Phase 1: State Analysis

**1.1 Current Worktree Check**
```bash
pwd  # Verify worktree path
git branch  # Current branch
git log --oneline -10  # Recent commits
```

**1.2 Load Workflow State**
```python
state = load_workflow_state(worktree_path)

current_phase = state['current_phase']
total_phases = state['total_phases']
completed_steps = state['completed_steps']
```

**1.3 Extract Phase Commit List**
```python
def extract_phase_commits(state):
    """Extract Phase commits from workflow state"""
    phase_commits = {}

    for step in state['completed_steps']:
        if step['step'] == 9:  # Step 9 = commit
            phase = step['phase']
            commit_sha = step.get('commit_sha')
            if commit_sha:
                phase_commits[phase] = {
                    'sha': commit_sha,
                    'timestamp': step['timestamp'],
                    'description': state.get('phases', {}).get(phase, {}).get('description', f'Phase {phase}')
                }

    return phase_commits
```

---

### Phase 2: Rollback Plan Generation

**2.1 Interactive Mode** (if no argument)

```markdown
📋 Rollback Available Phases

Current status: Phase 4 in progress

1. Phase 1 (commit: a1b2c3d) - Database schema updates
   - Completed: 2025-11-09 14:30
   - Changed files: 3
   - ⚠️ Will lose Phase 2-4 work

2. Phase 2 (commit: b2c3d4e) - Service logic implementation
   - Completed: 2025-11-09 15:00
   - Changed files: 5
   - ⚠️ Will lose Phase 3-4 work

3. Phase 3 (commit: c3d4e5f) - API endpoint integration
   - Completed: 2025-11-09 15:30
   - Changed files: 4
   - ⚠️ Will lose Phase 4 work

4. ❌ Cancel rollback

Select Phase number to rollback: [1-4]
```

**2.2 Rollback Impact Analysis**

```python
def analyze_rollback_impact(target_phase, current_phase, phase_commits):
    """Analyze rollback impact scope"""
    affected_phases = range(target_phase + 1, current_phase + 1)

    impact = {
        'phases_to_revert': list(affected_phases),
        'commits_to_revert': [],
        'files_affected': set(),
        'estimated_time_loss': 0
    }

    for phase in affected_phases:
        if phase in phase_commits:
            commit = phase_commits[phase]
            impact['commits_to_revert'].append(commit['sha'])

            # Check changed files via git diff
            changed_files = get_changed_files(commit['sha'])
            impact['files_affected'].update(changed_files)

            # Estimate work time (commit timestamp difference)
            time_diff = calculate_time_diff(commit['timestamp'])
            impact['estimated_time_loss'] += time_diff

    return impact
```

**2.3 User Confirmation**

```markdown
⚠️ Rollback Impact Analysis

**Rollback Target**: Phase 3 → Restore to Phase 2

**Commits to Revert**:
- Phase 3 (c3d4e5f): API endpoint integration

**Affected Files** (12):
- {{PROJECT_SRC}}/routes/quote_routes.{{FILE_EXT}}
- {{PROJECT_SRC}}/services/quote_service.{{FILE_EXT}}
- {{PROJECT_SRC}}/models/quote.{{FILE_EXT}}
- ... (9 more)

**Estimated Work Time Loss**: ~30 minutes

**Backup Plan**:
- Save current state to {{BACKUP_DIR}}/{feature-name}/phase3/
- Retain for 30 days
- Restore available: /workflow-restore phase3

Really proceed with rollback? [y/N]
```

---

### Phase 3: Backup Creation

**3.1 Backup Current State**

```bash
# Create backup directory
BACKUP_DIR="{{BACKUP_DIR}}/{feature-name}/phase{target_phase+1}_$(date +%Y%m%d_%H%M%S)"
mkdir -p $BACKUP_DIR

# Backup changed files
for file in $AFFECTED_FILES; do
  cp --parents $file $BACKUP_DIR/
done

# Save commit info
git show {commit_sha} > $BACKUP_DIR/commit_info.txt

# Backup workflow state
cp {{WORKTREE_DIR}}/{feature-name}/{{WORKFLOW_STATE_FILE}} $BACKUP_DIR/

# Backup metadata
cat > $BACKUP_DIR/BACKUP_INFO.md << EOF
# Rollback Backup

**Created**: $(date)
**Feature**: {feature-name}
**Rolled back from**: Phase {current_phase}
**Rolled back to**: Phase {target_phase}
**Commit reverted**: {commit_sha}

## Restore Command
\`\`\`bash
/workflow-restore phase{target_phase+1}
\`\`\`

## Files Backed Up
$(ls -1 $BACKUP_DIR/)
EOF
```

**3.2 Backup Verification**

```python
def verify_backup(backup_dir, affected_files):
    """Verify backup files"""
    for file in affected_files:
        backup_file = os.path.join(backup_dir, file)
        if not os.path.exists(backup_file):
            raise BackupError(f"Failed to backup: {file}")

    print(f"✅ {len(affected_files)} files backed up: {backup_dir}")
```

---

### Phase 4: Rollback Execution

**4.1 Git Revert vs Reset Selection**

| Situation | Recommended Method | Reason |
|-----------|-------------------|--------|
| Already merged | `git revert` | Preserve history, safe rollback |
| Pre-merge (worktree) | `git reset --hard` | Clean cancel, no history needed |
| Production deployed | `git revert` | Clear rollback history |

**4.2 Revert Execution** (post-merge)

```bash
cd {{WORKTREE_DIR}}/{feature-name}/

# Revert Phase commits in reverse order
for commit in "${COMMITS_TO_REVERT[@]}"; do
  git revert $commit --no-edit
done

# Modify revert commit message
git commit --amend -m "Rollback: Revert Phase 3 ({{PHASE_DESCRIPTION}}) due to {{ROLLBACK_REASON}}

Reverted commits:
- c3d4e5f: Phase 3 implementation

Reason: {{DETAILED_REASON}}

{{COMMIT_FOOTER}}"
```

**4.3 Reset Execution** (pre-merge)

```bash
cd {{WORKTREE_DIR}}/{feature-name}/

# Hard reset to target Phase commit
git reset --hard {target_phase_commit_sha}

# Verify changes
git status
git log --oneline -5
```

---

### Phase 5: Workflow State Update

**5.1 State File Modification**

```python
def update_state_after_rollback(state, target_phase):
    """Update workflow state after rollback"""

    # Update current Phase
    state['current_phase'] = target_phase
    state['current_step'] = 9  # Phase completion status

    # Remove completed_steps from rolled-back Phases
    state['completed_steps'] = [
        step for step in state['completed_steps']
        if step['phase'] <= target_phase
    ]

    # Update last execution info
    state['last_execution'] = {
        'phase': target_phase,
        'step': 9,
        'agent': '{{AGENT_GIT_MANAGER}}',
        'status': 'completed',
        'timestamp': datetime.now().isoformat(),
        'note': f'Rolled back from Phase {state["current_phase"]}'
    }

    # Reset resume_plan
    state['resume_plan'] = {
        'next_phase': target_phase + 1,
        'next_step': 1,
        'next_agent': '{{AGENT_PLANNER}}',
        'reason': f'Continue from Phase {target_phase} after rollback'
    }

    save_workflow_state(worktree_path, state)
```

**5.2 Issue Label Update** (if applicable)

```bash
# Revert {{ISSUE_TRACKER}} issue status to in-progress
if [ -n "$RELATED_ISSUES" ]; then
  for issue in $RELATED_ISSUES; do
    {{ISSUE_TRACKER_CLI}} issue edit $issue --remove-label "status:testing" --add-label "status:in-progress"
    {{ISSUE_TRACKER_CLI}} issue comment $issue --body "⏪ Rolled back to Phase $TARGET_PHASE due to: $ROLLBACK_REASON"
  done
fi
```

---

### Phase 6: Confirmation and Guidance

**6.1 Rollback Completion Message**

```markdown
✅ Rollback Complete!

**Rollback Info**:
- Target: Phase 3 → Phase 2
- Reverted commit: c3d4e5f
- Backup location: {{BACKUP_DIR}}/real-time-quotes/phase3_20251109_160000/

**Current Status**:
- Phase: 2/3 completed
- Branch: {{BRANCH_PREFIX}}/feat-real-time-quotes
- Last commit: b2c3d4e (Phase 2)

**Next Steps**:
1. Analyze root cause
2. Revise plan (if needed)
3. Reimplement Phase 3:
   ```
   /workflow-resume
   ```

**Restore Backup** (if needed):
```
/workflow-restore phase3
```

**Backup Auto-Cleanup**: Deleted after 30 days
```

**6.2 Rollback Log Recording**

```python
def log_rollback(feature_name, from_phase, to_phase, reason, backup_dir):
    """Record rollback history"""
    log_file = f"{{BACKUP_DIR}}/{feature_name}/ROLLBACK_LOG.md"

    with open(log_file, 'a') as f:
        f.write(f"""
## Rollback: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

- **From**: Phase {from_phase}
- **To**: Phase {to_phase}
- **Reason**: {reason}
- **Backup**: {backup_dir}
- **Restored**: No (use /workflow-restore to restore)

---
""")
```

---

## Restore from Backup

**Backup restore command** (separate implementation needed):

```bash
/workflow-restore phase3
```

**Actions**:
1. Restore files from backup directory
2. Restore workflow state
3. Reapply Git commits

---

## Safety Features

### 1. Pre-Rollback Mandatory Checks

```python
def pre_rollback_checks():
    """Pre-rollback safety validation"""

    # Check for uncommitted changes
    if has_uncommitted_changes():
        raise RollbackError("Uncommitted changes detected. Commit or stash first.")

    # Check merge status
    if is_merged_to_main():
        print("⚠️ Warning: Already merged to {{MAIN_BRANCH}}. Use revert instead of reset.")

    # Check backup space
    required_space = calculate_backup_size()
    available_space = get_available_disk_space()
    if available_space < required_space * 2:
        raise RollbackError("Insufficient disk space for backup.")
```

### 2. Rollback Restrictions

- **7+ days post-merge**: Warning message (possible production impact)
- **3+ rollbacks on same Phase**: Request user intervention (suspect design issue)
- **{{MAIN_BRANCH}} branch**: Rollback forbidden (separate hotfix process)

### 3. Automatic Backup Cleanup

```python
def cleanup_old_backups(feature_name, retention_days=30):
    """Auto-cleanup old backups"""
    backup_dir = f"{{BACKUP_DIR}}/{feature_name}/"

    for backup in os.listdir(backup_dir):
        backup_path = os.path.join(backup_dir, backup)
        backup_time = get_backup_timestamp(backup)

        if (datetime.now() - backup_time).days > retention_days:
            shutil.rmtree(backup_path)
            print(f"🗑️ Deleted old backup: {backup}")
```

---

## Integration with /workflow-exec

**Pre-merge check**:
```python
def before_merge():
    # Final confirmation
    print("⚠️ Rollback becomes complex after merge.")
    print("Final verification:")
    print("- [ ] All Phase tests passed?")
    print("- [ ] Code review complete?")
    print("- [ ] Documentation complete?")

    choice = input("Proceed with merge? [y/N]: ")
    if choice.lower() != 'y':
        print("Merge cancelled. Review again before retry.")
        return False
    return True
```

---

**Remember**: Rollback is the safety net that says "mistakes are okay". With backups, bold experimentation becomes possible.
