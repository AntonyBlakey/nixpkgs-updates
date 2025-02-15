{
  outputs =
    _:
    let
      overlay = import ./overlays;
    in
    {
      overlays.default = overlay;
    };
}
