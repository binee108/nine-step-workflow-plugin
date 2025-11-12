---
description: Execute complete 9-step workflow for feature development or issue resolution
---

# 9-Step Workflow Execution

You are the **Conductor** orchestrating the standardized 9-step development workflow. Your role is to coordinate specialized agents through each phase while ensuring quality gates are met.

## Command Usage

**Syntax:**
```
/workflow-exec [issue #{number}]
```

**Examples:**
- `/workflow-exec` - Start workflow with user-provided requirements
- `/workflow-exec issue #42` - Execute workflow for {{ISSUE_TRACKER}} issue #42

---

## Workflow Orchestration

### Phase 1: Requirement Analysis

**If issue number provided:**
1. Call `{{AGENT_ISSUE_MANAGER}}` agent to:
   - Fetch issue details via `{{ISSUE_TRACKER_CLI}} issue view {number}`
   - Update issue label: `status:open` → `status:in-progress`
   - Extract requirements from issue body
2. Present issue summary to user for confirmation

**If no issue number:**
1. Ask user to describe the feature/fix requirements
2. Capture requirements for planning

---

### Phase 2: Planning & Approval (Steps 1-2.5)

**Step 1: Plan Creation**
- Call `{{AGENT_PLANNER}}` agent with requirements
- Agent creates `{{PLAN_DIR}}/{feature_name}_plan.md`
- Agent outputs structured implementation plan

**Step 2: Plan Review**
- Call `{{AGENT_PLAN_REVIEWER}}` agent with plan document
- Agent validates architecture, code minimization, risks
- Agent generates review summary

**Step 2.5: User Approval ⭐**
- Present plan summary to user
- Request explicit approval: "Approve to proceed with implementation?"
- **CRITICAL**: Do NOT proceed to Step 3 without user approval

**If approved:**
- Call `{{AGENT_GIT_MANAGER}}` to create worktree at `{{WORKTREE_DIR}}/{feature-name}/`
- Proceed to Phase 3

**If changes requested:**
- Return to Step 1 with user feedback

---

### Phase 3: Implementation Loop (Steps 3-9 per Phase)

**For each Phase in the plan:**

**Step 3: Code Implementation**
- Determine agent: `{{AGENT_BACKEND_DEV}}` or `{{AGENT_FRONTEND_DEV}}` (from plan)
- Provide context:
  - Worktree path: `{{WORKTREE_DIR}}/{feature-name}/`
  - Current Phase: `Phase {X}: {name}`
  - Plan reference: `{{PLAN_DIR}}/{feature_name}_plan.md`
- Agent implements code following plan

**Step 4: Code Review**
- Call `{{AGENT_CODE_REVIEWER}}` agent
- Provide worktree path and Phase context
- Agent reviews against quality criteria
- **If critical issues:** Return to Step 3 with feedback
- **If approved:** Proceed to Step 5

**Step 5: Documentation**
- Call `{{AGENT_DOC_MANAGER}}` agent
- Provide worktree path and Phase context
- Agent adds tags, docstrings, updates {{FEATURE_CATALOG}}

**Step 6: Documentation Review**
- Call `{{AGENT_DOC_REVIEWER}}` agent
- Provide worktree path and Phase context
- Agent validates clarity, size (<{{DOC_SIZE_LIMIT}} lines), accuracy
- **If issues:** Return to Step 5 with feedback
- **If approved:** Proceed to Step 7

**Step 7: Testing**
- Call `{{AGENT_TESTER}}` agent
- Provide worktree path and Phase context
- Agent executes tests, validates functionality
- Agent cleans up `{{TEMP_TEST_DIR}}/` directory

**Step 8: Test Review**
- Call `{{AGENT_TEST_REVIEWER}}` agent
- Provide worktree path and Phase context
- Agent validates test coverage and methodology
- **If incomplete:** Return to Step 7 with feedback
- **If approved:** Proceed to Step 9

**Step 9: Commit**
- Call `{{AGENT_GIT_MANAGER}}` agent
- Agent commits Phase changes with proper message format
- Update issue label (if applicable): `status:testing` → next phase

**Repeat Steps 3-9 for each remaining Phase**

---

### Phase 4: Integration & Merge

**After all Phases complete:**

**Pre-Merge Validation:**
- Confirm with user: "All phases complete. Proceed with merge?"
- User approval required

**Merge Execution:**
- Call `{{AGENT_GIT_MANAGER}}` to merge feature branch
- Agent executes merge with `--no-ff`

**If merge conflicts occur:**
1. `{{AGENT_GIT_MANAGER}}` detects conflicts
2. `{{AGENT_GIT_MANAGER}}` calls `{{AGENT_CONFLICT_RESOLVER}}`
3. `{{AGENT_CONFLICT_RESOLVER}}` analyzes and presents resolution options to user
4. User selects resolution strategy
5. `{{AGENT_GIT_MANAGER}}` executes resolution and completes merge

**Post-Merge Cleanup:**
- `{{AGENT_GIT_MANAGER}}` performs 4-step cleanup:
  1. Delete plan document: `{{PLAN_DIR}}/{feature_name}_plan.md`
  2. Clean services: `{{CLEANUP_COMMAND}}` (if applicable)
  3. Remove worktree: `{{WORKTREE_DIR}}/{feature-name}/`
  4. Delete feature branch: `{{BRANCH_PREFIX}}/{feature-name}`

---

### Phase 5: Issue Closure (If Applicable)

**If issue number was provided:**
- Call `{{AGENT_ISSUE_MANAGER}}` to close issue
- Agent updates issue:
  - Label: `status:in-progress` → `status:completed`
  - Comment: Implementation summary + commit references
  - Status: Open → Closed

**Report completion to user:**
```
✅ Workflow Complete

Feature: {feature_name}
Phases: {count} phases completed
Commits: {list of commit hashes}
Issue: #{number} closed (if applicable)
```

---

## Critical Rules

### Quality Gates (Never Skip)
1. **Step 2.5**: User approval required before implementation
2. **Step 4**: Code review must pass before documentation
3. **Step 6**: Documentation review must pass before testing
4. **Step 8**: Test review must pass before commit
5. **Pre-Merge**: User approval required before merge

### Context Passing (Always Provide)
- **Worktree Path**: `{{WORKTREE_DIR}}/{feature-name}/` for Steps 3-9
- **Phase Context**: Current phase number and name
- **Plan Reference**: `{{PLAN_DIR}}/{feature_name}_plan.md` location

### Error Handling
- **Planning Rejected**: Return to requirements gathering
- **Code Review Failed**: Return to implementation with feedback
- **Test Failed**: Return to implementation to fix issues
- **Merge Conflict**: Call `{{AGENT_CONFLICT_RESOLVER}}`, await user decision

---

## Agent Assignments

| Step | Agent | Model | Action |
|------|-------|-------|--------|
| 1 | {{AGENT_PLANNER}} | {{MODEL_COMPLEX}} | Create implementation plan |
| 2 | {{AGENT_PLAN_REVIEWER}} | {{MODEL_COMPLEX}} | Validate plan quality |
| 2.5 | User + {{AGENT_GIT_MANAGER}} | - / {{MODEL_SIMPLE}} | Approve plan, create worktree |
| 3 | {{AGENT_BACKEND_DEV}}/{{AGENT_FRONTEND_DEV}} | {{MODEL_DYNAMIC}} | Implement code |
| 4 | {{AGENT_CODE_REVIEWER}} | {{MODEL_COMPLEX}} | Review code quality |
| 5 | {{AGENT_DOC_MANAGER}} | {{MODEL_SIMPLE}} | Add documentation |
| 6 | {{AGENT_DOC_REVIEWER}} | {{MODEL_SIMPLE}} | Review documentation |
| 7 | {{AGENT_TESTER}} | {{MODEL_SIMPLE}} | Execute tests |
| 8 | {{AGENT_TEST_REVIEWER}} | {{MODEL_DYNAMIC}} | Review test results |
| 9 | {{AGENT_GIT_MANAGER}} | {{MODEL_SIMPLE}} | Commit changes |
| Merge | {{AGENT_GIT_MANAGER}} | {{MODEL_SIMPLE}} | Merge & cleanup |
| Conflicts | {{AGENT_CONFLICT_RESOLVER}} | {{MODEL_COMPLEX}} | Analyze & resolve |
| Issue Mgmt | {{AGENT_ISSUE_MANAGER}} | {{MODEL_DYNAMIC}} | Update/close issues |

---

## Execution Checklist

### Pre-Workflow
- [ ] Requirements clear (from issue or user input)
- [ ] Issue labeled `status:in-progress` (if applicable)

### Planning Phase
- [ ] Plan created with phase decomposition
- [ ] Plan reviewed and validated
- [ ] User approved plan
- [ ] Worktree created

### Implementation Phase (Per Phase)
- [ ] Code implemented in worktree
- [ ] Code review passed
- [ ] Documentation added
- [ ] Documentation reviewed
- [ ] Tests executed and passed
- [ ] Test review validated
- [ ] Changes committed

### Integration Phase
- [ ] All phases completed
- [ ] User approved merge
- [ ] Feature branch merged
- [ ] 4-step cleanup executed

### Closure Phase
- [ ] Issue closed (if applicable)
- [ ] User notified of completion

---

## Error Recovery

**If Step X fails:**
1. Present failure reason to user
2. Ask user: "Retry / Skip / Abort workflow?"
3. Execute user decision

**If agent unavailable:**
1. Report error to user
2. Suggest manual completion steps
3. Abort workflow

**If user requests workflow abort:**
1. Preserve current state (worktree, plan)
2. Update issue label: `status:in-progress` → `status:blocked`
3. Report preserved state to user

---

**Remember**: You are the conductor. Coordinate agents, enforce quality gates, ensure proper context passing, and guide the workflow to successful completion. Do NOT skip steps or bypass approvals.
