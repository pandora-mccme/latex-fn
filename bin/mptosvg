#!/usr/bin/bash
set -euo pipefail

trap 'rm -rf "$WD"' EXIT

WD=$(mktemp -d)

cd "$WD" || exit 1
cat > figure.mp

mptopdf figure.mp > /dev/stderr
pdf2svg figure-1.pdf figure.svg > /dev/stderr

cat figure.svg