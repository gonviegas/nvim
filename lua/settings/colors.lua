module(..., package.seeall)

function Color()
  local colors = {
    pink = "#dd77dd",
    orange = "Orange",
    green = "#88cc00",
    blue = "#00aaee",
    dark_blue = "#0050aa",
    magenta = "#dd25dd",
    purple = "#5000b0",
    gray = "#504945",
    gray1a = "#101010",
    gray1b = "#151515",
    gray2a = "#202020",
    gray2b = "#252525",
    gray3a = "#303030",
    gray3b = "#353535",
    gray4a = "#403040",
    gray4b = "#454545",
    gray5a = "#505050",
    gray5b = "#555555",
    gray6a = "#606060",
    gray6b = "#656565",
    gray7a = "#707070",
  }
  return colors
end

function Default()
  local colors = {
    bg = Color().gray2a,
    normal = "#101010",
    normal2 = Color().gray3a,
    text = "#eaeaea",
    text2 = "#cfcfcf",
    textNC = "#b0b0b0",
    git_del = "#fb4934",
    git_add = "#b8bb26",
    git_change = "#8ec07c",
    diag_error = "#f44747",
    diag_error_bg = "#31262d",
    diag_warn = "#ff8800",
    diag_warn_bg = "#32302f",
    diag_hint = "#cc00ff",
    diag_hint_bg = "#252030",
    diag_info = "#4bc1fe",
    diag_info_bg = "#1e3135"
  }
  return colors
end
