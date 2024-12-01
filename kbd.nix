{ config, pkgs, ... }:
{
  imports = [];
  services.kmonad = {
   enable = true;
     keyboards = {
       qwerty = {
         device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
         config = builtins.readFile ./kmonad/config.kbd;
       };
     };
  };
}

