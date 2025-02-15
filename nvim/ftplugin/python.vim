" indent
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" lsp
lua << eof
local config = require('lsp').make_cfg()
config['name'] = 'pyright'
config['cmd'] = { 'pyright-langserver', '--stdio' }
config['root_dir'] = vim.fn.getcwd()
config['settings'] = {
  python = {
    analysis = {
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
      diagnosticMode = 'openFilesOnly',
    },
  },
}
vim.lsp.start(config)
eof
