return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      -- Configuração do plugin
      require("code_runner").setup({
        filetype = {
          javascript = "node", -- Use o comando `node` para rodar código JavaScript
          python = "python3", -- Use o comando `python3` para rodar código Python
        },
      })
      vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
      vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
    end,
  },
}
