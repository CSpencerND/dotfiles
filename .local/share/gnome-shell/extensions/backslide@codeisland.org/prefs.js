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

import Adw from 'gi://Adw';
import Gtk from 'gi://Gtk';
import GObject from 'gi://GObject';
import Gio from 'gi://Gio';
import GdkPixbuf from 'gi://GdkPixbuf';


import {ExtensionPreferences, gettext as _} from 'resource:///org/gnome/Shell/Extensions/js/extensions/prefs.js';
import * as Pref from './settings.js';

const IMAGE_REGEX = /^image\/\w+$/i;
const PIXBUF_COL = 0;
const PATH_COL = 1;


export default class BackslideExtensionPreferences extends ExtensionPreferences {

    fillPreferencesWindow(window) {
        this.settings = new Pref.Settings(this);
        this.ready = false;
        let page = new Adw.PreferencesPage({title: 'Backslide Settings'});
        let prefGroup = new Adw.PreferencesGroup({title: 'Select Images'});
        window.add(page);
        page.add(prefGroup);

        prefGroup.add(this.getPreferencesWidget());
        window.set_size_request(815, 600);
        window.connect('close-request', () => {
			this.saveToSettings();
            // cleaning up as requested in gnome review
            this.settings = null;
            this.grid_model = null;
        });
    }

    /**
     * Called to build a preferences widget.
     * @return object any type of GTK+ widget to be placed inside the prefs window.
     */
    getPreferencesWidget() {
        let frame = new Gtk.Box({
            orientation: Gtk.Orientation.HORIZONTAL
        });

        // The model for the tree:
        // See (and next page): http://scentric.net/tutorial/sec-treeviewcol-renderer.html
        let grid_model = new Gtk.ListStore();
        this.grid_model = grid_model;
        grid_model.set_column_types([GdkPixbuf.Pixbuf, GObject.TYPE_STRING]); // See http://blogs.gnome.org/danni/2012/03/29/gtk-liststores-and-clutter-listmodels-in-javascriptgjs/
        // The String-column is not visible and only used for storing the path to the pixbuf (no way of finding out later).

        // The Image-Grid:
        let image_grid = new Gtk.IconView({
            spacing: 2,
            columns: 3,
            hexpand: true,
            item_padding: 2,
            selection_mode: Gtk.SelectionMode.MULTIPLE,
            model: grid_model,
            reorderable: false,
            pixbuf_column: PIXBUF_COL,
            text_column: -1,
            markup_column: -1
        });

        // Set up DnD
        // image_grid.drag_dest_set(Gtk.DestDefaults.ALL, null, Gdk.DragAction.COPY | Gdk.DragAction.MOVE | Gdk.DragAction.LINK);
        // let target_list = Gtk.TargetList.new([]);
        // target_list.add_uri_targets(0);
        // image_grid.drag_dest_set_target_list(target_list);
        // image_grid.connect('drag-data-received', function(widget, drag_context, x, y, data, info, time, user_data){
        //     let uris = data.get_uris();
        //     for (let i = 0; i < uris.length; i++) {
        //         let uri = uris [i];
        //         this.addURI(uri);
        //     }
        // });

        frame.append(image_grid);


        /*    grid_scroll.drag_dest_set(Gtk.DestDefaults.ALL, null, Gdk.DragAction.MOVE);
            grid_scroll.drag_dest_add_image_targets();*/


        // Fill the Model:
        let image_list = this.settings.getImageList();
        for (let i = 0; i < image_list.length; i++){
            this.addFileEntry(image_list[i]);
        }
        // Pre-populate the list with default wallpapers:
        if (image_list.length <= 0){
            /*
                Just want to add, I have a bad feeling that this will not on every
                distribution be the directory where the "gnome-backgrounds"-package
                stores it's images...
                Anyways, if it's not, the search will gracefully die in peace.
             */
            this.addDirectory("/usr/share/backgrounds/gnome");
        }

        // Toolbar to the right:
        let toolbar = new Gtk.Box({
            orientation: Gtk.Orientation.VERTICAL
        });
        frame.append(toolbar);

        // Move the selected wallpaper up in the list.
        let move_up_button = new Gtk.Button({
            icon_name: 'go-up',
            tooltip_text: _("Move selected Wallpapers up in the list.")
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
        toolbar.append(move_up_button);

        // Move the selected wallpaper down in the list.
        let move_down_button = new Gtk.Button({
            icon_name: 'go-down',
            tooltip_text: _("Move selected Wallpapers down in the list."),
            'margin-bottom': 4
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
        toolbar.append(move_down_button);

        // Add a Wallpaper to the list.
        let add_button = new Gtk.Button({
            icon_name: 'list-add',
            tooltip_text: _("Add new Wallpapers")
        });
        // signal goes through gtk, this is not kept
        let self = this;
        add_button.connect('clicked', () => {
            var filter = new Gtk.FileFilter();
            filter.add_pixbuf_formats();
            let chooser = new Gtk.FileChooserDialog({
                title: _("Select the new wallpapers."),
                action: Gtk.FileChooserAction.OPEN,
                transient_for: frame.get_root(),
                filter: filter,
                select_multiple: true
            });
            chooser.add_button("_Cancel", 0);
            chooser.add_button("_Open", 1);
            chooser.set_default_response(1);
            chooser.connect('response', (_, response) => {
                try {
                    if (response === 1) {
                        let files = chooser.get_files();
                        // Add the selected files:
                        for (let i = 0; i < files.get_n_items(); i++) {
                            this.addPath(files.get_item(i).get_path());
                        }
                    }
                } catch (e) {
                    console.error(e);
                }
                chooser.destroy();
            });
            chooser.show();
        });
        toolbar.append(add_button);

        // Remove a Wallpaper from the list:
        let remove_button = new Gtk.Button({
            icon_name: 'list-remove',
            tooltip_text: _("Remove selected Wallpapers")
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
        toolbar.append(remove_button);

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
            if (selection.length !== 0){
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
        frame.connect('unrealize', (widget) => {
			this.saveToSettings();
        });

        return frame;
    }
    
    saveToSettings() {
		console.log(`unrealize, ready: ${this.ready}`);
        if (!this.ready) return;
        // Save the list:
        let [ success, iterator ] = this.grid_model.get_iter_first();
        let list = [];
        if (success){
            do {
                let img_path = this.grid_model.get_value(iterator, PATH_COL);
                list.push(img_path);
            } while (this.grid_model.iter_next(iterator));
        }
		console.log(`unrealize, setting ${list}`);
        this.settings.setImageList(list);
		console.log(`unrealize, done setting`);
		
	}


    addFileEntry(path){
        // Asynchronously load and scale the image from the given path:
        try {
            let file = Gio.file_new_for_path(path);
            let stream = file.read(null);
            /*
                We need to assign the new "space" in the grid outside, to keep the order
                of the list. Otherwise, we get the order in which the loading finishes...
            */
            let model = this.grid_model;
            let iterator = this.grid_model.append();
            // Load it Async:
            GdkPixbuf.Pixbuf.new_from_stream_at_scale_async(stream, 240, -1, true, null,
                (source, res) => {
                    // Get the loaded image:
                    let image = GdkPixbuf.Pixbuf.new_from_stream_finish(res);
                    if (image === undefined) return;
                    // Append to the list:
                    model.set(iterator, [PIXBUF_COL,PATH_COL], [image, path]);
                    // There is data in the list, we're ready to store if necessary:
                    this.ready = true;
                });
        } catch (e){
            // Image could not be loaded. Invalid path.
            /*
                It's okay to do nothing here, when the list is stored, the invalid image will not be
                stored with the rest, so it's practically gone.
            */
            console.warn(e);
        }
    }

    addDirectory(path){
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
                    this.addFileEntry(path + "/" + info.get_name());
                }
            } else if (info.get_file_type() == Gio.FileType.DIRECTORY && !info.get_is_hidden()){
                // Recursive search:
                this.addDirectory(path + "/" + info.get_name());
            }
        }
    }

    addGioFile(file){
        // Gather information:
        let type = file.query_file_type(Gio.FileQueryInfoFlags.NONE, null);
        // Check whether a directory or a file wasen:
        if (type == Gio.FileType.REGULAR){
            this.addFileEntry(file.get_path());
        } else if (type == Gio.FileType.DIRECTORY){
            this.addDirectory(file.get_path());
        }
    }

    addURI(uri){
        this.addGioFile(Gio.file_new_for_uri(uri));
    }

    addPath(path) {
        this.addGioFile(Gio.file_new_for_path(path));
    }
}
