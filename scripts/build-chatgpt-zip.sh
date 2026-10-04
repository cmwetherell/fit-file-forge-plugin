#!/usr/bin/env bash
# Builds the ChatGPT plugin ZIP (OpenAI's portable layout) from the committed
# tree: root plugin.json + mcp.json, skills/, assets/, LICENSE, and
# chatgpt/README.md as README.md. The Claude files (.claude-plugin/, .mcp.json,
# the Claude README) stay out.
#
#   scripts/build-chatgpt-zip.sh [out.zip]          production (mcp.fitfileforge.com)
#   scripts/build-chatgpt-zip.sh --dev [out.zip]    private test build "FFF Dev"
#                                                   (mcp-dev.fitfileforge.com, test data)
set -euo pipefail
cd "$(dirname "$0")/.."
dev=0
if [[ "${1:-}" == "--dev" ]]; then dev=1; shift; fi
if [[ $dev == 1 ]]; then out="${1:-$HOME/fit-file-forge-chatgpt-plugin-dev.zip}"; else out="${1:-$HOME/fit-file-forge-chatgpt-plugin.zip}"; fi
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
git archive HEAD plugin.json mcp.json skills assets LICENSE | tar -x -C "$tmp"
git show HEAD:chatgpt/README.md > "$tmp/README.md"
if [[ $dev == 1 ]]; then
  python3 - "$tmp" <<'PY'
import json, os, sys
t = sys.argv[1]
p = os.path.join(t, "plugin.json"); d = json.load(open(p))
d["name"] = "fit-file-forge-dev"
d["description"] = "DEV/UAT build of Fit File Forge (mcp-dev.fitfileforge.com) for testing only. " + d["description"]
i = d["extensions"]["com.openai"]["interface"]
i.update(displayName="FFF Dev", shortDescription="Fit File Forge (dev)",
         websiteURL="https://dev.fitfileforge.com/ai", supportURL="https://dev.fitfileforge.com/ai#support",
         privacyPolicyURL="https://dev.fitfileforge.com/privacy", termsOfServiceURL="https://dev.fitfileforge.com/terms")
json.dump(d, open(p, "w"), indent=2, ensure_ascii=False)
m = os.path.join(t, "mcp.json"); md = json.load(open(m))
md["mcpServers"] = {"fit-file-forge-dev": {"type": "streamable-http", "url": "https://mcp-dev.fitfileforge.com/mcp"}}
json.dump(md, open(m, "w"), indent=2)
r = os.path.join(t, "README.md"); s = open(r).read()
s = s.replace("# Fit File Forge for ChatGPT", "# Fit File Forge for ChatGPT (DEV: mcp-dev.fitfileforge.com, test data only)", 1)
s = s.replace("mcp.fitfileforge.com", "mcp-dev.fitfileforge.com").replace("mcp-dev.fitfileforge.com, test data only", "mcp-dev.fitfileforge.com, test data only")
s = s.replace("https://www.fitfileforge.com/", "https://dev.fitfileforge.com/")
open(r, "w").write(s)
PY
fi
rm -f "$out"
(cd "$tmp" && zip -qr "$out" plugin.json mcp.json README.md LICENSE skills assets)
echo "wrote $out"
