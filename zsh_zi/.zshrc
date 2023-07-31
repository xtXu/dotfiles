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
	OMZP::colorize \
	OMZP::git

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
alias lg="lazygit"

# Path
export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH

# proxy
# export http_proxy="http://127.0.0.1:7890"
# export https_proxy="http://127.0.0.1:7890"

# ROS
source /opt/ros/melodic/setup.zsh

# case insensitive
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


# cuda
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# startship prompt
eval "$(starship init zsh)"

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

# source ~/livox_ws/devel/setup.zsh
