# dotfiles

Some config files stored in the stow format

`stow <package>`

## Other files

Some files require things like sudo, or aren't as portable.

### /etc/X11/xorg.conf.d/20-intel.conf

For screen tearing on external monitors

```xf86conf
Section "Device"
    Identifier    "Intel Graphics"
    Driver        "XXX"
    Option        "TearFree"  "true"
EndSection
```

Replace XXX with the driver in use found using
`sudo lspci -k | grep -EA3 'VGA|3D|Display'`

### /usr/share/X11/xorg.conf.d/40-libinput.conf

For tap to click add

```xf86conf
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	Option "NaturalScrolling" "True"
	Option "Tapping" "on"
EndSection
```

## Packages

### email

- fortune (quotes)
- gpg (decrypt passwords)
- isync (imap syncing)
- msmtp (smtp)
- neomutt (email client)
- notmuch-addrlookup (address lookups)

### i3

- blueman (bluetooth)
- compton (compositor)
- nitrogen (wallpaper)
- redshift (screen temperature)
