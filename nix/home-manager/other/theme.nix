{pkgs, ...}: {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-White-Darkest-Solid";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

#    font = {
#      name = "Sans";
#      size = 11;
#    };
  };
}
