#!/bin/sh

readonly DEFAULT_PYTHON_VERSION = 3.10

for arg in "$@"
do
    IFS"=" read -r key value <<< "$arg"

    if [ "$key" = "python" ]; then
        if [ -z "$value" ]; then
            echo "バージョンが未設定です。"
            readonly PYTHON_VERSION = DEFAULT_PYTHON_VERSION
        else
            readonly PYTHON_VERSION = "$value"
        fi
    fi
done