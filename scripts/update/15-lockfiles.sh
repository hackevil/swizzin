#!/usr/bin/env bash

# Added 31 Dec 2020
# Move lockfiles from old directory to whatever the new one ends up being lol
# should run once and only once
if [[ -d /install/ ]]; then
    readarray -t list_installed < <(find /install -type f -name ".*.lock" | awk -F. '{print $2}')
    echo_log_only "Moving ${list_installed[*]} to  "
    mkdir -p "$lockdir"
    for app in "${list_installed[@]}"; do
        lock "$app"
        if [[ -s /install/.$app.lock ]]; then
            # In case there's some info we might have to retain
            cat "$(lockpath "$app")" < /install/."$app".lock
        fi
    done
    rm -rf /install/ # byyeeeee
fi