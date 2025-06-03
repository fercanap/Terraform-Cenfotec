# 1. Crear variables con info de la llave

> [Windows](https://www.git-tower.com/blog/setting-up-gpg-windows/)

export KEY_NAME="demo.storylabs.dev"
export KEY_COMMENT="terreform secrets"

echo $KEY_NAME - $KEY_COMMENT


# 2. Crear llave GPG
```vim
gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF
```

# 3. Comprobar la llave
gpg --list-secret-keys "${KEY_NAME}"

#export KEY_FP=<C3FEBC7F6AA094882569460B7EEA4945E3CB4D5B>
#echo $KEY_FP

# 4. export pub key, in binary format:
gpg --output terraform.gpg --export $KEY_NAME

# 5. add local provider
data "local_file" "pgp_key" {
  filename = "../keys/prod/terrafrom.gpg"
}
