#!/bin/bash
#
# Dotfiles deployment script
#
# This script creates symlinks from the repository to $HOME, making it easy to
# keep your dotfiles synchronized across multiple machines.
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

# Function to create a backup of an existing file or directory
backup_file() {
    local file="$1"
    local backup
    backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mv "$file" "$backup"
        print_warning "Backed up existing $file to $backup"
        return 0
    fi
    return 1
}

# Function to create a symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # If target is a symlink pointing to the correct source, skip
    if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$source")" ]; then
        print_info "Already linked: $target -> $source"
        return 0
    fi
    
    # If target exists but is not the correct symlink, back it up
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup_file "$target"
    fi
    
    # Create parent directory if it doesn't exist
    local target_dir
    target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        print_info "Created directory: $target_dir"
    fi
    
    # Create the symlink
    if ! ln -s "$source" "$target" 2>/dev/null; then
        print_error "Failed to create symlink: $target -> $source"
        return 1
    fi
    print_success "Linked: $target -> $source"
}

# Main deployment function
deploy_dotfiles() {
    print_info "Starting dotfiles deployment from $DOTFILES_DIR"
    echo ""
    
    # Deploy root-level dotfiles
    print_info "Deploying root-level dotfiles..."
    create_symlink "$DOTFILES_DIR/.profile" "$HOME/.profile"
    create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    echo ""
    
    # Deploy .vim directory
    print_info "Deploying .vim configuration..."
    create_symlink "$DOTFILES_DIR/.vim" "$HOME/.vim"
    echo ""
    
    # Deploy .config subdirectories
    print_info "Deploying .config subdirectories..."
    for config_dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$config_dir" ]; then
            local dir_name
            dir_name=$(basename "$config_dir")
            create_symlink "$config_dir" "$HOME/.config/$dir_name"
        fi
    done
    echo ""
    
    print_success "Dotfiles deployment completed successfully!"
    echo ""
    print_info "Note: Any existing files have been backed up with a .backup.TIMESTAMP suffix."
}

# Function to show usage
show_usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Automated dotfiles deployment script.

OPTIONS:
    -h, --help      Show this help message
    -d, --dry-run   Show what would be done without making changes

DESCRIPTION:
    This script creates symlinks from the dotfiles repository to your home
    directory. Any existing files will be backed up automatically.

EXAMPLES:
    # Deploy dotfiles
    ./deploy.sh

    # See what would be deployed without making changes
    ./deploy.sh --dry-run

EOF
}

# Parse command line arguments
DRY_RUN=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
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
    print_info "The following symlinks would be created:"
    echo ""
    echo "  $HOME/.profile -> $DOTFILES_DIR/.profile"
    echo "  $HOME/.zshrc -> $DOTFILES_DIR/.zshrc"
    echo "  $HOME/.vim -> $DOTFILES_DIR/.vim"
    for config_dir in "$DOTFILES_DIR/.config"/*; do
        if [ -d "$config_dir" ]; then
            dir_name=$(basename "$config_dir")
            echo "  $HOME/.config/$dir_name -> $config_dir"
        fi
    done
    echo ""
    print_info "Run without --dry-run to perform the deployment"
    exit 0
fi

# Run the deployment
deploy_dotfiles
