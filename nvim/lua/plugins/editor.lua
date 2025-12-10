return {
  -- Oil file explorer
  {
    "stevearc/oil.nvim",
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["-"] = "actions.parent",
          ["q"] = "actions.close",
        },
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<C-p>", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>ps", function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end, desc = "Grep search" },
      { "<leader>vh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },

  -- Undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
    },
  },

  -- git blame
  {
    "f-person/git-blame.nvim",
    event="BufReadPost",
    config = function()
      vim.g.gitblame_enabled = 1
    end,
  },

  -- autoclose
  {
    "m4xshen/autoclose.nvim",
    lazy = false,
    config = function()
      require("autoclose").setup()
    end,
  },

  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git status" },
    },
  },

  -- Harpoon
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
      { "<C-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
      { "<C-t>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
      { "<C-n>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon 3" },
      { "<C-s>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon 4" },
    },
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = { "n", "v" } },
    },
    config = true,
  },
}
