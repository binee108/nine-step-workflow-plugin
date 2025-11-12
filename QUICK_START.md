# Quick Start Guide

Get up and running with the Nine-Step Workflow Plugin in 5 minutes.

## 🚀 Installation (1 minute)

```bash
# Install the plugin
claude plugin install nine-step-workflow

# Verify installation
claude plugin list
# Should show: ✓ nine-step-workflow v1.0.0
```

## ⚙️ Minimal Configuration (2 minutes)

Create `CLAUDE.md` in your project root:

```markdown
# Claude Code Guidelines

## Project Information
- Project Name: MyApp
- Tech Stack: [Your stack, e.g., Python Flask, React]
- Coding Standards: [Your standards, e.g., PEP 8, ESLint]

## Language Settings
- Conversation Language: English
- Code Language: English
```

Add to `.gitignore`:
```bash
echo ".worktree/" >> .gitignore
echo ".plan/" >> .gitignore
echo ".test/" >> .gitignore
```

## 🎯 First Feature (2 minutes)

Start Claude Code and try:

```
User: I need to add a dark mode toggle to my app settings. Can you help?

Expected Flow:
1. project-planner analyzes requirements
2. Creates 3-phase implementation plan
3. plan-reviewer validates approach
4. Asks for your approval
5. Creates git worktree
6. Implements each phase (Steps 3-9)
7. Merges and cleans up
```

Or use the explicit command:

```
/workflow-exec "Add dark mode toggle to settings"
```

## ✅ Success Indicators

You'll know it's working when:

1. **Planning**: You see detailed phase breakdown
   ```
   Phase 1: Theme state management (2h)
   Phase 2: UI toggle component (1.5h)
   Phase 3: Apply to existing components (2h)
   ```

2. **Approval**: Plugin asks for your approval before coding
   ```
   🤔 Do you approve this plan? (Step 2.5)
   ```

3. **Worktree**: Git worktree created automatically
   ```
   .worktree/dark-mode-toggle/ created
   ```

4. **Quality Gates**: Multiple review stages
   ```
   ✅ Code reviewed - APPROVED
   ✅ Docs reviewed - APPROVED
   ✅ Tests reviewed - APPROVED
   ```

5. **Cleanup**: Automatic cleanup after merge
   ```
   ✅ Plan deleted
   ✅ Worktree removed
   ✅ Branch cleaned up
   ```

## 🎓 Next Steps

- **Read Full Docs**: [README.md](./README.md)
- **Configure Project**: [INSTALLATION.md](./INSTALLATION.md)
- **Learn Workflow**: [Skills: nine-step-workflow](./skills/nine-step-workflow/SKILL.md)
- **Add Tags**: Tag your code with `@FEAT:` for fast discovery
- **Create Catalog**: `docs/FEATURE_CATALOG.md` for feature listing

## 💡 Quick Tips

1. **Use Tags**: Add `# @FEAT:feature-name` to your code for 30-second discovery
2. **Trust Quality Gates**: Don't skip review steps
3. **Break Into Phases**: Large features work better as multiple 1-3 hour phases
4. **Approve Plans**: Always review plans at Step 2.5 before implementation
5. **Let It Clean**: Plugin auto-cleans after merge (don't delete worktrees manually)

## 🆘 Common Issues

**Plugin not found?**
```bash
ls ~/.claude/plugins/nine-step-workflow
# If missing: claude plugin install nine-step-workflow
```

**Agents not activating?**
```bash
claude plugin reload nine-step-workflow
```

**Worktree errors?**
```bash
git --version  # Need 2.25+
mkdir .worktree
```

## 📚 Resources

- [Full README](./README.md) - Complete documentation
- [Installation Guide](./INSTALLATION.md) - Detailed setup
- [Contributing](./CONTRIBUTING.md) - Join development
- [Changelog](./CHANGELOG.md) - Version history

---

**You're ready! Start building with the 9-step workflow.** 🎉
