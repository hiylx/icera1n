# Futurerestoring devices that support iOS 16 / 17 back down to iOS 15
# DISCLAIMER THIS GUIDE IS INCOMPLETE WAIT 4 DAYS FOR ME TO COMPLETE IT AND TEST IT AND ALL
 - This will ERASE everything on your device
 - Also touch ID will not work
 - And I don't recommend setting a password if you do and something goes wrong it's on you
 - You can't use this to bypass iCloud lock, like it literally won't work
 - This guide is incomplete like wait 2, 3 days for me to complete it cause I have a life too...
# Prerequisites
 - An iDevice on iOS 16 / 17 that is activated
 - Blobs and iPSW for the iOS 15 version you are downgrading to

# Backing up activation files
 - **Step 1.** Remove all previous jailbreaks
 - **Step 2.** Follow the rootless palera1n guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/jailbreaking.md).
 - **Step 3.** Install openssh package on your device using sileo
 - **Step 4.** Open icera1n
 - **Step 5.** Choose activation
 - **Step 6.** Choose backup activation files and follow the instructions
 - **Step 6.1.** To find the IP address of your iDevice, go to Settings -> Wi-Fi -> click the (i) icon next to your Wi-Fi network and scroll down until you find IP address
 - **Step 6.2.** If there are any errors, create an issue on github and I will check it out.
 - **Step 7.** Follow the futurerestore guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/futurerestore.md)
 - **Step 8.** Once your device boots into setup enter it into DFU mode
 - **Step 9.** Open icera1n if you closed it
 - **Step 10.** Choose Activation
 - **Step 11.** Choose Activate device using backup
 - **Step 12.** Success! If there is any issue create a github issue
 - **Step 12.1** If you want to sideload apps you will have to use the trollstore guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/trolstore.md) or else it wont work. Since your device is not activated in the standard way sideloading apps using safari, sideloadly or altstore won't work so you are forced to use the ramdisk version of trollstore.
