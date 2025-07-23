{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "adamaxelaugustinsky";
  home.homeDirectory = "/Users/adamaxelaugustinsky";
  home.stateVersion = "23.11";

  # Packages
  home.packages = with pkgs; [
    # Window management and ricing
    aerospace
    sketchybar
    jankyborders
    
    # Terminal and shell
    kitty
    neovim
    starship
    zoxide
    fzf
    ripgrep
    eza
    bat
    btop
    neofetch
    
    # Utilities
    raycast
    stats
    
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];

  # Font configuration
  fonts.fontconfig.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Adam Axel Augustinsky";  
    userEmail = "adamaugustinsky@gmail.com";
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "eza -l -g --icons";
      ls = "eza --icons";
      la = "eza -la --icons";
      tree = "eza --tree --icons";
      cat = "bat";
      vim = "nvim";
      rice = "~/.config/rice/launch.sh";
    };
    
    initExtra = ''
      # Starship prompt
      eval "$(starship init zsh)"
      
      # Zoxide
      eval "$(zoxide init zsh)"
      
      # FZF
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
    '';
  };

  # Starship configuration
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [](#89b4fa)$username[](bg:#45475a fg:#89b4fa)$directory[](fg:#45475a bg:#313244)$git_branch$git_status[](fg:#313244)
        $character
      '';
      
      username = {
        show_always = true;
        style_user = "bg:#89b4fa fg:#1e1e2e";
        style_root = "bg:#89b4fa fg:#1e1e2e";
        format = "[ $user ]($style)";
      };
      
      directory = {
        style = "fg:#cdd6f4 bg:#45475a";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      
      git_branch = {
        symbol = "";
        style = "bg:#313244";
        format = "[[ $symbol $branch ](fg:#89b4fa bg:#313244)]($style)";
      };
      
      git_status = {
        style = "bg:#313244";
        format = "[[($all_status$ahead_behind )](fg:#89b4fa bg:#313244)]($style)";
      };
      
      character = {
        success_symbol = "[](bold fg:#a6e3a1)";
        error_symbol = "[](bold fg:#f38ba8)";
      };
    };
  };

  # Kitty terminal
  programs.kitty = {
    enable = true;
    settings = {
      # Window
      background_opacity = "0.85";
      background_blur = 32;
      window_padding_width = 20;
      hide_window_decorations = "titlebar-only";
      confirm_os_window_close = 0;
      
      # Font
      font_family = "JetBrainsMono Nerd Font";
      bold_font = "JetBrainsMono Nerd Font Bold";
      italic_font = "JetBrainsMono Nerd Font Italic";
      bold_italic_font = "JetBrainsMono Nerd Font Bold Italic";
      font_size = 14;
      
      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = 2;
      cursor_blink_interval = "0.5";
      
      # Colors (Catppuccin Mocha)
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      
      # Black
      color0 = "#45475A";
      color8 = "#585B70";
      
      # Red
      color1 = "#F38BA8";
      color9 = "#F38BA8";
      
      # Green
      color2 = "#A6E3A1";
      color10 = "#A6E3A1";
      
      # Yellow
      color3 = "#F9E2AF";
      color11 = "#F9E2AF";
      
      # Blue
      color4 = "#89B4FA";
      color12 = "#89B4FA";
      
      # Magenta
      color5 = "#F5C2E7";
      color13 = "#F5C2E7";
      
      # Cyan
      color6 = "#94E2D5";
      color14 = "#94E2D5";
      
      # White
      color7 = "#BAC2DE";
      color15 = "#A6ADC8";
      
      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_foreground = "#1E1E2E";
      active_tab_background = "#89B4FA";
      inactive_tab_foreground = "#CDD6F4";
      inactive_tab_background = "#45475A";
    };
  };

  # AeroSpace configuration
  home.file.".config/aerospace/aerospace.toml" = {
    text = ''
      # Start at login
      start-at-login = true
      
      # Normalizations
      enable-normalization-flatten-containers = true
      enable-normalization-opposite-orientation-for-nested-containers = true
      
      # Gaps configuration (Hyprland-like)
      [gaps]
      inner.horizontal = 16
      inner.vertical = 16
      outer.left = 16
      outer.bottom = 16
      outer.top = 60      # Space for SketchyBar
      outer.right = 16
      
      # Main keybindings
      [mode.main.binding]
      
      # Focus windows (Vim-like)
      alt-h = "focus left"
      alt-j = "focus down"
      alt-k = "focus up"
      alt-l = "focus right"
      
      # Move windows
      alt-shift-h = "move left"
      alt-shift-j = "move down"
      alt-shift-k = "move up"
      alt-shift-l = "move right"
      
      # Resize
      alt-shift-minus = "resize smart -50"
      alt-shift-equal = "resize smart +50"
      
      # Workspaces
      alt-1 = "workspace 1"
      alt-2 = "workspace 2"
      alt-3 = "workspace 3"
      alt-4 = "workspace 4"
      alt-5 = "workspace 5"
      alt-6 = "workspace 6"
      alt-7 = "workspace 7"
      alt-8 = "workspace 8"
      alt-9 = "workspace 9"
      
      # Move to workspace
      alt-shift-1 = "move-node-to-workspace 1"
      alt-shift-2 = "move-node-to-workspace 2"
      alt-shift-3 = "move-node-to-workspace 3"
      alt-shift-4 = "move-node-to-workspace 4"
      alt-shift-5 = "move-node-to-workspace 5"
      alt-shift-6 = "move-node-to-workspace 6"
      alt-shift-7 = "move-node-to-workspace 7"
      alt-shift-8 = "move-node-to-workspace 8"
      alt-shift-9 = "move-node-to-workspace 9"
      
      # Layout
      alt-slash = "layout tiles horizontal vertical"
      alt-comma = "layout accordion horizontal vertical"
      alt-f = "fullscreen"
      alt-shift-f = "layout floating tiling"
      
      # Float specific windows
      [[on-window-detected]]
      if.app-id = "com.apple.systempreferences"
      run = "layout floating"
      
      [[on-window-detected]]
      if.app-id = "com.apple.finder"
      if.window-title-regex-substring = "Info$"
      run = "layout floating"
      
      [[on-window-detected]]
      if.app-id = "com.apple.ActivityMonitor"
      run = "layout floating"
    '';
  };

  # SketchyBar configuration
  home.file.".config/sketchybar/sketchybarrc" = {
    executable = true;
    text = ''
      #!/bin/bash
      
      # Color palette (Catppuccin Mocha)
      export BLACK=0xff181825
      export WHITE=0xffcdd6f4
      export RED=0xfff38ba8
      export GREEN=0xffa6e3a1
      export BLUE=0xff89b4fa
      export YELLOW=0xfff9e2af
      export ORANGE=0xfffab387
      export MAGENTA=0xfff5c2e7
      export GREY=0xff45475a
      export TRANSPARENT=0x00000000
      export BG0=0xcc1e1e2e
      export BG1=0xcc313244
      export BG2=0xcc45475a
      
      # Bar appearance
      sketchybar --bar height=40 \
                       blur_radius=50 \
                       position=top \
                       sticky=on \
                       color=$TRANSPARENT \
                       shadow=off \
                       padding_left=10 \
                       padding_right=10 \
                       corner_radius=0 \
                       y_offset=5 \
                       margin=10
      
      # Default values
      default=(
        icon.font="JetBrainsMono Nerd Font:Bold:16.0"
        icon.color=$WHITE
        label.font="JetBrainsMono Nerd Font:Semibold:14.0"
        label.color=$WHITE
        icon.padding_left=8
        icon.padding_right=4
        label.padding_left=4
        label.padding_right=8
        background.color=$BG1
        background.corner_radius=8
        background.height=30
        background.padding_left=5
        background.padding_right=5
      )
      sketchybar --default "''${default[@]}"
      
      # Workspace icons
      SPACE_ICONS=("" "" "" "" "" "" "" "" "")
      for i in "''${!SPACE_ICONS[@]}"
      do
        sid=$((i+1))
        space=(
          space=$sid
          icon="''${SPACE_ICONS[i]}"
          icon.padding_left=12
          icon.padding_right=12
          background.color=$BG1
          background.corner_radius=8
          background.drawing=on
          label.drawing=off
          script="$HOME/.config/sketchybar/plugins/aerospace.sh"
          click_script="aerospace workspace $sid"
        )
        sketchybar --add space space.$sid left --set space.$sid "''${space[@]}"
      done
      
      # Window title
      sketchybar --add item window_title center \
                 --set window_title script="$HOME/.config/sketchybar/plugins/window_title.sh" \
                                   icon.drawing=off \
                                   background.color=$BG0 \
                                   label.color=$MAGENTA \
                 --subscribe window_title front_app_switched
      
      # Right side items
      # Clock
      sketchybar --add item clock right \
                 --set clock update_freq=10 \
                            icon= \
                            icon.color=$YELLOW \
                            background.color=$BG1 \
                            script="$HOME/.config/sketchybar/plugins/clock.sh"
      
      # Battery
      sketchybar --add item battery right \
                 --set battery update_freq=120 \
                              icon.color=$GREEN \
                              background.color=$BG1 \
                              script="$HOME/.config/sketchybar/plugins/battery.sh" \
                 --subscribe battery system_woke power_source_change
      
      # CPU
      sketchybar --add item cpu right \
                 --set cpu update_freq=2 \
                          icon= \
                          icon.color=$BLUE \
                          background.color=$BG1 \
                          script="$HOME/.config/sketchybar/plugins/cpu.sh"
      
      # RAM
      sketchybar --add item memory right \
                 --set memory update_freq=2 \
                             icon= \
                             icon.color=$RED \
                             background.color=$BG1 \
                             script="$HOME/.config/sketchybar/plugins/memory.sh"
      
      sketchybar --update
    '';
  };

  # SketchyBar plugins
  home.file.".config/sketchybar/plugins/aerospace.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      
      # Get focused workspace from aerospace
      FOCUSED=$(aerospace list-workspaces --focused)
      
      if [ "$1" = "$FOCUSED" ]; then
        sketchybar --set $NAME background.color=0xff89b4fa icon.color=0xff1e1e2e
      else
        sketchybar --set $NAME background.color=0xcc313244 icon.color=0xffcdd6f4
      fi
    '';
  };

  home.file.".config/sketchybar/plugins/window_title.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.title' 2>/dev/null || echo "Desktop")
      
      if [ "$WINDOW_TITLE" = "" ] || [ "$WINDOW_TITLE" = "null" ]; then
        WINDOW_TITLE="Desktop"
      fi
      
      # Truncate if too long
      if [ ''${#WINDOW_TITLE} -gt 50 ]; then
        WINDOW_TITLE="''${WINDOW_TITLE:0:47}..."
      fi
      
      sketchybar --set $NAME label="$WINDOW_TITLE"
    '';
  };

  home.file.".config/sketchybar/plugins/clock.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      sketchybar --set $NAME label="$(date '+%H:%M')"
    '';
  };

  home.file.".config/sketchybar/plugins/battery.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      PERCENTAGE=$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)
      CHARGING=$(pmset -g batt | grep 'AC Power')
      
      if [ "$CHARGING" != "" ]; then
        ICON=""
        COLOR=0xffa6e3a1
      else
        case ''${PERCENTAGE} in
          9[0-9]|100) ICON="" COLOR=0xffa6e3a1 ;;
          [6-8][0-9]) ICON="" COLOR=0xffa6e3a1 ;;
          [3-5][0-9]) ICON="" COLOR=0xfff9e2af ;;
          [1-2][0-9]) ICON="" COLOR=0xfffab387 ;;
          *) ICON="" COLOR=0xfff38ba8 ;;
        esac
      fi
      
      sketchybar --set $NAME icon="$ICON" icon.color=$COLOR label="''${PERCENTAGE}%"
    '';
  };

  home.file.".config/sketchybar/plugins/cpu.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      CPU=$(top -l 2 | grep "CPU usage" | tail -1 | awk '{printf "%.0f%%", $3}')
      sketchybar --set $NAME label="$CPU"
    '';
  };

  home.file.".config/sketchybar/plugins/memory.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      MEMORY=$(memory_pressure | grep "System-wide memory free percentage" | awk '{printf "%d%%", 100-$5}')
      sketchybar --set $NAME label="$MEMORY"
    '';
  };

  # JankyBorders launch agent
  launchd.agents.jankyborders = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.jankyborders}/bin/borders"
        "style=round"
        "width=5.0"
        "hidpi=on"
        "active_color=0xff89b4fa"
        "inactive_color=0xff45475a"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };
  };

  # Launch script for the rice
  home.file.".config/rice/launch.sh" = {
    executable = true;
    text = ''
      #!/bin/bash
      
      echo "Launching Hyprland-style rice..."
      
      # Kill existing processes
      killall -q sketchybar
      killall -q borders
      
      # Wait until processes have been shut down
      while pgrep -x sketchybar >/dev/null; do sleep 1; done
      while pgrep -x borders >/dev/null; do sleep 1; done
      
      # Launch everything
      echo "Starting SketchyBar..."
      sketchybar &
      
      echo "Starting JankyBorders..."
      borders style=round width=5.0 hidpi=on active_color=0xff89b4fa inactive_color=0xff45475a &
      
      echo "Rice launched successfully!"
    '';
  };

  # Neovim configuration (if you don't have your own)
  # home.file.".config/nvim" = {
  #   source = ./nvim;  # Point to your nvim config
  #   recursive = true;
  # };

  # Enable home-manager
  programs.home-manager.enable = true;
}
