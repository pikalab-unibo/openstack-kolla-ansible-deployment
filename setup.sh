set -e

ansible-vault --version | head -n 1
read -sp "Insert password for encryption: " PASSWORD; echo
read -p "Insert username [root]: " USER_NAME
USER_NAME=${USER_NAME:-root}
read -sp "Insert user password: " USER_PASSWORD; echo
read -p "Insert private key path [$HOME/.ssh/id_rsa]: " PRIVATE_KEY
PRIVATE_KEY=${PRIVATE_KEY:-$HOME/.ssh/id_rsa}
PUBLIC_KEY=$PRIVATE_KEY.pub
read -sp "Insert passphrase: " PASSPHRASE; echo

PASSWORD_FILE=home/.password/value
SECRETS_FILE=home/secrets.yml
PRIVATE_KEY_FILE=home/.ssh/id_rsa
PUBLIC_KEY_FILE=home/.ssh/id_rsa.pub

echo $PASSWORD > $PASSWORD_FILE
ansible-vault encrypt_string -n user $USER_NAME --vault-pass-file $PASSWORD_FILE > $SECRETS_FILE
ansible-vault encrypt_string -n password $USER_PASSWORD --vault-pass-file $PASSWORD_FILE >> $SECRETS_FILE
ansible-vault encrypt_string -n passphrase $PASSPHRASE --vault-pass-file $PASSWORD_FILE >> $SECRETS_FILE
cp $PRIVATE_KEY $PRIVATE_KEY_FILE
cp $PUBLIC_KEY $PUBLIC_KEY_FILE
ansible-vault encrypt --vault-pass-file $PASSWORD_FILE $PRIVATE_KEY_FILE
ansible-vault encrypt --vault-pass-file $PASSWORD_FILE $PUBLIC_KEY_FILE
echo Done
