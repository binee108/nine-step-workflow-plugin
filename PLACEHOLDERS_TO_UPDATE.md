# Placeholders to Update Before Publication

This document lists all placeholders that must be updated before publishing to the Claude Code marketplace.

## 🔴 Critical Updates Required

### 1. GitHub URLs

**Files to Update**:
- `.claude-plugin/plugin.json`
- `README.md`
- `CHANGELOG.md`
- `CONTRIBUTING.md`
- `INSTALLATION.md`

**Find and Replace**:
```bash
# Find all occurrences
grep -r "your-org" .
grep -r "github.com/your-org" .

# Replace with your actual organization/username
# Example: github.com/anthropic/nine-step-workflow-plugin
```

**Specific Replacements**:
- `https://github.com/your-org/nine-step-workflow-plugin`
- `https://github.com/your-org/nine-step-workflow-plugin/issues`
- `https://github.com/your-org/nine-step-workflow-plugin/discussions`
- `https://github.com/your-org/nine-step-workflow-plugin/wiki`

### 2. Email Addresses

**Files to Update**:
- `.claude-plugin/plugin.json`
- `README.md`
- `CONTRIBUTING.md`
- `INSTALLATION.md`

**Find and Replace**:
```bash
grep -r "example.com" .
grep -r "@example.com" .
```

**Specific Replacements**:
- `contact@example.com` → Your contact email
- `support@example.com` → Your support email
- `security@example.com` → Your security email
- `contribute@example.com` → Your contribution email

### 3. Author Information

**File**: `.claude-plugin/plugin.json`

**Current**:
```json
"author": {
  "name": "Nine-Step Workflow Team",
  "email": "contact@example.com"
}
```

**Update to**:
```json
"author": {
  "name": "Your Name or Organization",
  "email": "your-email@domain.com"
}
```

## 🟡 Optional Updates (Recommended)

### 4. Homepage URL

**File**: `.claude-plugin/plugin.json`

**Current**:
```json
"homepage": "https://github.com/your-org/nine-step-workflow-plugin"
```

**Options**:
- GitHub repository URL (same as repository field)
- Dedicated documentation website
- Project landing page

### 5. Repository URL Verification

**File**: `.claude-plugin/plugin.json`

Ensure `repository` field matches your actual GitHub repository:
```json
"repository": "https://github.com/YOUR-USERNAME/nine-step-workflow-plugin"
```

## 🔍 How to Find All Placeholders

### Search Commands

```bash
# Navigate to plugin directory
cd /Users/binee/Desktop/quant/webserver/nine-step-workflow-plugin

# Find all "your-org" references
grep -rn "your-org" . --exclude-dir=.git

# Find all example.com references
grep -rn "example.com" . --exclude-dir=.git

# Find all TODO/FIXME comments (if any)
grep -rn "TODO\|FIXME" . --exclude-dir=.git
```

### Files Most Likely to Contain Placeholders

1. `.claude-plugin/plugin.json` (CRITICAL)
2. `README.md` (Many links)
3. `INSTALLATION.md` (Installation URLs)
4. `CONTRIBUTING.md` (Repository links)
5. `CHANGELOG.md` (Issue tracking links)

## ✅ Verification Checklist

Before publishing, verify:

- [ ] All GitHub URLs point to your repository
- [ ] All email addresses are functional
- [ ] Author information is correct in plugin.json
- [ ] Homepage URL is accessible
- [ ] Repository URL is correct
- [ ] Support email responds to inquiries
- [ ] Security email is monitored
- [ ] All links are clickable and valid
- [ ] No "your-org" references remain
- [ ] No "example.com" references remain

## 🔧 Automated Update Script

Save this as `update-placeholders.sh`:

```bash
#!/bin/bash

# Configuration
ORG="your-github-username"
REPO="nine-step-workflow-plugin"
CONTACT_EMAIL="your-email@domain.com"
SUPPORT_EMAIL="support@domain.com"
SECURITY_EMAIL="security@domain.com"
AUTHOR_NAME="Your Name"

# Backup first
cp -r . ../nine-step-workflow-plugin.backup

# Update GitHub URLs
find . -type f -not -path "./.git/*" -exec sed -i '' "s|your-org|$ORG|g" {} +

# Update email addresses
find . -type f -not -path "./.git/*" -exec sed -i '' "s|contact@example.com|$CONTACT_EMAIL|g" {} +
find . -type f -not -path "./.git/*" -exec sed -i '' "s|support@example.com|$SUPPORT_EMAIL|g" {} +
find . -type f -not -path "./.git/*" -exec sed -i '' "s|security@example.com|$SECURITY_EMAIL|g" {} +

# Update author name in plugin.json
sed -i '' "s|Nine-Step Workflow Team|$AUTHOR_NAME|g" .claude-plugin/plugin.json

echo "✅ Placeholders updated!"
echo "⚠️  Please verify all changes before committing"
```

**Usage**:
1. Edit the configuration variables at the top
2. Run: `chmod +x update-placeholders.sh`
3. Run: `./update-placeholders.sh`
4. Verify: Review all changes with `git diff`

## 📋 Manual Update Checklist

If updating manually, follow this order:

### Step 1: Update plugin.json
```json
{
  "author": {
    "name": "YOUR_NAME",
    "email": "YOUR_EMAIL"
  },
  "homepage": "YOUR_HOMEPAGE",
  "repository": "YOUR_REPO_URL"
}
```

### Step 2: Update README.md
- All GitHub links in header
- Installation instructions
- Support section
- Contributing links
- Issue tracking links

### Step 3: Update INSTALLATION.md
- Repository clone URLs
- GitHub issue links
- Discussion forum links

### Step 4: Update CONTRIBUTING.md
- Fork/clone instructions
- Issue/PR links
- Discussion links
- Contact emails

### Step 5: Update CHANGELOG.md
- Issue links
- Discussion links
- Support email

### Step 6: Verify Everything
```bash
# Check for remaining placeholders
grep -r "your-org" . | grep -v ".git" | grep -v "PLACEHOLDERS_TO_UPDATE"
grep -r "example.com" . | grep -v ".git" | grep -v "PLACEHOLDERS_TO_UPDATE"
```

## 🚨 Critical Reminder

**DO NOT publish to marketplace without updating these placeholders!**

Users will see:
- Broken links (404 errors)
- Bounced emails
- Placeholder names
- Unprofessional appearance

Take time to update everything properly before your first release.

## 📞 Questions?

If you're unsure about any placeholder:
1. Check this document
2. Search the file for context
3. Look at similar successful plugins
4. Ask in Claude Code community

---

**Last Updated**: 2025-01-10
**Purpose**: Guide for updating placeholders before marketplace publication
