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
const GLib = imports.gi.GLib;
const Me = imports.misc.extensionUtils.getCurrentExtension();
const Pref = Me.imports.settings;
const Notify = Me.imports.notification;

const Gettext = imports.gettext.domain('backslide');
const _ = Gettext.gettext;

/**
 * This is where the list of wallpapers is maintained and the current
 *  wallpaper is set.
 * This also includes jumping to next/previous wallpaper.
 * All Wallpaper-functionality is bundled in this class.
 */
var Wallpaper = class Wallpaper {

    /**
     * Constructs a new class to do all the wallpaper-related work.
     * @private
     */
    constructor(){
        this._settings = new Pref.Settings();
        this._notify = new Notify.Notification();
        this._image_queue = [];
        this._is_random = false;
        this._preview_callback = null;
        // Catch changes happening in the config-tool and update the list
        this._settings.bindKey(Pref.KEY_IMAGE_LIST, () => {
            this._image_queue.length = 0; // Clear the array, see http://stackoverflow.com/a/1234337/717341
            this._loadQueue();
            this._removeDuplicate();
            this._triggerPreviewCallback();
        });
        this._is_random = this._settings.isRandom();
        // Load images:
        this._loadQueue();
        this._removeDuplicate();
    }

    /**
     * <p>Set the function to be called, when the next image changes (due to a
     *  call to next(), shuffle() or order() ).</p>
     * <p>Calling this method will also cause the callback-function to be called
     *  immediately!</p>
     * @param callback the function to be called when the switch is done.
     *  This function will be passed an argument with the path of the next
     *  wallpaper.
     */
    setPreviewCallback(callback){
        // Validate:
        if (callback === undefined || callback === null || typeof callback !== "function"){
            throw TypeError("'callback' should be a function!");
        }
        // Set the callback:
        this._preview_callback = callback;
        // Callback:
        this._triggerPreviewCallback();
    }

    /**
     * Load the image-list from the settings, populate the Stack and
     *  randomize it, if necessary.
     * @private
     */
    _loadQueue(){
        let list = this._settings.getImageList();
        // Add current if empty:
        if (list.length === 0){
            list.push( this._settings.getWallpaper() );
        }
        // Check if shuffle:
        if (this._is_random === true){
            this._fisherYates(list);
            // Check if last element in queue is same as first in list:
            if (this._image_queue.length > 1 && this._image_queue[this._image_queue.length-1] === list[0]){
                // Move duplicate to the end of the new list:
                let duplicate = list.shift();
                list.push(duplicate);
            }
        }
        // Append to queue:
        for (let i in list){
            this._image_queue.push(list[i]);
        }
    }

    /**
     * If the first item from the current image-queue matches the wallpaper which is
     *  currently set, the item will be removed from the list.
     * @private
     */
    _removeDuplicate(){
        // Check if it's only one image in the list:
        if (this._image_queue.length <= 1){
            return;
        }
        // Otherwise, remove is necessary:
        if (this._settings.getWallpaper() === this._image_queue[0]){
            this._image_queue.shift();
        }
    }

    /**
     * Checks whether a preview-callback exists and calls it with the next wallpaper.
     * @see #setPreviewCallback
     * @private
     */
    _triggerPreviewCallback(){
        if (this._preview_callback !== null){
            let next_wallpaper = this._image_queue[0];
            this._preview_callback(next_wallpaper);
        }
    }

    /**
     * Sorts the image-list for iterative access.
     */
    order(){
        this._is_random = false;
        this._image_queue.length = 0; // Clear the array, see http://stackoverflow.com/a/1234337/717341
        this._loadQueue();
        this._removeDuplicate();
        // Callback:
        this._triggerPreviewCallback();
    }

    /**
     * Shuffle the image-list for random access.
     */
    shuffle(){
        this._is_random = true;
        // Shuffle the current queue
        this._fisherYates(this._image_queue);
        // Callback:
        this._triggerPreviewCallback();
    }

    /**
     * Implementation of the "Fisher-Yates shuffle"-algorithm, taken from
     *  http://stackoverflow.com/q/2450954/717341
     * @param array the array to shuffle.
     * @return {Boolean} false if the arrays length is 0.
     * @private
     */
    _fisherYates(array) {
        var i = array.length, j, tempi, tempj;
        if ( i == 0 ) return false;
        while ( --i ) {
            j       = Math.floor( Math.random() * ( i + 1 ) );
            tempi   = array[i];
            tempj   = array[j];
            array[i] = tempj;
            array[j] = tempi;
        }
        return true;
    }

    /**
     * Slide to the next wallpaper in the list.
     */
    next(){
        // Check if there where any items left in the stack:
        if (this._image_queue.length <= 2){
            this._loadQueue(); // Load new wallpapers
        }
        let wallpaper = this._image_queue.shift();
        // Set the wallpaper:
        if (GLib.file_test(wallpaper, GLib.FileTest.EXISTS)){
            // The file exists, we're good to go.
            this._settings.setWallpaper(wallpaper);
            // Callback:
            this._triggerPreviewCallback();
        } else {
            // File is not found. Check the *whole* list for any non-existing files and remove them.
            this.removeInvalidWallpapers(); // This will trigger a reload of the whole list.
        }
    }

    /**
     * This function will remove any invalid wallpaper(s) (image not found).
     * If no 'path' is specified, the whole list is searched for invalid wallpapers
     *  which will be removed.
     * @param path [optional] the path to the one invalid wallpaper.
     */
    removeInvalidWallpapers(path){
        let list = this._settings.getImageList();
        let found = [];
        if (path === undefined || path === null || typeof path !== "string"){
            // No wallpaper specified, remove all invalid ones:
            for (let i in list){
                if (GLib.file_test(list[i], GLib.FileTest.EXISTS) === false){
                    // File does not exist, remove:
                    found.push(list[i]);
                    list.splice(i, 1);
                }
            }
        } else {
            // We have a specific wallpaper, remove it:
            for (var i in list){
                if (list[i] === path){
                    // remove the item
                    found.push(list[i]);
                    list.splice(i, 1);
                }
            }
        }
        // Check if we have changes:
        if (found.length !== 0){
            this._settings.setImageList(list);
            // Show Notification.
            let body = "";
            for (let i in found){
                body += "* "+found[i]+"\n";
            }
            this._notify.notify(
                "BackSlide Wallpaper Error",
                _("The following images where invalid (not found or not image-types) and have been removed:"),
                body
            );
        }
    }

}
