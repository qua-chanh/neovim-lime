require("settings")

require("nvim.options")
require("treesitter")
require("lsp").setup()

require("plugins.notify").setup()
require("plugins.git").setup()
require("plugins.comment").setup()
require("plugins.graphic").setup()
require("plugins.scrollbar").setup()
require("plugins.session").setup()
require("plugins.tabline").setup()
require("plugins.statusline").setup()
require("plugins.winbar").setup()

require("nvim.mappings")
require("nvim.highlights")
