{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.acpilight;

in
{
  options = {
    programs.acpilight = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Whether to install acpilight backlight control command
          and udev rules granting access to members of the "video" group.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.acpilight ];
    services.udev.packages = [ pkgs.acpilight ];
  };
}
