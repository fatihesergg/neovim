return
{
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },

        config = function ()
            local cmp = require("cmp")
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed =  {
                    "lua_ls",
                    "omnisharp",
                    "lemminx",
                    "tsserver",
                    "html",
                    "cssls",
                    "jsonls",
                    "yamlls",
                    "bashls",
                    "pyright",
                    "sumneko_lua",
                },
                    handlers = {
                        function(server_name) -- default handler (optional)
        
                            require("lspconfig")[server_name].setup {
                                capabilities = capabilities
                            }
                        end,
                    }
            })

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<Return>'] = cmp.mapping.confirm({ select = true})
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                }, {
                    { name = 'buffer' },
                })
            })
                    end,
    }
