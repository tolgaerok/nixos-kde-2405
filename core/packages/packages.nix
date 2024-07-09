{ pkgs, lib, ... }: 
with lib;

{
  # ---------------------------------------------------------------------
  # My personal software collection ..
  # ---------------------------------------------------------------------

  # services.teamviewer.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # ---------------------------------------------------------------------
      # Andriod software
      # ---------------------------------------------------------------------

      android-file-transfer  # Reliable MTP client with minimalistic UI         
                             # provides: aft-mtp-cli android-file-transfer aft-mtp-mount

      android-tools          # Android SDK platform tools
                             # provides: lpadd append2simg lpmake mke2fs.android mkdtboimg simg2img lpdump lpunpack ext2simg 
                             # e2fsdroid adb unpack_bootimg repack_bootimg avbtool img2simg fastboot mkbootimg lpflash

      scrcpy                 # Display and control Android devices over USB or TCP/IP

      # ---------------------------------------------------------------------
      # Archive Utilities
      # ---------------------------------------------------------------------

      atool     # a script for managing file archives of various types 
                # provides: apack arepack als adiff atool aunpack acat
                #
                # examples: atool -x WPS-FONTS.zip    ==> this extracts the compressed file
                #           atool -l WPS-FONTS.zip    ==> this lists the contents of the compressed file
                #           atool -a name-your-compression.rar 1.pdf 2.pdf 3.sh    ==> this adds indovidual files to the compressed file

      gzip      # GNU zip compression program
                # provides: gunzip zmore zegrep zfgrep zdiff zcmp uncompress gzip znew zless zcat zforce gzexe zgrep

      lz4       # GNU zip compression program
                # provides: lz4c lz4 unlz4 lz4cat

      lzip      # A lossless data compressor based on the LZMA algorithm
                # provides: lzip

      lzo       # Real-time data (de)compression library

      lzop      # Fast file compressor
                # provides: lzop

      p7zip     # A new p7zip fork with additional codecs and improvements (forked from https://sourceforge.net/projects/p7zip/)
                # provides: 7zr 7z 7za

      rar       # Utility for RAR archives

      rzip      # Compression program
                # provides: rzip

      unzip     # An extraction utility for archives compressed in .zip format
                # provides: zipinfo unzipsfx zipgrep funzip unzip

      xz        # A general-purpose data compression software, successor of LZMA
                # provides: lzfgrep lzgrep lzma xzegrep xz unlzma lzegrep lzmainfo lzcat xzcat xzfgrep xzdiff
                #           lzmore xzgrep xzdec lzdiff xzcmp lzmadec xzless xzmore unxz lzless lzcmp

      zip       # Compressor/archiver for creating and modifying zipfiles
                # provides: zipsplit zipnote zip zipcloak

      zstd      # Zstandard real-time compression algorithm
                # provides: zstd pzstd zstdcat zstdgrep zstdless unzstd zstdmt

      # ---------------------------------------------------------------------
      # Multimedia Utilities
      # ---------------------------------------------------------------------

      audacity                        # Sound editor with graphical UI

      ffmpeg                          # A complete, cross-platform solution to record, convert and stream audio and video
                                      # provides: ffprobe ffmpeg

      ffmpegthumbnailer               # A lightweight video thumbnailer
      libdvdcss                       # A library for decrypting DVDs
      libdvdread                      # A library for reading DVDs
      libopus                         # Open, royalty-free, highly versatile audio codec
      libvorbis                       # Vorbis audio compression reference implementation
      mediainfo                       # Supplies technical and tag information about a video or audio file
      mediainfo-gui                   # Supplies technical and tag information about a video or audio file (GUI version)

      mpg123                          # Fast console MPEG Audio Player and decoder library
                                      # provides: out123 conplay mpg123-id3dump mpg123 mpg123-strip

      mplayer                         # A movie player that supports many video formats
                                      # provides: gmplayer mplayer mencoder

      mpv                             # General-purpose media player, fork of MPlayer and mplayer2

      ocamlPackages.gstreamer         # Bindings for the GStreamer library which provides functions for playning and manipulating multimedia streams
                                      # provides: mpv mpv_identify.sh umpv

      simplescreenrecorder            # A screen recorder for Linux
                                      # provides: ssr-glinject simplescreenrecorder

      video-trimmer                   # Trim videos quickly

      # ---------------------------------------------------------------------
      # Deduplicating archiver with compression and encryption softwar
      # ---------------------------------------------------------------------

      borgbackup                      # Deduplicating archiver with compression and encryption
                                      # provides: borgfs, borg

      restic                          # A backup program that is fast, efficient and secure
                                      # https://www.youtube.com/watch?v=MzJbSf7GQ1E

      restique                        # Restic GUI for Desktop/Laptop Backups

      # ---------------------------------------------------------------------
      # Database related
      # ---------------------------------------------------------------------

      # pgmodeler                       # A database modeling tool for PostgreSQL
                                      # provides: pgmodeler-cli pgmodeler pgmodeler-ch pgmodeler-se

      sqlitebrowser                   # DB Browser for SQLite

      # ---------------------------------------------------------------------
      # cli-utilities
      # ---------------------------------------------------------------------

      doas                            # Executes the given command as another user
      fzf                             # A command-line fuzzy finder written in Go
                                      # provides: fzf-tmux fzf-share fzf

      # ---------------------------------------------------------------------
      # Clipboard Utilities:
      # ---------------------------------------------------------------------

      # ---------------------------------------------------------------------
      # Code Search and Analysis:
      # ---------------------------------------------------------------------

      ripgrep                         # A utility that combines the usability of The Silver Searcher with the raw speed of grep
                                      # rg

      ripgrep-all                     # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
                                      # provides: rga-preproc rga

      # ---------------------------------------------------------------------
      # Utilities
      # ---------------------------------------------------------------------

      direnv                            # A shell extension that manages your environment
      nix-direnv                        # A fast, persistent use_nix implementation for direnv
      nixfmt-classic                            # An opinionated formatter for Nix
      nixos-option
      vscode-extensions.mkhl.direnv

      # ---------------------------------------------------------------------
      # Github related
      # ---------------------------------------------------------------------
    
      git       # Distributed version control system

      # ---------------------------------------------------------------------
      # Programming Languages and Tools:
      # ---------------------------------------------------------------------
      
      python311Full                 # A high-level dynamically-typed programming language
                                    # provides: idle3.11 python3.11-config idle python3-config pydoc pydoc3 pydoc3.11
                                    #           idle3 2to3-3.11 2to3 python3.11 python3 python-config python

      # ---------------------------------------------------------------------
      # Dsctool
      # ---------------------------------------------------------------------

      # ---------------------------------------------------------------------
      # Scanning and Image Viewing
      # ---------------------------------------------------------------------

      nsxiv                          # New Suckless X Image Viewer
      sane-backends                  # SANE (Scanner Access Now Easy) backends
      scanbd                         # Scanner button daemon
      sxiv                           # Simple X Image Viewer

      # ---------------------------------------------------------------------
      # Downloading Videos and Files
      # ---------------------------------------------------------------------

      clipgrab                       # Video downloader for YouTube and other sites
      wget                           # Tool for retrieving files using HTTP, HTTPS, and FTP

      # ---------------------------------------------------------------------
      # Messaging and Communication:
      # ---------------------------------------------------------------------

      # whatsapp-for-linux             # Whatsapp desktop messaging app

      # ---------------------------------------------------------------------
      # Miscellaneous:
      # ---------------------------------------------------------------------

      cowsay                         # A program which generates ASCII pictures of a cow with a message
                                     #
                                     # ex: $ fortune | cowsay -f tux
                                     #     $ fortune | cowsay -e ^^
                                     #     $ fortune | cowsay | lolcat
     
      flatpak                        # Linux application sandboxing and distribution framework
      fortune                        # unstr rot strfile fortune

      lolcat                         # A rainbow version of cat for colorful output
                                     # "lolcat" for colorful output
      themechanger                   # A theme changing utility for Linux
      variety                        # A wallpaper manager for Linux systems
      jp2a                           # A small utility that converts JPG images to ASCII
                                     # curl -sSL -o /tmp/deb-logo.png https://github.com/tolgaerok/Debian-tolga/raw/main/WALLPAPERS/deb-logo.png
                                     # Resize the image to 101x85
                                     # convert /tmp/deb-logo.png -resize 101x98 /tmp/deb-logo-resized.png
                                     # Display the Debian ASCII art logo as the background
                                     # jp2a --background=light --colors --width="$(tput cols)" /tmp/deb-logo-resized.png

      # ---------------------------------------------------------------------
      # Media and Entertainment:
      # ---------------------------------------------------------------------

      vlc                            # Cross-platform media player and streaming server   

      # ---------------------------------------------------------------------
      # Picture manger
      # ---------------------------------------------------------------------

      digikam                        # Photo Management Program
      shotwell                       # Popular photo organizer for the GNOME desktop

      # ---------------------------------------------------------------------
      # Picture Editors
      # ---------------------------------------------------------------------

      gimp-with-plugins              # The GNU Image Manipulation Program

      # ---------------------------------------------------------------------
      # Remote Access and Automation:
      # ---------------------------------------------------------------------
      anydesk
      sshpass                        # Non-interactive ssh password auth

      # ---------------------------------------------------------------------
      # File Sharing & Network
      # ---------------------------------------------------------------------

      cifs-utils                     # Tools for managing Linux CIFS client filesystems
      samba4Full                     # The standard Windows interoperability suite of programs for Linux and Unix

      # ---------------------------------------------------------------------
      # KDE Plasma tools
      # ---------------------------------------------------------------------

      ark                            # Graphical file compression/decompression utility
      filelight                      # Disk usage statistics
      kate                           # Advanced text editor
 
      # ---------------------------------------------------------------------
      # system tools
      # ---------------------------------------------------------------------

      media-downloader                # media-downloader
                                      
      # ---------------------------------------------------------------------
      # USB and Device Utilities
      # ---------------------------------------------------------------------

      usbutils                       # Tools for working with USB devices, such as lsusb

      # ---------------------------------------------------------------------
      # Other Miscellaneous Programs
      # ---------------------------------------------------------------------

      blueberry                     # Bluetooth configuration tool
                                    # blueberry-tray blueberry

      efibootmgr                    # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
                                    # efibootdump efibootmgr

      gum                           # gum https://github.com/charmbracelet/gum 

      espeak-classic                # Compact open source software speech synthesizer
                                    # espeak
                                    # espeak -v en+m7 -s 165 "Welcome! This script will! initiate! the! basic! setup! for your system. Thank you for using! my configuration." --punct=","

      # ---------------------------------------------------------------------
      # Libraries
      # ---------------------------------------------------------------------

      libarchive                    # bsdtar bsdcpio bsdcat
      libbtbb                       # Bluetooth baseband decoding library
      libnotify                     # Desktop Notify agent example: notify-send --icon=fcitx --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
      notify-desktop                # Desktop Notify agent example: notify-desktop --icon=call-start "Incoming call"   SOURCE: https://github.com/nowrep/notify-desktop/tree/master

      # ---------------------------------------------------------------------
      # File Transfer:
      # ---------------------------------------------------------------------
   
      rsync
      transmission-gtk
      zsync

      # ---------------------------------------------------------------------
      # Disk Utilities
      # ---------------------------------------------------------------------

      gparted                       # Graphical disk partitioning tool
      hw-probe                      # Probe for hardware, check operability and find drivers
                                    #
                                    # sudo -E hw-probe -all -upload

      ntfs3g                        # FUSE-based NTFS driver with full write support

      # ---------------------------------------------------------------------
      # Terminal Utilities
      # ---------------------------------------------------------------------

      asunder                       # A graphical Audio CD ripper and encoder for Linux
      bashInteractive               # GNU Bourne-Again Shell, the de facto standard shell on Linux (for interactive use)
      cmatrix                       # Simulates the falling characters theme from The Matrix movie
      duf                           # Disk Usage/Free Utility
      fd                            # A simple, fast and user-friendly alternative to find
      figlet                        # Program for making large letters out of ordinary text
      htop                          # An interactive process viewer

      inotify-tools                 # A set of command-line programs providing a simple interface to inotify.
                                    # inotifywait   inotifywatch
                                    # Source:  https://github.com/inotify-tools/inotify-tools/wiki

      
      gnome.zenity                  # Tool to display dialogs from the commandline and shell scripts
      lfs                           # Get information on your mounted disks
      lsd                           # The next gen ls command
      lsdvd                         # Display information about audio, video, and subtitle tracks on a DVD
      ncdu                          # Disk usage analyzer with an ncurses interface
      
      pciutils                      # A collection of programs for inspecting and manipulating configuration of PCI devices
      pmutils                       # A small collection of scripts that handle suspend and resume on behalf of HAL
      psmisc                        # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
      rPackages.pkgconfig           # Set configuration options on a per-package basis. Options set by a given package only apply to that package, other packages are unaffected.
      tree                          # Command to produce a depth indented directory listing

      # ---------------------------------------------------------------------
      # XDG Utilities
      # ---------------------------------------------------------------------

      xdg-launch                    # A command line XDG compliant launcher and tools
      xdg-utils                     # A set of command line tools that assist applications with a variety of desktop integration tasks for opening default programs when clicking links

      #---------------------------------------------------------------------
      # Office and Productivity:
      #---------------------------------------------------------------------

      #---------------------------------------------------------------------
      # New additions:
      #---------------------------------------------------------------------

      # megasync          # Easy automated syncing between your computers and your MEGA Cloud Drive
      # onedrive          # A complete tool to interact with OneDrive on Linux
      glances           # glances   : Cross-platform curses-based monitoring tool
      rclone            # Command line program to sync files and directories to and from major cloud storage
      rclone-browser    # Graphical Frontend to Rclone written in Qt

      #-----------------------------------------------------------------  
      # Extra Audio packages
      #-----------------------------------------------------------------

      # alsa-utils
      # pavucontrol
      # pulseaudio
      # pulsemixer

      #-----------------------------------------------------------------  
      # Extra Misc packages
      #-----------------------------------------------------------------

      appimage-run     
      bash
      bc
      ghostscript
      ghostscript_headless
      glxinfo
      gnomeExtensions.mock-tray
      google-chrome
      krita
      libva
      libva-utils
      minidlna
      nftables
      redhat-official-fonts
      vim
    ];
  };
} 
