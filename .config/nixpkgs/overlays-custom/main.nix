let
  lib = {

    runtimeWrapper = { lib, runtimeInputs ? [] }: ''
      for f in $out/bin/* ; do
        wrapProgram "$f" --prefix PATH : ${lib.makeBinPath runtimeInputs}
      done
    '';

  };
in
  self: super: {

    userPackages = super.userPackages // {

      alacritty = super.alacritty;

      amfora = super.amfora;

      arandr = super.arandr;

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
          #super.unarj # not free
          #super.unrar # not free
          super.unzip
          # missing?: unace, rpm, arc, nomarch, unalz
        ];
      };

      baobab = super.baobab;

      bind = super.bind;

      blucontrol = super.blucontrol;

      chromium = super.chromium;

      conky = super.conky;

      dict = super.dict;

      dig = super.sysdig;

      element = super.element-desktop;

      elinks = super.elinks;

      file = super.file;

      firefox = let firefoxDistribution = super.firefox;
                    ff2mpv = super.stdenv.mkDerivation rec {
                      pname = "ff2mpv";
                      version = "3.7.1";

                      src = super.fetchFromGitHub {
                        owner = "woodruffw";
                        repo = pname;
                        rev = "v${version}";
                        sha256 = "1ixgpa1hygii2y65jkgpn6ka1dc5zkcknvmlzam20lqqpya9530i";
                      };

                      buildInputs = [ super.python3 ];

                      patchPhase = ''
                        sed -i "s|/home/william/scripts/ff2mpv|$out/share/ff2mpv/ff2mpv.py|g" ff2mpv.json
                      '';

                      installPhase = ''
                        install -D -m644 ff2mpv.json $out/share/ff2mpv/ff2mpv.json
                        install -D -m755 ff2mpv.py $out/share/ff2mpv/ff2mpv.py
                      '';

                      meta = with super.lib; {
                        description = "A Firefox add-on for playing URLs in mpv.";
                        homepage = "https://github.com/woodruffw/ff2mpv";
                        license = licenses.mit;
                        maintainers = with maintainers; [ jumper149 ];
                      };
                    };
                in super.symlinkJoin {
        name = firefoxDistribution.name;
        paths = [
          firefoxDistribution
          super.passff-host
          ff2mpv
        ];
      };

      flashrom = super.flashrom;

      fzf = super.fzf;

      gimp = super.gimp;

      git = super.git;

      glava = super.glava;

      gnupg = super.gnupg;

      haskell-utils = super.symlinkJoin {
        name = "haskell-utils";
        paths = [
          super.cabal-install
          super.cabal2nix
          super.ghc
          super.haskellPackages.hoogle
        ];
      };

      htop = super.htop;

      i3lock = super.i3lock;

      khal = super.khal;

      khard = super.khard;

      killall = super.killall;

      kitty = super.kitty;

      libreoffice = super.libreoffice;

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

      openconnect = super.openconnect;

      pass = super.pass;

      pavucontrol = super.pavucontrol;

      pdfpc = super.pdfpc;

      pinentry = super.pinentry-gtk2;

      pulsemixer = super.pulsemixer;

      qutebrowser = super.symlinkJoin {
        name = super.qutebrowser.name;
        paths = [
          super.qutebrowser
          super.pythonLatestPackages.adblock
        ];
      };

      ranger = let rangerDistribution = super.ranger;
                   runtimeInputs = [
                     self.userPackages.atool
                     super.ffmpegthumbnailer
                     super.highlight
                     super.imagemagick
                     super.jq
                     super.mediainfo
                     super.poppler_utils
                     super.w3m
                     # not in nixpkgs: djvutxt, epub-thumbnailer, od2txt, fontimage
                   ];
               in super.symlinkJoin {
        name = rangerDistribution.name;
        paths = rangerDistribution;
        buildInputs = [ super.makeWrapper ] ++ runtimeInputs;
        postBuild = lib.runtimeWrapper { runtimeInputs = runtimeInputs; lib = super.lib; };
      };

      rofi = super.rofi;

      rxvt-unicode = super.rxvt-unicode;

      screenkey = super.screenkey.overrideAttrs ({ buildInputs ? [], ... }: {
        buildInputs = buildInputs ++ [
          super.inconsolata
        ];
      });

      scrot = super.scrot;

      sshfs = super.sshfs;

      sxiv = super.sxiv;

      task = super.symlinkJoin {
        name = "task";
        paths = [
          super.taskwarrior
          super.taskwarrior-tui
        ];
      };

      telegram = super.tdesktop;

      texlive = super.texlive-combined-basic;

      theme = super.symlinkJoin {
        name = "theme";
        paths = [
          super.pop-gtk-theme
          super.bibata-cursors
          super.fira-code
          super.libsForQt5.qtstyleplugin-kvantum # TODO: check if qt4 applications look nice too
          super.iosevka-bin
        ];
      };

      tmux = super.tmux;

      traceroute = super.traceroute;

      vim = let
        vimDistribution = super.vimHugeX;
        vimPlugins = with super.vimPlugins; [
          colorizer
          deoplete-nvim
          fzf-vim
          LanguageClient-neovim
          rainbow
          vim-airline
          vim-airline-themes
          vim-indent-guides
          vim-fugitive
          (super.vimUtils.buildVimPluginFrom2Nix {
            pname = "suda";
            version = "2020-09-08";
            src = super.fetchFromGitHub {
              owner = "lambdalisue";
              repo = "suda.vim";
              rev = "v0.2.0";
              sha256 = "0apf28b569qz4vik23jl0swka37qwmbxxiybfrksy7i1yaq6d38g";
            };
          meta.homepage = "https://github.com/lambdalisue/suda.vim";
          })
          wombat256-vim

          agda-vim
          haskell-vim
          idris2-vim
          purescript-vim
          vimtex
          vim-nix
          vim-terraform
        ];
        runtimeInputs = [
          super.haskellPackages.haskell-language-server
          super.idris2
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
                    matrixPlugin = super.weechatScripts.weechat-matrix.overrideAttrs ({ version, ... }: {
                      version = version + "-latest";
                      src = super.fetchFromGitHub {
                        owner = "poljar";
                        repo = "weechat-matrix";
                        rev = "ef09292005d67708511a44c8285df1342ab66bd1";
                        sha256 = "0rjfmzj5mp4b1kbxi61z6k46mrpybxhbqh6a9zm9lv2ip3z6bhlw";
                      };
                    });
                in super.symlinkJoin {
        name = weechatDistribution.name;
        paths = [
          (weechatDistribution.override {
            configure = { availablePlugins, ... }: {
              scripts = [ matrixPlugin ];
            };
          })
          matrixPlugin
        ];
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

      xdotool = super.xdotool;

      xmobar = super.xmobar;

      xournal = super.xournalpp;

      youtube-dl = super.youtube-dl;

      zathura = super.zathura;

      zoom-us = super.zoom-us;

    };

  }
