# Setting Nonce via dimentio

- **Step 1.** Install your favorite jailbreak using the guide [here](https://github.com/hiylx/icera1n/blob/main/Guides/jailbreaking.md) (You can skip this if you are already jailbroken)
- **Step 2.** Add the source "https://repo.1conan.com/" to Sileo
- **Step 3.** Open your shsh2 blob in a text editor and find Generator, below it will be something like 0x1111111111111111. This is your nonce. ALSO DO NOT EDIT OR CHANGE ANYTHING IN THE SHSH2 BLOB OR ELSE IT WILL NOT WORK. DO NOT SAVE ANYTHING TO THE SHSH2 BLOB
- **Step 4.** Install NewTerm 3 Beta using Sileo
- **Step 5.** Install dimentio using Sileo
- **Step 6.** Open NewTerm3 on your device
- **Step 7.** Run <code>sudo su root -c 'dimentio [nonce goes here without the brackets]' </code> and enter the root password
- Example if your nonce is 0x1111111111111111 you would run <code> sudo su root -c 'dimentio 0x1111111111111111' </code>
