let

  lib = {
    runtimeWrapper = { lib, runtimeInputs ? [] }: ''
      for f in $out/bin/* ; do
        wrapProgram "$f" --prefix PATH : ${lib.makeBinPath runtimeInputs}
      done
    '';
  };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

  overlay-base = self: super: {

    myDependencies = {
      aspell-configured = super.aspellWithDicts (d: with d; [en de]);
    };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

    userPackages = {

      nix-rebuild = super.writeScriptBin "nix-rebuild" ''
        #!${super.stdenv.shell}
        exec nix-env -f '<nixpkgs>' -r -iA userPackages "$@"
      '';

    };

  };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

  overlay-cli = self: super: {

    userPackages = super.userPackages // {

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

      file = super.file;

      firefox = let firefoxDistribution = super.firefox;
                in super.symlinkJoin {
        name = firefoxDistribution.name + "-jumper";
        paths = [
          firefoxDistribution
          super.passff-host
        ];
      };

      git = super.git;

      htop = super.htop;

      killall = super.killall;

      mpc = super.mpc_cli;

      mpv = super.mpv;

      mutt = let muttDistribution = super.mutt;
                 runtimeInputs = [
                   super.abook
                   super.enscript
                   super.ghostscript
                   super.msmtp
                   super.urlscan
                   super.w3m
                 ];
             in super.symlinkJoin {
        name = muttDistribution.name + "-jumper";
        paths = [ muttDistribution ];
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib;};
      };

      ncmpcpp = super.ncmpcpp;

      offlineimap = super.offlineimap;

      #openconnect = super.openconnect;

      pass = super.pass;

      ranger = let rangerDistribution = super.ranger;
                   runtimeInputs = [
                     self.userPackages.atool
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

      sshfs = super.sshfs;

      #texlive-combined-basic = super.texlive-combined-basic

      tmux = super.tmux;

      vim = let vimDistribution = super.vimHugeX;
            in super.symlinkJoin {
        name = vimDistribution.name + "-jumper";
        paths = [
          vimDistribution

          super.vimPlugins.colorizer
          super.vimPlugins.supertab
          super.vimPlugins.LanguageClient-neovim
          super.vimPlugins.vim-airline
          super.vimPlugins.vim-airline-themes
          super.vimPlugins.vim-indent-guides
          super.vimPlugins.vim-fugitive
          super.vimPlugins.wombat256-vim

          super.vimPlugins.agda-vim
          super.vimPlugins.haskell-vim
          super.vimPlugins.idris-vim
          super.vimPlugins.purescript-vim
        ];
      };

      vimpager = super.vimpager-latest;

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

      xdg-user-dirs = super.xdg-user-dirs;

      youtube-dl = super.youtube-dl;

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

    };

  };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

  overlay-x = self: super: {

    userPackages = super.userPackages // {

      theme = super.symlinkJoin {
        name = "theme-jumper";
        paths = [
          super.bibata-cursors
          super.fira-code
        ];
      };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

      alacritty = super.alacritty;

      arandr = super.arandr;

      baobab = super.baobab;

      blucontrol = let
        #src = fetchFromGitHub {
        #  owner = "jumper149";
        #  repo = "blucontrol";
        #  rev = "0.2.1.1"
        #  #sha256 = "";
        #};
        src = fetchGit {
          url = "https://github.com/jumper149/blucontrol.git";
          ref = "master";
          rev = "dd4b18a33923fcab99a4cc230fb70ae1e9642928";
        };
      in
        import "${src}/default.nix" {
          stdenv = super.stdenv;
          makeWrapper = super.makeWrapper;
          makeBinPath = super.lib.makeBinPath;
          ghcWithPackages = super.haskellPackages.ghcWithPackages;
        };

      #chromium = super.chromium;

      conky = super.conky;

      gimp = super.gimp;

      glava = super.glava;

      i3lock = super.i3lock;

      #libreoffice = super.libreoffice;

      #kitty = super.kitty;

      pavucontrol = super.pavucontrol;

      qutebrowser = super.qutebrowser;

      rofi = super.rofi;

      #rxvt-unicode = super.rxvt-unicode;

      screenkey = super.screenkey.overrideAttrs ({ buildInputs ? [], ... }: {
        buildInputs = buildInputs ++ [
          super.inconsolata
        ];
      });

      scrot = super.scrot;

      sxiv = super.sxiv;

      tdesktop = super.tdesktop;

      xdotool = super.xdotool;

      xmobar = super.xmobar;

      zathura = super.zathura;

      #zoom-us = super.zoom-us

    };

  };

in [ overlay-base overlay-cli ]
