# How to import

```
gpg --import .../public.pem
gpg --allow-secret-key-import --import .../private.pem
```

# How to export

```
gpg --output public.pem --armor --export PUT_KEY_ID
gpg --output private.pem --armor --export-secret-key PUT_KEY_ID
```
