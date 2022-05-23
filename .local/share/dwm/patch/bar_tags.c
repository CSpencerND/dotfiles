int width_tags(Bar *bar, BarArg *a)
{
        int w, i;

        for (w = 0, i = 0; i < NUMTAGS; i++)
        {
                w += TEXTW(tagicon(bar->mon, i));
        }
        return w;
}

int draw_tags(Bar *bar, BarArg *a)
{
        int invert;
        int w, x = a->x;
        unsigned int i, occ = 0, urg = 0;
        char *icon;
        Client *c;
        Monitor *m = bar->mon;

        for (c = m->clients; c; c = c->next)
        {
                occ |= c->tags;
                if (c->isurgent)
                        urg |= c->tags;
        }
        for (i = 0; i < NUMTAGS; i++)
        {

                icon = tagicon(bar->mon, i);
                invert = 0;
                w = TEXTW(icon);
                drw_setscheme(
                        drw,
                        scheme[m->tagset[m->seltags] & 1 << i ? SchemeTagsSel
                               : urg & 1 << i                 ? SchemeUrg
                                              : SchemeTagsNorm]);
                drw_text(drw, x, a->y, w, a->h, lrpad / 2, icon, invert, False);
                drawindicator(m, NULL, occ, x, a->y, w, a->h, i, -1, invert,
                              tagindicatortype);
                x += w;
        }

        return 1;
}

int click_tags(Bar *bar, Arg *arg, BarArg *a)
{
        if (selmon->previewshow != 0)
                hidetagpreview(selmon);

        int i = 0, x = 0;

        do
        {
                x += TEXTW(tagicon(bar->mon, i));
        } while (a->x >= x && ++i < NUMTAGS);
        if (i < NUMTAGS)
        {
                arg->ui = 1 << i;
        }
        return ClkTagBar;
}

int hover_tags(Bar *bar, BarArg *a, XMotionEvent *ev)
{
        int i = 0, x = lrpad / 2;
        int px, py;
        Monitor *m = bar->mon;
        int ov = gappov;
        int oh = gappoh;

        do
        {
                x += TEXTW(tagicon(m, i));
        } while (a->x >= x && ++i < NUMTAGS);

        if (i < NUMTAGS)
        {
                if ((i + 1) != m->previewshow &&
                    !(m->tagset[m->seltags] & 1 << i))
                {
                        if (bar->by > m->my + m->mh / 2) // bottom bar
                                py = bar->by - m->mh / scalepreview - oh;
                        else // top bar
                                py = bar->by + bar->bh + oh;
                        px = bar->bx + ev->x - m->mw / scalepreview / 2;
                        if (px + m->mw / scalepreview > m->mx + m->mw)
                                px = m->wx + m->ww - m->mw / scalepreview - ov;
                        else if (px < bar->bx)
                                px = m->wx + ov;
                        m->previewshow = i + 1;
                        showtagpreview(i, px, py);
                }
                else if (m->tagset[m->seltags] & 1 << i)
                {
                        hidetagpreview(m);
                }
        }
        else if (m->previewshow != 0)
        {
                hidetagpreview(m);
        }

        return 1;
}
