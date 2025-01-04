{
  terminal.shell = {
    program = "fish";
  };
  window = {
    padding = {
      x = 4;
      y = 4;
    };
  };
  env = {
    WINIT_HIDPI_FACTOR = "1";
    WINIT_X11_SCALE_FACTOR = "1";
  };
  font = {
    size = 10.0;
  };
  colors = {
    primary = {
      background = "#282a36";
      foreground = "#f8f8f2";
      bright_foreground = "#ffffff";
    };
    cursor = {
      text = "CellBackground";
      cursor = "CellForeground";
    };
    normal = {
      black = "#21222c";
      red = "#ff5555";
      green = "#50fa7b";
      yellow = "#f1fa8c";
      blue = "#bd93f9";
      magenta = "#ff79c6";
      cyan = "#8be9fd";
      white = "#f8f8f2";
    };
    bright = {
      black = "#6272a4";
      red = "#ff6e6e";
      green = "#69ff94";
      yellow = "#ffffa5";
      blue = "#d6acff";
      magenta = "#ff92df";
      cyan = "#a4ffff";
      white = "#ffffff";
    };
    indexed_colors = [ ];
    selection = {
      text = "CellForeground";
      background = "#44475a";
    };
    vi_mode_cursor = {
      text = "CellBackground";
      cursor = "CellForeground";
    };
    search = {
      matches = {
        foreground = "#44475a";
        background = "#50fa7b";
      };
      focused_match = {
        foreground = "#44475a";
        background = "#ffb86c";
      };
    };
    footer_bar = {
      background = "#282a36";
      foreground = "#f8f8f2";
    };
    hints = {
      start = {
        foreground = "#282a36";
        background = "#f1fa8c";
      };
      end = {
        foreground = "#f1fa8c";
        background = "#282a36";
      };
    };
    line_indicator = {
      foreground = "None";
      background = "None";
    };
  };
  selection = {
    semantic_escape_chars = '',│`|:"' ()[]{}<>	'';
    save_to_clipboard = true;
  };
  general.live_config_reload = false;
}
