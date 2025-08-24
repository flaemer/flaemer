{ pkgs, ... }:
let
  files = builtins.path {
    path = /home/flaemer/nix/zapret-flymer;
  };
  BIN = "${files}/bin/";
  LISTS = "${files}/lists/";
  GameFilter = "1024-65535";
in
{
  networking.firewall.extraCommands = ''
    ip46tables -t mangle -I POSTROUTING -p tcp -m multiport --dports 80,443,1024:65535 -m connbytes --connbytes-dir=original --connbytes-mode=packets --connbytes 1:6 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
    ip46tables -t mangle -A POSTROUTING -p udp -m multiport --dports 443,50000:50100,1024:65535 -m mark ! --mark 0x40000000/0x40000000 -j NFQUEUE --queue-num 200 --queue-bypass
  '';

  systemd.services.zapret = {
    enable = true;
    description = "DPI bypass service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.zapret}/bin/nfqws --pidfile=/run/nfqws.pid --qnum=200 \
          --filter-udp=443 --hostlist="${LISTS}list-general.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-udplen-increment=10 --dpi-desync-fake-quic="${BIN}quic_initial_www_google_com.bin" --new \
          --filter-udp=50000-65535 --hostlist="${LISTS}ipset-all.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --dpi-desync-fake-quic="${BIN}quic_initial_www_google_com.bin" --new \
          --filter-tcp=80 --hostlist="${LISTS}list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new \
          --filter-tcp=443 --hostlist="${LISTS}list-general.txt" --dpi-desync=split2 --dpi-desync-repeats=2 --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-split-seqovl-pattern="${BIN}tls_clienthello_www_google_com.bin" --new
      '';
      Type = "simple";
      PIDFile = "/run/nfqws.pid";
      Restart = "always";
      RuntimeMaxSec = "1h";
    };
  };

  # Отключаем IPv6 (если нужно)
  networking.enableIPv6 = false;
}
