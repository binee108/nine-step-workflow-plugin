# Documentation Draft - TDD for Documentation

## Purpose

"Code follows documentation" structure by writing **documentation drafts before implementation**. This is the documentation version of Test-Driven Development (TDD).

<!-- CUSTOMIZE: Adjust language/localization preferences -->

## Core Concept

**Old Approach (Problem)**:
```
Step 3: Write Code → Step 5: Write Documentation
Problem: Documentation after implementation → Intent distortion possible
```

**Improved Approach (Solution)**:
```
Step 3.5: Write Documentation Draft → Step 4: Write Code
Benefit: Documentation serves as design → Code follows documentation
```

---

## Step 3.5: Documentation Draft

### Location
- **After Step 3 (Code Implementation)**
- **Before Step 4 (Code Review)**

### Responsible Agent
- `backend-developer` or `frontend-developer`
- Implementation agent writes documentation draft immediately after coding

### Scope

<!-- CUSTOMIZE: Replace API examples with {{PROJECT_NAME}} domain examples -->

**1. API Specification (Backend)**
```markdown
## API Endpoint: POST /api/{{RESOURCE_NAME}}/{{ACTION}}

### Purpose
{{Brief description of what this endpoint does and why}}

### Request
```json
{
  "{{field1}}": "{{example_value}}",
  "{{field2}}": {{example_number}}
}
```

### Response (Success)
```json
{
  "{{id_field}}": "{{example_id}}",
  "status": "success",
  "{{data_field}}": {{example_data}}
}
```

### Response (Error)
```json
{
  "error": "{{error_code}}",
  "message": "{{error_description}}"
}
```

### Security
- Authentication: {{Auth mechanism required}}
- Rate limit: {{X}} requests/{{time_unit}}
- Input validation: {{Validation rules}}
```

**2. Function Signature & Docstring**

<!-- Multi-language examples -->

**Python:**
```python
def {{function_name}}({{param1}}: {{Type1}}, {{param2}}: {{Type2}} = {{default}}) -> {{ReturnType}}:
    """
    {{Brief description of function purpose}}.

    WHY: {{Explain why this function exists and what problem it solves}}

    Args:
        {{param1}}: {{Description and constraints}}
        {{param2}}: {{Description and default behavior}}

    Returns:
        {
            "{{field1}}": {{Description}},
            "{{field2}}": {{Description}}
        }

    Raises:
        {{ExceptionType}}: {{When and why this exception is raised}}

    Edge Cases:
        - {{Edge case 1}}: {{How it's handled}}
        - {{Edge case 2}}: {{How it's handled}}

    Side Effects:
        - {{Side effect 1}}
        - {{Side effect 2}}

    Performance:
        - {{Performance characteristic 1}}
        - {{Performance characteristic 2}}

    Debugging Tips:
        - {{Tip 1}}
        - {{Tip 2}}
    """
    # Implementation not yet written (draft stage)
    pass
```

**JavaScript/TypeScript:**
```typescript
/**
 * {{Brief description of function purpose}}.
 *
 * WHY: {{Explain why this function exists}}
 *
 * @param {{param1}} - {{Description and constraints}}
 * @param {{param2}} - {{Description and default behavior}}
 * @returns {{Return value description}}
 * @throws {{{ExceptionType}}} {{When and why}}
 *
 * Edge Cases:
 * - {{Edge case 1}}: {{How handled}}
 *
 * Side Effects:
 * - {{Side effect description}}
 *
 * Performance:
 * - {{Performance notes}}
 */
function {{functionName}}({{param1}}: {{Type1}}, {{param2}}: {{Type2}} = {{default}}): {{ReturnType}} {
    // Implementation not yet written (draft stage)
}
```

**Go:**
```go
// {{FunctionName}} {{brief description}}.
//
// WHY: {{Explain purpose}}
//
// Parameters:
//   - {{param1}}: {{Description}}
//   - {{param2}}: {{Description}}
//
// Returns:
//   - {{ReturnType}}: {{Description}}
//   - error: {{Error conditions}}
//
// Edge Cases:
//   - {{Edge case}}: {{Handling}}
//
// Side Effects:
//   - {{Side effect}}
func {{FunctionName}}({{param1}} {{Type1}}, {{param2}} {{Type2}}) ({{ReturnType}}, error) {
    // Implementation not yet written (draft stage)
    return nil, nil
}
```

**3. Core Logic Flow**
```markdown
## Core Logic Flow

1. Input Validation
   - {{field1}}: {{validation rules}}
   - {{field2}}: {{validation rules}}

2. {{Step 2 description}}
   - {{Details}}
   - {{Timeout/retry logic}}

3. {{Step 3 description}}
   ```json
   {{Example payload}}
   ```

4. Data Storage/Processing
   - {{Operation description}}
   - {{Tables/collections affected}}

5. Response Generation
   - {{Response structure}}
```

**4. Error Handling Strategy**
```markdown
## Error Scenarios

| Error Situation | HTTP Code | Response Message | Handling Method |
|----------------|-----------|------------------|-----------------|
| {{Error 1}} | {{4xx/5xx}} | "{{message}}" | {{Action}} |
| {{Error 2}} | {{4xx/5xx}} | "{{message}}" | {{Action}} |
| {{Error 3}} | {{4xx/5xx}} | "{{message}}" | {{Action}} |
```

**5. Test Scenarios (Draft)**
```markdown
## Test Scenarios

### Happy Path
- ✅ {{Scenario 1}} → {{Expected result}}
- ✅ {{Scenario 2}} → {{Expected result}}

### Error Scenarios
- ❌ {{Error scenario 1}} → {{Expected exception}}
- ❌ {{Error scenario 2}} → {{Expected exception}}

### Edge Cases
- ✅ {{Edge case 1}} → {{Expected behavior}}
- ✅ {{Edge case 2}} → {{Expected behavior}}
```

---

## Step 4 (Code Review) Changes

### Existing Review Items
- Code quality
- Architecture compliance
- Security verification

### Additional Review Items ⭐
- **Code-Documentation Consistency Verification**
  - API spec matches actual code?
  - Docstring Args/Returns match actual signature?
  - Error handling implemented as documented?
  - Test scenario coverage confirmed?

**Verification Example**:
```{{LANG}}
# Documentation draft (Step 3.5)
{{Example showing documentation}}

# Actual code (Step 4)
{{Example showing implementation}}
# ✅ Matches documentation
```

---

## Step 5 (Documentation Finalization) Changes

### Existing Tasks
- Add code comments
- Write feature documentation
- Manage tag system

### Changed Tasks ⭐
- **Finalize documentation based on Step 3.5 draft**
  - Fix inconsistencies with actual implementation
  - Reflect test results (after Step 7 completes)
  - Update code examples (based on actual code)
  - Add Known Issues (discovered constraints)

**Draft → Final Documentation**:
```markdown
# Step 3.5 Draft
## Edge Cases
- {{Edge case}}: {{Expected handling}}

# Step 5 Final (After testing)
## Edge Cases
- {{Edge case}}: {{Expected handling}}
  - ⚠️ Known Issue: {{Discovered issue}}
  - Solution: {{Workaround}}

## Test Results
- Actual {{metric}}: {{actual_value}} (Expected: {{expected_value}})
```

---

## Benefits

### 1. Improved Design Clarity
- API/function signatures finalized before implementation
- Error handling strategy decided in advance
- Test scenarios defined early

### 2. Code-Documentation Consistency
- Code written to follow documentation
- code-reviewer verifies consistency
- Minimizes documentation distortion

### 3. Reduced documentation-reviewer Burden
- Draft already exists → Only final review needed
- Structure established → Only consistency verification

### 4. Improved Testing Efficiency
- Test scenarios pre-defined
- feature-tester references draft
- Reduced missed test cases

---

## Implementation in Workflow

### Existing 9-Step Workflow
```
Step 3: Code (backend-developer)
  ↓
Step 4: Code Review (code-reviewer)
  ↓
Step 5: Documentation (documentation-manager)
```

### Improved Workflow ⭐
```
Step 3: Code Implementation (backend-developer)
  ↓
Step 3.5: Documentation Draft (backend-developer) ← New
  ↓
Step 4: Code Review (code-reviewer) ← Add consistency verification
  ↓
Step 5: Documentation Finalization (documentation-manager) ← Finalize from draft
```

---

## Agent Integration

### backend-developer / frontend-developer

**Immediately execute Step 3.5 after Step 3 completion**:
```markdown
✅ Step 3 (Code Implementation) Complete

Now starting Step 3.5 (Documentation Draft).

Write the following documentation draft:
1. API specification (endpoints, request/response)
2. Function signature & Docstring (WHY, Args, Returns, Raises, Edge Cases)
3. Core logic flow
4. Error handling strategy
5. Test scenarios (draft)

Draft location: docs/drafts/{{feature-name}}_draft.md
```

### code-reviewer

**Add to Step 4 review items**:
```markdown
## Code-Documentation Consistency

- [ ] API spec matches actual code?
- [ ] Docstring Args/Returns match signature?
- [ ] Defined exceptions exist in actual code?
- [ ] Edge case handling logic implemented?
- [ ] Error handling strategy followed?

If inconsistency found: NEEDS_REVISION (update docs or code)
```

### documentation-manager

**Change Step 5 tasks**:
```markdown
Finalize documentation based on Step 3.5 draft.

**Draft location**: docs/drafts/{{feature-name}}_draft.md

**Final Documentation Tasks**:
1. Review draft and compare with actual implementation
2. Fix inconsistencies
3. Reflect test results (after Step 7 complete)
4. Update code examples
5. Add Known Issues
6. Update Feature Catalog

**Final location**: docs/features/{{feature-name}}.md
```

---

## Success Criteria

**Step 3.5 Completion Criteria**:
- [ ] API specification complete (Backend)
- [ ] All major functions have docstring draft
- [ ] Core logic flow explained
- [ ] Error handling strategy defined
- [ ] Test scenarios draft (5+ scenarios)

**Step 4 Code-Documentation Consistency Criteria**:
- [ ] API spec = actual endpoints
- [ ] Docstring Args = function signature
- [ ] Docstring Raises = actual exception handling
- [ ] Edge Cases = actual implementation

**Step 5 Final Documentation Criteria**:
- [ ] Draft-based final documentation complete
- [ ] Test results reflected
- [ ] Known Issues added
- [ ] Under {{MAX_DOC_LINES}} lines <!-- CUSTOMIZE: Set project standard -->

---

**Remember**: "Documentation-First Development" like TDD clarifies design and reduces implementation errors. With a draft, code follows documentation.
