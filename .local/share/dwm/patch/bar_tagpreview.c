#include <Imlib2.h>

void showtagpreview(int tag, int x, int y)
{
        Monitor *m = selmon;

        if (!m->previewshow || !tag_preview)
        {
                XUnmapWindow(dpy, m->tagwin);
                return;
        }

        if (m->tagmap[tag])
        {
                XSetWindowBackgroundPixmap(dpy, m->tagwin, m->tagmap[tag]);
                XCopyArea(dpy, m->tagmap[tag], m->tagwin, drw->gc, 0, 0,
                          m->mw / scalepreview, m->mh / scalepreview, 0, 0);
                XMoveWindow(dpy, m->tagwin, x, y);
                XSync(dpy, False);
                XMapRaised(dpy, m->tagwin);
        }
        else
                XUnmapWindow(dpy, m->tagwin);
}

void hidetagpreview(Monitor *m)
{
        m->previewshow = 0;
        XUnmapWindow(dpy, m->tagwin);
}

void tagpreviewswitchtag(void)
{
        int i;
        unsigned int occ = 0;
        Monitor *m = selmon;
        Client *c;
        Imlib_Image image;

        for (c = m->clients; c; c = c->next)
                occ |= c->tags;
        for (i = 0; i < NUMTAGS; i++)
        {
                if (m->tagset[m->seltags] & 1 << i)
                {
                        if (m->tagmap[i] != 0)
                        {
                                XFreePixmap(dpy, m->tagmap[i]);
                                m->tagmap[i] = 0;
                        }
                        if (occ & 1 << i && tag_preview)
                        {
                                image = imlib_create_image(sw, sh);
                                if (image == NULL)
                                        continue;
                                imlib_context_set_image(image);
                                imlib_context_set_display(dpy);
                                imlib_context_set_visual(
                                        DefaultVisual(dpy, screen));
                                imlib_context_set_drawable(root);
                                imlib_copy_drawable_to_image(
                                        0, m->mx, m->my, m->mw, m->mh, 0, 0, 1);
                                m->tagmap[i] = XCreatePixmap(
                                        dpy, m->tagwin, m->mw / scalepreview,
                                        m->mh / scalepreview,
                                        DefaultDepth(dpy, screen));
                                imlib_context_set_drawable(m->tagmap[i]);
                                imlib_render_image_part_on_drawable_at_size(
                                        0, 0, m->mw, m->mh, 0, 0,
                                        m->mw / scalepreview,
                                        m->mh / scalepreview);
                                imlib_free_image();
                        }
                }
        }
}

void createpreview(Monitor *m)
{
        if (m->tagwin)
        {
                XUnmapWindow(dpy, m->tagwin);
                XDestroyWindow(dpy, m->tagwin);
                m->tagwin = 0;
                return;
        }

        XSetWindowAttributes wa = {.override_redirect = True,
                                   .background_pixmap = ParentRelative,
                                   .event_mask =
                                           ButtonPressMask | ExposureMask};
        XClassHint ch = {"preview", "preview"};

        // for (m = mons; m; m = m->next)
        // {
        m->tagwin = XCreateWindow(
                dpy, root, m->wx, m->my, m->mw / scalepreview,
                m->mh / scalepreview, 0, DefaultDepth(dpy, screen),
                CopyFromParent, DefaultVisual(dpy, screen),
                CWOverrideRedirect | CWBackPixmap | CWEventMask, &wa);
        XMapRaised(dpy, m->tagwin);
        XUnmapWindow(dpy, m->tagwin);
        XSetClassHint(dpy, m->tagwin, &ch);
        // }
}
