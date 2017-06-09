#!/bin/bash

_skip_opt=0
declare -a _options=(-d)
declare -a _opt_found_interfaces

for o in $OPTIONS; do
    _options+=("$o")

    if [ "$_skip_opt" != "0" ]; then
        _skip_opt=0
    fi

    case "$o" in
        -d)
            unset _options[-1]
            ;;
        -4o6|-C|-H|-F|-V|--request-options|--timeout|-e|-p|-s|-g|-D|-cf|-df|-lf|-pf|sf)
            _skip_opt=1
            ;;
        -*)
            ;;
        *)
            _opt_found_interfaces+=("$o")
            ;;
    esac
done

for i in $INTERFACES; do
    found=0
    for c in "${_opt_found_interfaces[@]}"; do
        if [ "$i" = "$c" ]; then
            found=1
            break
        fi
    done
    if [ "$found" = "0" ]; then
        _options+=($i)
    fi
done

echo -n "Running: /usr/bin/dhclient"
for o in "${_options[@]}"; do
    echo -n " \"$o\""
done
echo

/usr/sbin/dhclient "${_options[@]}"
