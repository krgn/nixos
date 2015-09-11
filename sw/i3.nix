{ config, pkgs, ... }:

{
  environment.etc = {
    "i3status.conf" = {
    text = ''
    # i3status configuration file.
    # see "man i3status" for documentation.
    
    # It is important that this file is edited as UTF-8.
    # The following line should contain a sharp s:
    # ß
    # If the above line is not correctly displayed, fix your editor first!
    
    general {
            colors = true
            interval = 5
    }
    
    order += "ipv6"
    order += "disk /"
    order += "run_watch DHCP"
    order += "run_watch VPN"
    order += "wireless _first_"
    order += "ethernet _first_"
    order += "battery 0"
    order += "load"
    order += "tztime local"
    
    wireless _first_ {
            format_up = "W: (%quality at %essid) %ip"
            format_down = "W: down"
    }
    
    ethernet _first_ {
            # if you use %speed, i3status requires root privileges
            format_up = "E: %ip (%speed)"
            format_down = "E: down"
    }
    
    battery 0 {
            format = "%status %percentage %remaining"
    }
    
    run_watch DHCP {
            pidfile = "/var/run/dhclient*.pid"
    }
    
    run_watch VPN {
            pidfile = "/var/run/vpnc/pid"
    }
    
    tztime local {
            format = "%Y-%m-%d %H:%M:%S"
    }
    
    load {
            format = "%1min"
    }
    
    disk "/" {
            format = "%avail"
    }
    '';
    };
    
    "i3/config" = {
      text = ''
      set $alt Mod1
      set $win Mod4
      
      font pango:Ubuntu Mono 8
      
      #font pango:DejaVu Sans Mono 8
      
      floating_modifier $win
      
      # kill focused window
      bindsym $alt+Shift+c kill
      
      # start dmenu (a program launcher)
      bindsym $alt+r exec dmenu_run
      # bindsym $alt+d exec --no-startup-id i3-dmenu-desktop
      
      # change focus
      bindsym $win+h focus left
      bindsym $win+j focus down
      bindsym $win+k focus up
      bindsym $win+l focus right
      
      # alternatively, you can use the cursor keys:
      bindsym $win+Left  focus left
      bindsym $win+Down  focus down
      bindsym $win+Up    focus up
      bindsym $win+Right focus right
      
      # move focused window
      bindsym $win+Shift+h move left
      bindsym $win+Shift+j move down
      bindsym $win+Shift+k move up
      bindsym $win+Shift+l move right
      
      # alternatively, you can use the cursor keys:
      bindsym $win+Shift+Left  move left
      bindsym $win+Shift+Down  move down
      bindsym $win+Shift+Up    move up
      bindsym $win+Shift+Right move right
      
      # enter fullscreen mode for the focused container
      bindsym $win+f fullscreen toggle
      
      # change container layout (stacked, tabbed, toggle split)
      bindsym $win+1 layout default
      bindsym $win+2 layout tabbed
      bindsym $win+3 layout stacking
      bindsym $win+4 layout splitv
      bindsym $win+5 layout splith
      
      # split in horizontal orientation
      bindsym $win+6 split vertical
      bindsym $win+7 split horizontal
      
      # toggle tiling / floating
      bindsym $win+Shift+space floating toggle
      
      # change focus between tiling / floating windows
      bindsym $win+space focus mode_toggle
      
      # focus the parent container
      bindsym $win+a focus parent
      
      # focus the child container
      #bindsym $alt+d focus child
      
      workspace 1  output VGA-0
      workspace 2  output VGA-0
      workspace 3  output VGA-0
      workspace 4  output VGA-0
      workspace 5  output VGA-0
      workspace 6  output DVI-D-0
      workspace 7  output DVI-D-0
      workspace 8  output DVI-D-0
      workspace 9  output DVI-D-0
      workspace 10 output DVI-D-0
      
      # switch to workspace
      bindsym $alt+1 workspace 1
      bindsym $alt+2 workspace 2
      bindsym $alt+3 workspace 3
      bindsym $alt+4 workspace 4
      bindsym $alt+5 workspace 5
      bindsym $alt+6 workspace 6
      bindsym $alt+7 workspace 7
      bindsym $alt+8 workspace 8
      bindsym $alt+9 workspace 9
      bindsym $alt+0 workspace 10
      
      # move focused container to workspace
      bindsym $alt+Shift+1 move container to workspace 1
      bindsym $alt+Shift+2 move container to workspace 2
      bindsym $alt+Shift+3 move container to workspace 3
      bindsym $alt+Shift+4 move container to workspace 4
      bindsym $alt+Shift+5 move container to workspace 5
      bindsym $alt+Shift+6 move container to workspace 6
      bindsym $alt+Shift+7 move container to workspace 7
      bindsym $alt+Shift+8 move container to workspace 8
      bindsym $alt+Shift+9 move container to workspace 9
      bindsym $alt+Shift+0 move container to workspace 10
      
      # reload the configuration file
      bindsym $win+Shift+r reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      bindsym $win+q restart
      # exit i3 (logs you out of your X session)
      bindsym $win+Shift+q exec "i3-nagbar -t warning -m 'Do you really want to exit i3? ' -b 'Yes, exit i3' 'i3-msg exit'"
      
      # Commands 
      bindsym $win+e      exec "emacsclient -c"
      bindsym $win+t      exec "thunar"
      bindsym $win+Return exec "evilvte"
      
      exec "xsetroot -solid black"
      exec "emacsclient -c"
      exec "evilvte"
      exec "firefox"
      exec "spotify"
      exec "keepass"
      
      # no borders for windows at all
      # new_window normal
      
      assign [class="Firefox"] 1
      assign [class="Chromium"] 1
      assign [class="Thunar"] 2
      assign [class="Skype"] 3
      assign [class="Gimp"] 4
      assign [class="KeePass"] 5
      assign [class="Inkscape"] 4
      assign [class="Emacs"] 6
      assign [class="Evilvte"] 7
      assign [class="VirtualBox"] 8
      assign [class="Spotify"] 9
      assign [class="Vlc"] 10
      
      for_window [class="Firefox"]    focus, layout splith, border 1pixel
      for_window [class="Chromium"]   focus, layout splith, border 1pixel
      for_window [class="Thunar"]     focus, layout splith, border 1pixel
      for_window [class="Skype"]      focus, layout splith
      for_window [class="Gimp"]       focus, layout tabbed
      for_window [class="Inkscape"]   focus, layout tabbed
      for_window [class="Emacs"]      focus, layout tabbed, border none
      for_window [class="Evilvte"]    focus, layout tabbed, border normal
      for_window [class="VirtualBox"] focus, layout tabbed, border none
      for_window [class="Spotify"]    focus, layout tabbed
      for_window [class="Vlc"]        focus, layout tabbed, border none
      
      # mark current window & jump to mark
      bindsym $win+m exec i3-input -F 'mark %s' -P 'Mark name: '
      bindsym $win+Shift+m exec i3-input -F '[con_mark=%s] focus' -P 'Go to mark: '
      
      # really useful switching between previous workspace
      bindsym $alt+Tab  workspace back_and_forth
      
      # focus the urgent window 
      bindsym $win+g [urgent=latest] focus
      
      set $Locker i3lock -c 000000 && sleep 1
      
      set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
      mode "$mode_system" {
              bindsym l exec --no-startup-id $Locker, mode "default"
              bindsym e exec --no-startup-id i3-msg exit, mode "default"
              bindsym s exec --no-startup-id $Locker && systemctl suspend, mode "default"
              bindsym h exec --no-startup-id $Locker && systemctl hibernate, mode "default"
              bindsym r exec --no-startup-id systemctl reboot, mode "default"
              bindsym Shift+s exec --no-startup-id systemctl poweroff -i, mode "default"  
      
              # back to normal: Enter or Escape
              bindsym Return mode "default"
              bindsym Escape mode "default"
      }
      
      bindsym $win+Escape mode "$mode_system"
      
      # mode for setting borders
      mode "border" {
              bindsym 1 border normal
              bindsym 2 border 1pixel
              bindsym 3 border none
              bindsym Return mode "default"
              bindsym Escape mode "default"
      }
      
      bindsym $win+v mode "border"
      
      # resize window (you can also use the mouse for that)
      mode "resize" {
              # same bindings, but for the arrow keys
              bindsym Left resize shrink width 10 px or 10 ppt
              bindsym Down resize grow height 10 px or 10 ppt
              bindsym Up resize shrink height 10 px or 10 ppt
              bindsym Right resize grow width 10 px or 10 ppt
      
              # back to normal: Enter or Escape
              bindsym Return mode "default"
              bindsym Escape mode "default"
      }
      
      bindsym $win+r mode "resize"
      
      # Start i3bar to display a workspace bar (plus the system information i3status
      # finds out, if available)
      bar {
          status_command    i3status
          position          top
          mode              hide
          modifier          Mod3
          # strip_workspace_numbers yes
          
          colors {
              background #222222
              statusline #ffffff
      
              focused_workspace  #ffffff #444444
              active_workspace   #ffffff #222222
              inactive_workspace #888888 #222222
              urgent_workspace   #ffffff #900000
          }
      }
      
      # class                     border  backgr. text    indicator
      client.focused          #666666 #444444 #ffffff #2e9ef4
      client.focused_inactive #222222 #333333 #ffffff #484e50
      client.unfocused        #222222 #222222 #555555 #292d2e
      client.urgent           #2f343a #900000 #ffffff #900000
      client.placeholder      #000000 #0c0c0c #ffffff #000000
      
      bindsym $win+b bar mode toggle
      
      bindsym XF86Eject exec i3lock -d -f -c 000000
      bindsym XF86AudioPlay exec sp play
      bindsym XF86AudioNext exec sp next
      bindsym XF86AudioPrev exec sp prev
      bindsym XF86AudioMute exec pamixer --toggle-mute
      bindsym XF86AudioRaiseVolume exec pamixer --increase 5
      bindsym XF86AudioLowerVolume exec pamixer --decrease 5
      '';
    };
    
    "X11/Xwrapper.config" = {
      text = ''
      allowed_users=anybody
      needs_root_rights=yes
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    i3
    i3lock
    i3status
    dmenu
    xsel
    xclip
    dunst
    libnotify
    networkmanagerapplet
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = { 
      auto.enable = true;    
      auto.user = "k";
      sessionCommands = with pkgs; ''
          ${i3}/bin/i3
      '';
      desktopManagerHandlesLidAndPower = false;
    };

    desktopManager.xterm.enable = false;

    # windowManager.i3 = {
    #   enable = false;
    #   configFile = "/etc/i3/config";
    # };
  };
}
