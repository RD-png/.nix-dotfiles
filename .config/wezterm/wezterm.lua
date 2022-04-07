local wezterm = require 'wezterm';
return {
       automatically_reload_config = false,
       hide_tab_bar_if_only_one_tab = true,

  keys = {
    {key="n", mods="CTRL|SHIFT", action=wezterm.action{ScrollByLine=1}},
    {key="p", mods="CTRL|SHIFT", action=wezterm.action{ScrollByLine=-1}},
    {key="v", mods="CTRL|SHIFT", action=wezterm.action{ScrollByPage=1}},
    {key="v", mods="META|SHIFT", action=wezterm.action{ScrollByPage=-1}},
    {key=",", mods="META|SHIFT", action="ScrollToTop"},
    {key=".", mods="META|SHIFT", action="ScrollToBottom"},
    {key="s", mods="CTRL", action=wezterm.action{Search={CaseInSensitiveString=""}}},
    {key="3", mods="CTRL|META", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="2", mods="CTRL|META", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="2", mods="CTRL|META", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="Enter", mods="CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="0", mods="CTRL|META", action=wezterm.action{CloseCurrentPane={confirm=true}}},
    {key="q", mods="CTRL", action=wezterm.action{CloseCurrentTab={confirm=true}}},
    {key="f", mods="CTRL|META", action="TogglePaneZoomState" },
  }
}
