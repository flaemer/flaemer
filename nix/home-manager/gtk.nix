{ pkgs, ... }: {
  # Установка тем
  home.packages = with pkgs; [
    arc-theme          # популярная темная тема
    adwaita-qt         # для Qt-приложений
    qgnomeplatform     # интеграция Qt с GNOME
  ];

  # Настройка GTK
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";  # Встроенная темная тема
      # Или используйте другую (например "Arc-Dark")
      package = pkgs.gnome.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
  };

  # Для Qt-приложений (KDE, Telegram и др.)
  qt = {
    enable = true;
    platformTheme = "gnome";  # Использует GTK-стиль
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
