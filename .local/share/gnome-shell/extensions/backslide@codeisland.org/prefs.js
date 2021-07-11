/*
 * Copyright (C) 2012 Lukas Knuth
 * 
 * This file is part of Backslide.
 *
 * Backslide is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Backslide is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Backslide.  If not, see <http://www.gnu.org/licenses/>.
*/
/**
 * Preferences for the extension which will be available in the "gnome-shell-extension-prefs"
 *  tool.
 * In the preferences, you can add new images to the list and remove old ones.
 * @see <a href="https://live.gnome.org/GnomeShell/Extensions#Extension_Preferences">Doc</a>
 */
const Gtk = imports.gi.Gtk;
const Gdk = imports.gi.Gdk;
const GObject = imports.gi.GObject;
const Gio = imports.gi.Gio;
const Pixbuf = imports.gi.GdkPixbuf;
const Me = imports.misc.extensionUtils.getCurrentExtension();
const Pref = Me.imports.settings;
const Utils = Me.imports.utils;

const Gettext = imports.gettext.domain('backslide');
const _ = Gettext.gettext;

let settings;
let ready = false;
const IMAGE_REGEX = /^image\/\w+$/i;
const PIXBUF_COL = 0;
const PATH_COL = 1;
/**
 * Called right after the file was loaded.
 */
function init(){
    Utils.initTranslations();
    settings = new Pref.Settings();
}

function addFileEntry(model, path){
    // Asynchronously load and scale the image from the given path:
    try {
        let file = Gio.file_new_for_path(path);
        let stream = file.read(null);
        /*
            We need to assign the new "space" in the grid outside, to keep the order
            of the list. Otherwise, we get the order in which the loading finishes...
        */
        let iterator = model.append();
        // Load it Async:
        Pixbuf.Pixbuf.new_from_stream_at_scale_async(stream, 240, -1, true, null,
            function(source, res){                   // TODO Max-Height...!
                // Get the loaded image:
                let image = Pixbuf.Pixbuf.new_from_stream_finish(res);
                if (image === undefined) return;
                // Append to the list:
                model.set(iterator, [PIXBUF_COL,PATH_COL], [image, path]);
                // There is data in the list, we're ready to store if necessary:
                ready = true;
            });
    } catch (e){
        // Image could not be loaded. Invalid path.
        /*
            It's okay to do nothing here, when the list is stored, the invalid image will not be
            stored with the rest, so it's practically gone.
        */
        print(e);
    }
}

function addDirectory(model, path){
    let dir = Gio.file_new_for_path(path);
    if (dir.query_file_type(Gio.FileQueryInfoFlags.NONE, null) != Gio.FileType.DIRECTORY){
        // Not a valid directory!
        return;
    }
    // List all children:
    let children = dir.enumerate_children("*", Gio.FileQueryInfoFlags.NOFOLLOW_SYMLINKS, null);
    let info;
    while ( (info = children.next_file(null)) != null){
        if (info.get_file_type() == Gio.FileType.REGULAR && info.get_is_hidden() == false){
            // Check if it's an image:
            if (info.get_content_type().match(IMAGE_REGEX) != null){
                addFileEntry(model, path + "/" + info.get_name());
            }
        } else if (info.get_file_type() == Gio.FileType.DIRECTORY && !info.get_is_hidden()){
            // Recursive search:
            addDirectory(model, path + "/" + info.get_name());
        }
    }
}

function addGioFile(model, file){
    // Gather information:
    let type = file.query_file_type(Gio.FileQueryInfoFlags.NONE, null);
    // Check whether a directory or a file wasen:
    if (type == Gio.FileType.REGULAR){
        addFileEntry(model, file.get_path());
    } else if (type == Gio.FileType.DIRECTORY){
        addDirectory(model, file.get_path());
    }
}

function addPath(model, path){
    addGioFile(model, Gio.file_new_for_path(path));
}

function addURI(model, uri){
    addGioFile(model, Gio.file_new_for_uri(uri));
}

/**
 * Called to build a preferences widget.
 * @return object any type of GTK+ widget to be placed inside the prefs window.
 */
function buildPrefsWidget(){
    let frame = new Gtk.Box({
        orientation: Gtk.Orientation.HORIZONTAL,
        width_request: 815,
        height_request: 600
    });

    // The model for the tree:
    // See (and next page): http://scentric.net/tutorial/sec-treeviewcol-renderer.html
    let grid_model = new Gtk.ListStore();
    grid_model.set_column_types([Pixbuf.Pixbuf, GObject.TYPE_STRING]); // See http://blogs.gnome.org/danni/2012/03/29/gtk-liststores-and-clutter-listmodels-in-javascriptgjs/
    // The String-column is not visible and only used for storing the path to the pixbuf (no way of finding out later).

    // The Image-Grid:
    let image_grid = new Gtk.IconView({
        spacing: 2,
        columns: 3,
        expand: true,
        item_padding: 2,
        selection_mode: Gtk.SelectionMode.MULTIPLE,
        model: grid_model,
        reorderable: false,
        pixbuf_column: PIXBUF_COL,
        text_column: -1,
        markup_column: -1
    });

    // Set up DnD
    image_grid.drag_dest_set(Gtk.DestDefaults.ALL, null, Gdk.DragAction.COPY | Gdk.DragAction.MOVE | Gdk.DragAction.LINK);
    let target_list = Gtk.TargetList.new([]);
    target_list.add_uri_targets(0);
    image_grid.drag_dest_set_target_list(target_list);
    image_grid.connect('drag-data-received', function(widget, drag_context, x, y, data, info, time, user_data){
        let uris = data.get_uris();
        for (let i = 0; i < uris.length; i++) {
            let uri = uris [i];
            addURI(grid_model, uri);
        }
    });

    let grid_scroll = new Gtk.ScrolledWindow();
    grid_scroll.add(image_grid);
    frame.add(grid_scroll);


/*    grid_scroll.drag_dest_set(Gtk.DestDefaults.ALL, null, Gdk.DragAction.MOVE);
    grid_scroll.drag_dest_add_image_targets();*/


    // Fill the Model:
    let image_list = settings.getImageList();
    for (let i = 0; i < image_list.length; i++){
        addFileEntry(grid_model, image_list[i]);
    }
    // Pre-populate the list with default wallpapers:
    if (image_list.length <= 0){
        /*
            Just want to add, I have a bad feeling that this will not on every
            distribution be the directory where the "gnome-backgrounds"-package
            stores it's images...
            Anyways, if it's not, the search will gracefully die in peace.
         */
        addDirectory(grid_model, "/usr/share/backgrounds/gnome");
    }

    // Toolbar to the right:
    let toolbar = new Gtk.Box({
        orientation: Gtk.Orientation.VERTICAL
    });
    frame.add(toolbar);

    // Move the selected wallpaper up in the list.
    let move_up_button = new Gtk.Button({
        image: new Gtk.Image({
            icon_name: 'go-up',
            tooltip_text: _("Move selected Wallpapers up in the list.")
        })
    });
    move_up_button.connect('clicked', function(){
        let selection = image_grid.get_selected_items();
        for (let i = selection.length-1; i >= 0; i--){ // Order is backwards...
            let [success, iterator_current] = grid_model.get_iter(selection[i]);
            if (success){
                let iterator_up = iterator_current.copy();
                grid_model.iter_previous(iterator_current);
                grid_model.swap(iterator_current, iterator_up);
                // Manually fire the "row-changed"-event so "button_state_callback" gets triggered!
                grid_model.row_changed(selection[i], iterator_current);
            }
        }
    });
    toolbar.add(move_up_button);

    // Move the selected wallpaper down in the list.
    let move_down_button = new Gtk.Button({
        image: new Gtk.Image({
            icon_name: 'go-down',
            tooltip_text: _("Move selected Wallpapers down in the list.")
        }),
        margin_bottom: 4
    });
    move_down_button.connect('clicked', function(){
        let selection = image_grid.get_selected_items();
        for (let i = 0; i < selection.length; i++){
            let [success, iterator_current] = grid_model.get_iter(selection[i]);
            if (success){
                let iterator_down = iterator_current.copy();
                grid_model.iter_next(iterator_current);
                grid_model.swap(iterator_current, iterator_down);
                // Manually fire the "row-changed"-event so "button_state_callback" gets triggered!
                grid_model.row_changed(selection[i], iterator_current);
            }
        }
    });
    toolbar.add(move_down_button);

    // Add a Wallpaper to the list.
    let add_button = new Gtk.Button({
        image: new Gtk.Image({
            icon_name: 'list-add',
            tooltip_text: _("Add new Wallpapers")
        })
    });
    add_button.connect('clicked', function(){
        var filter = new Gtk.FileFilter();
        filter.add_pixbuf_formats();
        let chooser = new Gtk.FileChooserDialog({
            title: _("Select the new wallpapers."),
            action: Gtk.FileChooserAction.OPEN,
            filter: filter,
            select_multiple: true
        });
        chooser.add_button(Gtk.STOCK_CANCEL, 0);
        chooser.add_button(Gtk.STOCK_OPEN, 1);
        chooser.set_default_response(1);
        if (chooser.run() === 1){
            let files = chooser.get_filenames();
            // Add the selected files:
            for (let i = 0; i < files.length; i++){
                addPath(grid_model, files[i]);
            }
        }
        chooser.destroy();
    });
    toolbar.add(add_button);

    // Remove a Wallpaper from the list:
    let remove_button = new Gtk.Button({
        image: new Gtk.Image({
            icon_name: 'list-remove',
            tooltip_text: _("Remove selected Wallpapers")
        })
    });
    remove_button.connect('clicked', function(){
        let selection = image_grid.get_selected_items();
        for (let i = 0; i < selection.length; i++){
            let [success, iterator_current] = grid_model.get_iter(selection[i]);
            if (success){
                grid_model.remove(iterator_current);
            }
        }
    });
    toolbar.add(remove_button);

    // Check if we can move up/down and deactivate buttons if not.
    let button_state_callback = function(){
        // Check if we have data:
        if (grid_model.iter_n_children(null) <= 1){
            move_up_button.set_sensitive(false);
            move_down_button.set_sensitive(false);
            return;
        }
        // Otherwise, we have data:
        let selection = image_grid.get_selected_items();
        if (selection.length != 0){
            let [success, iterator] = grid_model.get_iter(selection[0]);
            if (success){
                // We have a selection and data:
                if (grid_model.iter_next(iterator.copy()) === false){
                    // We're at the bottom:
                    move_up_button.set_sensitive(true);
                    move_down_button.set_sensitive(false);
                } else if (grid_model.iter_previous(iterator.copy()) === false){
                    // We're at the top:
                    move_up_button.set_sensitive(false);
                    move_down_button.set_sensitive(true);
                } else {
                    // We're in the middle, can move up and down:
                    move_up_button.set_sensitive(true);
                    move_down_button.set_sensitive(true);
                }
            }
        }
    };
    image_grid.connect('selection-changed', button_state_callback);
    grid_model.connect('row-changed', button_state_callback);

    // Store the changes in the settings, when the window is closed or the settings change:
    // Workaround, see https://bugzilla.gnome.org/show_bug.cgi?id=687510
    frame.connect('screen_changed', function(widget){
        if (!ready) return;
        // Save the list:
        let [ success, iterator ] = grid_model.get_iter_first();
        let list = [];
        if (success){
            do {
                let img_path = grid_model.get_value(iterator, PATH_COL);
                list.push(img_path);
            } while (grid_model.iter_next(iterator));
        }
        settings.setImageList(list);
    });

    frame.show_all();
    return frame;
}
