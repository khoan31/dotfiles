return {
   {
      'williamboman/mason.nvim',
      config = function()
         require('mason').setup()
      end
   },
   { 'mfussenegger/nvim-jdtls' },
   {
      'github/copilot.vim',
      config = function()
         vim.g.copilot_enabled = 0
      end
   }
}
