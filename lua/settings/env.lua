return {
    session_dir = ("%s/nvim/sessions"):format(vim.env.XDG_DATA_HOME),
    dashboard_image = ("%s/assets/lime.png"):format(vim.env.NVIM),
    dashboard_text = {
        "⠀⠀⠀⠀⠀⠀⠀⢀⣴⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣦⡀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣦⡀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣦⡀⠀⠀⠀",
        "⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣦⡀⠀",
        "⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣦",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
        "⠻⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟",
        "⠀⠈⠻⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀",
        "⠀⠀⠀⠈⠻⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠈⠻⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠈⠻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⠟⠁⠀⠀⠀⠀⠀⠀⠀",
    },
    terminal = require('utils.terminal').get_terminal()
}