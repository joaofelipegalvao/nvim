return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename

  {
    "b0o/incline.nvim",
    dependencies = { "folke/tokyonight.nvim" }, -- Dependência do tokyonight.nvim
    event = "BufReadPre",
    priority = 1200,
    config = function()
      -- Obtenha as cores do tema tokyonight
      local colors = require("tokyonight.colors").setup()

      require("incline").setup({
        highlight = {
          groups = {
            -- Ajuste os grupos de destaque para usar as cores do tokyonight
            InclineNormal = { guibg = "#25285B", guifg = "#FFFFFF" },
            InclineNormalNC = { guifg = "#494EB6", guibg = "#FFFFFF" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      -- Adiciona o ícone do sistema operacional
      table.insert(opts.sections.lualine_z, {
        function()
          local os_icons = {
            Linux = "", -- Ícone para Linux
          }
          local os_name = vim.loop.os_uname().sysname -- Detecta o sistema operacional
          return os_icons[os_name] -- Retorna o ícone correspondente ou um padrão
        end,
      })
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
      opts.sections.lualine_z = {
        function()
          return ""
        end,
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "folke/snacks.nvim",
    opts = {
      -- Configuração do LazyGit
      lazygit = {
        configure = true,
        config = {
          os = { editPreset = "nvim-remote" },
          gui = {
            nerdFontsVersion = "3",
          },
        },
        win = {
          style = "lazygit",
        },
      },

      -- Configuração do Dashboard
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
        ]],
        },
      },

      -- Configuração de outros recursos do snacks.nvim
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = { enabled = true },
        },
      },
    },
    keys = {
      { "<leader>e", "<cmd>lua require('snacks').explorer.open()<CR>", desc = "Open Snacks Explorer" },
      {
        "<leader>lg",
        "<cmd>lua require('snacks.lazygit').open()<CR>",
        desc = "Open LazyGit",
      },
      { "<leader>ll", "<cmd>lua require('snacks.lazygit').log()<CR>", desc = "Open LazyGit Log" },
      {
        "<leader>lf",
        "<cmd>lua require('snacks.lazygit').log_file()<CR>",
        desc = "Open LazyGit Log for Current File",
      },
    },
  },
}
