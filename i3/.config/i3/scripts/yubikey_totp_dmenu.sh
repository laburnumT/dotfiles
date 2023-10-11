#!/bin/bash

yk_cnt=$(ykman list | wc -l)

if [[ $yk_cnt -eq 1 ]]; then
        account=$(ykman oath accounts list | dmenu -i)
        if [[ -n $account ]]; then
                ykman oath accounts code -s "${account}" | xclip -rmlastnl -selection clipboard
        fi
elif [[ $yk_cnt -eq 0 ]]; then
        i3-nagbar --message "No yubikey inserted"
elif [[ $yk_cnt -gt 1 ]]; then
        i3-nagbar --message "More than one yubikey inserted"
fi
