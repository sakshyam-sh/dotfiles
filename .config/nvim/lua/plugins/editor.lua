return {
    {
        "stevearc/oil.nvim",
        lazy = false,
        config = function()
            require("oil").setup({
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
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        pickers = {
            find_files = {
                hidden = true, -- Shows hidden files in find_files
            },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/" },
                    -- Required for hidden files to show in live_grep and grep_string
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--hidden", -- Enables hidden file searching in grep
                    },
                },
                pickers = {
                    find_files = {

                        hidden = true,
                    },
                    -- live_grep does not support a 'hidden' key directly;
                    -- it uses vimgrep_arguments or additional_args
                    live_grep = {
                        additional_args = function(opts)
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
                    -- Explicitly passing hidden here for custom grep functions
                    require("telescope.builtin").grep_string({
                        search = vim.fn.input("Grep > "),
                        additional_args = { "--hidden" }
                    })
                end,
                desc = "Grep search"
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
        {
            "m4xshen/autoclose.nvim",
            event = "InsertEnter",
            config = function()
                require("autoclose").setup({
                    options = {
                        disabled_filetypes = { "text" },
                        disable_when_touch = false,
                        touch_regex = "[%w(%[{]",
                        pair_spaces = false,
                        auto_indent = true,
                        disable_command_mode = true, -- This disables autoclose in command mode
                    },
                    disabled_buftypes = {
                        "prompt",
                    },
                })
            end,
        },
        {
            "numToStr/Comment.nvim",
            event = "VeryLazy",
            config = function()
                require("Comment").setup({
                    toggler = {
                        line = "<leader>/",
                    },
                    opleader = {
                        line = "<leader>/",
                    },
                })
            end,
        },

        {
            "supermaven-inc/supermaven-nvim",
            lazy = false,
            config = function()
                require("supermaven-nvim").setup({})
            end,
        }

    }

}
