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
const Gio = imports.gi.Gio;
const Me = imports.misc.extensionUtils.getCurrentExtension();

var KEY_DELAY = "delay";
var KEY_RANDOM = "random";
var KEY_IMAGE_LIST = "image-list";
var KEY_WALLPAPER = "picture-uri";
var KEY_WALLPAPER_DARK = "picture-uri-dark";
var KEY_ELAPSED_TIME = "elapsed-time";
var KEY_CHANGE_LOCKSCREEN = "change-lockscreen";

var DELAY_MINUTES_MIN = 1;
var DELAY_MINUTES_DEFAULT = 5;
var DELAY_HOURS_MAX = 48;
var DELAY_MINUTES_MAX = DELAY_HOURS_MAX * 60;

var valid_minutes = function(minutes) {
    return minutes >= DELAY_MINUTES_MIN && minutes <= DELAY_MINUTES_MAX;
}

/**
 * This class takes care of reading/writing the settings from/to the GSettings backend.
 */
var Settings = class Settings {

    static _schemaName = "org.gnome.shell.extensions.backslide";

    /**
     * Creates a new Settings-object to access the settings of this extension.
     * @private
     */
    constructor() {
        let schemaDir = Me.dir.get_child('schemas').get_path();

        let schemaSource = Gio.SettingsSchemaSource.new_from_directory(
            schemaDir, Gio.SettingsSchemaSource.get_default(), false
        );
        let schema = schemaSource.lookup(Settings._schemaName, false);

        this._setting = new Gio.Settings({
            settings_schema: schema
        });
        this._background_setting = new Gio.Settings({
            schema: "org.gnome.desktop.background"
        });
        this._screensaver_setting = new Gio.Settings({
            schema: "org.gnome.desktop.screensaver"
        });
        this.bindKey(KEY_DELAY, (value) => {
            var minutes = value.get_int32();
            if (!valid_minutes(minutes)) {
                this.setDelay(DELAY_MINUTES_DEFAULT);
            }
        });
    }

    /**
     * <p>Binds the given 'callback'-function to the "changed"-signal on the given
     *  key.</p>
     * <p>The 'callback'-function is passed an argument which holds the new
     *  value of 'key'. The argument is of type "GLib.Variant". Given that the
     *  receiver knows the internal type, use one of the get_XX()-methods to get
     *  it's actual value.</p>
     * @see http://www.roojs.com/seed/gir-1.2-gtk-3.0/gjs/GLib.Variant.html
     * @param key the key to watch for changes.
     * @param callback the callback-function to call.
     */
    bindKey(key, callback){
        // Validate:
        if (key === undefined || key === null || typeof key !== "string"){
            throw TypeError("The 'key' should be a string. Got: '"+key+"'");
        }
        if (callback === undefined || callback === null || typeof callback !== "function"){
            throw TypeError("'callback' needs to be a function. Got: "+callback);
        }
        // Bind:
        this._setting.connect("changed::"+key, function(source, key){
            callback( source.get_value(key) );
        });
    }

    /**
     * Get the delay (in minutes) between the wallpaper-changes.
     * @returns int the delay in minutes.
     */
    getDelay(){
        var minutes = this._setting.get_int(KEY_DELAY);
        if (!valid_minutes(minutes)) {
                this.setDelay(DELAY_MINUTES_DEFAULT);
                return DELAY_MINUTES_DEFAULT;
        }
        return minutes;
    }

    /**
     * Set the new delay in minutes.
     * @param delay the new delay (in minutes).
     * @throws TypeError if the given delay is not a number or less than 1
     */
    setDelay(delay){
        // Validate:
        if (delay === undefined || delay === null || typeof delay !== "number" || !valid_minutes(delay)){
            throw TypeError("delay should be a number, in range [" + DELAY_MINUTES_MIN + ", " + DELAY_MINUTES_MAX + "]. Got: "+delay);
        }
        // Set:
        let key = KEY_DELAY;
        if (this._setting.get_int(key) == delay) { return; }
        if (this._setting.is_writable(key)){
            if (this._setting.set_int(key, delay)){
                Gio.Settings.sync();
            } else {
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
    }

    /**
     * Whether the order of the image-list should be random.
     * @returns boolean true if random, false otherwise.
     */
    isRandom(){
        return this._setting.get_boolean(KEY_RANDOM);
    }

    /**
     * Specify, whether the order of the image-list should be random or not.
     * @param isRandom true if random, false otherwise.
     * @throws TypeError if "isRandom" is not a boolean value.
     */
    setRandom(isRandom){
        // validate:
        if (isRandom === undefined || isRandom === null || typeof isRandom !== "boolean"){
            throw TypeError("isRandom should be a boolean variable. Got: "+isRandom);
        }
        // Set:
        let key = KEY_RANDOM;
        if (this._setting.is_writable(key)){
            if (this._setting.set_boolean(key, isRandom)){
                Gio.Settings.sync();
            } else {
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
    }

    /**
     * The list path's to the wallpaper-files.
     * @returns array list of wallpaper path's.
     */
    getImageList(){
        return this._setting.get_strv(KEY_IMAGE_LIST);
    }

    /**
     * Set the list of wallpaper-path's.
     * @param list the new list (array) of image-path's.
     * @throws TypeError if 'list' is not an array.
     */
    setImageList(list){
        // Validate:
        let what = Object.prototype.toString; // See http://stackoverflow.com/questions/4775722
        if (list === undefined || list === null || what.call(list) !== "[object Array]"){
            throw TypeError("'list' should be an array. Got: "+list);
        }
        // Set:
        let key = KEY_IMAGE_LIST;
        if (this._setting.is_writable(key)){
            if (this._setting.set_strv(key, list)){
                Gio.Settings.sync();
            } else {
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
    }

    /**
     * Get the Unix-styled, absolute path to the currently set wallpaper-file.
     * @return string the Unix-styled, absolute path to the wallpaper-file.
     */
    getWallpaper(){
        let full = this._background_setting.get_string(KEY_WALLPAPER);
        return full.substring("file://".length); // Cut out the "file://"-stuff
    }

    /**
     * Set the new Wallpaper.
     * @param path an absolute, Unix style path to the image-file for the new Wallpaper.
     *  For example: "/home/user/image.jpg"
     * @throws string if there was a problem setting the new wallpaper.
     * @throws TypeError if the given path was invalid
     */
    setWallpaper(path){
        // Validate
        if (path === undefined || path === null || typeof path !== "string"){
            throw TypeError("path should be a valid, absolute, linux styled path. Got: '"+path+"'");
        }
        // Set:
        let key = KEY_WALLPAPER;
        if (this._background_setting.is_writable(key)){
            // Set a new Background-Image (should show up immediately):
            if (!this._background_setting.set_string(key, "file://"+path) ){
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
        if (this.getChangeLockscreen()){
            if (this._screensaver_setting.is_writable(key)){
                // Set a new Screensaver-Image:
                if (!this._screensaver_setting.set_string(key, "file://"+path) ){
                    throw this._errorSet(key);
                }
            } else {
                throw this._errorWritable(key);
            }
        }
        // Set for the dark mode (GNOME 42):
        key = KEY_WALLPAPER_DARK;
        if (this._background_setting.is_writable(key)){
            // Set a new Background-Image (should show up immediately):
            if (!this._background_setting.set_string(key, "file://"+path) ){
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
        key = KEY_WALLPAPER;
        if (this.getChangeLockscreen()){
            if (this._screensaver_setting.is_writable(key)){
                // Set a new Screensaver-Image:
                if (!this._screensaver_setting.set_string(key, "file://"+path) ){
                    throw this._errorSet(key);
                }
            } else {
                throw this._errorWritable(key);
            }
        }
        Gio.Settings.sync(); // Necessary: http://stackoverflow.com/questions/9985140
    }

    /**
     * Get the time (in minutes), which has already elapsed from the last set timeout-interval.
     * @return int the elapsed time in minutes.
     */
    getElapsedTime(){
        return this._setting.get_int(KEY_ELAPSED_TIME);
    }

    /**
     * Set the time (in minutes) which has elapsed from the last set timeout-interval.
     * @param time the time (in minutes) that has elapsed.
     * @throws TypeError if 'time' wasn't a number or less than 0.
     */
    setElapsedTime(time){
        // Validate:
        if (time === undefined || time === null || typeof time != "number" || time < 0){
            throw TypeError("'time' needs to be a number, greater than 0. Given: "+time);
        }
        // Write:
        if (this._setting.is_writable(KEY_ELAPSED_TIME)){
            if (this._setting.set_int(KEY_ELAPSED_TIME, time)){
                Gio.Settings.sync();
            } else {
                throw this._errorSet(key);
            }
        } else {
            throw this._errorWritable(key);
        }
    }

    getChangeLockscreen(){
        return this._setting.get_boolean(KEY_CHANGE_LOCKSCREEN);
    }
    _errorWritable(key){
        return "The key '"+key+"' is not writable.";
    }
    _errorSet(key){
        return "Couldn't set the key '"+key+"'";
    }
}
