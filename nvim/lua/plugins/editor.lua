return {
  -- Oil file explorer (Keep existing)
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

  -- Trouble (The Zed-like Error List)
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

  -- Telescope (Keep existing, removed fzf build requirement to prevent errors if make isn't installed)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<C-p>", "<cmd>Telescope git_files<CR>", desc = "Git files" },
      { "<leader>ps", function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
      end, desc = "Grep search" },
    },
    config = function()
      require("telescope").setup({
        defaults = { file_ignore_patterns = { "node_modules", ".git/" } },
      })
    end,
  },

  -- Harpoon (Fixed Keybinds)
  {
    "theprimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon menu" },
      -- Changing these to Alt/Meta to avoid conflict with Window Navigation <C-h/j/k/l>
      { "<M-1>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon 1" },
      { "<M-2>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon 2" },
      { "<M-3>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon 3" },
      { "<M-4>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon 4" },
    },
  },

  -- Autoclose, Git Blame, Comment (Keep existing)
  { "m4xshen/autoclose.nvim", config = true },
  { "f-person/git-blame.nvim", event="BufReadPost" },
  { "numToStr/Comment.nvim", config = true },
}
