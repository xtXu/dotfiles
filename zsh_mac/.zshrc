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

    # You can also cherry pick just parts of the base library.
    # Not loading the base set of ohmyzsh libraries might lead to issues.
    # While you can do it, I won't recommend it unless you know how to fix
    # those issues yourself.

    # Remove `zgenom ohmyzsh` and load parts of ohmyzsh like this:
    # `zgenom ohmyzsh path/to/file.zsh`
    # zgenom ohmyzsh lib/git.zsh # load git library of ohmyzsh

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

    # use a plugin file
    # The file must only contain valid parameters for `zgenom load`
    # zgenom loadall < path/to/plugin/file

    # bulk load
#     zgenom loadall <<EOPLUGINS
#         zsh-users/zsh-history-substring-search
#         /path/to/local/plugin
# EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # add binaries
    # zgenom bin tj/git-extras


    # theme
    # zgenom ohmyzsh themes/arrow

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
    # Uncomment if you set ZDOTDIR manually
    # zgenom compile $ZDOTDIR

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi

setopt no_share_history

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


export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# starship
eval "$(starship init zsh)"
