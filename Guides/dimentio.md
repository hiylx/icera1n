# Setting Nonce via dimentio

- **Step 1.** Install your favorite jailbreak using the guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/jailbreaking.md) (You can skip this if you are already jailbroken)
- **Step 2.** Open your shsh2 blob in a text editor and find Generator, below it will be something like 0x1111111111111111. This is your nonce. ALSO DO NOT EDIT OR CHANGE ANYTHING IN THE SHSH2 BLOB OR ELSE IT WILL NOT WORK. DO NOT SAVE ANYTHING TO THE SHSH2 BLOB
- **Step 3.** Install NewTerm 3 using Sileo
- **Step 4.** Install dimentio using Sileo
- **Step 5.** Open NewTerm 3 on your device (if asked select 0)
- **Step 6.** Run <code>sudo su root -c 'dimentio [nonce goes here without the brackets]' </code> and enter the terminal password you entered when jailbreaking your device
- Example if your nonce is 0x1111111111111111 you would run <code> sudo su root -c 'dimentio 0x1111111111111111' </code>
