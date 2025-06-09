#!/usr/bin/env bash
currentdirwd="$(cd "$(dirname "$0")" && pwd)"
function kerncheck {
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     systemctl stop usbmuxd && usbmuxd -f -p &> /dev/null&;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    MSYS_NT*)   machine=Git;;
    *)          machine="UNKNOWN:${unameOut}"
esac
find . -name "*.sh" -exec chmod +x {} \;
 }
 function restoreiosnormal {
 	clear
 	echo Either paste the path to the shsh-blob or drag and drop it also remove the quotes: 
 	read pathsh22
 	echo Either paste the path to the ipsw or drag and drop it also remove the quotes:
 	read ipswpath
 	echo Does your device have a baseband? Only devices which have a SIM slot have baseband
 	case `select_opt "Yes" "No"` in
 	 			0) echo Running futurerestore -t $pathsh22 --latest-sep --latest-baseband $ipswpath && cd "$currentdirwd/""$unameOut"/ && ./futurerestore -t "$pathsh22" --latest-sep --latest-baseband "$ipswpath" && cd "$currentdirwd/" && echo Done! Press enter to continue && read && mainmenu ;;
 	 		    1) echo Running futurerestore -t $pathsh22 --latest-sep --no-baseband $ipswpath && cd "$currentdirwd/""$unameOut"/ && ./futurerestore -t "$pathsh22" --latest-sep --no-baseband "$ipswpath" && cd "$currentdirwd/" && echo Done! Press enter to continue && read && mainmenu ;;
 	esac
 }
 function restoreiosgaster {
 	clear
 	echo Either paste the path to the shsh-blob or drag and drop it: 
 	read pathsh22
 	echo Either paste the path to the ipsw or drag and drop it:
 	read ipswpath
 	echo Does your device have a baseband? Only devices which have a SIM slot have baseband
 	case `select_opt "Yes" "No"` in
 	 			0) echo Running futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --latest-baseband $ipswpath && cd "$currentdirwd/""$unameOut"/ && ./futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --latest-baseband $ipswpath && cd "$currentdirwd/" && echo Done! Press enter to continue && read && mainmenu;;
 	 		    1) echo Running futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --no-baseband $ipswpath && cd "$currentdirwd/""$unameOut"/ && ./futurerestore --use-pwndfu --set-nonce -t $pathsh22 --latest-sep --no-baseband $ipswpath && cd "$currentdirwd/" && echo Done! Press enter to continue && read && mainmenu;;
 	esac
 } 
 function restoreios {
 	clear
 	echo If you are restoring normally or with CheckM8 noncesetter or dimentio choose normal restore.
 	echo If you are using gaster choose gaster restore.
 	case `select_opt "Normal Restore" "Gaster Restore" "Back" "Help" "Exit Recovery"` in
 			0) restoreiosnormal;;
 		    1) restoreiosgaster;;
 		    2) mainmenu;;
 		    3) clear && echo Restores on devices which support ios 16 or 17 need you to follow the Guide in my repo && read && restoreios;;
 		    4) "$currentdirwd/""$unameOut"/futurerestore --exit-recovery && restoreios;;
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
			  	    0) "$currentdirwd/""$unameOut"/gaster pwn && "$currentdirwd/""$unameOut"/gaster reset && init_restore;;
			  	    1) dfupwn;;
	esac
}
function m8nonce {
	clear
	echo Connect your device in DFU mode and hit enter
	case `select_opt "Continue" "Back"` in
		  	    0) cd "$currentdirwd/""$unameOut"/noncesetter/ && ./main.sh && cd "$currentdirwd/" && echo Complete && read && init_restore;;
		  	    1) dfupwn;;
	esac
}
function dfupwn {
		clear
		case `select_opt "CheckM8 Nonce Setter" "Gaster" "Back" "Help"` in
	  	    0) m8nonce;;
	  	    1) dfugaster;;
	  	    2) init_restore;;
	  	    3) echo CheckM8 Nonce Setter is better than Gaster as it works better with futurerestore. && echo If neither does not work check Guides/dimentio.md && read && dfupwn;;
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

function init_ra1n {
		clear
		case `select_opt "palera1n rootless" "palera1n rootful (rejailbreak)" "palera1n rootful (first time setup)" "palera1n rootful (first time setup for 16GB devices)" "palera1n remove jailbreak (rootful)" "palera1n remove jailbreak (rootless)" "Back" "Help"` in
	  	    0) clear && echo "Running palera1n -l rootless" && palera1n -l && mainmenu;;
	  	    1) clear && echo "Running palera1n -f rootful" && palera1n -f && mainmenu;;
	  	    2) clear && echo "Running palera1n -fc rootful fakefs creation" && palera1n -fc && mainmenu;;
	  	    3) clear && echo "Running palera1n -Bf rootful fakefs bind mount creation" && palera1n -Bf && mainmenu;;
	  	    4) clear && echo "Running palera1n --force-revert -f Remove rootful" && palera1n --force-revert -f && mainmenu;;
	  	    5) clear && echo "Running palera1n --force-revert -l Remove rootless" && palera1n --force-revert -l && mainmenu;;
	  	    6) mainmenu ;;
	  	    7) echo Only use palera1n if your device is not supported by Dopamine jailbreak && read && init_ra1n;;
	  	esac
	  	
}

function trololo {
	cd "$currentdirwd/"eclipsera1n/SSHRD_Script/
	clear
	echo "Enter your iOS version (Make sure you have Tips installed on your iDevice, iOS16+ does not work on Linux):"
	read iosver
	#./sshrd.sh $iosver
	./sshrd.sh $iosver TrollStore Tips 
	./sshrd.sh boot
	echo Your device should automatically reboot in around a minute. Open Tips app and choose Install Trollstore
	read
	cd "$currentdirwd/"
	mainmenu
}
function bkpactiv {
	cd "$currentdirwd/"eclipsera1n/
	clear
	./backup.sh
	echo "Press enter to return"
	read
	cd "$currentdirwd/"
	mainmenu
}
function activationhecker {
	clear
	case `select_opt "Backup activation files" "Activate device using backup" "Back"` in
		0) bkpactiv;;
		1) doactivation;;
		2) mainmenu;;
	esac

}

function doactivation {
	cd "$currentdirwd/"eclipsera1n/
	clear
	./activate.sh
	echo "Press enter to return"
	read
	cd "$currentdirwd/"
	mainmenu
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
icera1n v3.0: eclipse
EOF
		case `select_opt "Palera1n" "Futurerestore" "TrollStore" "Activation" "Exit"` in
	  	    0) init_ra1n;;
	  	    1) init_restore;;
			2) trololo;;
			3) activationhecker;;
	  	    4) killall usbmuxd && clear && echo && exit;;
	  	esac
	  	
}

if [ "$EUID" -ne 0 ]
  then echo "Run sudo ./icera1n.sh"
  else(
  if [ -e /usr/local/bin/palera1n ]
  then (
  	kerncheck
  	mainmenu
  	)
  else sudo sh -c "$(curl -fsSL https://static.palera.in/scripts/install.sh)"
  	mainmenu
  	fi
  )
fi
