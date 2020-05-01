let

  lib = {
    runtimeWrapper = { lib, runtimeInputs ? [] }: ''
      for f in $out/bin/* ; do
        wrapProgram "$f" --prefix PATH : ${lib.makeBinPath runtimeInputs}
      done
    '';
  };

  overlay = self: super: {

    myDependencies = {
      aspell-configured = super.aspellWithDicts (d: with d; [en de]);
    };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

    myPackages = {

      atool = let atoolDistribution = super.atool;
              in super.symlinkJoin {
        name = atoolDistribution.name + "-jumper";
        paths = [
          atoolDistribution
          super.cpio
          super.gnutar
          super.gzip
          super.bzip2 # not parallel
          super.lzip # not parallel
          super.lzma
          super.lzop
          super.lhasa # works with atool?
          super.p7zip
          #asuper.unarj # not free
          #asuper.unrar # not free
          super.unzip
          # missing?: unace, rpm, arc, nomarch, unalz
        ];
      };

      firefox = let firefoxDistribution = super.firefox;
                in super.symlinkJoin {
        name = firefoxDistribution.name + "-jumper";
        paths = [
          firefoxDistribution
          super.passff-host
        ];
      };

      mutt = let muttDistribution = super.mutt;
                 runtimeInputs = [
                   super.abook
                   super.enscript
                   super.msmtp
                   super.urlscan
                   super.w3m
                 ];
             in super.symlinkJoin {
        name = "mutt-jumper";
        paths = [ muttDistribution ];
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib;};
      };

      ranger = let rangerDistribution = super.ranger;
                   runtimeInputs = [
                     self.atool
                     super.ffmpegthumbnailer
                     super.highlight
                     super.imagemagick
                     super.jq
                     super.mediainfo
                     super.python37Packages.pdftotext
                     super.w3m
                     # not in nixpkgs: djvutxt, epub-thumbnailer, od2txt, fontimage
                   ];
               in super.symlinkJoin {
        name = rangerDistribution.name + "-jumper";
        paths = rangerDistribution;
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib; };
      };

      screenkey = super.screenkey.overrideAttrs ({ buildInputs ? [], ... }: {
        buildInputs = buildInputs ++ [
          super.inconsolata
        ];
      });

      vim = let vimDistribution = super.vimHugeX;
            in super.symlinkJoin {
        name = vimDistribution.name + "-jumper";
        paths = [
          vimDistribution

          super.vimPlugins.supertab
          super.vimPlugins.vim-airline
          super.vimPlugins.vim-airline-themes
          super.vimPlugins.vim-fugitive
          super.vimPlugins.wombat256-vim

          super.vimPlugins.purescript-vim
          super.vimPlugins.haskell-vim
        ];
      };

      weechat = let weechatDistribution = super.weechat;
                in super.symlinkJoin {
        name = weechatDistribution.name + "-jumper";
        paths = [ weechatDistribution ];
        buildInputs = [
          super.makeWrapper
          self.myDependencies.aspell-configured
        ];
        postBuild = ''
          wrapProgram $out/bin/weechat \
            --prefix ASPELL_CONF ';' "dict-dir ${self.myDependencies.aspell-configured}/lib/aspell"
        '';
      };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

      haskell-utils = super.symlinkJoin {
        name = "haskell-utils-jumper";
        paths = [
          super.cabal-install
          super.cabal2nix
          super.ghc
          super.haskellPackages.hoogle
        ];
      };

      mpd-utils = super.symlinkJoin {
        name = "mpd-utils-jumper";
        paths = [
          super.mpc_cli
          super.ncmpcpp
        ];
      };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

      theme = super.symlinkJoin {
        name = "theme-jumper";
        paths = [
          super.bibata-cursors
          super.fira-code
        ];
      };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

      applications-cli = super.symlinkJoin {
        name = "applications-cli-jumper";
        paths = with super; [
          git
          htop
          killall
          mpv
          offlineimap
          openconnect
          pass
          # texlive-combined-basic
          tmux
          vimpager-latest
          youtube-dl
        ] ++ (with self.myPackages; [
          # atool
          haskell-utils
          mpd-utils
          mutt
          ranger
          vim
          weechat
        ]);
      };

      applications-x = super.symlinkJoin {
        name = "applications-x-jumper";
        paths = with super; [
          arandr
          baobab
          blugon
          conky
          gimp
          i3lock
          kitty
          # libreoffice
          pavucontrol
          rofi
          scrot
          sxiv
          tdesktop
          xdotool
          xmobar
          zathura

          # chromium
          # rxvt-unicode
          # zoom-us
        ] ++ (with self.myPackages; [
          firefox
        ]);
      };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

      applications = super.symlinkJoin {
        name = "applications-jumper";
        paths = with self.myPackages; [
          applications-cli
          applications-x
          theme
        ];
      };

    };

  };

in [ overlay ]
