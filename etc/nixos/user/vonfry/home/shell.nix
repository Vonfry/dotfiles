{ ... }:

{
  programs = {
    man.enable = true;
    tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      shortcut = "\\";
      extraConfig = ''
        set -g update-environment -r
        set -g status-right "#{tmux_mode_indicator}"
        unbind C-b
      '';
    };
  };
}
