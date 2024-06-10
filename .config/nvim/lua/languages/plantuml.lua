return {
  {
    "weirongxu/plantuml-previewer.vim",
    dependencies = { "tyru/open-browser.vim", "aklt/plantuml-syntax" },
    lazy = false,
    config = function()
      vim.g.plantuml_previewer_plantuml_jar_path = '/opt/homebrew/bin/plantuml'
    end
  }
}
