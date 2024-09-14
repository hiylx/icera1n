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
 function restoreiosnormal {
 	clear
 	echo Either paste the path to the shsh-blob or drag and drop it: 
 	read pathsh22
 	echo Either paste the path to the ipsw or drag and drop it:
 	read ipswpath
 	echo Does your device have a baseband? 
 	case `select_opt "Yes" "No"` in
 	 			0) echo Running futurerestore -t $pathsh22 --latest-sep --latest-baseband $ipswpath && ./"$unameOut"/futurerestore -t $pathsh22 --latest-sep --latest-baseband $ipswpath && echo Done! Press enter to continue && read && mainmenu ;;
 	 		    1) echo Running futurerestore -t $pathsh22 --latest-sep --no-baseband $ipswpath && ./"$unameOut"/futurerestore -t $pathsh22 --latest-sep --no-baseband $ipswpath && echo Done! Press enter to continue && read && mainmenu ;;
 	esac
 }
 function restoreiosgaster {
 	clear
 	echo Either paste the path to the shsh-blob or drag and drop it: 
 	read pathsh22
 	echo Either paste the path to the ipsw or drag and drop it:
 	read ipswpath
 	echo Does your device have a baseband? 
 	case `select_opt "Yes" "No"` in
 	 			0) echo Running futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --latest-baseband $ipswpath && ./"$unameOut"/futurerestore -t $pathsh22 --latest-sep --latest-baseband $ipswpath && echo Done! Press enter to continue && read && mainmenu;;
 	 		    1) echo Running futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --no-baseband $ipswpath && ./"$unameOut"/futurerestore -t $pathsh22 --latest-sep --no-baseband $ipswpath && echo Done! Press enter to continue && read && mainmenu;;
 	esac
 } 
 function restoreios {
 	clear
 	echo If you are restoring normally or with CheckM8 noncesetter choose normal restore.
 	echo If you are using gaster choose gaster.
 	case `select_opt "Normal Restore" "Gaster Restore" "Back" "Help" "Exit Recovery"` in
 			0) restoreiosnormal;;
 		    1) restoreiosgaster;;
 		    2) mainmenu;;
 		    3) echo Restores on iOS 16 Supported devices are not possible as they have incompatible SEP && read && restoreios;;
 		    4) ./"$unameOut"/futurerestore --exit-recovery && restoreios;;
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
function dfugaster {
	clear
	echo Connect your device in DFU mode and hit Enter
	case `select_opt "Continue" "Back"` in
			  	    0) ./"$unameOut"/gaster pwn && ./"$unameOut"/gaster reset && init_restore;;
			  	    1) dfupwn;;
	esac
}
function m8nonce {
	clear
	echo Connect your device in normal mode. Once the nonce setter gets stuck,
	echo Put it in DFU mode.
	case `select_opt "Continue" "Back"` in
		  	    0) cd ./"$unameOut"/noncesetter/ && ./main.sh && cd ../../ && init_restore;;
		  	    1) dfupwn;;
	esac
}
function dfupwn {
		clear
		case `select_opt "Method 1: CheckM8 Nonce Setter (Reccomended)" "Method 2: Gaster" "Back" "Help"` in
	  	    0) m8nonce;;
	  	    1) dfugaster;;
	  	    2) init_restore;;
	  	    3) echo CheckM8 Nonce Setter is better than Gaster as it works better with futurerestore. && echo Even if a guide you are following says to use gaster you can use CheckM8 instead && echo as they serve the same purpose. && read && dfupwn;;
	  	esac	
}
function init_restore {
		clear
		case `select_opt "Run Futurerestore" "PwnDFU" "Back"` in
	  	    0) restoreios;;
	  	    1) dfupwn;;
	  	    2) mainmenu;;
	  	esac
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
		case `select_opt "Rootless" "Rootful (Re Jailbreak)" "Rootful First-time setup" "Rootful First-time setup (16GB devices)" "Remove Jailbreak (Rootful)" "Remove Jailbreak (Rootless)" "Back" "Help"` in
	  	    0) clear && echo "Running palera1n -l rootless" && palera1n -l & ra1n_control;;
	  	    1) clear && echo "Running palera1n -f rootful" && palera1n -f & ra1n_control;;
	  	    2) clear && echo "Running palera1n -fc rootful fakefs creation" && palera1n -fc & ra1n_control;;
	  	    3) clear && echo "Running palera1n -Bf rootful fakefs bind mount creation" && palera1n -Bf & ra1n_control;;
	  	    4) clear && echo "Running palera1n --force-revert -f Remove rootful" && palera1n --force-revert -f & ra1n_control;;
	  	    5) clear && echo "Running palera1n --force-revert -l Remove rootless" && palera1n --force-revert -l & ra1n_control;;
	  	    6) mainmenu ;;
	  	    7) echo Only use palera1n if your device is not supported by Dopamine jailbreak && read && init_ra1n;;
	  	esac
	  	
}

function idr {
	echo "Drag 'n drop the ipsw: " 
	read ipswpath
	./"$unameOut"/idevicerestore -e $ipswpath
	
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
icera1n v2.0: KFD Chicken
EOF
		case `select_opt "Palera1n" "Futurerestore"  "Exit"` in
	  	    0) init_ra1n;;
	  	    1) init_restore;;
	  	    2) killall usbmuxd palera1n && clear && echo;;
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
