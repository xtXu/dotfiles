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
