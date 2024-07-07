{
  config,
  pkgs,
  lib,

  ...
}:
let
in

{

  # cloudflare is ranked as fastest dns
  # isp's know your queries too, so speed over security here.

  # DoH and DoT will protect you from your ISP, at the costs of handing all your DNS data to your DoH or DoT provider.
  services.blocky = {
    enable = true;
    settings = {
      upstream.default = [
        "https://one.one.one.one/dns-query" # Using Cloudflare's DNS over HTTPS server for resolving queries.
      ];
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://one.one.one.one/dns-query";
        ips = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
      #Enable Blocking of certian domains.
      blocking = {
        blackLists.default = [
          #Adblocking
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          #Block adult sites
          "https://blocklistproject.github.io/Lists/porn.txt"
          #You can add additional categories
        ];
        loading = {
          # refetching every 4h is too much, only download it once, never refresh
          refreshPeriod = 0;
          downloads = {
            timeout = "15s"; # 5s really isn't much time
          };
        };
      };
    };
  };
}
