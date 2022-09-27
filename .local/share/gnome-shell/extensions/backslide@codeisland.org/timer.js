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

/**
 * A simple interface for a timer which will call the given callback-function in
 *  intervals specified by the "delay"-setting.
 * <b>Documentation</b>
 * The JS standard functions "setTimeout()" and "setInterval()" don't seem to work, so
 *  we need to use the Mainloop-module. Documentation is hard to come by, here are some
 *  hints:
 * <ul>
 *     <li>
 *         Starting a new Timer/Interval:
 *         http://developer.gnome.org/glib/2.30/glib-The-Main-Event-Loop.html#g-timeout-add-seconds
 *     </li>
 *     <li>
 *         Cancelling a Timer/Interval:
 *         http://developer.gnome.org/glib/2.30/glib-The-Main-Event-Loop.html#g-source-remove
 *     </li>
 *     <li>
 *         Test-case from the Gjs Source, shows some of the syntax.
 *         http://git.gnome.org/browse/gjs/tree/test/js/testMainloop.js
 *     </li>
 * </ul>
 */
var Timer = class Timer {

    /**
     * Create a new timer (doesn't start it). To be usefull, you also need to specify a
     *  callback-function.
     * @see #setCallback
     * @private
     */
    constructor(){
        this._settings = new Pref.Settings();
        this._delay = this._settings.getDelay();
        this._elapsed_minutes = this._settings.getElapsedTime();
        // Listen to changes and restart with new delay.
        this._settings.bindKey(Pref.KEY_DELAY, (value) => {
            var minutes = value.get_int32();
            if (Pref.valid_minutes(minutes)){
                this._delay = minutes;
                this.restart();
            }
        });
    }

    /**
     * Set the callback-function for an exceeded delay.
     * @param callback the function to call when the delay has exceeded.
     */
    setCallback(callback){
        if (callback === undefined || callback === null || typeof callback !== "function"){
            throw TypeError("'callback' needs to be a function.");
        }
        this._callback = callback;
    }

    /**
     * Start or restart a new timer. The delay is taken from the settings. Calling this method
     *  will cause the current timer to be stopped, so repeated calls to this method don't have
     *  any effect. If no callback-function was set, this function will return without doing
     *  anything.
     * @see #setCallback
     */
    begin(){
        this.stop();
        this._start_timestamp = new Date();
        if (this._elapsed_minutes >= this._delay){
            /*
                Just defensive programming, the value could be manipulated
                See issue #12
            */
            this._elapsed_minutes = 0;
        }
        this._interval_id = GLib.timeout_add_seconds(
            GLib.PRIORITY_DEFAULT, (this._delay-this._elapsed_minutes)*60,
            this._callbackInternal.bind(this)
        );
    }

    /**
     * Stop the current timer. Repeated calls to this method don't have any effect.
     */
    stop(){
        if (this._interval_id !== null){
            if (GLib.source_remove(this._interval_id) ){
                this._interval_id = null;
                // Calculate elapsed time:
                let already = this._elapsed_minutes;
                let diff = Math.abs(new Date() - this._start_timestamp);
                this._elapsed_minutes = Math.floor((diff / 1000) / 60) + already;
                this._settings.setElapsedTime(this._elapsed_minutes);
            }
        }
    }

    /**
     * A convenient way to restart the timer.
     */
    restart(){
        this._start_timestamp = new Date();
        this._elapsed_minutes = 0; // Reset the elapsed minutes.
        this.stop();
        this.begin();
    }

    /**
     * The internal callback-function.
     * @private
     */
    _callbackInternal(){
        this._callback();
        this._start_timestamp = new Date(); // Reset the time-stamp, see issue12
        if (this._elapsed_minutes > 0){
            // The interval was started with a shortened delay. Restart it with the actual delay:
            this._elapsed_minutes = 0;
            this.begin();
            return false; // Don't restart the (shortened) interval.
        } else {
            // Was started with the un-shortened delay, continue looping.
            this._elapsed_minutes = 0;
            return true; // Keep on looping.
        }
    }
}
