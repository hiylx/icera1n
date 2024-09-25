#Setting Nonce via dimentio

- Step 1. Install your favorite jailbreak. Also remember what you set as the root password
- Step 2. Add the source "https://repo.1conan.com/" to your package manager
- Step 3. Open your shsh2 blob in a text editor and find <generator>, below it will be something like 0x1111111111111111. This is your nonce.
- Step 4. Install NewTerm 3 Beta using Sileo
- Step 5. Open NewTerm3 on your device
- Step 6. Run <code>sudo su root -c 'dimentio [nonce goes here without the brackets]' </code> and enter the root password
- Example if your nonce is 0x1111111111111111 you would run <code> sudo su root -c 'dimentio 0x1111111111111111' </code>
