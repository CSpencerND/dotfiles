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
// Import global libraries
//
const EXTENSION_UUID = 'backslide@codeisland.org';

import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';
import St from 'gi://St';

// Import own libs:
import {Extension, gettext as _} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Widget from './widgets.js';
import * as Wall from './wallpaper.js';
import * as Pref from './settings.js';
import * as Time from './timer.js';

let wallpaper_control;
let settings;
let timer;
let menu_entry;

export default class BackSlideExtension extends Extension {
    /*
     * Called when the extension is activated (maybe multiple times)
     */
    enable() {
        wallpaper_control = new Wall.Wallpaper(this);
        settings = new Pref.Settings(this);
        timer = new Time.Timer(this);
        menu_entry = new BackSlideEntry(this);
        Main.panel.addToStatusArea('backslide', menu_entry.button);
        timer.begin();
    }

    /**
     * Called when the extension is deactivated (maybe multiple times)
     */
    disable() {
        wallpaper_control = null;
        settings = null;
        timer.stop();
        timer = null;
        menu_entry.button.destroy();
        menu_entry = null;
    }
}


/**
 * The new entry in the gnome3 status-area.
 */
var BackSlideEntry = class BackSlideEntry {

    constructor(extension) {
        // Attach to status-area:
        this.button = new PanelMenu.Button(0.0, 'backslide');
        // Add the Icon
        this.button.show();
        this.button.add_child(new St.Icon({
            icon_name: 'emblem-photos-symbolic',
            style_class: 'system-status-icon'
        }));
        this.button.add_style_class_name('panel-status-button');

        // Add the Widgets to the menu:
        this.button.menu.addMenuItem(new Widget.LabelWidget(_("Up Next")).item);
        let next_wallpaper = new Widget.NextWallpaperWidget(extension);
        wallpaper_control.setPreviewCallback(function(path){
            try {
                next_wallpaper.setNextWallpaper(path);
            } catch (e){
                /*
                 The wallpaper could not be loaded (either not existent or not an image). Therefor,
                 remove particularly it from the image-list.
                */
                wallpaper_control.removeInvalidWallpapers(path);
            }
        });
        this.button.menu.addMenuItem(next_wallpaper.item);
        let control = new Widget.WallpaperControlWidget(function(){
            wallpaper_control.next();
            timer.restart();
        },function(state){
            if (state){
                timer.begin();
            } else {
                timer.stop();
            }
        },function(state){
            if (state === true){
                wallpaper_control.shuffle();
            } else {
                wallpaper_control.order();
            }
            // Also write the new setting:
            settings.setRandom(state);
        });
        control.setOrderState(settings.isRandom());
        this.button.menu.addMenuItem(control.item);
        this.button.menu.addMenuItem(new PopupMenu.PopupSeparatorMenuItem());

        let minutes = 0;
        let unit = _("minutes");
        if (settings.getDelay() > 60 ){
            minutes = Math.floor(settings.getDelay() / 60);
            unit = _("hours");
        } else {
            minutes = settings.getDelay();
        }
        let delay_slider_label = new Widget.LabelWidget(_("Delay (%d %s)").format(minutes, unit) );

        this.button.menu.addMenuItem(delay_slider_label.item);
        let delay_slider = new Widget.DelaySlider(settings.getDelay() );
        this.button.menu.addMenuItem(delay_slider.item);
        this.button.menu.addMenuItem(new Widget.OpenPrefsWidget(extension, this.button.menu).item);

        // React on control-interaction:
        timer.setCallback(function(){
            wallpaper_control.next();
        });

        // React on delay-change:
        let valueChanged = function(){
            let minutes = delay_slider.getMinutes();

            global.log('Extension Slider value-changed: returned minutes = ' + minutes);

            let label_text;
            if (minutes > 60){
                label_text = _("Delay (%d %s)").format(Math.floor(minutes / 60), _("hours"));
            } else {
                label_text = _("Delay (%d %s)").format(minutes, _("minutes"));
            }

            delay_slider_label.setText(label_text);

            settings.setDelay(minutes);
        };
        try {
          delay_slider.connect('value-changed', valueChanged);
        } catch(e) {
          delay_slider.connect('notify::value', valueChanged);
        }

        settings.bindKey(Pref.KEY_DELAY, (value) => {
            var minutes = value.get_int32();
            if (Pref.valid_minutes(minutes)) {
                delay_slider.setMinutes(minutes);
            }
        });
    }
}
