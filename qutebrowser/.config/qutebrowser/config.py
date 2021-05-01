config.load_autoconfig()
config.set("colors.webpage.darkmode.enabled", True)
config.bind(",darkmode", "config-cycle colors.webpage.darkmode.enabled")
config.set("auto_save.session", True)
