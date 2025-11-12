# Nine-Step Workflow Plugin for Claude Code

> Production-ready development workflow with specialized agents, quality gates, and git worktree integration

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/your-org/nine-step-workflow-plugin)

## 🎯 Overview

The Nine-Step Workflow Plugin transforms Claude Code into a complete development team with 12 specialized agents, 17 reusable skills, and a proven 9-step workflow that ensures production-ready code through systematic planning, implementation, review, testing, and deployment.

### Why This Plugin?

- **Structured Development**: No more ad-hoc coding. Every feature follows a proven 9-step workflow
- **Quality Gates**: Multiple review stages catch issues before they reach production
- **Specialized Agents**: 12 expert agents handle specific tasks (planning, coding, review, testing, documentation)
- **Git Worktree Integration**: Isolate feature development without branch switching chaos
- **Reusable Skills**: 17 skills provide consistent approaches to common challenges
- **Phase Decomposition**: Break large features into testable 1-3 hour phases

## ✨ Features

### 🤖 12 Specialized Agents

| Agent | Role | Responsibility |
|-------|------|----------------|
| **project-planner** | Planning | Analyze requirements, create detailed implementation plans |
| **plan-reviewer** | Quality Gate | Validate plans for maintainability, risks, architecture |
| **backend-developer** | Implementation | Build server-side logic, APIs, database operations |
| **frontend-developer** | Implementation | Create UI/UX, client-side logic, API integration |
| **code-reviewer** | Quality Gate | Review code for quality, security, performance |
| **documentation-manager** | Documentation | Write clear docs, code comments, feature guides |
| **documentation-reviewer** | Quality Gate | Verify documentation clarity and accuracy |
| **feature-tester** | Testing | Execute tests, write test cases, validate functionality |
| **test-reviewer** | Quality Gate | Ensure test coverage and strategy |
| **issue-manager** | Project Management | Track issues, prioritize work, manage GitHub issues |
| **git-worktree-manager** | Infrastructure | Manage git worktrees, commits, merges, cleanup |
| **merge-conflict-resolver** | Conflict Resolution | Analyze and resolve merge conflicts systematically |

### 🎓 17 Reusable Skills

**Core Skills** (used by all agents):
- `tag-based-search` - Fast code discovery using grep and feature tags
- `interactive-questions` - Structure effective clarifying questions
- `language-conventions` - Multilingual project guidelines
- `trust-principles` - TRUST quality framework (Test, Readable, Unified, Secured, Trackable)

**Planning & Workflow Skills**:
- `nine-step-workflow` - Complete workflow guide with examples
- `phase-decomposition` - Break features into 1-3 hour phases
- `risk-assessment` - Evaluate technical, operational, security, business risks
- `code-minimization` - Justify all new code with metrics
- `plan-document-lifecycle` - Manage planning documents from creation to cleanup

**Git & Testing Skills**:
- `git-workflow-policy` - Git operations, commits, 4-stage cleanup
- `worktree-path-policy` - Prevent accidental changes to wrong codebase
- `test-file-management` - Permanent vs temporary test organization

**Architecture & Quality Skills**:
- `architecture-principles` - SSOT, DRY, anti-spaghetti patterns
- `security-checklist` - Prevent RCE, SQL injection, common vulnerabilities
- `quality-gates` - 4-level approval system (APPROVED, WITH_CONDITIONS, NEEDS_REVISION, REJECTED)
- `agent-model-selection` - Choose Sonnet vs Haiku based on task complexity
- `documentation-draft` - Structured documentation templates

### 🔄 The 9-Step Workflow

Every feature development follows this proven workflow:

```
Step 1: Plan           → project-planner creates detailed implementation plan
Step 2: Review Plan    → plan-reviewer validates approach and risks
Step 2.5: User Approval ⭐ → YOU approve before implementation starts
  ↓ (git worktree created)
Step 3: Code           → backend/frontend-developer implements in worktree
Step 4: Review Code    → code-reviewer checks quality, security, performance
Step 5: Document       → documentation-manager writes docs and comments
Step 6: Review Docs    → documentation-reviewer validates documentation
Step 7: Test           → feature-tester executes comprehensive tests
Step 8: Review Tests   → test-reviewer ensures coverage and strategy
Step 9: Commit         → git-worktree-manager commits and merges
```

### 📦 3 Workflow Commands

- `/workflow-exec` - Execute complete 9-step workflow for a feature or bug fix
- `/workflow-resume` - Resume workflow from last completed step
- `/workflow-rollback` - Roll back to previous phase or step

## 🚀 Quick Start

### Installation

1. **Install via Claude Code CLI** (recommended):
```bash
claude plugin install nine-step-workflow
```

2. **Manual Installation**:
```bash
# Clone the repository
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# Install to Claude Code plugins directory
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow
```

3. **Verify Installation**:
```bash
claude plugin list
# Should show: nine-step-workflow v1.0.0
```

### First Use

1. **Start a new feature**:
```
Hey Claude, I need to add user authentication to my app. Can you help?
```

Claude will automatically:
- Invoke `project-planner` to analyze requirements
- Create a detailed implementation plan with phases
- Submit plan to `plan-reviewer` for validation
- Ask for your approval before starting implementation

2. **Use workflow command** (explicit control):
```
/workflow-exec "Add user authentication with JWT tokens"
```

3. **Resume interrupted work**:
```
/workflow-resume
```

## 📖 Usage Examples

### Example 1: Simple Feature Addition

```
User: Add a dark mode toggle to the settings page

Workflow:
Step 1: project-planner creates 3-phase plan
  - Phase 1: Theme context and state management (2h)
  - Phase 2: UI toggle component (1.5h)
  - Phase 3: Apply theme to existing components (2h)

Step 2: plan-reviewer validates approach
Step 2.5: You approve ✅

(git worktree created: .worktree/dark-mode-toggle/)

Phase 1:
  Step 3: backend-developer implements theme context
  Step 4: code-reviewer validates
  Step 5-6: Documentation added and reviewed
  Step 7-8: Tests created and reviewed
  Step 9: Committed to worktree

Phase 2-3: (repeat steps 3-9)

Final: git-worktree-manager merges to main and cleans up
```

### Example 2: Bug Fix with Investigation

```
User: Users report that orders are not processing correctly

Workflow:
Step 1: project-planner investigates
  - Uses tag-based-search to find @FEAT:order-processing
  - Analyzes logs and code
  - Identifies race condition in order validation

Step 2: plan-reviewer validates fix approach
Step 2.5: You approve ✅

Step 3: backend-developer implements fix with lock
Step 4: code-reviewer checks for similar race conditions
Step 5-6: Documentation updated
Step 7: feature-tester creates regression test
Step 8: test-reviewer validates test prevents recurrence
Step 9: Committed and merged
```

### Example 3: Large Feature with Multiple Phases

```
User: Implement real-time notifications system

Workflow:
Step 1: project-planner decomposes into 5 phases
  Phase 1: Database schema for notifications (2h)
  Phase 2: Backend notification service (3h)
  Phase 3: WebSocket infrastructure (2.5h)
  Phase 4: Frontend notification component (2h)
  Phase 5: Integration and testing (2h)

Each phase follows complete 9-step workflow independently
User can approve/reject after each phase
Early phases can be tested before later ones start
```

## ⚙️ Configuration

### Project-Specific Customization

Create a `CLAUDE.md` file in your project root to customize:

```markdown
# Claude Code Guidelines for MyProject

## Project-Specific Rules

- Always use TypeScript strict mode
- API responses must follow JSON:API spec
- Database migrations must be reversible
- All user input must be validated with Zod schemas

## Tech Stack

- Backend: Node.js + Express + PostgreSQL
- Frontend: React + TypeScript + TailwindCSS
- Testing: Jest + React Testing Library

## Coding Standards

- Max function length: 50 lines
- Max file length: 300 lines
- Use functional components only
```

### Placeholders and Variables

The plugin uses these common placeholders that you should define in your `CLAUDE.md`:

- `{{PROJECT_NAME}}` - Your project name
- `{{TECH_STACK}}` - Technologies used
- `{{CODING_STANDARDS}}` - Your coding conventions
- `{{TEST_FRAMEWORK}}` - Testing tools
- `{{DEPLOYMENT_PROCESS}}` - How you deploy

Example:
```markdown
## Project Information
- Project Name: MyAwesomeApp
- Tech Stack: Python Flask + React + PostgreSQL
- Coding Standards: PEP 8, ESLint Standard
```

### Language Settings

Set your preferred language in `CLAUDE.md`:

```markdown
## Language Settings

- conversation_language: Korean  # or English, Japanese, etc.
- code_language: English  # Always English for code/comments
```

## 📐 Architecture

### How It Works

```
User Request
    ↓
Conductor (Claude) analyzes request
    ↓
Selects appropriate agent (e.g., project-planner)
    ↓
Agent loads required skills
    ↓
Agent executes task using skills
    ↓
Agent returns structured result
    ↓
Conductor routes to next agent (quality gate)
    ↓
Workflow continues through all 9 steps
```

### Agent-Skill Relationship

```
project-planner agent
├── Uses: tag-based-search skill (find existing code)
├── Uses: phase-decomposition skill (break into phases)
├── Uses: code-minimization skill (justify new code)
├── Uses: risk-assessment skill (identify risks)
└── Uses: interactive-questions skill (clarify requirements)

code-reviewer agent
├── Uses: architecture-principles skill (SSOT, DRY)
├── Uses: security-checklist skill (vulnerability scan)
├── Uses: quality-gates skill (approval criteria)
└── Uses: trust-principles skill (TRUST framework)
```

## 🎓 Best Practices

### 1. Always Start with Planning

Let `project-planner` analyze before jumping into code:
```
❌ Bad: "Change the login function to use JWT"
✅ Good: "I need to switch authentication from sessions to JWT. Can you plan this?"
```

### 2. Trust the Quality Gates

Don't skip review steps:
```
❌ Bad: Merge without code review
✅ Good: Let code-reviewer validate before proceeding
```

### 3. Use Phase Decomposition

Break large features into testable phases:
```
❌ Bad: "Implement entire e-commerce checkout in one phase"
✅ Good:
  Phase 1: Cart summary and validation (2h)
  Phase 2: Payment integration (2.5h)
  Phase 3: Order confirmation (1.5h)
```

### 4. Leverage Tag-Based Search

Use feature tags for fast code discovery:
```python
# @FEAT:user-auth @COMP:service @TYPE:core
class AuthService:
    def authenticate(self, credentials):
        # ...
```

### 5. Document Decisions

Use `plan-document-lifecycle`:
```
.plan/
├── user-auth_plan.md        # Active development
├── dark-mode_plan.md         # Active development
└── (deleted after merge)     # Auto-cleanup
```

## 🔍 Troubleshooting

### Issue: Agent not finding existing code

**Solution**: Ensure your code has feature tags:
```python
# @FEAT:feature-name @COMP:service @TYPE:core
```

Update `docs/FEATURE_CATALOG.md` with feature descriptions.

### Issue: Plan too vague, implementation unclear

**Solution**: Request more detail:
```
"The plan is too high-level. Can project-planner provide file-level details?"
```

Or specify "Detailed Guide" approach in planning.

### Issue: Review keeps rejecting

**Solution**: Check specific rejection reasons:
- plan-reviewer: Usually architecture or code minimization issues
- code-reviewer: Usually security or maintainability issues
- test-reviewer: Usually coverage or strategy issues

Ask reviewer to explain specific concerns.

### Issue: Worktree path errors

**Solution**: Ensure conductor passes worktree path:
```
"Work in worktree: .worktree/feature-name/"
```

Check with `git worktree list`.

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

### Development Setup

```bash
# Clone repository
git clone https://github.com/your-org/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin

# Test locally
cp -r . ~/.claude/plugins/nine-step-workflow

# Make changes to agents, skills, or commands

# Test changes
claude plugin reload nine-step-workflow
```

### Adding New Agents

1. Create agent file in `agents/`:
```markdown
---
name: your-agent
description: Brief description
tools: Read, Write, Edit
model: sonnet
---

# Your Agent Name
[Agent implementation...]
```

2. Update this README's agent table
3. Submit pull request

### Adding New Skills

1. Create skill directory in `skills/your-skill/`
2. Add `SKILL.md` with frontmatter:
```markdown
---
name: your-skill
description: Brief description
---

# Your Skill
[Skill implementation...]
```

3. Reference in relevant agents
4. Submit pull request

## 📊 Metrics & Analytics

Track workflow effectiveness:

- **Planning Accuracy**: How often plans complete as estimated
- **Review Rejection Rate**: Percentage of artifacts rejected at quality gates
- **Phase Completion Time**: Actual vs estimated time per phase
- **Code Churn**: Lines changed after reviews
- **Test Coverage**: Percentage of code covered by tests

## 🗺️ Roadmap

### v1.1.0 (Next Release)
- [ ] Performance metrics dashboard
- [ ] Custom quality gate rules
- [ ] Integration with CI/CD pipelines
- [ ] Agent performance analytics

### v1.2.0
- [ ] Multi-language support (expand beyond English/Korean)
- [ ] Custom agent templates
- [ ] Workflow visualization
- [ ] Automated rollback on test failure

### v2.0.0
- [ ] Plugin marketplace for custom agents
- [ ] Team collaboration features
- [ ] Enterprise SSO integration
- [ ] Advanced conflict resolution AI

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details

## 🙏 Acknowledgments

- Inspired by production workflows at leading tech companies
- Built on Claude Code's powerful agent framework
- Community feedback shaped the 9-step workflow

## 📞 Support

- **Documentation**: [Full docs](https://github.com/your-org/nine-step-workflow-plugin/wiki)
- **Issues**: [GitHub Issues](https://github.com/your-org/nine-step-workflow-plugin/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
- **Email**: support@example.com

## 🌟 Star History

If this plugin helps your development workflow, please star the repository!

---

**Made with ❤️ by the Nine-Step Workflow Team**

[Get Started](#quick-start) | [View Examples](#usage-examples) | [Read Docs](https://github.com/your-org/nine-step-workflow-plugin/wiki)
