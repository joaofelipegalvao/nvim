return {
  "derektata/lorem.nvim",
  config = function()
    require("lorem").opts({
      sentenceLength = "medium",
      comma_chance = 0.2,
      max_commas_per_sentence = 2,
    })

    -- Keymaps para gerar lorem ipsum
    vim.api.nvim_set_keymap("n", "<Leader>lw", ":LoremIpsum words 1000<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>lp", ":LoremIpsum paragraphs 2<CR>", { noremap = true, silent = true })
  end,
}
