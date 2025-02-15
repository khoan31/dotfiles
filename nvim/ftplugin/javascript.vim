set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

lua << EOF
local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())

   config['name'] = 'tsserver'
   config['cmd'] = { 'typescript-language-server', '--stdio' }
   config['root_dir'] = vim.fs.root(0, { 'package.json', '.git' }) or vim.fn.getcwd()
   config['init_options'] = { hostInfo = 'neovim' }

   vim.lsp.start(config)
   coroutine.yield()
end)
EOF
