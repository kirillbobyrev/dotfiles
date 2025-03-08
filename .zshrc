# Minimal .zshrc with Colorful, Git-Aware Prompt

# ----------------------------
# 1. Basic Initialization
# ----------------------------
# Load color definitions and enable prompt substitution.
autoload -U colors && colors
setopt PROMPT_SUBST

# Initialize command auto-completion.
autoload -U compinit && compinit

# Enable extended globbing for advanced pattern matching.
setopt extended_glob

# Enable vi-style keybindings.
bindkey -v

# ----------------------------
# 2. History Configuration
# ----------------------------
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# ----------------------------
# 3. Git Integration
# ----------------------------
# Function to extract the current Git branch.
git_branch() {
  local branch
  branch=$(git symbolic-ref HEAD 2>/dev/null | sed 's/refs\/heads\///')
  if [[ -n "$branch" ]]; then
    echo " %{$fg[cyan]%}($branch)%{$reset_color%}"
  fi
}

# ----------------------------
# 4. Prompt Setup
# ----------------------------
# The prompt will show:
#   - Username@hostname in bold green.
#   - Current directory in bold blue.
#   - Git branch (if in a Git repo) in cyan.
#   - A prompt character (# for root, % for normal users).
PROMPT='%{$fg_bold[green]%}%n@%m %{$fg_bold[blue]%}%~$(git_branch)%{$reset_color%} %# '

# ----------------------------
# 5. Aliases and Shortcuts
# ----------------------------
alias ll='ls -l'
alias la='ls -la'
alias g='git'
alias gs='git status'
alias gc='git commit'
alias gp='git push'

# ----------------------------
# 6. Local Overrides
# ----------------------------
# Source additional settings from ~/.zshrc.local if the file exists.
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

