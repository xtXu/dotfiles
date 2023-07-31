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

    # just load the completions
    # zgenom ohmyzsh --completion plugins/docker-compose


    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-autosuggestions
    # completions
    zgenom load zsh-users/zsh-completions

		zgenom load conda-incubator/conda-zsh-completion
		zgenom load wfxr/forgit
	

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

# ======================= conda ===============================
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
# ============================================================


setopt no_share_history

# aliases
alias c="xclip -selection clipboard" # {cmd} | c to redirect the output to the system clipboard
alias lg="lazygit"


# proxy
# export http_proxy="http://127.0.0.1:7890"
# export https_proxy="http://127.0.0.1:7890"

# ROS
source /opt/ros/melodic/setup.zsh


# cuda
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Path
export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH

# starship
eval "$(starship init zsh)"

# ================================= PIXHAWK4 ==========================================

# 1.13.3
# source ~/PX4-1_13_3/Tools/setup_gazebo.bash ~/PX4-1_13_3 ~/PX4-1_13_3/build/px4_sitl_default
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-1_13_3
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-1_13_3/Tools/sitl_gazebo

# 1.11
# source ~/realsense_gazebo_ws//devel/setup.zsh
# source ~/PX4-Autopilot/Tools/setup_gazebo.bash ~/PX4-Autopilot ~/PX4-Autopilot/build/px4_sitl_default
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Autopilot
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Autopilot/Tools/sitl_gazebo

# xtdrone
source ~/xtdrone_ws/devel/setup.zsh
source ~/PX4_Firmware/Tools/setup_gazebo.bash ~/PX4_Firmware/ ~/PX4_Firmware/build/px4_sitl_default
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4_Firmware
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4_Firmware/Tools/sitl_gazebo

# source ~/px4_fastplanner_ws/devel/setup.zsh
# source ~/PX4-Autopilot/Tools/setup_gazebo.bash ~/PX4-Autopilot ~/PX4-Autopilot/build/px4_sitl_default
# export GAZEBO_MODEL_PATH=~/px4_fastplanner_ws/src/simulation/models
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Autopilot
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Autopilot/Tools/sitl_gazebo

# ====================================================================================

