// #include "./themes/dracula.h"   /* Importing Theme */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int gappih    = 12;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 12;       /* vert inner gap between windows */
static const unsigned int gappoh    = 12;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 12;       /* vert outer gap between windows and screen edge */
static int smartgaps          = 0;              /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

static const int showsystray             = 0;     /* 0 means no systray */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 4;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/

static const Bool viewontag         = False;     /* Switch view on tag switch */

#define ICONSIZE 28   /* icon size */
#define ICONSPACING 2 /* space between icon and title */

static const char *fonts[] = {
	"Hack Nerd Font:size=12",
	// "JoyPixels:pixelsize=10:antialias=true:autohint=true"
	"monospace:size=12"
};
static const char dmenufont[]       = "Hack Nerd Font:size=7";

static const char fg_norm[]         = "#f8f8f2";
static const char bg_norm[]         = "#282a36";
static const char bor_norm[]        = "#6272a4";
static const char fg_sel[]          = "#424450";
static const char bg_sel[]          = "#ff79c6";
// static const char bg_sel[]          = "#bd93f9";
// static const char bor_sel[]         = "#bd93f9";
static const char bor_sel[]         = "#bd93f9";
// static const char bor_sel[]         = "#ff79c6";

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { fg_norm, bg_norm, bor_norm },
	[SchemeSel]  = { fg_sel, bg_sel,  bor_sel },
	[SchemeHid]  = { bor_sel,  bg_norm, bor_sel },
};
static const unsigned int baralpha = 0xcc;
static const unsigned int borderalpha = OPAQUE;

static const unsigned int alphas[][3] = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* scratchpad */
typedef struct {
	const char *name;
	const void *cmd;
} Sp;
// const char *spcmd1[] = { "kitty", "-T", "sptop", "-e", "btop", NULL };
// const char *spcmd2[] = { "kitty", "-T", "spvim", "-e", "nvim", "~/.cache/scratchpad", NULL };
const char *spcmd1[] = { "st", "-t", "sptop", "-g", "100x34", "-e", "btop", NULL };
const char *spcmd2[] = { "st", "-t", "spvim", "-g", "100x34", "-e", "nvim", "~/.cache/scratchpad", NULL };
const char *spcmd3[] = { "st", "-t", "spranger", "-g", "100x34", "-e", "ranger", NULL };
static Sp scratchpads[] = {
	/* name     cmd  */
	{"sptop",   spcmd1},
	{"spvim",   spcmd2},
	{"spranger",   spcmd3},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *  use tags mask to point an application to a specific workspace
	 */
	/* class      instance     title         tags mask   isfloating   monitor */
	{ NULL,       NULL,        "sptop",      SPTAG(0),   1,           -1 },
	{ NULL,       NULL,        "spvim",      SPTAG(1),   1,           -1 },
	{ NULL,       NULL,        "spranger",   SPTAG(2),   1,           -1 },
	{ NULL,       NULL,        "Qalculate!", 0,          1,           -1 },
	{ NULL,       NULL,        "Bluetooth",  0,          1,           -1 },
	{ NULL,       NULL,        "Volume Control",  0,          1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
// #include "tatami.c"
#include "vanitygaps.c"


static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },/* first entry is default */
	{ "[M]",      monocle },
	{ "|+|",      tatami },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz},
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },/* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *dmenucmd[] = { "dmenu_run" };
// static const char *calendar[]  = { "gsimplecal", NULL };
// static const char *filecmd[]  = { "thunar", NULL };
// static const char *taskmanager[]  = { "xfce4-taskmanager", NULL };
// static const char *termcmd[]  = { "kitty", NULL };

#include "selfrestart.c"
#include "shift-tools-scratchpads.c"

static Key keys[] = {
	/* modifier             key                 function        argument */

	// window move
	{ MODKEY,               XK_j,               focusstackvis,  {.i = +1 } },
	{ MODKEY,               XK_k,               focusstackvis,  {.i = -1 } },
	{ MODKEY|ControlMask,   XK_j,               focusstackhid,  {.i = +1 } },
	{ MODKEY|ControlMask,   XK_k,               focusstackhid,  {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_j,               rotatestack,    {.i = +1} },
	{ MODKEY|ShiftMask,     XK_k,               rotatestack,    {.i = -1} },

	// window size
	{ MODKEY,               XK_h,               setmfact,       {.f = -0.05} },
	{ MODKEY,               XK_l,               setmfact,       {.f = +0.05} },

	// window control
	{ MODKEY,               XK_m,               hide,           {0} },
	{ MODKEY|ControlMask,   XK_m,               show,           {0} },
	{ MODKEY|ShiftMask,     XK_m,               togglefullscr,  {0} },
	{ MODKEY|Mod1Mask,      XK_m,               setlayout,      {.v = &layouts[2]} },
	{ MODKEY,               XK_f,               togglefloating, {0} },
	{ MODKEY,               XK_c,               killclient,     {0} },
	{ MODKEY,               XK_v,               spawn,          SHCMD("skippy-xd") },

	// shift-tools
	{ MODKEY,               XK_Tab,             shiftview,      {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_Tab,             shiftview,      {.i = -1 } },
	{ MODKEY,               XK_i,               shiftview,      {.i = +1 } },
	{ MODKEY,               XK_u,               shiftview,      {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_i,               shifttag,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_u,               shifttag,       {.i = -1 } },
	{ MODKEY|ControlMask,   XK_i,               shiftboth,      {.i = +1 } },
	{ MODKEY|ControlMask,   XK_u,               shiftboth,      {.i = -1 } },
	{ MODKEY|Mod1Mask,      XK_i,               shiftswaptags,  {.i = +1 } },
	{ MODKEY|Mod1Mask,      XK_u,               shiftswaptags,  {.i = -1 } },

	// screen
	{ MODKEY,               XK_comma,           focusmon,       {.i = -1 } },
	{ MODKEY,               XK_period,          focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_comma,           tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_period,          tagmon,         {.i = +1 } },
	{ MODKEY|ControlMask,   XK_comma,           travelmon,      {.i = -1 } },
	{ MODKEY|ControlMask,   XK_period,          travelmon,      {.i = +1 } },

	// layout
	{ MODKEY,               XK_bracketleft,     cyclelayout,    {.i = -1 } },
	{ MODKEY,               XK_bracketright,    cyclelayout,    {.i = +1 } },

	// scratchpad
	{ MODKEY,               XK_t,               togglescratch,  {.ui = 0 } },
	{ MODKEY,               XK_p,               togglescratch,  {.ui = 1 } },
	{ MODKEY,               XK_o,               togglescratch,  {.ui = 2 } },

	// misc
	{ MODKEY|ShiftMask,     XK_b,               togglebar,      {0} },
	{ MODKEY,               XK_equal,           incnmaster,     {.i = +1 } },
	{ MODKEY,               XK_minus,           incnmaster,     {.i = -1 } },

	// quit / restart
	{ MODKEY,               XK_r,               self_restart,   {0} },
	{ MODKEY|ShiftMask,     XK_x,               quit,           {0} },

	// ????
	{ MODKEY,               XK_semicolon,       view,           {0} },
	{ MODKEY|ShiftMask,     XK_semicolon,       view,           {.ui = ~0 } },
	{ MODKEY,               XK_apostrophe,      zoom,           {0} },
	{ MODKEY|ShiftMask,     XK_apostrophe,      tag,            {.ui = ~0 } },

	// gaps
	{ MODKEY,               XK_a,      incrgaps,       {.i = +1 } },
	{ MODKEY,               XK_z,      incrgaps,       {.i = -1 } },
	{ MODKEY|ShiftMask,     XK_a,      togglegaps,     {0} },
	{ MODKEY|ShiftMask,     XK_z,      defaultgaps,    {0} },

	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	TAGKEYS(XK_5, 4)
	TAGKEYS(XK_6, 5)

	// unused
	// { MODKEY,            XK_t,       setlayout,      {.v = &layouts[0]} },
	// { MODKEY,            XK_g,       setlayout,      {.v = &layouts[1]} },
	// { MODKEY,            XK_m,       setlayout,      {.v = &layouts[2]} },
	// { MODKEY,            XK_f,       setlayout,      {.v = &layouts[2]} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button2,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	// { ClkStatusText,        0,              Button6,        spawn,          {.v = taskmanager } },
	// { ClkStatusText,        0,              Button2,        spawn,          {.v = calendar } },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
