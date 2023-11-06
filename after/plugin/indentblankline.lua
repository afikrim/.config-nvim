local indent = require("ibl")

indent.setup({
	scope = {
		enabled = true,
		show_start = true,
		show_end = true,
		injected_languages = true,
		highlight = { "Function", "Label" },
		priority = 500,
	},
})
