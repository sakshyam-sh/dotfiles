return {
  {
    "cordx56/rustowl",
    version = "*",
    build = "cargo install rustowl",
    lazy = false,
    opts = {
      auto_attach = true,
      auto_enable = true,
      idle_time = 500,
      client = {
        cmd = { "rustowl" },
        name = "rustowl",
        on_attach = function(_, buffer)
          vim.keymap.set("n", "<leader>ro", function()
            require("rustowl").toggle(buffer)
          end, { buffer = buffer, silent = true, desc = "Toggle RustOwl" })
          vim.keymap.set("n", "<leader>re", function()
            require("rustowl").enable(buffer)
          end, { buffer = buffer, silent = true, desc = "Enable RustOwl" })
          vim.keymap.set("n", "<leader>rd", function()
            require("rustowl").disable(buffer)
          end, { buffer = buffer, silent = true, desc = "Disable RustOwl" })
        end,
      },
    },
  },
}
