# Futurerestoring devices that support iOS 16 / 17 / 18 back down to iOS 15 or 14
# DISCLAIMERS (READ BEFORE ATTEMPTING ANYTHING)
 - This will ERASE everything on your device
 - Also touch ID will not work
 - And I don't recommend setting a password on A11 chip devices if you are planning on using palera1n
 - You can't use this to bypass iCloud lock, like it literally won't work
 - This guide was only tested on iOS 16 supporting device. It should (hopefully) work on 17 and 18. If you try this on a device supporting iOS 17 or 18 you should be prepared if you need to restore back to the latest version
 - This guide only works on checkm8 compatible devices. The explicit list is iPad 5, 6 and 7, iPad Pro 12.9" 1st and 2nd generation, iPad Pro 10.5" 1st generation and iPad 9.7" 1st Generation and iPhone 8. DO NOT TRY THIS WITH AN IPHONE X
# Prerequisites
 - An iDevice on iOS 16 / 17 / 18 that is activated
 - Blobs and iPSW for the iOS 15 / 14 version you are downgrading to

# Backing up activation files
 - **Step 1.** Remove all previous jailbreaks
 - **Step 2.** Follow the rootless palera1n guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/jailbreaking.md).
 - **Step 3.** Install openssh package on your device using Sileo
 - **Step 4.** Open icera1n
 - **Step 5.** Choose activation
 - **Step 6.** Choose backup activation files and follow the instructions
 - **Step 6.1.** To find the IP address of your iDevice, go to Settings -> Wi-Fi -> click the (i) icon next to your Wi-Fi network and scroll down until you find IP address
 - **Step 6.2.** If there are any errors, create an issue on github and I will check it out

# Now futurerestore your device to iOS 15 using [this guide](https://github.com/hiylx/icera1n/blob/main/Guides/futurerestore.md) You can ignore the SEP BB Prerequisite

# Restoring activation files

 - **Step 1.** Once your device boots into setup enter it into DFU mode
 - **Step 2.** Open icera1n if you closed it
 - **Step 3.** Choose Activation
 - **Step 4.** Choose Activate device using backup
 - **Step 4.1** If you get a lib usb error then press Ctr+C, open icera1n again, choose Activation choose Activate device using backup. If it still does not work then reboot your computer and try open icera1n again, choose Activation choose Activate device using backup
 - **Step 4.2** LINUX USERS, THE SCRIPT WILL TELL YOU TO RUN A COMMAND. OPEN A NEW TERMINAL AND RUN IT. DO NOT MISS THIS STEP
 - **Step 5.** Success! If there is any issue create a github issue
 - **Step 5.1** If you want to sideload apps you will have to use the trollstore guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/trollstore.md) or else it won't work. Since your device is not activated in the standard way sideloading apps using safari, sideloadly or altstore won't work so you are forced to use the ramdisk version of trollstore.
