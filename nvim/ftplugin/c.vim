" indent
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

" lsp
lua << eof
local config = require('lsp').make_cfg()
config['name'] = 'clangd'
config['cmd'] = { 'clangd' }
config['root_dir'] = vim.fs.root(0, { 'CMakeLists.txt', '.clangd', '.clang-format' }) or vim.fn.getcwd()
vim.lsp.start(config)
eof
