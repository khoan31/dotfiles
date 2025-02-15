local common = require('utils.common')
local config = require('utils.lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())
   vim.opt.expandtab = true
   vim.opt.shiftwidth = 2
   vim.opt.tabstop = 2
   vim.opt.softtabstop = 2

   config['name'] = 'tsserver'
   config['cmd'] = { 'typescript-language-server', '--stdio' }
   config['root_dir'] = vim.fs.root(0, { 'package.json', '.git' }) or vim.fn.getcwd()
   config['init_options'] = { hostInfo = 'neovim' }

   vim.lsp.start(config)
   coroutine.yield()
end)
