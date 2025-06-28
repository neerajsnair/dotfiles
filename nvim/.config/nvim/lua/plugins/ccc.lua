return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      highlighter ={
        auto_enable = true
      },
    })
    vim.keymap.set("n", "<leader>cc", "<cmd>CccConvert<CR>", { desc = "Convert Color Format" })
    vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Pick a Color" })
  end,
  --cmd = { "CccPick", "CccConvert" } -- optional lazy-loading
}

