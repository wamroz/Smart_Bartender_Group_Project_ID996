#!/bin/bash
 
i=0
 
if [ $# -eq 2 ]; then
    target=$1
    newname=$2
 
    if [ ! -d "$target" ]; then
        echo "Błąd: '$target' nie jest folderem"
        exit 1
    fi
 
    for f in "$target"/*; do
        # pomijamy podfoldery i puste dopasowanie globa
        [ -f "$f" ] || continue
 
        base=$(basename "$f")
        ext=""
        # zachowaj rozszerzenie (jeśli jest i plik nie jest ukryty)
        if [[ "$base" == *.* && "$base" != .* ]]; then
            ext=".${base##*.}"
        fi
 
        i=$((i + 1))
        # -n: nie nadpisuj istniejących plików
        mv -n -- "$f" "$target/${newname}_${i}${ext}"
        echo "$base -> ${newname}_${i}${ext}"
    done
else
    echo "Użycie: $0 <folder> <nowa_nazwa>"
    exit 1
fi
 