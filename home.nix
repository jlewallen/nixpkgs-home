{ pkgs, ... }: {
  home.username = "jlewallen";
  home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/jlewallen";
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.sl
    pkgs.bashInteractive # don't ask me why
    pkgs.ripgrep
    pkgs.bat
    pkgs.htop
    pkgs.rsstail
    pkgs.unzip
    pkgs.wget
    pkgs.mosh
    pkgs.python3
    pkgs.exa
    pkgs.jq
    pkgs.sqlite
    # pkgs.wireshark
    pkgs.du-dust
    pkgs.fd
    pkgs.prettyping
    pkgs.imagemagick
    pkgs.tshark
    pkgs.tig
  ];

  programs.vim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshenv;
    sessionVariables = {
      EDITOR = "vim";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.fzf = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  /*
  Bad GL configuration?
  programs.alacritty = {
    enable = true;
  };
  */

  programs.tmux = {
    enable = true;
    shortcut = "a";

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];

    extraConfig = ''
unbind C-b
unbind l

set-option -g prefix C-a
set-option -g allow-rename off

bind-key a send-prefix
bind r source-file ~/.tmux.conf

set -g default-terminal "screen-256color"
set -g history-limit 50000
set -g mouse off
set -sg escape-time 0

set-window-option -g mode-keys vi

setw -g aggressive-resize on

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind P paste-buffer

bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X copy-selection
bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

bind-key S-Left swap-window -t -1
bind-key S-Right swap-window -t +1

bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# THEME
set -g status-bg black
set -g status-fg green
set -g status-interval 60
set -g status-left-length 20
set -g status-justify centre
set -g status-left ' #[fg=cyan,bright]JACOB#[fg=green]:#[fg=white]#S#[fg=green]#[default] '
set -g status-right ' #[fg=yellow]%y-%m-%d %H:%M '

setw -g window-status-current-style fg=black,bg=white

set-option -g set-titles on
set-option -g set-titles-string '#H:#S.#I.#P #W #T' # window number,program name, active(or not)

set -ga terminal-overrides ',xterm*:smglr=\E7\E[?69h\E[%i%p1%d;%p2%ds\E8:mgc=\E7\E[?69l\E8'
    '';
  };
}
