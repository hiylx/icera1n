# icera1n

Version 3: Eclipse (WIP)

(oh yeah also install usbmuxd and libimobiledevice and imobiledeviceutils if you use linux)

Install Steps (needs git cli installed):

<code> git clone https://github.com/hiylx/icera1n --recursive </code>

To run:

cd into the directory where icera1n is installed

then run <code>sudo ./icera1n.sh</code>


User-friendly wrapper for palera1n, futurerestore, entering pwndfu mode and activating devices which were futurerestore'd to iOS 15 on iOS 16 SEP / Baseband
Works on Linux and Mac (I don't know if it works on apple sillicon)

This tool automatically installs palera1n and provides you with a
menu to jailbreak your palera1n compatible device. It also comes
with futurerestore and tools to enter PwnDFU mode.

It makes it easy to do these things with an easily navigatable menu:

Jailbreak iPhone with Palera1n
Enter PwnDFU mode
Use Futurerestore
Activate devices restored to iOS 15 on iOS 16 SEP

Check out the [Guides](https://github.com/hiylx/icera1n/tree/main/Guides/)

Note for Linux users: Manually stop usbmuxd if your linux distro does not have systemd / systemctl. You do not have to start usbmuxd as the script takes care

