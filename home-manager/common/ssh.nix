{ config, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      # my tailnet
      "wavedash" = {
        hostname = "100.95.172.31";
        user = "nyadiia";
      };
      "reverse-wavedash" = {
        hostname = "100.94.234.54";
        user = "nyadiia";
      };
      "hyprdash" = {
        hostname = "100.106.53.95";
        user = "nyadiia";
      };
      "crystal-heart" = {
        hostname = "100.88.38.130";
        user = "nyadiia";
      };
      "farewell" = {
        hostname = "100.122.216.134";
        user = "nyadiia";
      };

      # acm servers
      "argo" = {
        hostname = "160.94.179.148";
        user = "root";
      };
      "vm" = {
        hostname = "160.94.179.162";
        user = "root";
      };
      "medusa" = {
        hostname = "160.94.179.149";
        user = "nadia";
      };
      "garlic" = {
        hostname = "160.94.179.150";
        user = "root";
      };

      ## acm vms
      "acm.umn.edu" = {
        user = "root";
      };
      "matrix-vm" = {
        hostname = "160.94.179.135";
        user = "root";
      };

      # localhost only
      "balsam" = {
        hostname = "10.0.100.227";
        user = "nyadiia";
      };
    };

  };
}
