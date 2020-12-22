let

  fallbackPackages = [
    "firefox"
    "qutebrowser"
  ];

  removePackages = [
  ];

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

    pythonLatestPackages = super.python38Packages;

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

    userPackages = {

      # nix-channels <nixpkgs> and <nixos> need to be set up
      nix-rebuild = super.writeScriptBin "nix-rebuild" ''
        #!${super.stdenv.shell}
        set -e
        if [ "$1" = "--upgrade" ]; then
          nix-channel --update nixpkgs nixos
        fi
        nix-env -f '<nixpkgs>' -r -iA userPackages "$@"
        nix-env -f '<nixos>' -iA userPackagesFallback "$@"
      '';

    };

  };

      #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

  overlay-cli = self: super: {

    userPackages = super.userPackages // {

      atool = let atoolDistribution = super.atool;
              in super.symlinkJoin {
        name = atoolDistribution.name;
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

      elinks = super.elinks;

      file = super.file;

      firefox = let firefoxDistribution = super.firefox;
                in super.symlinkJoin {
        name = firefoxDistribution.name;
        paths = [
          firefoxDistribution
          super.passff-host
        ];
      };

      flashrom = super.flashrom;

      fzf = super.fzf;

      git = super.git;

      gnupg = super.gnupg;

      htop = super.htop;

      killall = super.killall;

      mpc = super.mpc_cli;

      mpv = super.mpv;

      mumble = super.mumble;

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
        name = muttDistribution.name;
        paths = [ muttDistribution ];
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib;};
      };

      ncmpcpp = super.ncmpcpp;

      offlineimap = super.offlineimap;

      #openconnect = super.openconnect;

      pass = super.pass;

      pinentry = super.pinentry;

      ranger = let rangerDistribution = super.ranger;
                   runtimeInputs = [
                     self.userPackages.atool
                     super.ffmpegthumbnailer
                     super.highlight
                     super.imagemagick
                     super.jq
                     super.mediainfo
                     super.pythonLatestPackages.pdftotext
                     super.w3m
                     # not in nixpkgs: djvutxt, epub-thumbnailer, od2txt, fontimage
                   ];
               in super.symlinkJoin {
        name = rangerDistribution.name;
        paths = rangerDistribution;
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib; };
      };

      sshfs = super.sshfs;

      #texlive-combined-basic = super.texlive-combined-basic

      tmux = super.tmux;

      vim = let
        vimDistribution = super.vimHugeX;
        vimPlugins = with super.vimPlugins; [
          colorizer
          supertab
          LanguageClient-neovim
          rainbow
          vim-airline
          vim-airline-themes
          vim-indent-guides
          vim-fugitive
          wombat256-vim

          agda-vim
          haskell-vim
          idris-vim
          purescript-vim
          vimtex
          vim-nix
        ];
        runtimeInputs = [
          super.nodePackages.bash-language-server
          super.nodePackages.vim-language-server
          super.pythonLatestPackages.python-language-server
          super.rnix-lsp
        ];
      in super.symlinkJoin {
        name = vimDistribution.name;
        paths = [
          vimDistribution

          (super.neovim.override {
            configure = {
              customRC = ''
                source $XDG_CONFIG_HOME/nvim/init.vim
              '';
              packages.myVimPackage = {
                start = vimPlugins;
              };
            };
          })
        ] ++ vimPlugins;
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib; };
      };

      vimpager = super.vimpager-latest;

      weechat = let weechatDistribution = super.weechat;
                in super.symlinkJoin {
        name = weechatDistribution.name;
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
        name = "haskell-utils";
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
        name = "theme";
        paths = [
          super.bibata-cursors
          super.fira-code
          super.iosevka-bin
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

  overlay-fallback = self: super: {

    userPackagesFallback = super.lib.getAttrs fallbackPackages super.userPackages;

  };

  overlay-remove = self: super: {

    userPackages = removeAttrs super.userPackages (fallbackPackages ++ removePackages);

  };

in [
  overlay-base
  overlay-cli
  overlay-x
  overlay-fallback
  overlay-remove
]
