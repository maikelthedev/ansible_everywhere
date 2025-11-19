# This is just a sample simple config file. 
{ config, pkgs, lib, ...}:

let
  unstable = import <unstable> { };
  vars = import "/tmp/vars.nix";
{

  services.openssh.listenAddresses = [
    { 
      addr = "${vars.ip_zt}"; 
      port = 60265; 
    }
  ];
}