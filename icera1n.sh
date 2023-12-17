#!/usr/bin/env bash
function kerncheck {
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     sudo systemctl stop usbmuxd && usbmuxd -f -p &;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac

 }
function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}
function select_opt {
    select_option "$@" 1>&2
    local result=$?
    echo $result
    return $result
}
function ra1n_control {
		case `select_opt "Kill Palera1n" ` in
	  	    0) killall palera1n && mainmenu;;
	  	esac
}
function init_ra1n {
		clear
		case `select_opt "Rootless" "Rootful (Re Jailbreak)" "Rootful First-time setup" "Rootful First-time setup (16GB devices)" "Remove Jailbreak (Rootful)" "Remove Jailbreak (Rootless)" "Back"` in
	  	    0) clear && echo "Running palera1n rootless" && palera1n & ra1n_control;;
	  	    1) clear && echo "Running palera1n -f rootful" && palera1n -f & ra1n_control;;
	  	    2) clear && echo "Running palera1n -fc rootful fakefs creation" && palera1n -fc & ra1n_control;;
	  	    3) clear && echo "Running palera1n -Bf rootful fakefs bind mount creation" && palera1n -Bf & ra1n_control;;
	  	    4) clear && echo "Running palera1n --force-revert -f Remove rootful" && palera1n --force-revert -f & ra1n_control;;
	  	    5) clear && echo "Running palera1n --force-revert Remove rootless" && palera1n --force-revert & ra1n_control;;
	  	    6) mainmenu ;;
	  	esac
	  	
}
function mainmenu {
		clear
cat << "EOF"
============================================================
_________ _______  _______  _______  _______  __    _       
\__   __/(  ____ \(  ____ \(  ____ )(  ___  )/  \  ( (    /|
   ) (   | (    \/| (    \/| (    )|| (   ) |\/) ) |  \  ( |
   | |   | |      | (__    | (____)|| (___) |  | | |   \ | |
   | |   | |      |  __)   |     __)|  ___  |  | | | (\ \) |
   | |   | |      | (      | (\ (   | (   ) |  | | | | \   |
___) (___| (____/\| (____/\| ) \ \__| )   ( |__) (_| )  \  |
\_______/(_______/(_______/|/   \__/|/     \|\____/|/    )_)
============================================================
icera1n v1.0: dash carbon
============================================================

EOF
		case `select_opt "Palera1n" "Exit"` in
	  	    0) init_ra1n;;
	  	    1) killall usbmuxd palera1n && clear && echo;;
	  	esac
	  	
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  else(
  if [ -e /usr/local/bin/palera1n ]
  then (
  	kerncheck
  	mainmenu
  	)
  else sudo sh -c "$(curl -fsSL https://static.palera.in/scripts/install.sh)"
  	fi
  )
fi
