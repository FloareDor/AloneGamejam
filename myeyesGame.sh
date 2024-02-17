#!/bin/sh
echo -ne '\033c\033]0;Gamejam\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/myeyesGame.x86_64" "$@"
