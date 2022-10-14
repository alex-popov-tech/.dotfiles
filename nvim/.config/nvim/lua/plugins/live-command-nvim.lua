return function()
  require("live-command").setup {
    commands = {
      Norm = { cmd = "norm" },
      G = { cmd = "g" },
    },
  }
end
