{ pkgs, config, lib, ... }:

let
  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in {
  accounts.email = {
    maildirBasePath = "${config.home.homeDirectory}/.mail";
    accounts = {
      vonfry = {
        realName = "Vonfry";
        primary = true;
        # other configurations are save in local
        maildir.path = "mail";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "imap";
          remove = "both";
          patterns = [ "*" ];
          extraConfig.channel.Sync = "All";
        };
      };
      local.maildir.path = "local";
    };
  };
  home = lib.optionalAttrs isDarwin {
    file.".config/qutebrowser/config.py".source = ./files/qutebrowser.macos.py;
  } // {
    activation.qutebrowserActivation = lib.hm.dag.entryAfter ["shellActivation"] ''
      $DRY_RUN_CMD ln $VERBOSE_ARG -s -f $CLOUD_DIR/dotfiles/config/qutebrowser/* ~/.config/qutebrowser
    '';
  };
  programs = {
    mbsync.enable = true;
  } // lib.optionalAttrs isLinux {
    chromium.enable = true;
    qutebrowser = {
      enable = true;
      settings =
        let
          padding = {
             top = 6;
             right = 8;
             bottom = 6;
             left = 8;
          };
          draculaBackground          = "#282a36";
          draculaBackgroundAttention = "#181920";
          draculaForeground          = "#f8f8f2";
          draculaForegroundAlt       = "#e0e0e0";
          draculaForegroundAttention = "#ffffff";
          draculaComment             = "#6272a4";
          draculaSelection           = "#44475a";
          draculaCurrent             = "#44475a";
          draculaYellow              = "#f1fabc";
          draculaOrange              = "#ffb86c";
          draculaRed                 = "#ff5555";
          draculaPink                = "#ff79c6";
          draculaPurple              = "#bd93f9";
          draculaCyan                = "#8be9fd";
          draculaGreen               = "#50fa7b";
        in {
        url = {
          default_page = "about:blank";
          start_pages = [ "about:blank" ];
        };
        bindings.commands = {
          normal = {
            "gv" = "spawn chromium {url}";
          };
        };
        colors = {
          completion.category.bg = draculaBackground;
          completion.category.border.bottom = draculaBackground;
          completion.category.border.top = draculaBackground;
          completion.category.fg = draculaForeground;
          completion.even.bg = draculaBackground;
          completion.odd.bg = draculaBackground;
          completion.fg = draculaForeground;
          completion.item.selected.bg = draculaSelection;
          completion.item.selected.border.bottom = draculaSelection;
          completion.item.selected.border.top = draculaSelection;
          completion.item.selected.fg = draculaForeground;
          completion.match.fg = draculaOrange;
          completion.scrollbar.bg = draculaBackground;
          completion.scrollbar.fg = draculaForeground;
          downloads.bar.bg = draculaBackground;
          downloads.error.bg = draculaBackground;
          downloads.error.fg = draculaRed;
          downloads.stop.bg = draculaBackground;
          downloads.system.bg = "none";
          hints.bg = draculaBackground;
          hints.fg = draculaPurple;
          hints.match.fg = draculaForegroundAlt;
          keyhint.bg = draculaBackground;
          keyhint.fg = draculaPurple;
          keyhint.suffix.fg = draculaSelection;
          messages.error.bg = draculaBackground;
          messages.error.border = draculaBackground;
          messages.error.fg = draculaRed;
          messages.info.bg = draculaBackground;
          messages.info.border = draculaBackground;
          messages.info.fg = draculaComment;
          messages.warning.bg = draculaBackground;
          messages.warning.border = draculaBackground;
          messages.warning.fg = draculaRed;
          prompts.bg = draculaBackground;
          prompts.border = "1px solid " + draculaBackground;
          prompts.fg = draculaCyan;
          prompts.selected.bg = draculaSelection;
          statusbar.caret.bg = draculaBackground;
          statusbar.caret.fg = draculaOrange;
          statusbar.caret.selection.bg = draculaBackground;
          statusbar.caret.selection.fg = draculaOrange;
          statusbar.command.bg = draculaBackground;
          statusbar.command.fg = draculaPink;
          statusbar.command.private.bg = draculaBackground;
          statusbar.command.private.fg = draculaForegroundAlt;
          statusbar.insert.bg = draculaBackgroundAttention;
          statusbar.insert.fg = draculaForegroundAttention;
          statusbar.normal.bg = draculaBackground;
          statusbar.normal.fg = draculaForeground;
          statusbar.passthrough.bg = draculaBackground;
          statusbar.passthrough.fg = draculaOrange;
          statusbar.private.bg = draculaBackground;
          statusbar.private.fg = draculaForegroundAlt;
          statusbar.progress.bg = draculaBackground;
          statusbar.url.error.fg = draculaRed;
          statusbar.url.fg = draculaForeground;
          statusbar.url.hover.fg = draculaCyan;
          statusbar.url.success.http.fg = draculaGreen;
          statusbar.url.success.https.fg = draculaGreen;
          statusbar.url.warn.fg = draculaYellow;
          tabs.bar.bg = draculaSelection;
          tabs.even.bg = draculaSelection;
          tabs.even.fg = draculaForeground;
          tabs.indicator.error = draculaRed;
          tabs.indicator.start = draculaOrange;
          tabs.indicator.stop = draculaGreen;
          tabs.indicator.system = "none";
          tabs.odd.bg = draculaSelection;
          tabs.odd.fg = draculaForeground;
          tabs.selected.even.bg = draculaBackground;
          tabs.selected.even.fg = draculaForeground;
          tabs.selected.odd.bg = draculaBackground;
          tabs.selected.odd.fg = draculaForeground;
        };
        hints.border = "1px solid " + draculaBackground;
        statusbar.padding = padding;
        tabs = {
          padding = padding;
          indicator.width = 1;
          favicons.scale = 1;
          show = "multiple";
        };
        editor.command = [ "alacritty -e nvim" "{file}" ];
        downloads = {
          location.directory = "~/downloads";
          location.prompt = false;
          remove_finished = 7;
        };
      };
    };
  };
}