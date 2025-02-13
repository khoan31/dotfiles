return {
   {
      'neovim/nvim-lspconfig',
      dependencies = {
         { 'williamboman/mason.nvim' },
         { 'williamboman/mason-lspconfig.nvim' },
         { 'mfussenegger/nvim-jdtls' },
      },
      config = function()
         local servers = { 'clangd', 'gopls', 'pyright', 'jdtls', 'lua_ls', 'ts_ls' }

         require('mason').setup()
         require('mason-lspconfig').setup({ ensure_installed = servers })

         local lspconfig = require('lspconfig')
         local config = require('utils.lsp').make_cfg()

         for _, server in ipairs(servers) do
            if server ~= 'jdtls' then
               lspconfig[server].setup(config)
            end -- Use nvim-jdtls for Java
         end
      end
   },
}
