# SSH access to VM

SSH server is installed in created VM and [SSH key](../shared/id_rsa_test.pub) is added to `test` user `authorized_keys`.

***Note: SSH private key should be kept secret.  
In this repository private key is added with related public key for test/lab purposes***

# SSH authentication agent

Commands for adding related ssh private key to authentication agent:
```bash
# Copy ssh private key to .ssh folder
cp shared/id_rsa_test ~/.ssh

# Set file permissions and ownership
chmod 600 ~/.ssh/id_rsa_test
chown $USER:$USER ~/.ssh/id_rsa_test

# Add SSH private key to authentication agent
ssh-add ~/.ssh/id_rsa_test

# Verify that key was added
ssh-add -l

# In case when message 'Could not open a connection to your authentication agent.' is received from ssh-add
ssh-agent bash
```