final: prev: {
  racket-minimal = prev.racket-minimal.overrideAttrs (oldAttrs: {
    configureFlags = (builtins.filter (x: x != "--enable-xonx") oldAttrs.configureFlags) ++ [
      "--enable-macprefix"
    ];
    meta = oldAttrs.meta // {
      badPlatforms = [ ];
    };
  });
}
