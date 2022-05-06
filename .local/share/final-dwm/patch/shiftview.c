void
shiftview(const Arg *arg)
{
	Arg shifted;
	unsigned int seltagset = selmon->tagset[selmon->seltags] & ~SPTAGMASK;
	if (arg->i > 0) // left circular shift
		shifted.ui = (seltagset << arg->i)
		   | (seltagset >> (NUMTAGS - arg->i));
	else // right circular shift
		shifted.ui = seltagset >> -arg->i
		   | seltagset << (NUMTAGS + arg->i);

	view(&shifted);
}

/* Sends a window to the next/prev tag */
void shifttag(const Arg *arg)
{
    Arg shifted;
    shifted.ui = selmon->tagset[selmon->seltags] & ~SPTAGMASK;

    if (arg->i > 0) /* left circular shift */
        shifted.ui =
            ((shifted.ui << arg->i) | (shifted.ui >> (LENGTH(tags) - arg->i))) &
            ~SPTAGMASK;
    else /* right circular shift */
        shifted.ui =
            (shifted.ui >> (-arg->i) | shifted.ui << (LENGTH(tags) + arg->i)) &
            ~SPTAGMASK;
    tag(&shifted);
}

/* move the current active window to the next/prev tag and view it. More like
 * following the window */
void shiftboth(const Arg *arg)
{
    Arg shifted;
    shifted.ui = selmon->tagset[selmon->seltags] & ~SPTAGMASK;

    if (arg->i > 0) /* left circular shift */
        shifted.ui =
            ((shifted.ui << arg->i) | (shifted.ui >> (LENGTH(tags) - arg->i))) &
            ~SPTAGMASK;
    else /* right circular shift */
        shifted.ui = ((shifted.ui >> (-arg->i) |
                       shifted.ui << (LENGTH(tags) + arg->i))) &
                     ~SPTAGMASK;
    tag(&shifted);
    view(&shifted);
}

// helper function for shiftswaptags found on:
// https://github.com/moizifty/DWM-Build/blob/65379c62640788881486401a0d8c79333751b02f/config.h#L48
//  modified to work with scratchpad
void swaptags(const Arg *arg)
{
    Client *c;
    unsigned int newtag = arg->ui & TAGMASK;
    unsigned int curtag = selmon->tagset[selmon->seltags] & ~SPTAGMASK;

    if (newtag == curtag || !curtag || (curtag & (curtag - 1)))
        return;

    for (c = selmon->clients; c != NULL; c = c->next)
    {
        if ((c->tags & newtag) || (c->tags & curtag))
            c->tags ^= curtag ^ newtag;

        if (!c->tags)
            c->tags = newtag;
    }

    // move to the swaped tag
    // selmon->tagset[selmon->seltags] = newtag;

    focus(NULL);
    arrange(selmon);
}

/* swaps "tags" (all the clients) with the next/prev tag. */
void shiftswaptags(const Arg *arg)
{
    Arg shifted;
    shifted.ui = selmon->tagset[selmon->seltags] & ~SPTAGMASK;

    if (arg->i > 0) /* left circular shift */
        shifted.ui =
            ((shifted.ui << arg->i) | (shifted.ui >> (LENGTH(tags) - arg->i))) &
            ~SPTAGMASK;
    else /* right circular shift */
        shifted.ui = ((shifted.ui >> (-arg->i) |
                       shifted.ui << (LENGTH(tags) + arg->i))) &
                     ~SPTAGMASK;
    swaptags(&shifted);
    // uncomment if you also want to "go" (view) the tag where the the clients
    // are going
    // view(&shifted);
}

