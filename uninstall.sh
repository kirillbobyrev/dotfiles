#!/bin/bash
#
# Dotfiles uninstall script
#
# This script removes symlinks created by deploy.sh and optionally restores
# backups if they exist.
#

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the absolute path to the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to remove a symlink if it points to our dotfiles
remove_symlink() {
    local target="$1"
    local expected_source="$2"
    
    if [ -L "$target" ]; then
        local actual_source
        local expected_source_abs
        actual_source=$(readlink -f "$target")
        expected_source_abs=$(readlink -f "$expected_source")
        
        if [ "$actual_source" = "$expected_source_abs" ]; then
            if ! rm "$target" 2>/dev/null; then
                print_error "Failed to remove symlink: $target"
                return 1
            fi
            print_success "Removed symlink: $target"
            return 0
        else
            print_warning "Skipping $target (points to $actual_source, not our dotfiles)"
            return 1
        fi
    elif [ -e "$target" ]; then
        print_warning "Skipping $target (not a symlink)"
        return 1
    else
        print_info "Already removed: $target"
        return 0
    fi
}

# Function to find and optionally restore the most recent backup
restore_backup() {
    local target="$1"
    
    # Find the most recent backup (portable across Linux and macOS/BSD)
    local latest_backup
    # Try GNU stat first, then BSD stat
    if stat -c '%Y' "$(dirname "$target")" >/dev/null 2>&1; then
        # GNU stat (Linux)
        latest_backup=$(find "$(dirname "$target")" -maxdepth 1 -name "$(basename "$target").backup.*" -type f -exec stat -c '%Y %n' {} \; 2>/dev/null | sort -rn | head -n 1 | cut -d' ' -f2-)
    else
        # BSD stat (macOS)
        latest_backup=$(find "$(dirname "$target")" -maxdepth 1 -name "$(basename "$target").backup.*" -type f -exec stat -f '%m %N' {} \; 2>/dev/null | sort -rn | head -n 1 | cut -d' ' -f2-)
    fi
    
    if [ -n "$latest_backup" ] && [ -e "$latest_backup" ]; then
        print_info "Found backup: $latest_backup"
        
        if [ "$RESTORE_BACKUPS" = true ]; then
            mv "$latest_backup" "$target"
            print_success "Restored backup: $latest_backup -> $target"
        else
            print_info "Use --restore to restore this backup"
        fi
    fi
}

# Main uninstall function
uninstall_dotfiles() {
    print_info "Starting dotfiles uninstall"
    echo ""
    
    # Remove root-level dotfiles
    print_info "Removing root-level dotfiles..."
    remove_symlink "$HOME/.profile" "$DOTFILES_DIR/.profile" && restore_backup "$HOME/.profile"
    remove_symlink "$HOME/.zshrc" "$DOTFILES_DIR/.zshrc" && restore_backup "$HOME/.zshrc"
    echo ""
    
    # Remove .vim directory
    print_info "Removing .vim configuration..."
    remove_symlink "$HOME/.vim" "$DOTFILES_DIR/.vim" && restore_backup "$HOME/.vim"
    echo ""
    
    # Remove .config subdirectories
    print_info "Removing .config subdirectories..."
    for config_dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$config_dir" ]; then
            local dir_name
            local target
            dir_name=$(basename "$config_dir")
            target="$HOME/.config/$dir_name"
            remove_symlink "$target" "$config_dir" && restore_backup "$target"
        fi
    done
    echo ""
    
    print_success "Dotfiles uninstall completed!"
    
    if [ "$RESTORE_BACKUPS" != true ]; then
        echo ""
        print_info "Backup files were not restored. Use --restore to restore them."
    fi
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Remove dotfiles symlinks created by deploy.sh.

OPTIONS:
    -h, --help      Show this help message
    -r, --restore   Restore backup files after removing symlinks
    -d, --dry-run   Show what would be done without making changes

DESCRIPTION:
    This script removes symlinks created by deploy.sh. Only symlinks that point
    to this dotfiles repository will be removed. Use --restore to automatically
    restore the most recent backup files.

EXAMPLES:
    # Remove dotfiles symlinks
    ./uninstall.sh

    # Remove symlinks and restore backups
    ./uninstall.sh --restore

    # See what would be removed without making changes
    ./uninstall.sh --dry-run

EOF
}

# Parse command line arguments
DRY_RUN=false
RESTORE_BACKUPS=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -r|--restore)
            RESTORE_BACKUPS=true
            shift
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Dry run mode
if [ "$DRY_RUN" = true ]; then
    print_info "DRY RUN MODE - No changes will be made"
    echo ""
    print_info "The following symlinks would be removed (if they exist and point to our dotfiles):"
    echo ""
    echo "  $HOME/.profile"
    echo "  $HOME/.zshrc"
    echo "  $HOME/.vim"
    for config_dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$config_dir" ]; then
            dir_name=$(basename "$config_dir")
            echo "  $HOME/.config/$dir_name"
        fi
    done
    echo ""
    print_info "Run without --dry-run to perform the uninstall"
    exit 0
fi

# Run the uninstall
uninstall_dotfiles
