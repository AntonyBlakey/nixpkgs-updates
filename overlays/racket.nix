final: prev:
let
  isDarwin = builtins.match ".*-darwin" prev.stdenv.hostPlatform.system != null;
in
if isDarwin then
  {
    racket-minimal = prev.racket-minimal.overrideAttrs (oldAttrs: {
      configureFlags = (builtins.filter (x: x != "--enable-xonx") oldAttrs.configureFlags) ++ [
        "--enable-macprefix"
      ];
      meta = oldAttrs.meta // {
        badPlatforms = [ ];
      };
    });
  }
else
  { }
