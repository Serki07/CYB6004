

#!/bin/python3
from itertools import product
import string
import hashlib
#possible password combination
passcombo= string.ascii_lowercase + string.ascii_uppercase + string.digits
#hidden password hash
passwordHash="2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"
#generate possible password combination 
for PassLength in range(8):
    for password in product(passcombo, repeat=PassLength):
        password = ''.join(password)
        #hash the word
        wordlistHash = hashlib.sha256(password.encode("utf-8")).hexdigest()
        print(f"Trying password {password}:{wordlistHash}")
        #if the hash is the same as the correct password's hash then we have cracked the password!
        if(wordlistHash == passwordHash):
            print(f"Password has been cracked! It was {password}")
            exit()
