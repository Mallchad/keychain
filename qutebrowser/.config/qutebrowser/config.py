config.load_autoconfig()
config.set("colors.webpage.darkmode.enabled", True)
config.bind(",darkmode", "config-cycle colors.webpage.darkmode.enabled")
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.threshold.background", 155)
config.set("colors.webpage.darkmode.threshold.text", 155)
config.set("auto_save.session", True)
config.set("content.autoplay", False)