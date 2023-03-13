if [ ! -f ~/.zi/bin/zi.zsh ];then
	source <(curl -sL init.zshell.dev); zzinit
else
	source ~/.zi/bin/zi.zsh
fi


# ohmyzsh plugin
zi wait lucid for \
	OMZ::lib/history.zsh \
	OMZ::lib/theme-and-appearance.zsh \
	OMZP::extract \
	OMZP::z \
	OMZP::command-not-found \
	OMZP::sudo \
	OMZP::safe-paste \
	OMZP::pip \
	OMZP::colorize

# normal plugin
zi wait lucid light-mode for \
	paulirish/git-open \
	conda-incubator/conda-zsh-completion \
	changyuheng/zsh-interactive-cd \
	wfxr/forgit

# local snippet (some cli tool configuration, eg:fzf, conda...)
zi ice wait lucid 
zi snippet ~/dotfiles/zsh/fzf/fzf.setting.zsh
zi ice wait lucid
zi snippet ~/dotfiles/zsh/conda/conda.setting.zsh

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


# cuda
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# startship prompt
eval "$(starship init zsh)"
