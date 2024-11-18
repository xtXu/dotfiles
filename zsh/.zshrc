# auto download zgenom
if [[ ! -e "${HOME}/.zgenom" ]]; then
    git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    zgenom compdef
    # Ohmyzsh base library
    zgenom ohmyzsh

    # plugins
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/sudo
    zgenom ohmyzsh plugins/extract
    zgenom ohmyzsh plugins/z
    zgenom ohmyzsh plugins/command-not-found
		zgenom ohmyzsh plugins/safe-paste
		zgenom ohmyzsh plugins/pip
		zgenom ohmyzsh plugins/colorize
		zgenom ohmyzsh plugins/aliases
		zgenom ohmyzsh plugins/brew

    # just load the completions
    # zgenom ohmyzsh --completion plugins/docker-compose

    # Install ohmyzsh osx plugin if on macOS
    [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-autosuggestions
    # completions
    zgenom load zsh-users/zsh-completions
		zgenom load Aloxaf/fzf-tab

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
fi
# ============================================================

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ======================= fzf ===============================
if [ -f ~/.fzf.zsh ]; then
	export FZF_COMPLETION_TRIGGER='\'
	# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
	export FZF_DEFAULT_COMMAND='fd --type f --hidden'
	# export FZF_DEFAULT_OPTS="--reverse --height 60% --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
	export FZF_DEFAULT_OPTS="--reverse --height 60% "
	# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
	export FZF_CTRL_T_COMMAND='fd --hidden --exclude ".git"'
	export FZF_CTRL_R_OPTS="--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
	export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude ".git"'
	# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
	# Use fd (https://github.com/sharkdp/fd) instead of the default find
	# command for listing path candidates.
	# - The first argument to the function ($1) is the base path to start traversal
	# - See the source code (completion.{bash,zsh}) for the details.
	_fzf_compgen_path() {
		fd --hidden --exclude ".git" . "$1"
	}
	# Use fd to generate the list for directory completion
	_fzf_compgen_dir() {
		fd --type d --hidden --exclude ".git" . "$1"
	}

	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
# ============================================================


# generate .gitignore
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# shpool
shpool_choose() {
    if [ -z "$SHPOOL_SESSION_NAME" ]
    then
        cur_sess=""
    else
        cur_sess=" (current: '$SHPOOL_SESSION_NAME')"
    fi
    cmd_output=$(
    shpool list | tail -n +2 | cut -f1 | fzf \
        --bind 'k:reload-sync(shpool kill {} ; shpool list | tail -n +2 | cut -f1)' \
        --bind 'x:reload-sync(shpool kill {} ; shpool list | tail -n +2 | cut -f1)' \
        --bind 'a:execute(shpool attach --force {})' \
        --bind 'ctrl-r:reload-sync(shpool list | tail -n +2 | cut -f1 )' \
        --preview 'shpool list | tail -n +2 | sed -n "$(({n}+1))"p' \
        --bind "change:reload(shpool list | tail -n +2 | cut -f1)" \
        --reverse \
        --height=~100% \
        --preview-window down:wrap \
        --header "Shpool sessions$cur_sess" \
        --print-query \
        --no-select-1 \
        --no-exit-0
    ) || return
    # query is what is entered by the user, it's always present
    query=$(echo "$cmd_output" | head -n 1)
    # selection is the lines after query, that are only here if some sessions matched the que
ry
    selection=$(echo "$cmd_output" | tail -n +2)
    if [ "$selection" ]
    then
        # notify-send "SEL $selection"
        shpool attach --force $selection
        return
    else
        # notify-send "NOSEL: $cmd_output"
        shpool attach --force $query
        return
    fi

}
if ! command_exists shpool; then
	bindkey -s "^s" 'shpool_choose\n'
	bindkey -s "^ad" 'shpool detach\n'
fi

setopt no_share_history
if [ -d "$HOME/.cargo/env" ]; then
	source "$HOME/.cargo/env"
fi
export PATH="$HOME/.cargo/bin/:$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$PATH"

# starship
eval "$(starship init zsh)"

