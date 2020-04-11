{ pkgs , ... }:
let aspellEnv = pkgs.aspellWithDicts (d: [d.en d.de]);
in
  pkgs.symlinkJoin {
    name = "my-weechat";
    paths = [
      pkgs.weechat
    ];
    buildInputs = [
      pkgs.makeWrapper
      aspellEnv
    ];
    postBuild = ''
      wrapProgram $out/bin/weechat \
        --prefix ASPELL_CONF ';' "dict-dir ${aspellEnv}/lib/aspell"
    '';
  }
