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
const Main = imports.ui.main;
const Lang = imports.lang;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;
const St = imports.gi.St;
// Import own libs:
const Me = imports.misc.extensionUtils.getCurrentExtension();
const Widget = Me.imports.widgets;
const Wall = Me.imports.wallpaper;
const Pref = Me.imports.settings;
const Time = Me.imports.timer;
const Utils = Me.imports.utils;
// Import translation stuff
const Gettext = imports.gettext.domain('backslide');
const _ = Gettext.gettext;

/**
 * The new entry in the gnome3 status-area.
 * @type {Lang.Class}
 */
const BackSlideEntry = new Lang.Class({
    Name: 'BackSlideEntry',

    _init: function(){
        // Attach to status-area:
        this.button = new PanelMenu.Button(0.0, 'backslide');
        // Add the Icon
        this.button.show();
        this._iconBox = new St.BoxLayout();
        this._iconIndicator = new St.Icon({
            icon_name: 'emblem-photos-symbolic',
            style_class: 'system-status-icon'
        });
        this._iconBox.add(this._iconIndicator);
        this.button.add_actor(this._iconBox);
        this.button.add_style_class_name('panel-status-button');

        // Add the Widgets to the menu:
        this.button.menu.addMenuItem(new Widget.LabelWidget(_("Up Next")).item);
        let next_wallpaper = new Widget.NextWallpaperWidget();
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
        this.button.menu.addMenuItem(new Widget.OpenPrefsWidget(this.button.menu).item);

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

        settings.bindKey(Pref.KEY_DELAY, Lang.bind(this, function(value){
            var minutes = value.get_int32();
            if (Pref.valid_minutes(minutes)) {
                delay_slider.setMinutes(minutes);
            }
        }));
    }
});

/**
 * Called when the extension is first loaded (only once)
 */
function init() {
    Utils.initTranslations();
    wallpaper_control = new Wall.Wallpaper();
    settings = new Pref.Settings();
    timer = new Time.Timer();
}

let wallpaper_control;
let settings;
let timer;
let menu_entry;

/**
 * Called when the extension is activated (maybe multiple times)
 */
function enable() {
    menu_entry = new BackSlideEntry();
    Main.panel.addToStatusArea('backslide', menu_entry.button);
    timer.begin();
}

/**
 * Called when the extension is deactivated (maybe multiple times)
 */
function disable() {
    menu_entry.button.destroy();
    timer.stop();
}
