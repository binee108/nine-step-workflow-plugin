---
description: Resume interrupted workflow from last successful checkpoint
---

# Workflow Resume Command

## Command Usage

```bash
/workflow-resume [worktree_path]
```

**Arguments**:
- `worktree_path` (optional): Specific worktree path. If omitted, searches current directory

**Purpose**: Resume interrupted workflow from last successful checkpoint

---

## When to Use

- Workflow execution interrupted by error
- User manually paused and wants to continue
- System restart after work in progress
- Reviewer rejection fixed and ready to resume

---

## Workflow Resume Process

### Phase 1: State File Discovery and Loading

**1.1 Worktree Discovery**
```bash
# Check current directory
pwd

# If worktree_path argument provided, use it
# Otherwise, search {{WORKTREE_DIR}}/ directory
if [no worktree_path]:
  find {{WORKTREE_DIR}}/ -name "{{WORKFLOW_STATE_FILE}}"
```

**1.2 State File Validation**
- Verify `{{WORKTREE_DIR}}/{feature-name}/{{WORKFLOW_STATE_FILE}}` exists
- Validate JSON structure
- Confirm required fields exist (`feature_name`, `current_phase`, `current_step`, `last_execution`)

**1.3 Multiple Worktrees Found**
```markdown
Found interrupted workflows:
1. feat-real-time-quotes (Phase 2: Step 4) - 30 minutes ago
2. fix-order-validation (Phase 1: Step 8) - 2 hours ago

Select workflow to resume: [1-2]
```

---

### Phase 2: State Analysis and Resume Planning

**2.1 Last Execution Status Analysis**

Processing based on `last_execution.status`:

| Status | Meaning | Resume Strategy |
|--------|---------|-----------------|
| `failed` | Step failed (NEEDS_REVISION, REJECTED) | Return to previous Step |
| `waiting_approval` | Awaiting user approval (Step 2.5) | Proceed to next Step |
| `in_progress` | Step execution interrupted | Retry current Step or skip |
| `completed` | Step successfully completed | Proceed to next Step |

**2.2 Resume Plan Generation**

```python
def generate_resume_plan(state):
    last = state['last_execution']

    if last['status'] == 'failed':
        # Return to previous Step
        if last['step'] == 4:  # {{AGENT_CODE_REVIEWER}} failed
            return {
                'next_phase': last['phase'],
                'next_step': 3,  # {{AGENT_BACKEND_DEV}}
                'reason': 'Address {{AGENT_CODE_REVIEWER}} feedback'
            }
        elif last['step'] == 6:  # {{AGENT_DOC_REVIEWER}} failed
            return {
                'next_phase': last['phase'],
                'next_step': 5,  # {{AGENT_DOC_MANAGER}}
                'reason': 'Address {{AGENT_DOC_REVIEWER}} feedback'
            }
        # Other reviewer failure cases...

    elif last['status'] == 'waiting_approval':
        # Step 2.5 awaiting user approval
        return {
            'next_phase': last['phase'],
            'next_step': 2.5,
            'reason': 'User approval required'
        }

    elif last['status'] in ['completed', 'in_progress']:
        # Proceed to next Step
        next_step = last['step'] + 1
        if next_step > 9:
            # Phase complete, move to next Phase
            return {
                'next_phase': last['phase'] + 1,
                'next_step': 1,
                'reason': f'Phase {last["phase"]} completed'
            }
        else:
            return {
                'next_phase': last['phase'],
                'next_step': next_step,
                'reason': 'Continue Step progression'
            }
```

**2.3 User Confirmation**

```markdown
📋 Workflow Resume Plan

**Feature**: {feature_name}
**Worktree**: {worktree_path}
**Branch**: {branch_name}

**Current State**:
- Phase: {current_phase}/{total_phases} - {phase_description}
- Last Step: {last_step} ({last_agent}) - {last_status}
- Interrupted: {timestamp}
- Interruption Reason: {error_message}

**Completed Work**:
✅ Phase 1: Step 1-9 completed (commit: a1b2c3d)
✅ Phase 2: Step 1-3 completed

**Resume Plan**:
- Next Phase: {next_phase}
- Next Step: {next_step}
- Agent to invoke: {next_agent}
- Resume Reason: {reason}

**Required Actions** (if any):
- [ ] {required_action_1}
- [ ] {required_action_2}

Proceed with resume? [Y/n]
```

---

### Phase 3: Environment Verification

**3.1 Worktree State Check**
```bash
cd {worktree_path}
pwd  # Verify path
git branch  # Verify branch
git status  # Check changes
```

**3.2 Plan Document Existence**
```bash
ls -lh {plan_reference}
```

**3.3 Previous Commit Verification** (Phase 2+ resume)
```bash
git log --oneline -5
# Verify Phase 1 commit exists
```

---

### Phase 4: Workflow Resume

**4.1 Context Construction**

Prepare context based on `{{CONTEXT_SCHEMA}}`:

```yaml
agent_context:
  worktree_path: {from {{WORKFLOW_STATE_FILE}}}
  branch_name: {from {{WORKFLOW_STATE_FILE}}}
  current_phase: {resume_plan.next_phase}
  current_step: {resume_plan.next_step}
  feature_name: {from {{WORKFLOW_STATE_FILE}}}
  plan_reference: {from {{WORKFLOW_STATE_FILE}}}
  previous_step_output:
    agent_name: {last_execution.agent}
    status: {last_execution.status}
    findings: {from last_execution.error_message}
  phase_description: {from {{WORKFLOW_STATE_FILE}}}
  related_issues: {from {{WORKFLOW_STATE_FILE}}}
```

**4.2 Agent Invocation**

Invoke `next_agent` from resume plan with above context:

```
Work Context:
- Worktree path: {{WORKTREE_DIR}}/feat-real-time-quotes/
- Branch: {{BRANCH_PREFIX}}/feat-real-time-quotes
- Current Phase: 2
- Current Step: 3
- Feature name: real-time-quotes
- Plan document: {{PLAN_DIR}}/real-time-quotes_plan.md

Previous Step Result (Step 4 - {{AGENT_CODE_REVIEWER}}):
- Status: NEEDS_REVISION
- Findings:
  - {{SECURITY_ISSUE_1}}: user_input validation missing
  - {{SECURITY_ISSUE_2}} not applied

Task Scope:
Address {{AGENT_CODE_REVIEWER}} feedback and reimplement QuoteService.
```

**4.3 State Update**

Update `{{WORKFLOW_STATE_FILE}}` after agent invocation:
- Refresh `last_execution`
- Add to `completed_steps` (on success)
- Update `current_step`

---

### Phase 5: Continuous Progression (Optional)

**5.1 Auto-Progress Mode**

Ask user whether to continue to next Step automatically:

```markdown
Step 3 ({{AGENT_BACKEND_DEV}}) completed!

Continue to next Step 4 ({{AGENT_CODE_REVIEWER}})?
- [Y] Yes, continue (auto workflow)
- [N] No, pause here (manual verification then resume)
- [A] Full auto-progress (until Phase end)
```

**5.2 Full Auto-Progress Mode**

If user selects [A]:
- Auto-execute all remaining Steps in current Phase
- Auto-pause at Step 2.5, Step 4/6/8 approvals if needed
- Auto-pause and save state on error

---

## Error Handling

### Error Scenario 1: State File Not Found

```markdown
❌ No interrupted workflow found.

Please verify:
- {{WORKTREE_DIR}}/{feature-name}/{{WORKFLOW_STATE_FILE}} exists
- Correct worktree path

To start new workflow:
/workflow-exec
```

### Error Scenario 2: State File Corrupted

```markdown
❌ Workflow state file corrupted.

File: {{WORKTREE_DIR}}/feat-real-time-quotes/{{WORKFLOW_STATE_FILE}}
Error: Invalid JSON syntax

Recovery options:
1. Restore from backup (if available)
2. Start new workflow (/workflow-exec)
3. Manual recovery (edit file)
```

### Error Scenario 3: Worktree Corrupted

```markdown
❌ Worktree state doesn't match workflow state.

Expected branch: {{BRANCH_PREFIX}}/feat-real-time-quotes
Actual branch: {{MAIN_BRANCH}}

Recovery options:
1. Checkout correct branch
2. Recreate worktree (possible data loss)
3. Abort workflow and restart
```

### Error Scenario 4: Infinite Loop Prevention

```markdown
⚠️ Same Step failed 3+ times.

Phase 2: Step 3 ({{AGENT_BACKEND_DEV}}) → Step 4 ({{AGENT_CODE_REVIEWER}})
- Attempt 1: NEEDS_REVISION
- Attempt 2: NEEDS_REVISION
- Attempt 3: NEEDS_REVISION

Recommended Actions:
1. Review plan (identify root cause)
2. User intervention (architecture redesign needed?)
3. Skip current Phase (temporary)

Continue anyway? [y/N]
```

---

## State File Management

### Auto-Save Triggers

1. **Step Completion**: Auto-save after every Step completion
2. **Error Occurrence**: Immediate save (enable recovery)
3. **User Interruption**: Save on interrupt signal (Ctrl+C, etc.)

### Save Function

```python
def save_workflow_state(worktree_path, state_data):
    state_file = f"{worktree_path}/{{WORKFLOW_STATE_FILE}}"

    # Create backup (if existing file)
    if os.path.exists(state_file):
        backup_file = f"{state_file}.backup"
        shutil.copy(state_file, backup_file)

    # Save state
    with open(state_file, 'w') as f:
        json.dump(state_data, f, indent=2)

    print(f"✅ Workflow state saved: {state_file}")
```

### Load Function

```python
def load_workflow_state(worktree_path):
    state_file = f"{worktree_path}/{{WORKFLOW_STATE_FILE}}"

    if not os.path.exists(state_file):
        return None

    try:
        with open(state_file, 'r') as f:
            state = json.load(f)

        # Validate required fields
        required = ['feature_name', 'current_phase', 'current_step', 'last_execution']
        for field in required:
            if field not in state:
                raise ValueError(f"Missing required field: {field}")

        return state

    except (json.JSONDecodeError, ValueError) as e:
        print(f"❌ State file load failed: {e}")
        return None
```

---

## Integration with /workflow-exec

`/workflow-exec` command modifications needed:

**Startup Check**:
```python
# At /workflow-exec start
def workflow_exec_start():
    # Check for existing state files
    existing_states = find_workflow_states()

    if existing_states:
        print("⚠️ Interrupted workflow(s) found.")
        print("To resume: /workflow-resume")
        print("To start new workflow, continue.")

        choice = input("Continue anyway? [y/N]: ")
        if choice.lower() != 'y':
            return

    # Start new workflow...
```

**Save on Step Completion**:
```python
def after_step_completion(phase, step, agent, status):
    # Update state
    state = load_workflow_state(worktree_path)
    state['current_step'] = step
    state['last_execution'] = {
        'phase': phase,
        'step': step,
        'agent': agent,
        'status': status,
        'timestamp': datetime.now().isoformat()
    }

    if status in ['approved', 'completed']:
        state['completed_steps'].append({
            'phase': phase,
            'step': step,
            'agent': agent,
            'status': status,
            'timestamp': datetime.now().isoformat()
        })

    save_workflow_state(worktree_path, state)
```

---

## Success Criteria

**Resume Success Criteria**:
- [ ] State file loaded successfully
- [ ] Worktree state matches (branch, path)
- [ ] Resume plan generated
- [ ] User confirmation completed
- [ ] Agent invocation successful
- [ ] State file updated

---

**Remember**: Workflow resume provides "recoverable even on failure" confidence. It enables safe long-running work without fear of losing progress.
