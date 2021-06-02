config.load_autoconfig()
# Qutebrowser Bindings
config.bind("b", "set-cmd-text --space :tab-select  ", mode="normal")
config.bind("<Ctrl-Shift-s>", "open qute://back;;tab-prev")
# Chromium Like Bindings
config.bind("<ctrl+tab>", "tab-next")
config.bind("<ctrl+shift+tab>", "tab-prev")
config.bind("<f12>", "devtools")
config.bind("<ctrl+r>", "reload")
# Unbind Destruction, Error Prone Commands
config.unbind("r")
# Misc Config
config.bind(",test", "message-info testmessg")
# Misc Settings
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.threshold.background", 155)
config.set("colors.webpage.darkmode.threshold.text", 155)
config.set("auto_save.session", True)
config.set("content.autoplay", False)
config.set("url.searchengines", {"DEFAULT": "https://google.com/search?q={}"})
