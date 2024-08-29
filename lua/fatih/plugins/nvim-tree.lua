return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {

            filters = { dotfiles = false },
            disable_netrw = true,
            sync_root_with_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            sort = {
                sorter = "name",
                folders_first = true,
                files_first = false,
            },
            view = {
                width = 30,
                preserve_window_proportions = true,
            },
            renderer = {
                root_folder_label = false,
                highlight_git = true,
                indent_markers = { enable = true },
                icons = {
                    glyphs = {
                        default = "󰈚",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                        },
                        git = { unmerged = "" },
                    },
                },
            
            icons = {
                web_devicons = {
                    file = {
                        enable = true,
                        color = true,
                    },
                    folder = {
                        enable = false,
                        color = true,
                    },
                },

            }}
        }
        local api = require("nvim-tree.api")

        vim.keymap.set("n", "<C-n>", api.tree.toggle, {})
    end,
}
