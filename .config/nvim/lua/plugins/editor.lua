return {
    {
        "barrettruth/import-cost.nvim",
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "astro" },
        build = "./install.sh yarn", -- uses yarn to install the node server
        config = function()
            local ok, ic = pcall(require, "import-cost")
            if not ok then
                return
            end

            ic.setup({
                display_mode = true,
            })
        end,
    },

    {
        "stevearc/oil.nvim",
        lazy = false,
        config = function()
            local ok, oil = pcall(require, "oil")
            if not ok then
                return
            end

            oil.setup({
                default_file_explorer = true,
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["-"] = "actions.parent",
                    ["q"] = "actions.close",
                },
            })
        end,
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local ok, telescope = pcall(require, "telescope")
            if not ok then
                return
            end

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", "%.git/" },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
            })
        end,
        keys = {
            { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<C-p>",      "<cmd>Telescope git_files<CR>",  desc = "Git files" },
            {
                "<leader>ps",
                function()
                    require("telescope.builtin").grep_string({
                        search = vim.fn.input("Grep > "),
                        additional_args = { "--hidden" },
                    })
                end,
                desc = "Grep search",
            },
        },
    },

    {
        "theprimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>a", function() require("harpoon.mark").add_file() end,        desc = "Harpoon add" },
            { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
            { "<M-1>",     function() require("harpoon.ui").nav_file(1) end,         desc = "Harpoon 1" },
            { "<M-2>",     function() require("harpoon.ui").nav_file(2) end,         desc = "Harpoon 2" },
            { "<M-3>",     function() require("harpoon.ui").nav_file(3) end,         desc = "Harpoon 3" },
            { "<M-4>",     function() require("harpoon.ui").nav_file(4) end,         desc = "Harpoon 4" },
        },
    },

    { "f-person/git-blame.nvim", event = "BufReadPost" },

    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        config = function()
            local ok, autoclose = pcall(require, "autoclose")
            if not ok then
                return
            end

            autoclose.setup({
                options = {
                    disabled_filetypes = { "text" },
                    disable_when_touch = false,
                    touch_regex = "[%w(%[{]",
                    pair_spaces = false,
                    auto_indent = true,
                    disable_command_mode = true,
                },
                disabled_buftypes = { "prompt" },
            })
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            local ok, comment = pcall(require, "Comment")
            if not ok then
                return
            end

            comment.setup({
                toggler = { line = "<leader>/" },
                opleader = { line = "<leader>/" },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },

    {
        "supermaven-inc/supermaven-nvim",
        lazy = false,
        config = function()
            local ok, sm = pcall(require, "supermaven-nvim")
            if not ok then
                return
            end

            sm.setup({})
        end,
    },
}
