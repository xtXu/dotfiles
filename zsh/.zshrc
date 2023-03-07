if [ ! -f ~/.zi/bin/zi.zsh ];then
	source <(curl -sL init.zshell.dev); zzinit
else
	source ~/.zi/bin/zi.zsh
fi


zi wait lucid light-mode for \
	paulirish/git-open \
	wfxr/forgit \
	conda-incubator/conda-zsh-completion \
	changyuheng/zsh-interactive-cd \
	# changyuheng/fz

zi wait lucid for \
	OMZ::lib/history.zsh \
	OMZ::lib/theme-and-appearance.zsh \
	OMZP::git \
	OMZP::extract \
	OMZP::z \
	OMZP::command-not-found \
	OMZP::sudo \
	OMZP::safe-paste \
	OMZP::pip \
	OMZP::colorize

# completion init
zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
     z-shell/F-Sy-H \
  blockf \
     zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
     zsh-users/zsh-autosuggestions
 


setopt no_share_history
setopt nonomatch

# aliases
alias c="xclip -selection clipboard" # {cmd} | c to redirect the output to the system clipboard

# Path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# proxy
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

# ROS
source /opt/ros/melodic/setup.zsh

# case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# fzf
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

# interactive cd when no arguments
function cd() {
	if [[ "$#" != 0 ]]; then
			builtin cd "$@";
			return
	fi
	while true; do
			local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
			local dir="$(printf '%s\n' "${lsd[@]}" |
					fzf --reverse --preview '
							__cd_nxt="$(echo {})";
							__cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
							echo $__cd_path;
							echo;
							ls -p --color=always "${__cd_path}";
			')"
			[[ ${#dir} != 0 ]] || return 0
			builtin cd "$dir" &> /dev/null
	done
}

# conda
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/xxt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/xxt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/xxt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/xxt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# cuda
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# startship prompt
eval "$(starship init zsh)"
