---
name: risk-assessment
description: Identifies technical, timeline, and dependency risks with mitigation strategies. Use when reviewing plans or implementations to catch potential issues early before they become problems.
---

# Risk Assessment

## Instructions

### Assess 3 risk types

**Technical:** Complex algorithms, new tech, performance
**Timeline:** Unrealistic estimates, dependencies
**Dependency:** External APIs, third-party libraries

### Assessment process

1. Identify risks
2. Evaluate impact (Low/Medium/High)
3. Propose mitigation

## Example

<!-- CUSTOMIZE: Replace with {{PROJECT_NAME}} domain examples -->

**Plan:** "Implement real-time {{FEATURE}}"

```markdown
⚠️ HIGH Risk: Performance

Problem: Real-time {{FEATURE}} with high throughput is complex
Impact: May not meet latency requirements

Mitigation:
1. Start simple (Phase 1)
2. Load test early (Phase 2)
3. Optimize based on results (Phase 3)
```

## Risk matrix

| Impact | Probability | Action |
|--------|-------------|--------|
| High | High | ⛔ Redesign |
| High | Medium | ⚠️ Strong mitigation |
| Medium | High | ⚠️ Mitigation needed |
| Low | Any | ℹ️ Accept |

## Domain-Specific Risk Examples

### E-commerce Platform

**Technical Risks:**
```markdown
⚠️ HIGH: Payment Gateway Integration
- Problem: Third-party API downtime affects checkout
- Impact: Lost revenue during outages
- Mitigation:
  1. Implement circuit breaker pattern
  2. Queue failed transactions for retry
  3. Add fallback payment processor
```

```markdown
⚠️ MEDIUM: Inventory Race Conditions
- Problem: Multiple users buying last item simultaneously
- Impact: Overselling inventory
- Mitigation:
  1. Use database row locking
  2. Implement optimistic locking with versioning
  3. Add inventory reservation system
```

**Timeline Risks:**
```markdown
⚠️ HIGH: Holiday Season Deadline
- Problem: Must launch before Black Friday (8 weeks)
- Impact: Miss peak revenue opportunity
- Mitigation:
  1. Reduce MVP scope (defer wishlists, reviews)
  2. Add 2-week buffer
  3. Prepare rollback plan
```

**Dependency Risks:**
```markdown
⚠️ MEDIUM: Shipping API Rate Limits
- Problem: {{SHIPPING_PROVIDER}} API limited to 100 req/min
- Impact: Cannot calculate shipping for high-traffic periods
- Mitigation:
  1. Cache shipping rates for common routes
  2. Batch requests where possible
  3. Add secondary provider
```

---

### SaaS Application

**Technical Risks:**
```markdown
⚠️ HIGH: Multi-Tenancy Data Isolation
- Problem: Complex query filtering for tenant separation
- Impact: Data leak between customers (catastrophic)
- Mitigation:
  1. Implement tenant context middleware
  2. Add automated tests for every query
  3. Security review before launch
```

```markdown
⚠️ MEDIUM: Database Migration on Large Dataset
- Problem: Schema change on 10M+ record table
- Impact: Downtime during migration
- Mitigation:
  1. Test on production-size dataset
  2. Use online migration strategy
  3. Schedule during low-traffic window
```

**Timeline Risks:**
```markdown
⚠️ MEDIUM: Team Availability
- Problem: 2 developers on vacation during Phase 3
- Impact: 1-week delay
- Mitigation:
  1. Reschedule Phase 3 to after vacation
  2. Cross-train team members
  3. Complete critical knowledge transfer
```

**Dependency Risks:**
```markdown
⚠️ HIGH: Email Service Provider
- Problem: Relying on single ESP for critical notifications
- Impact: Users miss password resets, billing alerts
- Mitigation:
  1. Add fallback ESP ({{PROVIDER_2}})
  2. Queue failed emails for retry
  3. Monitor delivery rates
```

---

### Data Platform

**Technical Risks:**
```markdown
⚠️ HIGH: Data Pipeline Scalability
- Problem: Current design handles 100K records/day, expecting 10M
- Impact: Pipeline crashes under load
- Mitigation:
  1. Add horizontal scaling (partition by date)
  2. Load test at 20M records/day (2x expected)
  3. Implement backpressure mechanisms
```

```markdown
⚠️ MEDIUM: Data Quality Issues
- Problem: Source system sends malformed data periodically
- Impact: Pipeline failures, bad analytics
- Mitigation:
  1. Add comprehensive validation layer
  2. Quarantine invalid records
  3. Alert on quality threshold violations
```

**Timeline Risks:**
```markdown
⚠️ HIGH: Data Source API Changes
- Problem: Upstream team planning API redesign (unknown timeline)
- Impact: Integration breaks unexpectedly
- Mitigation:
  1. Request advance notice from upstream team
  2. Build adapter pattern for easy swapping
  3. Add integration tests for early detection
```

**Dependency Risks:**
```markdown
⚠️ MEDIUM: Cloud Storage Costs
- Problem: Storing 100TB+ data, costs uncertain
- Impact: Budget overrun
- Mitigation:
  1. Implement data lifecycle policies (archive old data)
  2. Use cost monitoring alerts
  3. Evaluate compression options
```

---

### Mobile App

**Technical Risks:**
```markdown
⚠️ HIGH: Offline-First Sync Complexity
- Problem: Conflict resolution between offline changes and server
- Impact: Data loss or corruption
- Mitigation:
  1. Use CRDT (Conflict-free Replicated Data Types)
  2. Implement last-write-wins with timestamps
  3. Extensive testing of conflict scenarios
```

```markdown
⚠️ MEDIUM: App Store Review Delay
- Problem: Apple review takes 3-7 days, unpredictable
- Impact: Launch date uncertainty
- Mitigation:
  1. Submit 1 week before target launch
  2. Have TestFlight beta ready as backup
  3. Prepare expedited review justification
```

**Timeline Risks:**
```markdown
⚠️ HIGH: Multiple Platform Parity
- Problem: Must ship iOS, Android, Web simultaneously
- Impact: 3x development effort
- Mitigation:
  1. Use React Native for code sharing
  2. Accept platform-specific features in v2
  3. Prioritize one platform for MVP
```

**Dependency Risks:**
```markdown
⚠️ HIGH: Push Notification Service
- Problem: FCM/APNS outages prevent critical notifications
- Impact: Users miss time-sensitive alerts
- Mitigation:
  1. Add in-app notification fallback
  2. Implement retry logic
  3. Monitor notification delivery rates
```

---

### IoT System

**Technical Risks:**
```markdown
⚠️ HIGH: Device Firmware Updates
- Problem: Updating 10,000+ deployed devices remotely
- Impact: Bricking devices if update fails
- Mitigation:
  1. Implement rollback mechanism
  2. Phased rollout (1%, 10%, 100%)
  3. Add device health monitoring
```

```markdown
⚠️ MEDIUM: Network Reliability
- Problem: Devices on unstable cellular networks
- Impact: Frequent disconnections
- Mitigation:
  1. Implement exponential backoff reconnection
  2. Queue commands for offline devices
  3. Add offline operation mode
```

**Timeline Risks:**
```markdown
⚠️ HIGH: Hardware Delivery Delays
- Problem: Chip shortage affecting device production
- Impact: Cannot deploy devices for testing
- Mitigation:
  1. Order dev kits 2 months in advance
  2. Use device simulators for early development
  3. Source alternative hardware vendors
```

**Dependency Risks:**
```markdown
⚠️ MEDIUM: MQTT Broker Limits
- Problem: Current broker handles 1K devices, expecting 50K
- Impact: Connection drops under scale
- Mitigation:
  1. Load test broker at 100K devices
  2. Evaluate managed MQTT services ({{PROVIDER}})
  3. Implement device connection pooling
```

---

## Risk Assessment Template

```markdown
## Risk Assessment for {{FEATURE_NAME}}

### Technical Risks

#### {{Risk Name}}
- **Severity:** HIGH | MEDIUM | LOW
- **Probability:** HIGH | MEDIUM | LOW
- **Problem:** {{Description of the risk}}
- **Impact:** {{What happens if this occurs}}
- **Mitigation:**
  1. {{Primary mitigation strategy}}
  2. {{Secondary mitigation strategy}}
  3. {{Monitoring/early warning}}

### Timeline Risks

#### {{Risk Name}}
- **Severity:** HIGH | MEDIUM | LOW
- **Probability:** HIGH | MEDIUM | LOW
- **Problem:** {{Description}}
- **Impact:** {{Effect on schedule}}
- **Mitigation:**
  1. {{Buffer time}}
  2. {{Scope reduction}}
  3. {{Resource allocation}}

### Dependency Risks

#### {{Risk Name}}
- **Severity:** HIGH | MEDIUM | LOW
- **Probability:** HIGH | MEDIUM | LOW
- **Problem:** {{External dependency issue}}
- **Impact:** {{How it blocks progress}}
- **Mitigation:**
  1. {{Fallback option}}
  2. {{Monitoring}}
  3. {{Alternative provider}}

### Overall Risk Score
- **Total HIGH risks:** {{count}}
- **Total MEDIUM risks:** {{count}}
- **Recommendation:** [PROCEED | MITIGATE_FIRST | REDESIGN]
```

---

**For detailed patterns, see [reference.md](reference.md)**
**For more examples, see [examples.md](examples.md)**
