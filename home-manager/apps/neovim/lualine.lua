local colors = {
  black         = '#282c34',
  red           = '#e06c75',
  green         = '#98c379',
  yellow        = '#e5c07b',
  blue          = '#61afef',
  magenta       = '#c678dd',
  cyan          = '#56b6c2',
  white         = '#dcdfe4',
  gray          = '#333333',
  foreground    = '#dcdfe4',
  background    = '#282c34'
}
local onehalf = {
  normal = {
    a = {bg = colors.green, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.green},
    c = {bg = colors.black, fg = colors.white},

    v = {bg = colors.black, fg = colors.white},
    w = {bg = colors.gray, fg = colors.white},
    x = {bg = colors.gray, fg = colors.white},
    y = {bg = colors.gray, fg = colors.white},
    z = {bg = colors.green, fg = colors.black}
  },
  insert = {
    a = {bg = colors.yellow, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.yellow},
    c = {bg = colors.black, fg = colors.white}
  },
  visual = {
    a = {bg = colors.blue,    fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.blue},
    c = {bg = colors.black, fg = colors.white}
  },
  replace = {
    a = {bg = colors.red, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.red},
    c = {bg = colors.black, fg = colors.white}
  },
  command = {
    a = {bg = colors.magenta, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.magenta},
    c = {bg = colors.black, fg = colors.white}
  },
  inactive = {
    a = {bg = colors.white, fg = colors.black, gui = 'bold'},
    b = {bg = colors.gray, fg = colors.white},
    c = {bg = colors.black, fg = colors.white}
  }
}

require("lualine").setup {
    options = {
    	icons_enable = true,
    	theme = onehalf,
    }
}
