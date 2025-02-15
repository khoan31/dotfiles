" indent
setlocal expandtab
setlocal shiftwidth=3
setlocal tabstop=3
setlocal softtabstop=3

" lsp
lua << eof
local config = require('lsp').make_cfg()
config['name'] = 'luals'
config['cmd'] = { 'lua-language-server' }
config['root_dir'] = vim.fs.root(0, { '.luarc.json', '.luacheckrc', '.stylua.toml' }) or vim.fn.getcwd()
config['settings'] = {
  Lua = {
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file('', true),
    },
    telemetry = {
      enable = false,
    },
  },
}
vim.lsp.start(config)
eof
