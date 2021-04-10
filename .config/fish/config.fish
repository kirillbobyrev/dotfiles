fish_vi_key_bindings
set -gx LC_ALL en_US.UTF-8

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set -g pure_symbol_prompt "λ"
set -gx GOPATH /home/kirillbobyrev/go

zoxide init fish | source
