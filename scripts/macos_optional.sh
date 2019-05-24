#!/usr/bin/env bash

# ~/.macos Ñ https://mths.be/macos

echo "+---------------------------------------------+"
echo "|        Setting Up MacOS ( optional )        |"
echo "+---------------------------------------------+"

# Close any open System Preferences panes, to prevent them from overriding
# settings weÕre about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
sudo rm /private/var/vm/sleepimage
# Create a zero-byte file insteadÉ
sudo touch /private/var/vm/sleepimage
# Éand make sure it canÕt be rewritten
sudo chflags uchg /private/var/vm/sleepimage

# Show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" $HOME/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" $HOME/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" $HOME/Library/Preferences/com.apple.finder.plist

# Hide Spotlight tray-icon (and subsequent helper)
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

sudo reboot
