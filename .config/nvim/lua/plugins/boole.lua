return {
  "nat-418/boole.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require('boole').setup({
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>'
      },
      additions = {
        {'Foo', 'Bar', 'Baz', 'Qux', 'Quux'},
        {'light', 'dark'},
        {'if', 'unless'},
        {'true', 'false'},
        {'&&', '||'},
        {'private', 'public', 'protected'},
      },
    })
  end
}
