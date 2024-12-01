{ config, pkgs, outputs,   ... }:
{
  home.username = "em";
  home.homeDirectory = "/home/em";
  fonts.fontconfig = {enable = true;};
  nixpkgs = {
    overlays = outputs.overlays.unstable;
  };

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
  # services.podman.enable = true;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';
  # Packages that should be installed to the user profile.
  home.sessionPath = [
    "$HOME/.local/share/nvim/mason/bin"
    "$HOME/.asdf/shims"
    "$HOME/.config/emacs/bin"
  ];

  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them
    hyprgui
    hyprwall
    hyprlock

    neofetch
    neovim
    emacs30
    coreutils
    cmake
    gnumake
    clang
    ispell
    obsidian

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    eza
    p7zip
    inotify-tools

    snipaste

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    asdf-vm

    # apps
    vesktop
    # misc
    file
    wl-clipboard
    imagemagick
    fd
    ffmpeg
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    brightnessctl

    #productivity
    taskwarrior-tui
    taskopen

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    
    # tuis
    yazi
    podman-tui
    # lazydocker
    tftui
    nchat
    k9s
    kind
    neomutt
    warp-terminal
    discordo
    rustfmt

    #rofi battery deps
    light
    powertop
    ncmpcpp
    mpd
    pavucontrol

    
    # CLIs
    flyctl
    kmonad
    opentofu
    terraform
    argo
    argocd
    podman-compose
    eksctl
    awscli
    nodePackages.aws-cdk
    

    # Languages
    zig
    nodejs_22
    nixd
    devbox
    deno
    go
    rustc
    cargo
    (python3.withPackages (ppkgs: with ppkgs; 
      [uv pynvim tasklib syncall[google]]
      )
    )
    # dotnetCorePackages.dotnet_8.sdk
    dotnetCorePackages.dotnet_9.sdk
  ];

  # programs.taskwarrior = {
  #   enable = true;
  #   package = pkgs.unstable.taskwarrior3;
  # };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "nord";
    };
  };


  programs.nushell = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.config#\" --impure";
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
  
  #
  programs.zoxide = {
    enable = true;
  };

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.vscode = {
    enable = true;
    package = (pkgs.vscode).overrideAttrs (attrs: {
      src = (builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?os=linux-x64";
        sha256 = "09piqkfmd1x7mcn6ry3kjwgvgn93jq7n1k7jj77ckq3pyqlsnr9j";
      });
      version = "latest";
      buildInputs = attrs.buildInputs;
    });
    extensions = with pkgs.vscode-extensions; [
      christian-kohler.path-intellisense
      ms-vscode-remote.vscode-remote-extensionpack
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode-remote.remote-containers
      ms-vscode.live-server
      asvetliakov.vscode-neovim

      # .net
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      ms-dotnettools.vscodeintellicode-csharp
      ms-dotnettools.vscode-dotnet-runtime
      # craigthomas.supersharp

      # Linting
      
      # Git
      donjayamanne.githistory
      mhutchie.git-graph

      # Testing
      ms-vscode.test-adapter-converter



      vscode-icons-team.vscode-icons

      redhat.vscode-yaml
      zainchen.json

      # web
      aaron-bond.better-comments
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace 
    ([
      {
        name = "vscode-solution-explorer";
        publisher = "fernandoescolar";
        version = "0.8.8";
        sha256 = "sha256-1Z+iB26y+6SBbCrr+vqzF075FyL/5KpRTH/IoqBKNNs=";
      }
      {
        name = "dotnet-interactive-vscode";
        publisher = "ms-dotnettools";
        version = "1.0.5568010";
        sha256 = "sha256-qRgm9E5uUencjUq8Gz0i8nazxRo1aKrkfUSTHq3dz60=";
      }
      {
        name = "vscode-dotnet-auto-attach";
        publisher = "DennisMaxJung";
        version = "1.1.1";
        sha256 = "sha256-vwf6MrN/v63N+oELCT1ANDN27dZ+A8zmCE0+3AypmoU=";
      }
      {
        name = "devbox";
        publisher = "jetpack-io";
        version = "0.1.6";
        sha256 = "sha256-cPlMZzF3UNVJCz16TNPoiGknukEWXNNXnjZVMyp/Dz8=";
      }
      {
        name = "onenord-vscode";
        publisher = "s1e2b3i4";
        version = "0.5.1";
        sha256 = "sha256-Nw9UrWQc57QoFLUWFi6ShzpSLbtlOvM8x04ULeFjQKM=";
      }
      {
        name = "vspacecode";
        publisher = "VSpaceCode";
        version = "0.10.19";
        sha256 = "sha256-4kyfoQ0VOPYFJwaTPRCIL7NIZ1/jx7THnc9UCHm0aWQ=";
      }
      {
        name = "indent-rainbow";
        publisher = "oderwat";
        version = "8.3.1";
        sha256 = "sha256-dOicya0B2sriTcDSdCyhtp0Mcx5b6TUaFKVb0YU3jUc=";
      }
      {
        name = "vsliveshare";
        publisher = "MS-vsliveshare";
        version = "1.0.5941";
        sha256 = "sha256-s7N6Qywq/SaubOOGw3+Rx1sl/Y1tHrtA2Cz8KiTB62I=";
      }
      {
        name = "docomment";
        publisher = "k--kato";
        version = "1.0.0";
        sha256 = "sha256-8kV4QLyA9ouqhBzpoZavUkYt9lyc8kTeHmH7L153Alo=";
      }
      {
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "sha256-j+P2oprpH0rzqI0VKt0JbZG19EDE7e7+kAb3MGGCRDk=";
      }
      {
        name = "playwright";
        publisher = "ms-playwright";
        version = "1.1.12";
        sha256 = "sha256-B6RYsDp1UKZmBRT/GdTPqxGOyCz2wJYKAqYqSLsez+w=";
      }
      {
        name = "dendron";
        publisher = "dendron";
        version = "0.124.0";
        sha256 = "sha256-/hxgmmiMUfBtPt5BcuNvtXs3LzDmPwDuUOyDf2udHws=";
      }
    ] ++ map (x: {publisher = "ms-vscode"; name = x.n; version = x.v; sha256 = x.sha;}) 
      [ 
        {v = "1.5.2"; n = "remote-server"; sha = "sha256-Gqb3/fSQS3rYheoFS8ksoidaZrOldxeYPoFSlzSgmVI="; } 
        {v = "0.4.3"; n = "remote-explorer"; sha = "sha256-772l0EnAWXLg53TxPZf93js/W49uozwdslmzNwD1vIk"; } 
        {v = "0.42.0"; n = "remote-repositories"; sha = "sha256-cYbkCcNsoTO6E5befw/ZN3yTW262APTCxyCJ/3z84dc="; } 
      ]
    );
    keybindings = builtins.fromJSON (builtins.readFile "${config.home.homeDirectory}/.config/vscode-keybindings.json");
    userSettings = {
      "workbench.colorTheme" = "Tokyo Night Storm";
      "editor.bracketPairColorization.enabled" = true;
      "extensions.experimental.affinity" = true;
    };
  };

  programs.waybar = {
    enable = true;
    # settings = {
    #   mainBar = {
    #     modules-left = ["sway/workspaces"];
    #   };
    # };
    style = ''
      * {
          font-family: ComicCodeLigaturesNerdFont;
      }
    '';
  };
  programs.rofi = {
    enable = true;
    theme = "/home/em/.config/rofi/theme.rasi";
    pass = {enable = true;};
    extraConfig = {
      modes = "window,drun,ssh";
      show-icons = true;
      kb-primary-paste = "Control+V";
      kb-secondary-paste = "Control+v";
    };
  };
  programs.rbw.enable = true;
  programs.chromium.enable = true;
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # cyberdream theme for tmux (catppuccin)
      thm_bg="#1e2124"
      thm_fg="#ffffff"
      thm_cyan="#5ef1ff"
      thm_black="#3c4048"
      thm_gray="#3c4048"
      thm_magenta="#ff5ef1"
      thm_pink="#ff5ea0"
      thm_red="#ff6e5e"
      thm_green="#5eff6c"
      thm_yellow="#f1ff5e"
      thm_blue="#5ea1ff"
      thm_orange="#ffbd5e"
      thm_black4="#7b8496"'';
  };
  programs.lazygit.enable = true;
  

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Em";
    userEmail = "emjonesdev@gmail.com";
    lfs.enable = true;
    extraConfig = {
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = false;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };


  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake \"${config.home.homeDirectory}/.config#\" --impure";
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
