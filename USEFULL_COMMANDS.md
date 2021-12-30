# GPG
## How to import

```
gpg --import .../public.pem
gpg --allow-secret-key-import --import .../private.pem
```

## How to export

```
gpg --output public.pem --armor --export PUT_KEY_ID
gpg --output private.pem --armor --export-secret-key PUT_KEY_ID
```

# Moom
## How to import

```
defaults import com.manytricks.Moom ./Moom.plist
```

## How to export

```
defaults export com.manytricks.Moom ./Moom.plist
```

# Cron
## How to edit
`crontab -e`
## How to add passwords backup
```
# At 13:00 on Monday.
0 13 * * 1 $HOME/.dotfiles/.scripts/backup/backupWithNotify.sh
```
