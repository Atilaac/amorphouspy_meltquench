#!/bin/bash
set -e

echo "Registering Jupyter kernel..."
python -m ipykernel install --user --name python3 --display-name "Python 3"

echo "Executing notebooks..."
current_dir=$(pwd)
failures=0

for f in $(find . -name "*.ipynb" | sort); do
    echo "Processing: $f"
    cd "$(dirname "$f")"
    nb="$(basename "$f")"
    if papermill "$nb" "${nb%.*}-out.${nb##*.}" -k python3; then
        echo "OK: $nb"
    else
        echo "FAILED: $nb"
        failures=$((failures + 1))
    fi
    cd "$current_dir"
done

if [ "$failures" -gt 0 ]; then
    echo "$failures notebook(s) failed"
    exit 1
fi

echo "All notebooks executed successfully"
