---
name: interactive-questions
description: Ask clarifying questions when requirements are unclear to prevent assumptions and misunderstandings. Use when facing ambiguous requirements, missing information, or trade-off decisions before implementation.
---

# Interactive Questions

## Instructions

### When to ask

**Always ask when:**
- Requirements unclear
- Missing critical information
- Multiple interpretations possible
- Trade-offs need decision

**Never assume - Always ask!**

### Question framework

1. Identify the gap
2. Formulate specific question
3. Provide context
4. Offer options if applicable

## Example

<!-- CUSTOMIZE: Replace domain-specific examples with {{PROJECT_NAME}} examples -->

**Request:** "Add validation to {{ENTITIES}}"

```markdown
❌ Don't assume: "Implementing {{field1}} and {{field2}} validation..."

✅ Ask questions:

<!-- Adjust language based on project conventions -->
{{ENTITY}} validation needs clarification:

1. Which fields should be validated?
   - [ ] {{field1}}
   - [ ] {{field2}}
   - [ ] {{field3}}

2. What are the validation rules?
   - {{field1}}: Min value? Max value?
   - {{field2}}: Decimal allowed?

3. What happens on failure?
   - [ ] Throw exception
   - [ ] Return error
```

## Common Scenarios

### Scenario 1: Feature Scope Ambiguity
```markdown
**Request:** "Add authentication"

**Good Questions:**
1. Which authentication method?
   - [ ] JWT tokens
   - [ ] Session-based
   - [ ] OAuth2
   - [ ] API keys

2. What needs to be protected?
   - [ ] All endpoints
   - [ ] Specific resources only
   - [ ] Admin routes only

3. Where to store credentials?
   - [ ] Database
   - [ ] External service (e.g., Auth0)
   - [ ] In-memory cache
```

### Scenario 2: Technical Implementation Choices
```markdown
**Request:** "Improve performance"

**Good Questions:**
1. What is the performance target?
   - Response time: < {{X}}ms?
   - Throughput: {{Y}} requests/sec?
   - Memory usage: < {{Z}}MB?

2. Which operations are slow?
   - [ ] Database queries
   - [ ] API calls
   - [ ] File processing
   - [ ] Computations

3. Are there any constraints?
   - Budget for infrastructure?
   - Backwards compatibility required?
   - Existing architecture must remain?
```

### Scenario 3: Error Handling Strategy
```markdown
**Request:** "Handle edge cases"

**Good Questions:**
1. What edge cases are known?
   - Empty input?
   - Null values?
   - Concurrent access?
   - Network failures?

2. How should each be handled?
   - [ ] Fail fast (throw error)
   - [ ] Graceful degradation (default value)
   - [ ] Retry with backoff
   - [ ] Log and continue

3. What is the user experience?
   - Show error message?
   - Silent failure?
   - Redirect to error page?
```

### Scenario 4: Data Migration/Schema Changes
```markdown
**Request:** "Update database schema"

**Good Questions:**
1. How to handle existing data?
   - [ ] Migrate automatically
   - [ ] Require manual migration
   - [ ] Provide migration script
   - [ ] Drop and recreate (development only)

2. What is the backwards compatibility requirement?
   - Old API must work?
   - Grace period for deprecation?
   - Breaking change acceptable?

3. When to apply changes?
   - [ ] Immediately
   - [ ] Scheduled maintenance window
   - [ ] Gradual rollout
```

---

**For detailed patterns, see [reference.md](reference.md)**
**For more examples, see [examples.md](examples.md)**
