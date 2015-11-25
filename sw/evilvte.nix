{ config, pkgs, ... }:

{
  nixpkgs.config.evilvte.config = ''
  #define BACKSPACE_KEY     BACKSPACE
  #define DELETE_KEY        DELETE
  #define BELL_AUDIBLE      TRUE
  #define BELL_VISIBLE      TRUE
  #define BELL_URGENT       TRUE
  #define CLOSE_DIALOG      FALSE
  #define CLOSE_SAFELY      FALSE
  #define COLOR_STYLE       ZENBURN
  #define CURSOR_BLINKS          TRUE
  #define CURSOR_COLOR           "green"
  #define CURSOR_SHAPE           BLOCK /* Options: BLOCK, IBEAM, UNDERLINE                  */
  #define DEFAULT_COMMAND        "/run/current-system/sw/bin/fish"
  #define DEFAULT_DIRECTORY      g_get_current_dir()
  #define EXPORT_WINDOWID        TRUE
  #define FONT                   "Ubuntu Mono 9"
  #define FONT_ANTI_ALIAS        TRUE
  #define FONT_ENABLE_BOLD_TEXT  TRUE
  #define PROGRAM_WM_CLASS       TRUE
  #define RECORD_LASTLOG         TRUE
  #define RECORD_UTMP            TRUE
  #define RECORD_WTMP            TRUE
  #define SCROLL_LINES           51000  /* Negative value means unlimited     */
  #define SCROLL_ON_KEYSTROKE    TRUE
  #define SCROLL_ON_OUTPUT       TRUE
  #define SCROLLBAR              OFF_R /* Options: LEFT, RIGHT, OFF_L, OFF_R */
  #define SHOW_WINDOW_BORDER     FALSE
  #define SHOW_WINDOW_DECORATED  FALSE
  #define SHOW_WINDOW_ICON       FALSE
  #define STATUS_BAR             FALSE
  #define WINDOW_TITLE_DYNAMIC   TRUE  /* for xterm escape sequences         */
  #define WORD_CHARS             "-A-Za-z0-9_$.+!*(),;:@&=?/~#%"
  #define MENU                   TRUE
  #define MENU_MATCH_STRING_EXEC "firefox"
  #define      MATCH_STRING_L    "firefox" /* left click to open without menu*/
  #define      MATCH_STRING_M    "firefox" /* middle click to open           */
  #define      MATCH_STRING_HTTP TRUE      /* Detect http(s) and ftp(s)      */
  #define      MATCH_STRING_MAIL TRUE      /* Detect mailto:                 */
  #define      MATCH_STRING_FILE TRUE      /* Detect file:///                */
  #define TAB                    FALSE
  #define HOTKEY                         TRUE
  #define HOTKEY_COPY                    CTRL_SHIFT(GDK_C) || CTRL_SHIFT(GDK_c)
  #define HOTKEY_PASTE                   CTRL_SHIFT(GDK_V) || CTRL_SHIFT(GDK_v)
  #define HOTKEY_SELECT_ALL              CTRL_SHIFT(GDK_A) || CTRL_SHIFT(GDK_a)
  #define HOTKEY_FONT_BIGGER             CTRL(GDK_KEY_plus)
  #define HOTKEY_FONT_SMALLER            CTRL(GDK_KEY_underscore)
  #define HOTKEY_FONT_DEFAULT_SIZE       CTRL(GDK_KEY_parenright)
  #define HOTKEY_RESET_TERMINAL          CTRL_SHIFT(GDK_K) || CTRL_SHIFT(GDK_k)
  #define HOTKEY_RESET_AND_CLEAR         CTRL_SHIFT(GDK_L) || CTRL_SHIFT(GDK_l)
  #define HOTKEY_SEARCH_STRING           CTRL_SHIFT(GDK_S) || CTRL_SHIFT(GDK_s)
  #define HOTKEY_SEARCH_PREVIOUS         CTRL_SHIFT(GDK_KEY_numbersign)
  #define HOTKEY_SEARCH_NEXT             CTRL_SHIFT(GDK_KEY_asterisk)
  #define        SEARCH_CASE_SENSITIVE   FALSE
  '';


  environment.etc = {
    "fish/config.fish" = {
       text = ''
       set fish_theme robbyrussell
       set fish_greeting "Hi."

       set -U fish_key_bindings fish_vi_key_bindings

       set -x LS_COLORS 'no=00;38;5;244:rs=0:di=00;38;5;33:ln=01;38;5;33:mh=00:pi=48;5;230;38;5;136;01:so=48;5;230;38;5;136;01:do=48;5;230;38;5;136;01:bd=48;5;230;38;5;244;01:cd=48;5;230;38;5;244;01:or=48;5;235;38;5;160:su=48;5;160;38;5;230:sg=48;5;136;38;5;230:ca=30;41:tw=48;5;64;38;5;230:ow=48;5;235;38;5;33:st=48;5;33;38;5;230:ex=01;38;5;64:*.tar=00;38;5;61:*.tgz=01;38;5;61:*.arj=01;38;5;61:*.taz=01;38;5;61:*.lzh=01;38;5;61:*.lzma=01;38;5;61:*.tlz=01;38;5;61:*.txz=01;38;5;61:*.zip=01;38;5;61:*.z=01;38;5;61:*.Z=01;38;5;61:*.dz=01;38;5;61:*.gz=01;38;5;61:*.lz=01;38;5;61:*.xz=01;38;5;61:*.bz2=01;38;5;61:*.bz=01;38;5;61:*.tbz=01;38;5;61:*.tbz2=01;38;5;61:*.tz=01;38;5;61:*.deb=01;38;5;61:*.rpm=01;38;5;61:*.jar=01;38;5;61:*.rar=01;38;5;61:*.ace=01;38;5;61:*.zoo=01;38;5;61:*.cpio=01;38;5;61:*.7z=01;38;5;61:*.rz=01;38;5;61:*.apk=01;38;5;61:*.jpg=00;38;5;136:*.JPG=00;38;5;136:*.jpeg=00;38;5;136:*.gif=00;38;5;136:*.bmp=00;38;5;136:*.pbm=00;38;5;136:*.pgm=00;38;5;136:*.ppm=00;38;5;136:*.tga=00;38;5;136:*.xbm=00;38;5;136:*.xpm=00;38;5;136:*.tif=00;38;5;136:*.tiff=00;38;5;136:*.png=00;38;5;136:*.svg=00;38;5;136:*.svgz=00;38;5;136:*.mng=00;38;5;136:*.pcx=00;38;5;136:*.dl=00;38;5;136:*.xcf=00;38;5;136:*.xwd=00;38;5;136:*.yuv=00;38;5;136:*.cgm=00;38;5;136:*.emf=00;38;5;136:*.eps=00;38;5;136:*.pdf=01;38;5;245:*.tex=01;38;5;245:*.rdf=01;38;5;245:*.owl=01;38;5;245:*.n3=01;38;5;245:*.tt=01;38;5;245:*.nt=01;38;5;245:*.log=00;38;5;240:*.bak=00;38;5;240:*.aux=00;38;5;240:*.bbl=00;38;5;240:*.blg=00;38;5;240:*.aac=00;38;5;166:*.au=00;38;5;166:*.flac=00;38;5;166:*.mid=00;38;5;166:*.midi=00;38;5;166:*.mka=00;38;5;166:*.mp3=00;38;5;166:*.mpc=00;38;5;166:*.ogg=00;38;5;166:*.ra=00;38;5;166:*.wav=00;38;5;166:*.axa=00;38;5;166:*.oga=00;38;5;166:*.spx=00;38;5;166:*.xspf=00;38;5;166:*.mov=01;38;5;166:*.mpg=01;38;5;166:*.mpeg=01;38;5;166:*.m2v=01;38;5;166:*.mkv=01;38;5;166:*.ogm=01;38;5;166:*.mp4=01;38;5;166:*.m4v=01;38;5;166:*.mp4v=01;38;5;166:*.vob=01;38;5;166:*.qt=01;38;5;166:*.nuv=01;38;5;166:*.wmv=01;38;5;166:*.asf=01;38;5;166:*.rm=01;38;5;166:*.rmvb=01;38;5;166:*.flc=01;38;5;166:*.avi=01;38;5;166:*.fli=01;38;5;166:*.flv=01;38;5;166:*.gl=01;38;5;166:*.axv=01;38;5;166:*.anx=01;38;5;166:*.ogv=01;38;5;166:*.ogx=01;38;5;166:'

       function fish_title
         true
       end
       '';
    };

    "fish/functions/fish_prompt.fish" = {
      text = ''
      function fish_prompt

        if not set -q -g __fish_robbyrussell_functions_defined
          set -g __fish_robbyrussell_functions_defined
          function _git_branch_name
            echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
          end

          function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty ^/dev/null)
          end
        end

        set -l cyan (set_color -o cyan)
        set -l yellow (set_color -o yellow)
        set -l red (set_color -o red)
        set -l blue (set_color -o blue)
        set -l normal (set_color normal)

        set -l arrow "$red➜ "
        set -l cwd $cyan(basename (prompt_pwd))

        if [ (_git_branch_name) ]
          set -l git_branch $red(_git_branch_name)
          set git_info "$blue git:($git_branch$blue)"

          if [ (_is_git_dirty) ]
            set -l dirty "$yellow ✗"
            set git_info "$git_info$dirty"
          end
        end

        echo -n -s $arrow ' '$cwd $git_info $normal ' '
      end
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    evilvte
    fish
  ];
}
