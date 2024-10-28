return {
  {
    "olexsmir/gopher.nvim", -- Nome do repositório do plugin Gopher
    dependencies = { -- Dependências do plugin
      "nvim-lua/plenary.nvim", -- Plugin necessário para o funcionamento
    },
    config = function()
      require("gopher").setup {
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
          dlv = "dlv",
        },
        gotests = {
          -- gotests doesn't have template named "default" so this plugin uses "default" to set the default template
          template = "default",
          -- path to a directory containing custom test code templates
          template_dir = nil,
          -- switch table tests from using slice to map (with test name for the key)
          -- works only with gotests installed from develop branch
          named = false,
        },
        gotag = {
          transform = "snakecase",
        },
      }
    end
  }
}

