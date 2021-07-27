static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom */
static int fuzzy = 1;  /* -F  option; if 0, dmenu doesn't use fuzzy matching */

static const char *fonts[] = {
  "Hack Nerd Font:size=12:antialias=true:autohint=true",
  "NotoColorEmoji:pixelsize=12:antialias=true:autohint=true"
};

static const char *prompt = NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#f8f8f2", "#282a36" },
	[SchemeSel] = { "#f8f8f2", "#7a51d7" },
	[SchemeSelHighlight] = { "#e6e6e6", "#4d5b86" },
	[SchemeNormHighlight] = { "#50fa7b", "#14151b" },
	[SchemeOut] = { "#14151b", "#59dffc" },
	[SchemeMid] = { "#d7d7d7", "#14151b" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;
static unsigned int lineheight = 28; /* -h option; minimum height of a menu line */

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
