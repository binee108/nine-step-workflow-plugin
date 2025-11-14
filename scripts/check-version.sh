#!/bin/bash

# Nine-Step Workflow Plugin - Version Checker
# This script checks for plugin updates from GitHub

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Plugin directory (should be the parent of scripts/)
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VERSION_FILE="$PLUGIN_DIR/.version.json"
PLUGIN_JSON="$PLUGIN_DIR/.claude-plugin/plugin.json"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Function to extract version from plugin.json
get_current_version() {
    if [ -f "$PLUGIN_JSON" ]; then
        grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "$PLUGIN_JSON" | cut -d'"' -f4
    else
        echo "unknown"
    fi
}

# Function to extract repository from version file
get_repository() {
    if [ -f "$VERSION_FILE" ]; then
        grep -o '"repository"[[:space:]]*:[[:space:]]*"[^"]*"' "$VERSION_FILE" | cut -d'"' -f4
    else
        echo "binee108/nine-step-workflow-plugin"
    fi
}

# Function to get latest version from GitHub
get_latest_version() {
    local repo=$1
    local api_url="https://api.github.com/repos/$repo/releases/latest"

    # Try to get latest release
    local response=$(curl -s "$api_url")

    # Check if we got a valid response
    if echo "$response" | grep -q '"tag_name"'; then
        echo "$response" | grep -o '"tag_name"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4 | sed 's/^v//'
    else
        # If no releases, try to get from plugin.json in main branch
        local raw_url="https://raw.githubusercontent.com/$repo/main/.claude-plugin/plugin.json"
        local version=$(curl -s "$raw_url" | grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' | cut -d'"' -f4)
        echo "$version"
    fi
}

# Function to compare versions (semver)
version_greater_than() {
    local ver1=$1
    local ver2=$2

    # Remove 'v' prefix if present
    ver1=$(echo "$ver1" | sed 's/^v//')
    ver2=$(echo "$ver2" | sed 's/^v//')

    # Split versions into array
    IFS='.' read -ra V1 <<< "$ver1"
    IFS='.' read -ra V2 <<< "$ver2"

    # Compare major, minor, patch
    for i in 0 1 2; do
        local num1=${V1[$i]:-0}
        local num2=${V2[$i]:-0}

        if [ "$num1" -gt "$num2" ]; then
            return 0
        elif [ "$num1" -lt "$num2" ]; then
            return 1
        fi
    done

    return 1  # Equal versions
}

# Function to update version cache
update_version_cache() {
    local current_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    if [ -f "$VERSION_FILE" ]; then
        # Update lastChecked field
        if command -v jq &> /dev/null; then
            # If jq is available, use it
            jq ".lastChecked = \"$current_time\"" "$VERSION_FILE" > "$VERSION_FILE.tmp"
            mv "$VERSION_FILE.tmp" "$VERSION_FILE"
        else
            # Fallback: simple sed replacement
            sed -i.bak "s/\"lastChecked\"[[:space:]]*:[[:space:]]*[^,]*/\"lastChecked\": \"$current_time\"/" "$VERSION_FILE"
            rm -f "$VERSION_FILE.bak"
        fi
    fi
}

# Main execution
main() {
    local check_only=false
    local force=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --check-only)
                check_only=true
                shift
                ;;
            --force)
                force=true
                shift
                ;;
            *)
                shift
                ;;
        esac
    done

    print_info "Checking for Nine-Step Workflow Plugin updates..."
    echo ""

    # Get current version
    local current_version=$(get_current_version)
    print_info "Current version: v$current_version"

    # Get repository
    local repo=$(get_repository)
    print_info "Repository: $repo"

    # Get latest version
    print_info "Fetching latest version from GitHub..."
    local latest_version=$(get_latest_version "$repo")

    if [ -z "$latest_version" ] || [ "$latest_version" = "unknown" ]; then
        print_error "Failed to fetch latest version from GitHub"
        print_warning "Please check your internet connection or try again later"
        exit 1
    fi

    print_info "Latest version: v$latest_version"
    echo ""

    # Update cache
    update_version_cache

    # Compare versions
    if version_greater_than "$latest_version" "$current_version"; then
        print_warning "Update available: v$current_version → v$latest_version"
        echo ""
        echo "To update, run:"
        echo "  /plugin-update"
        echo ""
        echo "Or manually:"
        echo "  cd $PLUGIN_DIR"
        echo "  git pull origin main"
        return 2
    else
        print_success "Plugin is up-to-date (v$current_version)"
        return 0
    fi
}

# Run main function
main "$@"
exit $?
