# Installation Guide

Complete guide for installing and configuring the Nine-Step Workflow Plugin.

## 📋 Prerequisites

- **Claude Code**: Version 1.0.0 or higher
- **Git**: Version 2.25 or higher (for worktree features)
- **Operating System**: macOS, Linux, or Windows with WSL

## 🚀 Installation Methods

### Method 1: Claude Code CLI (Recommended)

```bash
# Install from Claude Code marketplace
claude plugin install nine-step-workflow

# Verify installation
claude plugin list

# Expected output:
# ✓ nine-step-workflow v1.0.0
#   Production-ready 9-step development workflow
```

### Method 2: Manual Installation

```bash
# 1. Download the plugin
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# 2. Create plugins directory if it doesn't exist
mkdir -p ~/.claude/plugins

# 3. Copy plugin to Claude Code plugins directory
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow

# 4. Verify installation
claude plugin list
```

### Method 3: Development Installation (For Contributors)

```bash
# 1. Clone the repository
git clone https://github.com/your-org/nine-step-workflow-plugin.git
cd nine-step-workflow-plugin

# 2. Symlink for development (changes reflect immediately)
ln -s $(pwd) ~/.claude/plugins/nine-step-workflow

# 3. Test changes
claude plugin reload nine-step-workflow
```

## ⚙️ Configuration

### Step 1: Create Project Configuration

Create a `CLAUDE.md` file in your project root:

```markdown
# Claude Code Guidelines for MyProject

## Project Information
- **Project Name**: MyAwesomeApp
- **Description**: Brief project description
- **Tech Stack**: Python Flask, React, PostgreSQL
- **Version**: 1.0.0

## Tech Stack Details

### Backend
- Framework: Flask 2.3.0
- Database: PostgreSQL 14
- ORM: SQLAlchemy 2.0
- API Style: RESTful JSON

### Frontend
- Framework: React 18
- State Management: Redux Toolkit
- UI Library: Material-UI 5
- Build Tool: Vite

### Testing
- Backend: pytest, pytest-cov
- Frontend: Jest, React Testing Library
- E2E: Playwright

## Coding Standards

### General Rules
- Max function length: 50 lines
- Max file length: 300 lines
- Use type hints (Python) / TypeScript
- All public APIs must have docstrings

### Python Standards
- Follow PEP 8
- Use Black for formatting
- Use pylint for linting
- Type hints required

### JavaScript/TypeScript Standards
- Follow ESLint Standard config
- Use Prettier for formatting
- Functional components only (React)
- Hooks for state management

## Development Workflow

### Feature Development
1. Create issue in GitHub
2. Run `/workflow-exec` with feature description
3. Follow 9-step workflow
4. Merge after all quality gates pass

### Bug Fixes
1. Reproduce bug
2. Create failing test
3. Run `/workflow-exec` with bug description
4. Fix must pass new test

## Security Requirements

### Authentication
- JWT tokens with 15-minute expiration
- Refresh tokens with 7-day expiration
- Password minimum 12 characters

### Input Validation
- All user input validated with Pydantic (backend)
- All user input validated with Zod (frontend)
- SQL parameterization required (no string concatenation)

### API Security
- Rate limiting: 100 req/min per IP
- CORS: whitelist specific origins
- HTTPS required in production

## Testing Requirements

### Code Coverage
- Minimum: 80% overall
- Critical paths: 100% coverage
- All public APIs: 100% coverage

### Test Strategy
- Unit tests for all business logic
- Integration tests for API endpoints
- E2E tests for critical user flows

## Documentation Standards

### Code Comments
- All public functions/classes documented
- Complex algorithms explained
- TODOs tracked in GitHub issues

### API Documentation
- OpenAPI/Swagger spec maintained
- All endpoints documented
- Request/response examples provided

## Deployment Process

### Environments
- Development: Local
- Staging: staging.myapp.com
- Production: myapp.com

### Deployment Steps
1. All tests pass
2. Code reviewed and approved
3. Staging deployment and smoke tests
4. Production deployment
5. Monitor for 30 minutes

## Language Settings

- **Conversation Language**: English
- **Code Language**: English (always)
- **Documentation Language**: English
- **Comment Language**: English (always)
```

### Step 2: Add Feature Tags to Existing Code

Tag your existing code for fast discovery:

```python
# Example: Python backend service
# @FEAT:user-authentication @COMP:service @TYPE:core @DEPS:database
class AuthService:
    """Handle user authentication and authorization."""

    # @FEAT:user-authentication @COMP:service @TYPE:core
    def authenticate(self, email: str, password: str) -> User:
        """Authenticate user with email and password."""
        # Implementation...
```

```javascript
// Example: React frontend component
// @FEAT:user-profile @COMP:component @TYPE:ui
export function UserProfile({ userId }) {
  // @FEAT:user-profile @COMP:component @TYPE:helper
  const fetchUserData = async (id) => {
    // Implementation...
  };
}
```

### Step 3: Create Feature Catalog

Create `docs/FEATURE_CATALOG.md`:

```markdown
# Feature Catalog

## Authentication Features

### user-authentication
- **Description**: User login, logout, JWT token management
- **Components**: AuthService, LoginForm, AuthMiddleware
- **Tags**: @FEAT:user-authentication
- **Files**:
  - backend/services/auth_service.py
  - frontend/components/LoginForm.jsx
  - backend/middleware/auth_middleware.py

### password-reset
- **Description**: Password reset via email
- **Components**: PasswordResetService, ResetForm
- **Tags**: @FEAT:password-reset
- **Dependencies**: @FEAT:user-authentication, email-service

## User Management Features

### user-profile
- **Description**: User profile viewing and editing
- **Components**: UserService, ProfilePage, ProfileForm
- **Tags**: @FEAT:user-profile
- **Files**:
  - backend/services/user_service.py
  - frontend/pages/ProfilePage.jsx

## Data Features

### data-export
- **Description**: Export user data in various formats
- **Components**: ExportService, ExportButton
- **Tags**: @FEAT:data-export
- **Dependencies**: @FEAT:user-profile

[Add more features...]
```

### Step 4: Configure Git Worktree Directory

Add to your `.gitignore`:

```bash
# Git worktrees
.worktree/

# Planning documents
.plan/

# Temporary test files
.test/
```

### Step 5: Test Installation

```bash
# Navigate to your project
cd ~/my-project

# Start Claude Code
claude

# Test the plugin
# > /workflow-exec "Add a simple feature to test the plugin"
```

Expected behavior:
1. `project-planner` agent activates
2. Creates implementation plan
3. `plan-reviewer` validates
4. Asks for your approval
5. Creates git worktree
6. Proceeds with implementation

## 🔧 Troubleshooting

### Issue: Plugin not found

```bash
# Check installation
ls ~/.claude/plugins/nine-step-workflow

# If missing, reinstall
claude plugin install nine-step-workflow
```

### Issue: Agents not activating

**Symptom**: Claude doesn't use specialized agents

**Solution**:
1. Verify plugin is enabled: `claude plugin list`
2. Check plugin.json is valid: `cat ~/.claude/plugins/nine-step-workflow/.claude-plugin/plugin.json`
3. Reload plugin: `claude plugin reload nine-step-workflow`

### Issue: Tag-based search not working

**Symptom**: Agents can't find existing code

**Solution**:
1. Add feature tags to your code (see Step 2)
2. Create `docs/FEATURE_CATALOG.md` (see Step 3)
3. Verify tags with: `grep -r "@FEAT:" --include="*.py" --include="*.js"`

### Issue: Worktree creation fails

**Symptom**: Error creating git worktree

**Solution**:
1. Check git version: `git --version` (need 2.25+)
2. Ensure you're in a git repository: `git status`
3. Create `.worktree/` directory: `mkdir .worktree`
4. Add to `.gitignore`: `echo ".worktree/" >> .gitignore`

### Issue: Skills not loading

**Symptom**: Agent says "Skill not found"

**Solution**:
1. Check skills directory exists:
   ```bash
   ls ~/.claude/plugins/nine-step-workflow/skills/
   ```
2. Verify SKILL.md files:
   ```bash
   find ~/.claude/plugins/nine-step-workflow/skills -name "SKILL.md"
   ```
3. Reinstall plugin if files are missing

### Issue: Commands not working

**Symptom**: `/workflow-exec` not recognized

**Solution**:
1. Check commands directory:
   ```bash
   ls ~/.claude/plugins/nine-step-workflow/commands/
   ```
2. Verify frontmatter in command files
3. Reload Claude Code
4. Try: `claude plugin reload nine-step-workflow`

## 🎓 Next Steps

After installation:

1. **Read the Quick Start**: See [README.md](./README.md#quick-start)
2. **Try Examples**: Test with simple features first
3. **Customize Configuration**: Adapt `CLAUDE.md` to your project
4. **Add Feature Tags**: Tag existing code for better discovery
5. **Join Community**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)

## 🔄 Updating

### Update via CLI

```bash
# Check for updates
claude plugin update nine-step-workflow

# View changelog
cat ~/.claude/plugins/nine-step-workflow/CHANGELOG.md
```

### Update Manually

```bash
# Backup current version
cp -r ~/.claude/plugins/nine-step-workflow ~/.claude/plugins/nine-step-workflow.backup

# Download new version
git clone https://github.com/your-org/nine-step-workflow-plugin.git

# Replace old version
rm -rf ~/.claude/plugins/nine-step-workflow
cp -r nine-step-workflow-plugin ~/.claude/plugins/nine-step-workflow

# Reload plugin
claude plugin reload nine-step-workflow
```

## 🗑️ Uninstallation

### Via CLI

```bash
claude plugin uninstall nine-step-workflow
```

### Manual Uninstallation

```bash
# Remove plugin directory
rm -rf ~/.claude/plugins/nine-step-workflow

# Verify removal
claude plugin list
```

### Cleanup Project Configuration (Optional)

If you want to completely remove plugin traces from your project:

```bash
# Remove planning documents
rm -rf .plan/

# Remove worktrees
git worktree list | grep ".worktree" | awk '{print $1}' | xargs -I {} git worktree remove {}

# Remove worktree directory
rm -rf .worktree/

# Remove test directory
rm -rf .test/

# Remove feature catalog (if not needed)
rm docs/FEATURE_CATALOG.md
```

**Note**: Keep your `CLAUDE.md` as it may have project-specific guidelines.

## 🆘 Support

If you encounter issues:

1. **Check Documentation**: [README.md](./README.md), [CONTRIBUTING.md](./CONTRIBUTING.md)
2. **Search Issues**: [GitHub Issues](https://github.com/your-org/nine-step-workflow-plugin/issues)
3. **Ask Community**: [GitHub Discussions](https://github.com/your-org/nine-step-workflow-plugin/discussions)
4. **Report Bug**: Create a detailed issue with reproduction steps

---

**Installation complete! Ready to build with the 9-step workflow.** 🚀
