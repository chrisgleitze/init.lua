# CLAUDE.md — Neovim Configuration

## What

Personal Neovim config (Lua, Neovim 0.11+) using lazy.nvim as the plugin manager. Vague colorscheme, blink.cmp for completion, fzf-lua for fuzzy finding, conform.nvim for formatting, and treesitter for syntax.

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

**Formatting:** StyLua for Lua, clang-format for C/C++, prettier for web languages, shfmt for shell. Config is in `.stylua.toml`. Conform.nvim runs formatters on save.

**Formatter tools:** Non-LSP tools are installed with Mason directly, not through mason-lspconfig. Expected tools: `clang-format`, `prettier`, `stylua`, `shfmt`.

**Verify changes:** After editing Lua, run `luac -p <path>` or `rg --files -g '*.lua' -0 | xargs -0 luac -p`. Use `git diff --check` to catch whitespace problems.

**Add a plugin:** Create `lua/plugins/<name>.lua` returning a lazy.nvim spec. Use lazy-loading (`event`, `keys`, `ft`, `cmd`). Put plugin keymaps in the spec, not in `lua/keymaps.lua`.

**Add an LSP server:** Create `lsp/<name>.lua` returning a `vim.lsp.Config` table. Optionally add to `ensure_installed` in `lua/plugins/mason.lua:8`.

**Add a filetype override:** Create `after/ftplugin/<filetype>.lua` with `vim.opt_local` option assignments.

**Git UI:** `<leader>gg` opens `lazygit` in a new tmux window rooted at the current Neovim working directory. It intentionally only checks for a tmux session to keep the mapping small.

## Key decisions

- Leader key is Space (`init.lua:4`)
- No netrw — neo-tree is used instead (`init.lua:14`)
- TypeScript uses tsgo (native Go-based TS server), not ts_ls (`lsp/tsgo.lua`)
- blink.cmp sets LSP capabilities globally — don't set them in individual LSP configs (`lua/plugins/completion.lua`)
- LSP keymaps are buffer-local and created on `LspAttach` (`lua/lsp.lua`)
- LSP server configs are auto-discovered from `lsp/`, sorted deterministically, and enabled once on first buffer read/new-file
- Project-specific LSP root markers should come before `.git`, especially for monorepos
- schemastore.nvim is lazy-loaded and called inside `lsp/jsonls.lua` and `lsp/yamlls.lua`
- mason-lspconfig installs servers only; `automatic_enable = false` avoids duplicate loading because `lua/lsp.lua` enables `lsp/*.lua`
- UI command plugins should be command-loadable when they expose commands used directly (for example `cmd = 'Mason'`, `cmd = 'FzfLua'`)
- The colorscheme is loaded eagerly with high priority so UI plugins inherit the intended highlights

## Rules

- Never modify `init.lua` without explicit approval.
- Never add, remove, or update plugins unless asked.
- Never modify LSP configs in `lsp/` unless asked.
- Never remove or rename existing keymaps unless asked.
- `lazy-lock.json` is auto-managed — do not edit.
