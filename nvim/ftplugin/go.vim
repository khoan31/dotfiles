" indent
setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" lsp
lua << eof
local config = require('lsp').make_cfg()
config['name'] = 'gopls'
config['cmd'] = { 'gopls' }
config['root_dir'] = vim.fs.root(0, { 'go.mod', 'go.work' }) or vim.fn.getcwd()
vim.lsp.start(config)
eof
