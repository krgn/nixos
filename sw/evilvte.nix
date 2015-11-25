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
  #define FONT                   "DejaVu Sans Mono 9"
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

  environment.systemPackages = with pkgs; [
    evilvte
    fish
  ];
}
