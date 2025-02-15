" indent
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

" lsp
lua << eof
local config = require('lsp').make_cfg()
config['name'] = 'tsserver'
config['cmd'] = { 'typescript-language-server', '--stdio' }
config['root_dir'] = vim.fs.root(0, { 'package.json', '.git' }) or vim.fn.getcwd()
config['init_options'] = { hostInfo = 'neovim' }
vim.lsp.start(config)
eof
