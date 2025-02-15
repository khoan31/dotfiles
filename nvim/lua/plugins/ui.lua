return {
   {
      'lunacookies/vim-colors-xcode',
      config = function()
         vim.cmd.colorscheme 'xcodedarkhc'
      end
   },
   {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
         require('telescope').setup({
            defaults = {
               layout_strategy = 'bottom_pane',
               layout_config = {
                  height = 0.41,
                  preview_cutoff = 9999
               },
            },
         })

         -- Keymaps
         local builtin = require('telescope.builtin')
         vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[f]ind files' })
         vim.keymap.set('n', '<leader>ss', builtin.git_files, { desc = '[ss]earch git files' })
         vim.keymap.set('v', '<leader>f',
            [["0y:lua require('telescope.builtin').find_files({search_file = '<C-r>0'})<CR>]],
            { desc = '[f]ind files match marked text' })
         vim.keymap.set('n', '<leader>F', function()
            builtin.find_files({ search_file = vim.fn.expand('<cword>') })
         end, { desc = '[F]ind files match current <cword>' })
         vim.keymap.set('n', '<leader>j', builtin.jumplist, { desc = '[j]ump list' })
         vim.keymap.set('n', '<leader>m', builtin.marks, { desc = '[m]arks' })
         vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = '[g]rep text' })
         vim.keymap.set('v', '<leader>g', [["0y:lua require('telescope.builtin').grep_string({search = '<C-r>0'})<CR>]],
            { desc = '[g]rep marked text' })
         vim.keymap.set('n', '<leader>G', function()
            builtin.grep_string({ search = vim.fn.expand('<cword>') })
         end, { desc = '[G]rep current <cword>' })
         vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Browse [b]uffers' })
         vim.keymap.set('n', '<leader>o', builtin.resume, { desc = '[o]pen last picker' })
      end
   },
   { 'tpope/vim-fugitive' },
   {
      'kristijanhusak/vim-dadbod-ui',
      dependencies = {
         { 'tpope/vim-dadbod', lazy = true },
      },
   },
}
