# CLAUDE.md — Neovim Configuration

## What

Personal Neovim config (Lua, Neovim 0.11+) using lazy.nvim as the plugin manager. Gruvbox colorscheme, blink.cmp for completion, fzf-lua for fuzzy finding, conform.nvim for formatting, treesitter for syntax.

## Structure

- `init.lua` — Entry point: leader key, disables built-ins, bootstraps lazy.nvim, loads core modules
- `lua/settings.lua` — Editor options (indent, UI, search, undo)
- `lua/keymaps.lua` — Global keymaps (non-plugin)
- `lua/autocmds.lua` — Autocommands (cursor restore, whitespace strip, yank highlight)
- `lua/lsp.lua` — LSP keymaps, diagnostics config, auto-enables all servers from `lsp/`
- `lua/plugins/` — Each file returns a lazy.nvim plugin spec; auto-imported via `{ import = 'plugins' }`
- `lsp/` — Native LSP configs (vim.lsp.Config tables); auto-discovered and enabled by `lua/lsp.lua`
- `after/ftplugin/` — Filetype-specific option overrides
- `snippets/` — Custom LuaSnip snippet files (JSON)

## How

**Formatting:** StyLua for Lua, prettier for web languages, shfmt for shell. Config is in `.stylua.toml`. Conform.nvim runs formatters on save.

**Verify changes:** After editing any Lua file, check syntax with `lua -e "loadfile('<path>')"`.

**Add a plugin:** Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. Use lazy-loading (`event`, `keys`, `ft`, `cmd`). Put plugin keymaps in the spec, not in `lua/keymaps.lua`.

**Add an LSP server:** Create `lsp/<name>.lua` returning a `vim.lsp.Config` table. Optionally add to `ensure_installed` in `lua/plugins/mason.lua:8`.

**Add a filetype override:** Create `after/ftplugin/<filetype>.lua` with `vim.o` option assignments.

## Key decisions

- Leader key is Space (`init.lua:4`)
- No netrw — neo-tree is used instead (`init.lua:14`)
- TypeScript uses tsgo (native Go-based TS server), not ts_ls (`lsp/tsgo.lua`)
- blink.cmp sets LSP capabilities globally — don't set them in individual LSP configs (`lua/plugins/completion.lua`)
- schemastore.nvim is lazy-loaded and called inside `lsp/jsonls.lua` and `lsp/yamlls.lua`
- mason-lspconfig `automatic_enable` excludes some servers to avoid duplicate loading (`lua/plugins/mason.lua`)

## Rules

- Never modify `init.lua` without explicit approval.
- Never add, remove, or update plugins unless asked.
- Never modify LSP configs in `lsp/` unless asked.
- Never remove or rename existing keymaps unless asked.
- `lazy-lock.json` is auto-managed — do not edit.
