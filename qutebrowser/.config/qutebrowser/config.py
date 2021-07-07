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
config.bind("<ctrl+=>", "zoom-in")
config.bind("<ctrl+->", "zoom-out")
# Unbind Destructive, Error Prone Commands
config.unbind("r") # reload
config.unbind("d") # tab-close
# Misc Bindings
config.bind(",test", "message-info testmessg")

# Darkmode Setup
config.set("colors.webpage.bg", "black") # prevent blind white flash on tab change
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("colors.webpage.darkmode.threshold.background", 120)
config.set("colors.webpage.darkmode.threshold.text", 120)

# Input Settings
config.set("zoom.mouse_divider", 2048)          # Increase mouse zoom precision
config.set("input.partial_timeout", 5000)       # Quit verb after 5 seconds
config.set("input.mouse.rocker_gestures", False) # Navigatie history with rocker gestures
config.set("tabs.mousewheel_switching", False)  # Prevent scroll from switching tabs
# Because of the various automatic insert mode entering behaviour
# it can be quite non-deterministic, especially between sites,
# this is quite confusing and mentally taxing on the user, especially a new user
#
# Here we tweak some of settings to make it more deterministic

# Don't automatically change insert mode on text prompt
config.set("input.insert_mode.auto_enter", False)
config.set("input.insert_mode.auto_leave", False)
config.set("input.insert_mode.auto_load", False)     # When focusing a prompt after page load
# Leave insert mode when enterting a new page
config.set("input.insert_mode.leave_on_load", True)
# Don't enter insert mode when focusing a plugin like flash
config.set("input.insert_mode.plugins", False)
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
