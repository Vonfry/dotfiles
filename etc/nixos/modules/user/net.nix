{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.vonfry.net;
  cfg' = config.vonfry;

  colorscheme = config.lib.theme.dracula;
in {
  options.vonfry.net = {
    email = mkOption {
      type = with types; nullOr attrs;
      description = "Private email config.";
      default = null;
    };
  };

  config = mkIf cfg'.enable {
    accounts.email = mkIf (cfg.email != null) {
      maildirBasePath = "${config.home.homeDirectory}/.mail";
      accounts = {
        vonfry = mkMerge [{
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
          msmtp = {
            enable = true;
            extraConfig = {
            };
          };
          mu.enable = true;
        } cfg.email];
        local.maildir.path = "local";
      };
    };

    vonfry.development.emacs.excludeModules =
      optionals (cfg.email == null) [ "misc/mail" "misc/feed" "misc/gnus"
                                      "misc/irc"
                                    ];

    home = {
      sessionVariables = {
        BROWSER = "qutebrowser";
      };

      packages = with pkgs; [
        curl rsync

        firefox
        qbittorrent
        # unstable.tor-browser-bundle-bin

        fractal # matrix.org

        wireshark iftop
      ];
    };

    programs = {
      mbsync.enable = true;
      mu.enable = true;
      msmtp.enable = true;

      qutebrowser = {
        enable = true;
        keyBindings = {
          normal = {
            "gv" = "spawn firefox {url}";
            "pm" = "spawn mpv {url}";
            "pa" = "open -t https://web.archive.org/save/{url}";
            ";m" = "hint links spawn mpv {hint-url}";
            "ab" = "spawn --userscript getbib";
            "ap" = "spawn --userscript password_fill";
          };
        };
        searchEngines = {
          DEFAULT = "https://duckduckgo.com/?q={}";
          w  = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
          g  = "https://www.google.com/search?hl=en&q={}";
          nw = "https://nixos.wiki/index.php?search={}";
          gh = "https://github.com/search?type=&q={}";
          gl = "https://gitlab.com/search?search={}";
          su = "https://superuser.com/search?q={}";
          so = "https://stackoverflow.com/search?q={}";
          hg = "https://hoogle.haskell.org/?scope=set%3Astackage&hoogle={}";
          yt = "https://www.youtube.com/results?search_query={}";
          ie3 = "https://ieeexplore.ieee.org/search/searchresult.jsp?newsearch=true&queryText={}";
          se  = "https://www.sciencedirect.com/search?qs={}";
          acm = "https://dl.acm.org/action/doSearch?AllField={}";
          gs  = "https://scholar.google.com/scholar?q={}";
          doi = "https://www.doi.org/{}";
        };
        settings = {
          hints.chars = "aoeuidhtns";
          input.partial_timeout = 30000;
          url = {
            default_page = "about:blank";
            start_pages = [ "about:blank" ];
          };
          colors = {
            completion.category.bg = colorscheme.background;
            completion.category.border.bottom = colorscheme.background;
            completion.category.border.top = colorscheme.background;
            completion.category.fg = colorscheme.foreground;
            completion.even.bg = colorscheme.background;
            completion.odd.bg = colorscheme.background;
            completion.fg = colorscheme.foreground;
            completion.item.selected.bg = colorscheme.selection;
            completion.item.selected.border.bottom = colorscheme.selection;
            completion.item.selected.border.top = colorscheme.selection;
            completion.item.selected.fg = colorscheme.foreground;
            completion.match.fg = colorscheme.orange;
            completion.scrollbar.bg = colorscheme.background;
            completion.scrollbar.fg = colorscheme.foreground;
            downloads.bar.bg = colorscheme.background;
            downloads.error.bg = colorscheme.background;
            downloads.error.fg = colorscheme.red;
            downloads.stop.bg = colorscheme.background;
            downloads.system.bg = "none";
            hints.bg = colorscheme.background;
            hints.fg = colorscheme.purple;
            hints.match.fg = colorscheme.foregroundAlt;
            keyhint.bg = colorscheme.background;
            keyhint.fg = colorscheme.purple;
            keyhint.suffix.fg = colorscheme.selection;
            messages.error.bg = colorscheme.background;
            messages.error.border = colorscheme.background;
            messages.error.fg = colorscheme.red;
            messages.info.bg = colorscheme.background;
            messages.info.border = colorscheme.background;
            messages.info.fg = colorscheme.comment;
            messages.warning.bg = colorscheme.background;
            messages.warning.border = colorscheme.background;
            messages.warning.fg = colorscheme.red;
            prompts.bg = colorscheme.background;
            prompts.border = "1px solid " + colorscheme.background;
            prompts.fg = colorscheme.cyan;
            prompts.selected.bg = colorscheme.selection;
            statusbar.caret.bg = colorscheme.background;
            statusbar.caret.fg = colorscheme.orange;
            statusbar.caret.selection.bg = colorscheme.background;
            statusbar.caret.selection.fg = colorscheme.orange;
            statusbar.command.bg = colorscheme.background;
            statusbar.command.fg = colorscheme.pink;
            statusbar.command.private.bg = colorscheme.background;
            statusbar.command.private.fg = colorscheme.foregroundAlt;
            statusbar.insert.bg = colorscheme.backgroundAttention;
            statusbar.insert.fg = colorscheme.foregroundAttention;
            statusbar.normal.bg = colorscheme.background;
            statusbar.normal.fg = colorscheme.foreground;
            statusbar.passthrough.bg = colorscheme.background;
            statusbar.passthrough.fg = colorscheme.orange;
            statusbar.private.bg = colorscheme.background;
            statusbar.private.fg = colorscheme.foregroundAlt;
            statusbar.progress.bg = colorscheme.background;
            statusbar.url.error.fg = colorscheme.red;
            statusbar.url.fg = colorscheme.foreground;
            statusbar.url.hover.fg = colorscheme.cyan;
            statusbar.url.success.http.fg = colorscheme.green;
            statusbar.url.success.https.fg = colorscheme.green;
            statusbar.url.warn.fg = colorscheme.yellow;
            tabs.bar.bg = colorscheme.selection;
            tabs.even.bg = colorscheme.selection;
            tabs.even.fg = colorscheme.foreground;
            tabs.indicator.error = colorscheme.red;
            tabs.indicator.start = colorscheme.orange;
            tabs.indicator.stop = colorscheme.green;
            tabs.indicator.system = "none";
            tabs.odd.bg = colorscheme.selection;
            tabs.odd.fg = colorscheme.foreground;
            tabs.selected.even.bg = colorscheme.background;
            tabs.selected.even.fg = colorscheme.foreground;
            tabs.selected.odd.bg = colorscheme.background;
            tabs.selected.odd.fg = colorscheme.foreground;
          };
          hints.border = "1px solid " + colorscheme.background;
          tabs = {
            indicator.width = 1;
            favicons.scale = 1;
            show = "multiple";
          };
          editor.command = [ "alacritty" "-e" "nvim" "{file}" ];
          downloads = {
            location = {
              directory = "~/Downloads";
              prompt = false;
            };
            remove_finished = 7;
          };
          content.autoplay = false;
          session.default_name = "autosave";
          auto_save.session = true;
          colors.webpage.preferred_color_scheme = "dark";
        };
        extraConfig = ''
          padding = { "top": 6, "right": 8, "bottom": 6, "left": 8 }
          c.tabs.padding = padding
          c.statusbar.padding = padding
        '';
        loadAutoconfig = true;
      };
    };
  };
}
