#!/bin/sh
echo -ne '\033c\033]0;No Controle\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/on_control.x86_64" "$@"
