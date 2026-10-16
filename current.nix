{
  programs.plasma = {
    enable = true;
    shortcuts = {
      ActivityManager.switch-to-activity-ea7789fa-065c-4685-84df-0f275f16c39b = [ ];
      "KDE Keyboard Layout Switcher" = {
        "Switch to Last-Used Keyboard Layout" = [ ];
        "Switch to Next Keyboard Layout" = [ ];
      };
      kaccess."Toggle Screen Reader On and Off" = [ ];
      kmix = {
        decrease_microphone_volume = "Microphone Volume Down";
        decrease_volume = "Volume Down";
        decrease_volume_small = "Shift+Volume Down";
        increase_microphone_volume = "Microphone Volume Up";
        increase_volume = "Volume Up";
        increase_volume_small = "Shift+Volume Up";
        mic_mute = [
          "Microphone Mute"
          "Meta+Volume Mute"
        ];
        mute = "Volume Mute";
        push_to_talk = [ ];
      };
      ksmserver = {
        "Halt Without Confirmation" = [ ];
        "Lock Screen" = [ ];
        "Lock Session" = [
          "Screensaver"
          "Meta+L"
        ];
        "Log Out" = "Ctrl+Alt+Del";
        "Log Out Without Confirmation" = [ ];
        LogOut = [ ];
        Reboot = [ ];
        "Reboot Without Confirmation" = [ ];
        "Shut Down" = [ ];
      };
      kwin = {
        "Activate Window Demanding Attention" = "Meta+Ctrl+A";
        "Cycle Overview" = [ ];
        "Cycle Overview Opposite" = [ ];
        "Decrease Opacity" = [ ];
        "Edit Tiles" = [ ];
        Expose = [ ];
        ExposeAll = [ ];
        ExposeClass = [ ];
        ExposeClassCurrentDesktop = [ ];
        "Grid View" = "Meta+G";
        "Increase Opacity" = [ ];
        "Kill Window" = [ ];
        KrohnkiteBTreeLayout = [ ];
        KrohnkiteColumnsLayout = [ ];
        KrohnkiteDecrease = [ ];
        KrohnkiteFloatAll = [ ];
        KrohnkiteFloatingLayout = [ ];
        KrohnkiteFocusDown = "Meta+J";
        KrohnkiteFocusLeft = "Meta+H";
        KrohnkiteFocusNext = [ ];
        KrohnkiteFocusPrev = [ ];
        KrohnkiteFocusRight = "Meta+L";
        KrohnkiteFocusUp = "Meta+K";
        KrohnkiteGrowHeight = [ ];
        KrohnkiteIncrease = [ ];
        KrohnkiteMonocleLayout = "Meta+F";
        KrohnkiteNextLayout = [ ];
        KrohnkitePreviousLayout = [ ];
        KrohnkiteQuarterLayout = [ ];
        KrohnkiteRotate = [ ];
        KrohnkiteRotatePart = [ ];
        KrohnkiteSetMaster = [ ];
        KrohnkiteShiftDown = "Meta+Shift+J";
        KrohnkiteShiftLeft = "Meta+Shift+H";
        KrohnkiteShiftRight = "Meta+Shift+L";
        KrohnkiteShiftUp = "Meta+Shift+K";
        KrohnkiteShrinkHeight = [ ];
        KrohnkiteShrinkWidth = [ ];
        KrohnkiteSpiralLayout = [ ];
        KrohnkiteSpreadLayout = [ ];
        KrohnkiteStackedLayout = [ ];
        KrohnkiteStairLayout = [ ];
        KrohnkiteTileLayout = "Meta+M";
        KrohnkiteToggleFloat = "Meta+P";
        KrohnkiteTreeColumnLayout = [ ];
        KrohnkitegrowWidth = [ ];
        KrohnkitetoggleDock = [ ];
        "Move Tablet to Next LogicalOutput" = [ ];
        MoveMouseToCenter = "Meta+F6";
        MoveMouseToFocus = "Meta+F5";
        MoveZoomDown = [ ];
        MoveZoomLeft = [ ];
        MoveZoomRight = [ ];
        MoveZoomUp = [ ];
        Overview = [ ];
        "Setup Window Shortcut" = [ ];
        "Show Desktop" = [ ];
        "Switch One Desktop Down" = [ ];
        "Switch One Desktop Up" = [ ];
        "Switch One Desktop to the Left" = [ ];
        "Switch One Desktop to the Right" = [ ];
        "Switch One Window Down" = [ ];
        "Switch One Window Left" = [ ];
        "Switch One Window Right" = [ ];
        "Switch One Window Up" = [ ];
        "Switch Window Down" = "Meta+Alt+Down";
        "Switch Window Left" = "Meta+Alt+Left";
        "Switch Window Right" = "Meta+Alt+Right";
        "Switch Window Up" = "Meta+Alt+Up";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 10" = [ ];
        "Switch to Desktop 11" = [ ];
        "Switch to Desktop 12" = [ ];
        "Switch to Desktop 13" = [ ];
        "Switch to Desktop 14" = [ ];
        "Switch to Desktop 15" = [ ];
        "Switch to Desktop 16" = [ ];
        "Switch to Desktop 17" = [ ];
        "Switch to Desktop 18" = [ ];
        "Switch to Desktop 19" = [ ];
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 20" = [ ];
        "Switch to Desktop 21" = [ ];
        "Switch to Desktop 22" = [ ];
        "Switch to Desktop 23" = [ ];
        "Switch to Desktop 24" = [ ];
        "Switch to Desktop 25" = [ ];
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = [ ];
        "Switch to Desktop 8" = [ ];
        "Switch to Desktop 9" = [ ];
        "Switch to Next Desktop" = [ ];
        "Switch to Next Screen" = [ ];
        "Switch to Previous Desktop" = [ ];
        "Switch to Previous Screen" = [ ];
        "Switch to Screen 0" = [ ];
        "Switch to Screen 1" = [ ];
        "Switch to Screen 2" = [ ];
        "Switch to Screen 3" = [ ];
        "Switch to Screen 4" = [ ];
        "Switch to Screen 5" = [ ];
        "Switch to Screen 6" = [ ];
        "Switch to Screen 7" = [ ];
        "Switch to Screen Above" = [ ];
        "Switch to Screen Below" = [ ];
        "Switch to Screen to the Left" = [ ];
        "Switch to Screen to the Right" = [ ];
        "Toggle Night Color" = [ ];
        "Toggle Window Raise/Lower" = [ ];
        "Walk Through Windows" = [
          "Alt+Tab"
          "Meta+Tab"
        ];
        "Walk Through Windows (Reverse)" = [
          "Alt+Shift+Tab"
          "Meta+Shift+Tab"
        ];
        "Walk Through Windows Alternative" = [ ];
        "Walk Through Windows Alternative (Reverse)" = [ ];
        "Walk Through Windows of Current Application" = [
          "Alt+`"
          "Meta+`"
        ];
        "Walk Through Windows of Current Application (Reverse)" = [
          "Alt+~"
          "Meta+~"
        ];
        "Walk Through Windows of Current Application Alternative" = [ ];
        "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
        "Window Above Other Windows" = [ ];
        "Window Below Other Windows" = [ ];
        "Window Close" = "Meta+W";
        "Window Custom Quick Tile Bottom" = [ ];
        "Window Custom Quick Tile Left" = [ ];
        "Window Custom Quick Tile Right" = [ ];
        "Window Custom Quick Tile Top" = [ ];
        "Window Fullscreen" = [ ];
        "Window Grow Horizontal" = [ ];
        "Window Grow Vertical" = [ ];
        "Window Lower" = [ ];
        "Window Maximize" = "Meta+PgUp";
        "Window Maximize Horizontal" = [ ];
        "Window Maximize Vertical" = [ ];
        "Window Minimize" = "Meta+PgDown";
        "Window Move" = [ ];
        "Window Move Center" = [ ];
        "Window No Border" = [ ];
        "Window On All Desktops" = [ ];
        "Window One Desktop Down" = [ ];
        "Window One Desktop Up" = [ ];
        "Window One Desktop to the Left" = [ ];
        "Window One Desktop to the Right" = [ ];
        "Window One Screen Down" = [ ];
        "Window One Screen Up" = [ ];
        "Window One Screen to the Left" = [ ];
        "Window One Screen to the Right" = [ ];
        "Window Operations Menu" = [ ];
        "Window Pack Down" = [ ];
        "Window Pack Left" = [ ];
        "Window Pack Right" = [ ];
        "Window Pack Up" = [ ];
        "Window Quick Tile Bottom" = "Meta+Down";
        "Window Quick Tile Bottom Left" = [ ];
        "Window Quick Tile Bottom Right" = [ ];
        "Window Quick Tile Left" = "Meta+Left";
        "Window Quick Tile Right" = "Meta+Right";
        "Window Quick Tile Top" = "Meta+Up";
        "Window Quick Tile Top Left" = [ ];
        "Window Quick Tile Top Right" = [ ];
        "Window Raise" = [ ];
        "Window Resize" = [ ];
        "Window Restore" = [ ];
        "Window Shrink Horizontal" = [ ];
        "Window Shrink Vertical" = [ ];
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 10" = [ ];
        "Window to Desktop 11" = [ ];
        "Window to Desktop 12" = [ ];
        "Window to Desktop 13" = [ ];
        "Window to Desktop 14" = [ ];
        "Window to Desktop 15" = [ ];
        "Window to Desktop 16" = [ ];
        "Window to Desktop 17" = [ ];
        "Window to Desktop 18" = [ ];
        "Window to Desktop 19" = [ ];
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 20" = [ ];
        "Window to Desktop 21" = [ ];
        "Window to Desktop 22" = [ ];
        "Window to Desktop 23" = [ ];
        "Window to Desktop 24" = [ ];
        "Window to Desktop 25" = [ ];
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window to Desktop 6" = "Meta+^";
        "Window to Desktop 7" = [ ];
        "Window to Desktop 8" = [ ];
        "Window to Desktop 9" = [ ];
        "Window to Next Desktop" = [ ];
        "Window to Next Screen" = "Meta+Shift+Right";
        "Window to Previous Desktop" = [ ];
        "Window to Previous Screen" = "Meta+Shift+Left";
        "Window to Screen 0" = [ ];
        "Window to Screen 1" = [ ];
        "Window to Screen 2" = [ ];
        "Window to Screen 3" = [ ];
        "Window to Screen 4" = [ ];
        "Window to Screen 5" = [ ];
        "Window to Screen 6" = [ ];
        "Window to Screen 7" = [ ];
        disableInputCapture = "Meta+Shift+Esc";
        view_actual_size = "Meta+0";
        view_zoom_in = [
          "Meta++"
          "Meta+="
        ];
        view_zoom_out = "Meta+-";
      };
      mediacontrol = {
        mediavolumedown = [ ];
        mediavolumeup = [ ];
        nextmedia = "Media Next";
        pausemedia = "Media Pause";
        playmedia = [ ];
        playpausemedia = "Media Play";
        previousmedia = "Media Previous";
        seekbackwardmedia = "Media Rewind";
        seekbackwardmedialong = [ ];
        seekforwardmedia = "Media Fast Forward";
        seekforwardmedialong = [ ];
        stopmedia = "Media Stop";
      };
      org_kde_powerdevil = {
        "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
        "Decrease Screen Brightness" = "Monitor Brightness Down";
        "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
        Hibernate = "Hibernate";
        "Increase Keyboard Brightness" = "Keyboard Brightness Up";
        "Increase Screen Brightness" = "Monitor Brightness Up";
        "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
        PowerDown = "Power Down";
        PowerOff = "Power Off";
        Sleep = "Sleep";
        "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
        "Turn Off Screen" = [ ];
        powerProfile = [
          "Battery"
          "Meta+B"
        ];
      };
      plasmashell = {
        "Slideshow Wallpaper Next Image" = [ ];
        "activate application launcher" = [ ];
        "activate task manager entry 1" = [ ];
        "activate task manager entry 10" = [ ];
        "activate task manager entry 2" = [ ];
        "activate task manager entry 3" = [ ];
        "activate task manager entry 4" = [ ];
        "activate task manager entry 5" = [ ];
        "activate task manager entry 6" = [ ];
        "activate task manager entry 7" = [ ];
        "activate task manager entry 8" = [ ];
        "activate task manager entry 9" = [ ];
        "clear history" = [ ];
        clear-history = [ ];
        clipboard_action = "Meta+Ctrl+X";
        cycle-panels = [ ];
        cycleNextAction = [ ];
        cyclePrevAction = [ ];
        edit_clipboard = [ ];
        "manage activities" = [ ];
        "next activity" = [ ];
        "previous activity" = [ ];
        repeat_action = [ ];
        "show dashboard" = [ ];
        show-barcode = [ ];
        show-on-mouse-pos = "Meta+V";
        "switch to next activity" = [ ];
        "switch to previous activity" = [ ];
        "toggle do not disturb" = [ ];
      };
      "services/chromium-default.desktop"._launch = "Meta+D";
      "services/chromium-work.desktop"._launch = "Meta+Shift+D";
      "services/com.mitchellh.ghostty.desktop"._launch = "Meta+Return";
      "services/org.kde.emojier.desktop"._launch = "Meta+.";
      "services/org.kde.konsole.desktop"._launch = [ ];
      "services/org.kde.touchpadshortcuts.desktop" = {
        DisableTouchpad = [ ];
        EnableTouchpad = [ ];
        ToggleTouchpad = [ ];
      };
      "services/systemdsettings.desktop".kcm_screen = "Meta+Shift+P";
    };
    configFile = {
      baloofilerc.General.dbVersion = 2;
      dolphinrc = {
        dolphinrc.General.ViewPropsTimestamp = "2026,10,13,23,51,49.426";
        "KFileDialog Settings" = {
          "Places Icons Auto-resize" = false;
          "Places Icons Static Size" = 22;
        };
      };
      kactivitymanagerdrc.activities.ea7789fa-065c-4685-84df-0f275f16c39b = "Default";
      kcminputrc.Keyboard.NumLock = 0;
      kded5rc.Module-device_automounter.autoload = false;
      kdeglobals = {
        KDE = {
          SingleClick = false;
          contrast = 7;
          frameContrast = 0.2;
        };
        "KFileDialog Settings" = {
          "Allow Expansion" = false;
          "Automatically select filename extension" = true;
          "Breadcrumb Navigation" = false;
          "Decoration position" = 2;
          "Show Full Path" = false;
          "Show Inline Previews" = true;
          "Show Preview" = false;
          "Show Speedbar" = true;
          "Show hidden files" = false;
          "Sort by" = "Date";
          "Sort directories first" = true;
          "Sort hidden files last" = false;
          "Sort reversed" = false;
          "Speedbar Width" = 177;
          "View Style" = "DetailTree";
        };
        WM = {
          activeBackground = "30,30,46";
          activeBlend = "249,226,175";
          activeForeground = "205,214,244";
          inactiveBackground = "30,30,46";
          inactiveBlend = "108,112,134";
          inactiveForeground = "205,214,244";
        };
      };
      kscreenlockerrc = {
        kscreenlockerrc.Daemon.Timeout = 15;
        "Greeter/Wallpaper/org.kde.image/General" = {
          Image = "file:///nix/store/jblfqxg0rmjflsj8yrlx7xn5ibv6ismf-plasma-workspace-wallpapers-6.7.5/share/wallpapers/Altai/";
          PreviewImage = "file:///nix/store/jblfqxg0rmjflsj8yrlx7xn5ibv6ismf-plasma-workspace-wallpapers-6.7.5/share/wallpapers/Altai/";
        };
      };
      ksmserverrc.General.loginMode = "restoreSavedSession";
      "\\/home\\/mm\\/.local\\/share\\/Trash" = {
        Days = 7;
        LimitReachedAction = 0;
        Percent = 10;
        UseSizeLimit = true;
        UseTimeLimit = false;
      };
      General = {
        EnableWebShortcuts = true;
        KeywordDelimiter = ":";
        PreferredWebShortcuts = "";
        UsePreferredWebShortcutsOnly = false;
      };
      kwalletrc.Wallet."First Use" = false;
      kwinrc = {
        Desktops = {
          Id_1 = "Desktop_1";
          Id_2 = "Desktop_2";
          Id_3 = "Desktop_3";
          Id_4 = "Desktop_4";
          Id_5 = "Desktop_5";
          Id_6 = "Desktop_6";
          Number = 6;
          Rows = 1;
        };
        kwinrc.Effect-overview.BorderActivate = 9;
        NightColor = {
          Active = true;
          Mode = "Constant";
          NightTemperature = 3000;
        };
        Plugins = {
          krohnkiteEnabled = true;
          translucencyEnabled = true;
          virtualdesktopsonlyonprimaryEnabled = true;
        };
        Script-krohnkite = {
          adjustLayout = false;
          adjustLayoutLive = false;
          binaryTreeLayoutOrder = 0;
          cascadeLayoutOrder = 0;
          columnsLayoutOrder = 0;
          floatingLayoutOrder = 3;
          quarterLayoutOrder = 0;
          screenGapBetween = 10;
          spiralLayoutOrder = 0;
          spreadLayoutOrder = 0;
          stackedLayoutOrder = 0;
          stairLayoutOrder = 0;
          threeColumnLayoutOrder = 0;
        };
        "Tiling/Desktop_1/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_1/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_2/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_2/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_3/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_3/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_4/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_4/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_5/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_5/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_6/538851b8-29f8-408f-a732-659fb743886c" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        "Tiling/Desktop_6/c02d3bb4-5572-49d6-bb27-42de57fc627d" = {
          padding = 4;
          tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
        };
        kwinrc.Xwayland.Scale = 1;
      };
      Layout = {
        Model = "pc105";
        Options = "compose:ralt";
        ResetOldOptions = true;
      };
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
      plasmanotifyrc."Applications/io.itch.itch".Seen = true;
      spectaclerc = {
        spectaclerc.ImageSave.translatedScreenshotsFolder = "Screenshots";
        spectaclerc.VideoSave.translatedScreencastsFolder = "Screencasts";
      };
      systemsettingsrc.systemsettings_sidebar_mode.HighlightNonDefaultSettings = true;
    };
    dataFile = {

    };
  };
}
