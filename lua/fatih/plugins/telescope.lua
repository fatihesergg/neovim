return {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }
    
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>f', builtin.find_files, {})
        vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>b', builtin.buffers, {})
        vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})
    end
}
