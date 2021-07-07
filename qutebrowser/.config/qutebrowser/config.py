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

# Hints Settings
# Increase the minimum character count to make the behaviour more deterministic
# normally, the maximum hints is 24, on for each character,
# For a normal page, this limit can easily be exceeded, which quickly introduces
# secondary characters to input, its difficult to determine at a glance if you
# are looking at a page with 2 chars
# This makes it difficult to mentally prepare, do I prepare to type 1 character, or 2?
#
# By making the minimum charactrs to type 2, you end up with 24*24 hint options,
# more than enough for the vast majority of pages, meaning you almost always expect 2
# characters
#
# The different hint character set is also reduced to the home row by default
# 9 characters, not 24, this leaves you a mere 9 for 1 character and 9*9 for 2
# characters 9*9 is still a lot of hints, but it is common enough and uncomfortable
# enough to type to warrent increasing availible characters
#
# There is also this quirky behaviour where the hints are "scattered", so they hint
# characters are distnct from close by hints
# Whilst this makes sense in theory, increasing the distinctiveness of each hint pair
# to reduce confusion
# There is reason to believe that actually you can better mentally prepare yourself if
# you know beforehand that your first chartarget will be in the upper alphabeta,
# for example
# Also, if you lose track of the hint location, you will immediately see nearby hints
# with the same first sequence
#
# Additionally, by reducing the hint size and using uppercase characters,
# the hint can be made easier to view and find
# A background change to a darker colour can make it less jaring
# and focus on the text, not the background colour
config.set("hints.min_chars", 2)
config.set("hints.chars", "abcdefghijklmnopqrstuvwxyz")
config.set("hints.scatter", False)
# config.set("fonts.hints", "bold 9 default_family")
config.set("hints.uppercase", True)
config.set("colors.hints.fg", "rgba(255, 255, 255)")
config.set("colors.hints.bg", "rgba(29,29,98,0.85)")
config.set("colors.hints.match.fg", "red")
config.set("hints.radius", 2)           # Reduce rounding radius to make box sharper
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
