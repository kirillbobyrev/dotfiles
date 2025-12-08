# dotfiles

This repository contains configuration files I use on my host system, which is
Arch Linux. I sync those in order to simplify setting up working environment
whenever I have to.

I mostly try to keep configuration files as minimalistic as possible in order to
make things easier and not to pollute the environment.

## Installation

To deploy these dotfiles to your system, use the automated deployment script:

```bash
./deploy.sh
```

This will create symlinks from the repository to your `$HOME` directory. Any existing files will be automatically backed up with a `.backup.TIMESTAMP` suffix.

### Preview Changes (Dry Run)

To see what would be deployed without making any changes:

```bash
./deploy.sh --dry-run
```

### Uninstall

To remove the symlinks created by the deployment script:

```bash
./uninstall.sh
```

To remove symlinks and restore your backed-up files:

```bash
./uninstall.sh --restore
```

## What Gets Deployed

The deployment script creates symlinks for:

- **Root-level dotfiles**: `.profile`, `.zshrc`
- **Vim configuration**: `.vim/`
- **Application configs**: `.config/alacritty/`, `.config/clangd/`, `.config/git/`, `.config/nvim/`, `.config/tmux/`

## Requirements

- Bash shell
- `readlink` command (usually pre-installed on most Linux distributions)
