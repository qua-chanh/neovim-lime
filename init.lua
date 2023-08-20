require("settings")

require("nvim.options")
require("treesitter")

require("plugins.comment").setup()
require("plugins.scrollbar").setup()
require("plugins.session").setup()

require("nvim.mappings")
require("nvim.commands")
require("nvim.highlights")
