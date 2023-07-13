{ inputs, config, pkgs, ... }:

let inherit (inputs) ssh-keys;
in {
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [ ssh-keys.outPath ];

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibt-password";
    };
  };
}
