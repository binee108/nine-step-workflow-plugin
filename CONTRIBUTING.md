# Contributing to Nine-Step Workflow Plugin

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the Nine-Step Workflow Plugin.

## 🎯 Ways to Contribute

- **Report Bugs**: Submit detailed bug reports with reproduction steps
- **Suggest Features**: Propose new agents, skills, or workflow improvements
- **Improve Documentation**: Fix typos, clarify instructions, add examples
- **Add Agents**: Create new specialized agents for specific tasks
- **Add Skills**: Develop reusable skills that multiple agents can use
- **Fix Issues**: Pick up issues labeled `good-first-issue` or `help-wanted`
- **Share Usage Patterns**: Document effective workflow patterns you discover

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR-USERNAME/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin
```

### 2. Install for Development

```bash
# Create a symlink to your local development version
ln -s $(pwd) ~/.claude/plugins/nine-step-workflow

# Or copy for testing
cp -r . ~/.claude/plugins/nine-step-workflow
```

### 3. Make Changes

Edit files in your local repository:
- `agents/` - Agent implementations
- `skills/` - Reusable skill modules
- `commands/` - Workflow commands
- `hooks/` - Event handlers

### 4. Test Your Changes

```bash
# Reload the plugin in Claude Code
claude plugin reload nine-step-workflow

# Test with a sample project
cd ~/test-project
claude
# > Test your changes interactively
```

### 5. Submit Pull Request

```bash
# Create a feature branch
git checkout -b feature/your-feature-name

# Commit your changes
git add .
git commit -m "feat: add your feature description"

# Push to your fork
git push origin feature/your-feature-name

# Create pull request on GitHub
```

## 📋 Development Guidelines

### Agent Development

**File Structure:**
```markdown
---
name: agent-name
description: Brief description (1-2 sentences)
tools: Read, Write, Edit, Grep, Glob, Bash
model: sonnet  # or haiku
---

# Agent Name - Role Title

## 🎭 Agent Persona
**Icon**: 🔧
**Job**: Professional Title
**Area of Expertise**: Specific skills
**Role**: What this agent does
**Goal**: Ultimate objective

## 🌍 Language Handling
[Language instructions]

## 🧰 Skills & Conditional Loading
[Skills used by this agent]

## 🎯 Your Role in 9-Step Workflow
[Which step this agent handles]

## Core Mission
[Detailed responsibilities]

## Output Format
[Expected outputs]

## Success Criteria
[How to evaluate success]
```

**Best Practices:**
- Use clear, action-oriented names (e.g., `database-migrator`, `api-designer`)
- Specify exact tools needed (minimize unnecessary tool access)
- Choose appropriate model (Sonnet for complex reasoning, Haiku for execution)
- Load skills conditionally (only when needed)
- Include concrete examples in documentation
- Define clear success criteria

**Model Selection:**
```
Sonnet: Architecture, design, complex decisions, security analysis
Haiku: Rule-following, repetitive tasks, simple execution
```

### Skill Development

**Directory Structure:**
```
skills/
└── your-skill/
    └── SKILL.md
```

**File Structure:**
```markdown
---
name: your-skill
description: Brief description
applies_to: ["agent1", "agent2"]  # Which agents use this
---

# Skill Name

## 🎯 Purpose
[What problem this skill solves]

## 📋 When to Use
[Specific scenarios]

## 🛠️ How to Use
[Step-by-step instructions]

## 💡 Examples

### Example 1: [Scenario]
[Code or instructions]

### Example 2: [Scenario]
[Code or instructions]

## ⚠️ Common Pitfalls
[What to avoid]

## 🔗 Related Skills
[Other skills that complement this one]
```

**Best Practices:**
- Make skills focused and reusable
- Provide 2-3 concrete examples
- Document common pitfalls
- Link to related skills
- Include metrics when applicable (e.g., "30s vs 5min")

### Command Development

**File Structure:**
```markdown
---
description: Brief command description
usage: /command-name [arguments]
---

# Command Implementation

[Command prompt and instructions]
```

**Best Practices:**
- Clear, action-oriented command names
- Support common arguments (resume, rollback, etc.)
- Provide helpful error messages
- Include usage examples in description

### Hook Development

**Add to `hooks/hooks.json`:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "ToolName",
        "hooks": [
          {
            "type": "notification",
            "message": "Helpful message"
          }
        ]
      }
    ]
  }
}
```

**Hook Types:**
- `PreToolUse`: Before tool execution
- `PostToolUse`: After tool execution
- `UserPromptSubmit`: On user input

## 🧪 Testing Guidelines

### Manual Testing Checklist

Before submitting a PR, test:

**For Agents:**
- [ ] Agent activates correctly when called
- [ ] Agent loads required skills successfully
- [ ] Agent produces expected output format
- [ ] Agent handles errors gracefully
- [ ] Agent passes work to next workflow step

**For Skills:**
- [ ] Skill loads without errors
- [ ] Examples in documentation work correctly
- [ ] Multiple agents can use the skill
- [ ] Skill provides clear error messages

**For Commands:**
- [ ] Command parses arguments correctly
- [ ] Command executes expected workflow
- [ ] Command handles missing/invalid arguments
- [ ] Command provides helpful usage info

**For Hooks:**
- [ ] Hook triggers on correct events
- [ ] Hook message is clear and actionable
- [ ] Hook doesn't interfere with workflow

### Test Projects

Create test projects for common scenarios:

```bash
test-projects/
├── simple-feature/      # Single-phase feature
├── complex-feature/     # Multi-phase feature
├── bug-fix/            # Bug investigation and fix
└── refactoring/        # Code restructuring
```

## 📝 Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature (agent, skill, command)
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test additions or fixes
- `chore`: Maintenance tasks

**Examples:**
```
feat(agent): add database-migrator agent

Implements a specialized agent for database schema migrations
with rollback support and validation.

feat(skill): add sql-injection-prevention skill

Provides patterns and checks to prevent SQL injection vulnerabilities.

docs(readme): add troubleshooting section for worktree errors

fix(command): handle missing plan document in workflow-resume

Gracefully handle case where plan document was deleted.
```

## 📚 Documentation Standards

### Code Comments

**Agent Files:**
```markdown
# Clear section headers
## Subsection organization
**Bold** for important concepts
`code` for technical terms
```

**Skill Files:**
```markdown
# Title matches skill name
## Purpose (why it exists)
## When to Use (specific scenarios)
## How to Use (step-by-step)
## Examples (2-3 concrete examples)
```

### README Updates

When adding features, update:
- Feature list with description
- Agent/skill/command tables
- Usage examples (if applicable)
- Configuration options (if applicable)

## 🔍 Code Review Process

### For Contributors

1. **Self-Review**: Check your own code first
2. **Documentation**: Update relevant docs
3. **Testing**: Test manually with real scenarios
4. **Commit Messages**: Follow conventional commit format
5. **PR Description**: Explain what, why, how

### For Reviewers

Review for:
- **Functionality**: Does it work as intended?
- **Code Quality**: Is it clean, readable, maintainable?
- **Documentation**: Is it well-documented?
- **Consistency**: Does it match existing patterns?
- **Performance**: Any performance concerns?
- **Security**: Any security implications?

## 🏷️ Issue Labels

We use these labels:

- `bug`: Something isn't working
- `feature`: New feature request
- `enhancement`: Improvement to existing feature
- `documentation`: Documentation improvements
- `good-first-issue`: Good for newcomers
- `help-wanted`: Community help appreciated
- `priority:high`: High priority
- `priority:medium`: Medium priority
- `priority:low`: Low priority
- `agent`: Related to agents
- `skill`: Related to skills
- `command`: Related to commands
- `hook`: Related to hooks

## 🎯 Roadmap Contribution

Want to work on roadmap items? Check:
- [CHANGELOG.md](./CHANGELOG.md) - Planned versions
- [GitHub Projects](https://github.com/your-org/nine-step-workflow-plugin/projects) - Task boards
- [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions) - Feature discussions

## 🤝 Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the problem, not the person
- Assume good intentions
- Help newcomers learn

### Communication

- **GitHub Issues**: Bug reports, feature requests
- **GitHub Discussions**: Ideas, questions, general discussion
- **Pull Requests**: Code contributions with clear descriptions
- **Email**: security@example.com for security issues

## 🆘 Getting Help

Stuck? Here's how to get help:

1. **Read Documentation**: Check README, CHANGELOG, and skill/agent docs
2. **Search Issues**: Someone might have asked already
3. **Ask in Discussions**: Community can help
4. **Create Issue**: If it's a bug or missing feature

## 📊 Contribution Recognition

Contributors are recognized:
- Listed in release notes
- Mentioned in CHANGELOG.md
- GitHub contributor graph
- Special recognition for major contributions

## 🔐 Security Issues

**Do not** open public issues for security vulnerabilities.

Instead:
1. Email security@example.com
2. Include detailed description
3. Provide reproduction steps
4. Allow 90 days for fix before disclosure

## 📜 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

## Questions?

- **Documentation**: [Wiki](https://github.com/your-org/nine-step-workflow-plugin/wiki)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
- **Email**: contribute@example.com

Thank you for contributing to the Nine-Step Workflow Plugin! 🎉
