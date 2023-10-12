#!/bin/bash

exit_i3_nagbar() {
        i3-nagbar --message "${@}" >/dev/null 2>&1
        exit 1
}

check_installed() {
        for program in xclip ykman base64 dmenu i3-nagbar; do
                if ! command -v "${program}" >/dev/null; then
                        echo "missing ${program}" 1>&2
                        exit 1
                fi
        done
}

copy_clear() {
        local account="${1}"
        local copy_cmd=(xclip -rmlastnl -selection clipboard)
        local paste_cmd=(xclip -out -selection clipboard)
        local sleep_argv0="yubikey_totp_dmenu sleep"
        local before
        before="$("${paste_cmd[@]}" 2>/dev/null | base64)"
        pkill -f "^${sleep_argv0}" && sleep 0.5
        ykman oath accounts code -s "${account}" 2>/dev/null | "${copy_cmd[@]}" || exit_i3_nagbar "Failed to copy token"
        ( 
                (exec -a "${sleep_argv0}" bash <<<"trap 'kill %1' TERM; sleep '45' & wait")
                echo "${before}" | base64 --decode | "${copy_cmd[@]}"
        ) >/dev/null 2>&1 &
        disown
}

main() {
        check_installed

        local yk_cnt
        yk_cnt=$(ykman list | wc -l)

        if [[ ${yk_cnt} -eq 1 ]]; then
                local accounts
                local account

                if ! accounts="$(ykman oath accounts list 2>/dev/null)"; then
                        exit_i3_nagbar "Could not get a list of accounts"
                        return
                fi
                account="$(echo -n "${accounts}" | dmenu -i)"
                if [[ -n ${account} ]]; then
                        copy_clear "${account}"
                fi
        elif [[ ${yk_cnt} -eq 0 ]]; then
                exit_i3_nagbar "No yubikey inserted"
        elif [[ ${yk_cnt} -gt 1 ]]; then
                exit_i3_nagbar "More than one yubikey inserted"
        fi
}

main
