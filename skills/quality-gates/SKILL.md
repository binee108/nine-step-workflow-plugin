# Quality Gates - Approval Criteria Standardization

## Purpose

Standardize approval/rejection decisions across all reviewer agents (plan-reviewer, code-reviewer, documentation-reviewer, test-reviewer) using consistent criteria.

<!-- CUSTOMIZE: Adjust language based on project conventions -->

## 4-Tier Approval System

### 1. ✅ APPROVED (Proceed Immediately)

**Definition**: Meets all required criteria, ready to proceed to next step immediately

**Criteria**:
- All required requirements met
- No architecture/security/performance issues
- Code quality standards met
- Only optional improvements exist (non-blocking)

**Output Format**:
```markdown
## Overall Assessment
✅ **APPROVED** - Ready for next step

## Critical Issues
None

## Important Improvements
None

## Suggestions
- [Optional improvement 1]
- [Optional improvement 2]
```

**Conductor Action**: Immediately proceed to next step

---

### 2. ⚠️ APPROVED_WITH_CONDITIONS (Conditional Approval)

**Definition**: Mostly passed but requires specific conditions to be met before proceeding

**Criteria**:
- Core functionality complete
- Important but not immediately blocking issues exist
- Conditions can be quickly verified by conductor

**Condition Examples**:
- "Proceed after confirming security issue #42 resolved"
- "Proceed after performance test results show < {{X}}ms"
- "Proceed after user approval"

**Output Format**:
```markdown
## Overall Assessment
⚠️ **APPROVED_WITH_CONDITIONS**

## Conditions for Approval
1. [Condition 1]: [Verification method]
2. [Condition 2]: [Verification method]

## Critical Issues
None

## Important Improvements
- [Issue requiring condition]
```

**Conductor Action**:
1. Verify conditions
2. If conditions met → Proceed to next step
3. If conditions not met → Treat as NEEDS_REVISION

---

### 3. 🔄 NEEDS_REVISION (Return to Previous Step)

**Definition**: Required criteria not met, rework needed

**Criteria**:
- Required requirements not met
- Architecture issues requiring redesign
- Security vulnerabilities found
- Performance criteria not met
- Plan and implementation mismatch

**Output Format**:
```markdown
## Overall Assessment
🔄 **NEEDS_REVISION**

## Critical Issues (Must Fix)
1. [Issue 1]: [Why critical] → [Required action]
2. [Issue 2]: [Why critical] → [Required action]

## Important Improvements (Should Fix)
- [Improvement 1]

## Recommended Actions
1. [Step to take 1]
2. [Step to take 2]
```

**Conductor Action**:
1. Request rework from previous step agent
2. Re-review after critical issues resolved
3. Prevent infinite loop: Escalate to user after 3 iterations

---

### 4. 🚫 REJECTED (Stop Workflow)

**Definition**: Fundamental problems requiring workflow stop and user decision

**Criteria**:
- Fundamental architecture flaws (complete redesign needed)
- Plan itself has problems (requirements redefinition needed)
- Security risk too high (alternative approach needed)
- Technically infeasible

**Output Format**:
```markdown
## Overall Assessment
🚫 **REJECTED** - Workflow requires user decision

## Blocking Issues
1. [Fundamental problem 1]: [Why blocking] → [Alternative approach needed]
2. [Fundamental problem 2]: [Why blocking] → [Alternative approach needed]

## Recommended Next Steps
1. [User decision needed on X]
2. [Consider alternative approach Y]
3. [Escalate to senior architect]
```

**Conductor Action**:
1. Stop workflow immediately
2. Report situation to user
3. Wait for user decision:
   - Complete plan revision
   - Select alternative approach
   - Reduce feature scope
   - Stop workflow

---

## Reviewer-Specific Application Guide

### plan-reviewer (Step 2)

**APPROVED**:
- Phase breakdown clear
- Dependency analysis complete
- Risks identified
- Code minimization verified

**APPROVED_WITH_CONDITIONS**:
- "Proceed after user selects architecture option A/B"
- "Proceed after performance test strategy confirmed"

**NEEDS_REVISION**:
- Insufficient phase breakdown
- Code bloat concern (provide alternatives)
- Security risks not assessed

**REJECTED**:
- Fundamental architecture flaws
- Requirements ambiguous (redefinition needed)

---

### code-reviewer (Step 4)

**APPROVED**:
- Plan compliance
- Architecture principles met
- No security issues
- Excellent code quality

**APPROVED_WITH_CONDITIONS**:
- "Proceed after confirming TODO comments removed"
- "Proceed after confirming type hints added"

**NEEDS_REVISION**:
- Security vulnerabilities (RCE, SQL Injection)
- Architecture violations (SSOT, DRY)
- Performance issues (N+1 query)
- Plan non-compliance

**REJECTED**:
- Implementation completely different from plan
- Unfixable security design flaws

---

### documentation-reviewer (Step 6)

<!-- CUSTOMIZE: Set MAX_DOC_LINES based on project standards -->

**APPROVED**:
- Under {{MAX_DOC_LINES}} lines
- Clear and concise
- Matches code
- Tag consistency

**APPROVED_WITH_CONDITIONS**:
- "Proceed after reducing Known Issues to < 5 lines"
- "Proceed after updating example code"

**NEEDS_REVISION**:
- Exceeds {{MAX_DOC_LINES}} lines
- Code mismatch
- Missing/inconsistent tags
- Excessive explanation

**REJECTED**:
- Document size uncontrollable (structural issue)
- Documentation itself impossible (code complexity issue)

---

### test-reviewer (Step 8)

**APPROVED**:
- All test scenarios executed
- Works as intended
- Edge cases verified
- Performance criteria met

**APPROVED_WITH_CONDITIONS**:
- "Proceed after confirming {{X}} concurrent connections load test"
- "Proceed after production environment verification"

**NEEDS_REVISION**:
- Insufficient test coverage
- Performance criteria not met
- Test failures (code fix needed)

**REJECTED**:
- Testing itself impossible (architecture issue)
- Critical bugs (redesign needed)

---

## Output Template

All reviewers must include this structure:

```markdown
# [Agent Name] Review Summary

## Overall Assessment
[✅ APPROVED | ⚠️ APPROVED_WITH_CONDITIONS | 🔄 NEEDS_REVISION | 🚫 REJECTED]

[Additional sections based on selected status]

## [Status-Specific Required Sections]
[Follow output format for that status]

## Next Steps
[Actions conductor should take]
```

---

## Conductor Processing Logic

```{{LANG}}
<!-- CUSTOMIZE: Adapt to your tech stack -->

def handle_review_result(review_output):
    status = extract_status(review_output)

    if status == "APPROVED":
        proceed_to_next_step()

    elif status == "APPROVED_WITH_CONDITIONS":
        conditions = extract_conditions(review_output)
        verify_conditions(conditions)
        if all_conditions_met():
            proceed_to_next_step()
        else:
            return_to_previous_step()

    elif status == "NEEDS_REVISION":
        critical_issues = extract_critical_issues(review_output)
        if revision_count >= 3:
            escalate_to_user()  # Prevent infinite loop
        else:
            return_to_previous_step(issues=critical_issues)

    elif status == "REJECTED":
        stop_workflow()
        report_to_user(blocking_issues)
        wait_for_user_decision()
```

---

## Consistency Checklist

**Reviewer self-check before submitting review:**
- [ ] Overall Assessment specifies one of 4 statuses?
- [ ] Using correct output format for selected status?
- [ ] Critical Issues truly critical? (NEEDS_REVISION/REJECTED only)
- [ ] Conditions verifiable by conductor? (APPROVED_WITH_CONDITIONS only)
- [ ] Next Steps clear?

---

## Edge Case Decision Criteria

**Ambiguous situations:**

| Situation | Choice |
|-----------|--------|
| 5 minor issues vs 1 critical issue | NEEDS_REVISION (critical takes priority) |
| 90% complete, 10% missing | NEEDS_REVISION (100% completion required) |
| Cannot choose between alternatives A/B | REJECTED (user decision needed) |
| 1 test fails, rest pass | NEEDS_REVISION (all tests must pass) |
| Document {{MAX_DOC_LINES + 10}} lines (standard: {{MAX_DOC_LINES}}) | NEEDS_REVISION (clear criteria violation) |

---

**Remember**: Consistency is key to automation. When all reviewers apply the same criteria, the conductor can manage workflows predictably.
