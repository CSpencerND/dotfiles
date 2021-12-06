// #include "./themes/dracula.h"   /* Importing Theme */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 15;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */

static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */

static const char *fonts[]          = { "Hack Nerd Font:size=12" };
static const char dmenufont[]       = "Hack Nerd Font:size=12";

static const char fg_norm[]         = "#f8f8f2";
static const char bg_norm[]         = "#282a36";
static const char bor_norm[]        = "#6272a4";
static const char fg_sel[]          = "#424450";
static const char bg_sel[]          = "#bd93f9";
static const char bor_sel[]         = "#bd93f9";

static const char *colors[][3]      = {
    /*               fg         bg         border   */
    [SchemeNorm] = { fg_norm, bg_norm, bor_norm },
    [SchemeSel]  = { fg_sel, bg_sel,  bor_sel },
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
const char *spcmd1[] = { "kitty", "-e", "bpytop", NULL };
static Sp scratchpads[] = {
    /* name     cmd  */
    {"sptop",   spcmd1},
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     *  use tags mask to point an application to a specific workspace
     */
    /* class                instance    title       tags mask   isfloating   monitor */
    { "Gimp",               NULL,       NULL,       0,          0,           -1 },
    { "Xfce4-terminal",     NULL,       NULL,       0,          1,           -1 },
    { "firefox",            NULL,       NULL,       0,          0,           -1 },
    { NULL,                 "sptop",	NULL,	    SPTAG(0),   1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

#include "layouts.c"

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },    /* first entry is default */
    { "HHH",      grid },
    { "[M]",      monocle },
    // { "H[]",      deck },
    // { "TTT",      bstack },
    // { "===",      bstackhoriz},
    // { "###",      nrowgrid },
    // { "---",      horizgrid },
    // { ":::",      gaplessgrid },
    { "|M|",      centeredmaster },
    { ">M>",      centeredfloatingmaster },
    { "><>",      NULL },    /* no layout function means floating behavior */
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
static const char *filecmd[]  = { "thunar", NULL };
static const char *calendar[]  = { "gsimplecal", NULL };
static const char *taskmanager[]  = { "xfce4-taskmanager", NULL };
// static const char *termcmd[]  = { "kitty", NULL };

#include "selfrestart.c"
#include "shift-tools-scratchpads.c"

static Key keys[] = {
    /* modifier             key                 function        argument */

    // window move
    // { MODKEY,               XK_j,               focusstack,     {.i = +1 } },
    // { MODKEY,               XK_k,               focusstack,     {.i = -1 } },
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

    // shift-tools
    { MODKEY,               XK_Tab,             shiftview,      {.i = +1 } },
    { MODKEY|ShiftMask,     XK_Tab,             shiftview,      {.i = -1 } },
    { MODKEY,               XK_i,               shiftview,      {.i = +1 } },
    { MODKEY,               XK_u,               shiftview,      {.i = -1 } },
    { MODKEY|ShiftMask,     XK_i,               shifttag,       {.i = +1 } },
    { MODKEY|ShiftMask,	    XK_u,               shifttag,       {.i = -1 } },
    { MODKEY|ControlMask,   XK_i,               shiftboth,      {.i = +1 } },
    { MODKEY|ControlMask,   XK_u,               shiftboth,      {.i = -1 } },
    { MODKEY|Mod1Mask,      XK_i,               shiftswaptags,  {.i = +1 } },
    { MODKEY|Mod1Mask,	    XK_u,               shiftswaptags,  {.i = -1 } },

    // screen
    { MODKEY,               XK_comma,           focusmon,       {.i = -1 } },
    { MODKEY,               XK_period,          focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,     XK_comma,           tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,     XK_period,          tagmon,         {.i = +1 } },

    // layout
    { MODKEY,               XK_bracketleft,     cyclelayout,    {.i = -1 } },
    { MODKEY,               XK_bracketright,    cyclelayout,    {.i = +1 } },

    // scratchpad
    { MODKEY,               XK_t,               togglescratch,  {.ui = 0 } },

    // misc
    { MODKEY,               XK_b,               togglebar,      {0} },
    { MODKEY,               XK_equal,           incnmaster,     {.i = +1 } },
    { MODKEY,               XK_minus,           incnmaster,     {.i = -1 } },

    // quit / restart
    { MODKEY,               XK_r,               self_restart,   {0} },
    { MODKEY|ShiftMask,     XK_x,               quit,           {0} },

    // ????
    { MODKEY,               XK_0,               view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,     XK_0,               tag,            {.ui = ~0 } },

    TAGKEYS(XK_1, 0)
    TAGKEYS(XK_2, 1)
    TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3)
    TAGKEYS(XK_5, 4)
    TAGKEYS(XK_6, 5)

    // unused
    // { MODKEY,            XK_p,       spawn,          {.v = dmenucmd } },
    // { MODKEY,            XK_Return,  zoom,           {0} },
    // { MODKEY,            XK_Tab,     view,           {0} },
    // { MODKEY|ShiftMask,  XK_Return,  spawn,          {.v = filecmd } },
    // { MODKEY,            XK_t,       setlayout,      {.v = &layouts[0]} },
    // { MODKEY,            XK_g,       setlayout,      {.v = &layouts[1]} },
    // { MODKEY,            XK_m,       setlayout,      {.v = &layouts[2]} },
    // { MODKEY,            XK_f,       setlayout,      {.v = &layouts[2]} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button2,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        spawn,          {.v = taskmanager } },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = filecmd } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = calendar } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button1,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button2,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button2,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button2,        toggletag,      {0} },
};
