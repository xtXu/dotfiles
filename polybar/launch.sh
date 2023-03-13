#!/bin/bash
killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 0.5; done


if type "polybar";then
	primary=$(polybar --list-monitors | grep primary | cut -d":" -f1)
	for m in $(polybar --list-monitors | cut -d":" -f1); do
		if [[ $m == $primary ]]; then
			MONITOR=$m TRAY_POSITION=center polybar --reload mybar &
		else
			MONITOR=$m TRAY_POSITION=none polybar --reload mybar &
		fi
	done
fi
