return {
  "ibhagwan/fzf-lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
	{ 
            "<leader><leader>",
            function() require('fzf-lua').files() end,
            desc="Find Files in project directory"
        },
  }
}
