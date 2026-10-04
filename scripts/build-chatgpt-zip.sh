#!/usr/bin/env bash
# Builds the ChatGPT plugin ZIP (OpenAI's portable layout) from the committed
# tree: root plugin.json + mcp.json, skills/, assets/, LICENSE, and
# chatgpt/README.md as README.md. The Claude files (.claude-plugin/, .mcp.json,
# the Claude README) stay out. Usage: scripts/build-chatgpt-zip.sh [out.zip]
set -euo pipefail
cd "$(dirname "$0")/.."
out="${1:-$HOME/fit-file-forge-chatgpt-plugin.zip}"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
git archive HEAD plugin.json mcp.json skills assets LICENSE | tar -x -C "$tmp"
git show HEAD:chatgpt/README.md > "$tmp/README.md"
rm -f "$out"
(cd "$tmp" && zip -qr "$out" plugin.json mcp.json README.md LICENSE skills assets)
echo "wrote $out"
