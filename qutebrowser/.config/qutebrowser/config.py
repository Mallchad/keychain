config.load_autoconfig()
# Qutebrowser Bindings
config.bind("b", "set-cmd-text --space :tab-select  ", mode="normal")
config.bind("<Ctrl-Shift-s>", "open qute://back;;tab-prev")
# Chromium Like Bindings
config.bind("<ctrl+tab>", "tab-next")
config.bind("<ctrl+shift+tab>", "tab-prev")
config.bind("<f12>", "devtools")
config.bind("<ctrl+r>", "reload")
config.bind("ctrl+w", "tab-close")
config.bind("<alt+d>", "set-cmd-text :open -w {url:pretty}")
# Unbind Destruction, Error Prone Commands
config.unbind("r") # reload
config.unbind("d") # tab-close
# Misc Config
config.bind(",test", "message-info testmessg")
# Darkmode Setup
config.set("colors.webpage.bg", "black") # prevent blind white flash on tab change
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("colors.webpage.darkmode.threshold.background", 120)
config.set("colors.webpage.darkmode.threshold.text", 120)
# Misc Settings
config.set("auto_save.session", True)
config.set("content.autoplay", False)
config.set("url.searchengines", {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'g': 'https://www.google.com/search?q={}',
    'ddg': 'https://duckduckgo.com/?q={}',
    'ama': 'https://www.amazon.com/s?k={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'red': 'https://www.reddit.com/r/{}',
    'ud': 'https://www.urbandictionary.com/define.php?term={}',
    'wiki': 'https://en.wikipedia.org/wiki/{}',
    'yt': 'https://www.youtube.com/results?search_query={}'})
config.set("scrolling.smooth", True)
config.set("content.pdfjs", True) # Automatically use pdfjs where possible
