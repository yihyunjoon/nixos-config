{ lib, modulesPath, ... }:
{
  imports = [
    ../modules/common.nix
    ./orbstack-guest.nix
    ../users/yihyunjoon/orbstack.nix
    (modulesPath + "/virtualisation/lxc-container.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  networking.hostName = "nixos-orbstack";

  # Keep orbstack group GID aligned with the current VM.
  # Use `--impure` on rebuild so `/etc/group` is readable at eval time.
  users.groups.orbstack.gid = lib.mkForce (
    let
      groupFile = "/etc/group";
    in
    if !builtins.pathExists groupFile then
      throw "orbstack gid detection failed: /etc/group not found (use --impure on nixos-rebuild)"
    else
      let
        lines = lib.splitString "\n" (builtins.readFile groupFile);
        entry = lib.findFirst (line: lib.hasPrefix "orbstack:" line) "" lines;
        parts = lib.splitString ":" entry;
      in
      if entry != "" && builtins.length parts > 2 then
        builtins.fromJSON (builtins.elemAt parts 2)
      else
        throw "orbstack gid detection failed: 'orbstack' group entry missing or malformed in /etc/group"
  );

  # Import host-provided extra root CAs (e.g. OrbStack local CA, custom proxy CA).
  # NOTE: Use `nixos-rebuild --impure` so this runtime file can be read at eval time.
  security.pki.certificates = lib.optionals
    (builtins.pathExists "/opt/orbstack-guest/run/extra-certs.crt")
    [ (builtins.readFile "/opt/orbstack-guest/run/extra-certs.crt") ];

  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;
}
