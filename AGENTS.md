# AGENTS.md — fit-file-forge-plugin

The **public** plugin for Fit File Forge in two packages: the Claude plugin (`.claude-plugin/plugin.json`, `.mcp.json`, `README.md`, which Anthropic's directory shows) and the ChatGPT plugin (OpenAI's portable layout: root `plugin.json` + `mcp.json`, with `chatgpt/README.md` as its README; build the upload ZIP with `scripts/build-chatgpt-zip.sh`). Both share `skills/` and `assets/`; keep each README about its own app. The MCP server itself lives in the private app repo (`cmwetherell/fit-file-forge`, route served at `https://mcp.fitfileforge.com/mcp`); this repo only points at it.

## Rules

- **This repository is public.** Never add secrets, API keys, tokens, app source code, our coach or engine prompts, internal docs, customer data, or anything from the app repo's `docs/garmin/` (Garmin Confidential).
- `name` in `.claude-plugin/plugin.json` (`fit-file-forge`) is permanent — never change it. Change `displayName` instead.
- `.mcp.json` must use the exact URL the connector is listed under, so people with both the connector and the plugin see one set of tools.
- Raise `version` on every release. The directory tracks the default branch and re-scans every commit, so `main` must always be releasable.
- README keeps three things current: what it does, how to use it, what data it sends (Anthropic's validation requires them; ≥ 40 words).
- No top-level `bin/` directory (it stops claude.ai and Cowork from installing the plugin).
- Skill and tool names in skills must match the server's real tool names.

## Check before pushing

```bash
claude plugin validate .
```

Test locally: `claude --plugin-dir .`, or zip the folder and upload it in claude.ai → Customize → Plugins → Add → Upload plugin.
