/* See LICENSE file for copyright and license details. */
#include "themes/catppuccin.h"

/* custom function */
static void shiftmon(const Arg *arg);

/* appearance */
static const unsigned int borderpx       = 2;   /* border pixel of windows */
static const unsigned int borderpxf      = 1;   /* border pixel of floating windows */

static const unsigned int snap           = 8;  /* snap pixel */
static const int scalepreview            = 3;        /* Tag preview scaling */
static const int tag_preview             = 1;

static const unsigned int gappih         = 12;  /* horiz inner gap between windows */
static const unsigned int gappiv         = 12;  /* vert inner gap between windows */
static const unsigned int gappoh         = 12;  /* horiz outer gap between windows and screen edge */
static const unsigned int gappov         = 12;  /* vert outer gap between windows and screen edge */
static const int smartgaps_fact          = 1;   /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */

static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */

static const int horizpadbar             = -3;   /* horizontal padding for statusbar */
static const int vertpadbar              = 3;   /* vertical padding for statusbar */
static const unsigned int barborderpx    = 6;   /* border pixel of status bar */

static const char dwmdir[]               = "dwm";
static const char localshare[]           = ".local/share";
static const char autostartblocksh[]     = "autostart_blocking.sh";
static const char autostartsh[]          = "autostart.sh";
static const char *layoutmenu_cmd        = "layoutmenu.sh";


#define ICONSIZE 28    /* icon size */
#define ICONSPACING 2  /* space between icon and title */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = 'A';
static const unsigned int systrayspacing = 4;   /* systray spacing */
static const int showsystray             = 1;   /* 0 means no systray */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_BOTTOM_BAR_SLIM;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;

static const char buttonbar[]            = " ";

static const char *fonts[] = {
	"Hack Nerd Font:size=10",
	// "JoyPixels:pixelsize=10:antialias=true:autohint=true"
	"monospace:size=10"
};

static char *colors[][ColCount] = {

                /* fg
                 * bg
                 * border
                 * float
                 */

	[SchemeNorm] = {
                button_color,
                main_color,
                main_color,
                minor_color
        },

	[SchemeSel] = {
                unused,
                unused,
                border_color,
                border_color
        },

	[SchemeTitleNorm] = {
                unused,
                main_color,
                unused,
                unused
        },

	[SchemeTagsNorm] = {
                minor_color,
                main_color,
                unused,
                unused
        },

	[SchemeTitleSel] = {
                main_color,
                highlight_color,
                unused,
                unused
        },

	[SchemeTagsSel] = {
                main_color,
                highlight_color,
                unused,
                unused
        },

	[SchemeHidNorm] = {unused,unused,unused,unused},
	[SchemeHidSel] = {unused,unused,unused,unused},
	[SchemeUrg] = {unused,unused,unused,unused},
};

const char *spcmd0[] = { "st", "-c", "basic", "-g", "120x34", NULL };
const char *spcmd1[] = { "st", "-c", "task", "-g", "120x34", "-e", "btop", NULL };
const char *spcmd2[] = { "st", "-c", "note", "-g", "120x34", "-e", "vi", "~/Documents/notes/", NULL };
const char *spcmd3[] = { "st", "-c", "explore", "-g", "120x34", "-e", "ranger", NULL };

// const char *spcmd0[] = { "kitty", "--class", "basic",    NULL };

static Sp scratchpads[] = {
	/* name       cmd  */
        { "basic",    spcmd0 },
	{ "task",     spcmd1 },
	{ "note",     spcmd2 },
	{ "explore",  spcmd3 },
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */

static const char *tags[] = { "1", "2", "3", "4", "5" };

static char *tagicons[][NUMTAGS] = {
	[DEFAULT_TAGS]        = { "1", "2", "3", "4", "5" },
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>" },
};


/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG",                        .isfloating = 1,)
	RULE(.wintype = WTYPE "UTILITY",                       .isfloating = 1,)
	RULE(.wintype = WTYPE "TOOLBAR",                       .isfloating = 1,)
	RULE(.wintype = WTYPE "DOCK",                          .isfloating = 1,)
	RULE(.wintype = WTYPE "POPUP",                         .isfloating = 1,)
	RULE(.wintype = WTYPE "DROPDOWN",                      .isfloating = 1,)
	RULE(.wintype = WTYPE "DND",                           .isfloating = 1,)

	RULE(.title = "Qalculate!",                            .isfloating = 1)
	RULE(.title = "Bluetooth",                             .isfloating = 1)
	RULE(.title = "Volume Control",                        .isfloating = 1)
	RULE(.class = "eww",                                   .isfloating = 1)
	RULE(.class = "Archlinux-logout.py",                   .unmanaged  = 4)
	RULE(.class = "Thunar",                                .isfloating = 1)
	RULE(.class = "System-monitoring-center",              .isfloating = 1)
	RULE(.class = "Spicy",                                 .isfloating = 1)
	RULE(.class = "Solaar",                                .isfloating = 1)
	RULE(.class = "Xfce",                                  .isfloating = 1)
	RULE(.class = "Hotkeys.py",                            .isfloating = 1)

        // scratchpads
	RULE(.class = "basic",   .tags = SPTAG(0),             .isfloating = 1)
	RULE(.class = "task",    .tags = SPTAG(1),             .isfloating = 1)
	RULE(.class = "note",    .tags = SPTAG(2),             .isfloating = 1)
	RULE(.class = "explore", .tags = SPTAG(3),             .isfloating = 1)
};


/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar  alignment         widthfunc        drawfunc        clickfunc        hoverfunc    name */
	{ -1,        0,   BAR_ALIGN_LEFT,   width_stbutton,  draw_stbutton,  click_stbutton,  NULL,        "statusbutton" },
	{ -1,        0,   BAR_ALIGN_LEFT,   width_tags,      draw_tags,      click_tags,      hover_tags,  "tags" },
	{  0,        0,   BAR_ALIGN_RIGHT,  width_systray,   draw_systray,   click_systray,   NULL,        "systray" },
	{ -1,        0,   BAR_ALIGN_LEFT,   width_ltsymbol,  draw_ltsymbol,  click_ltsymbol,  NULL,        "layout" },
	{ statusmon, 0,   BAR_ALIGN_RIGHT,  width_status2d,  draw_status2d,  click_status2d,  NULL,        "status2d" },
	{ -1,        0,   BAR_ALIGN_NONE,   width_wintitle,  draw_wintitle,  click_wintitle,  NULL,        "wintitle" },
};

/* layout(s) */
static const float mfact        = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */


static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "TTT",      bstack },
	{ "[D]",      deck },
	{ "HHH",      grid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "[M]",      monocle },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};


/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|Mod1Mask,              KEY,      toggletag,      {.ui = 1 << TAG} },


/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

void shiftmon(const Arg *arg)
{
    tagmon(arg);
    focusmon(arg);
}

static Key keys[] = {
	/* modifier                     key            function                argument */

        // window move
	{ MODKEY,               XK_j,               focusstack,     {.i = +1} },
	{ MODKEY,               XK_k,               focusstack,     {.i = -1} },
	{ MODKEY|ShiftMask,     XK_j,               rotatestack,    {.i = +1} },
	{ MODKEY|ShiftMask,     XK_k,               rotatestack,    {.i = -1} },
	{ MODKEY|ControlMask,   XK_j,               movestack,      {.i = +1} },
	{ MODKEY|ControlMask,   XK_k,               movestack,      {.i = -1} },

	// window size
	{ MODKEY,               XK_h,               setmfact,       {.f = -0.05} },
	{ MODKEY,               XK_l,               setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,   XK_h,               setcfact,       {.f = -0.05} },
	{ MODKEY|ControlMask,   XK_l,               setcfact,       {.f = +0.05} },
	{ MODKEY,               XK_n,               setcfact,       {.f =  0.00} },
	{ MODKEY,               XK_n,               setmfact,       {.f =  mfact+1} },

	// window control
	{ MODKEY|ShiftMask,     XK_m,               togglefullscreen,  {0} },
	{ MODKEY,               XK_m,               setlayout,      {.v = &layouts[6]} },
	{ MODKEY,               XK_f,               togglefloating, {0} },
	{ MODKEY,               XK_c,               killclient,     {0} },
	{ MODKEY,               XK_v,               spawn,          SHCMD("skippy-xd") },
	{ MODKEY,               XK_s,               togglesticky,   {0} },

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
	{ MODKEY|ControlMask,   XK_comma,           shiftmon,       {.i = -1 } },
	{ MODKEY|ControlMask,   XK_period,          shiftmon,       {.i = +1 } },
	{ MODKEY|Mod1Mask,      XK_comma,           tagswapmon,     {.i = +1 } },
	{ MODKEY|Mod1Mask,      XK_period,          tagswapmon,     {.i = -1 } },
	{ MODKEY,               XK_b,               togglebar,      {0} },

	// layout
	{ MODKEY,               XK_bracketleft,     cyclelayout,    {.i = -1 } },
	{ MODKEY,               XK_bracketright,    cyclelayout,    {.i = +1 } },
	{ MODKEY,               XK_equal,           incnmaster,     {.i = +1 } },
	{ MODKEY,               XK_minus,           incnmaster,     {.i = -1 } },

	// scratchpads
	{ MODKEY,               XK_apostrophe,      togglescratch,  {.ui = 0 } },
	{ MODKEY,               XK_t,               togglescratch,  {.ui = 1 } },
	{ MODKEY,               XK_semicolon,       togglescratch,  {.ui = 2 } },
	{ MODKEY,               XK_o,               togglescratch,  {.ui = 3 } },

	{ MODKEY,               XK_p,               togglescratch,  {.ui = 4 } },
	{ MODKEY|ControlMask,   XK_p,               setscratch,     {.ui = 4 } },
	{ MODKEY|Mod1Mask,      XK_p,               removescratch,  {.ui = 4 } },

	// quit / restart - if restart doesn't work, try quit
	{ MODKEY|ShiftMask,     XK_r,               self_restart,   {0} },
	{ MODKEY|ControlMask,   XK_r,               quit,           {0} },

	// gaps
	{ MODKEY,               XK_a,               incrgaps,       {.i = -1 } },
	{ MODKEY,               XK_z,               incrgaps,       {.i = +1 } },
	{ MODKEY|ShiftMask,     XK_a,               togglegaps,     {0} },
	{ MODKEY|ShiftMask,     XK_z,               defaultgaps,    {0} },

	// ????
	{ MODKEY,               XK_Home,            view,           {0} },
	{ MODKEY|ShiftMask,     XK_Home,            view,           {.ui = ~0 } },
	{ MODKEY,               XK_End,             zoom,           {0} },
 	{ MODKEY|ShiftMask,     XK_End,             tag,            {.ui = ~0 } },

	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
};

static const char *filecmd[]     = { "thunar", NULL };
static const char *appfinder[]   = { "xfce4-appfinder", NULL };
static const char *taskmanager[] = { "system-monitoring-center", NULL };
static const char *calendar[]    = { "gsimplecal", NULL };
static const char *batinfo[]     = { "bat-notif.sh", NULL };
static const char *logout[]      = { "archlinux-logout", NULL};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask           button          function        argument */

	{ ClkButton,            0,                   Button1,        spawn,          {.v = appfinder } },
	{ ClkButton,            0,                   Button3,        spawn,          {.v = logout } },

	{ ClkLtSymbol,          0,                   Button1,        cyclelayout,    {.i = -1 } },
	{ ClkLtSymbol,          0,                   Button3,        layoutmenu,     {0} },
	// { ClkLtSymbol,          0,                   Button3,        cyclelayout,    {.i = +1 } },

	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },

	{ ClkStatusText,        0,                   Button1,        spawn,          {.v = batinfo } },
	{ ClkStatusText,        0,                   Button3,        spawn,          {.v = calendar } },
	{ ClkStatusText,        MODKEY,              Button1,        spawn,          {.v = filecmd } },
	{ ClkStatusText,        MODKEY,              Button3,        spawn,          {.v = taskmanager } },

	// { ClkStatusText,        0,                   Button4,        spawn,          {.v = } },
	// { ClkStatusText,        0,                   Button5,        spawn,          {.v = } },

	// { ClkStatusText,        0,                   Button9,        spawn,          {.v = calendar } },
	// { ClkStatusText,        0,                   Button8,        spawn,          {.v = } },

	{ ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,    Button3,        dragcfact,      {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,    Button1,        dragmfact,      {0} },

	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

