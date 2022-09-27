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
const MessageTray = imports.ui.messageTray;
const St = imports.gi.St;
const Main = imports.ui.main;

/**
 * A simple to use class for showing notifications.
 */
var Notification = class Notification {

    constructor(){
        this._source = new SimpleSource("BackSlide", "dialog-error");
    }

    /**
     * Issue a simple notification.
     * @param title the notification-title
     * @param banner_text the text for the banner
     * @param body the body-text (larger).
     */
    notify(title, banner_text, body){
        Main.messageTray.add(this._source.source);
        let notification = new MessageTray.Notification(this._source, title, banner_text,
            {
                body: body,
                bodyMarkup: true
            }
        );
        this._source.notify(notification);
    }
}

/**
 * A simple source-implementation for notifying new Notifications.
 */
var SimpleSource = class SimpleSource {

    /**
     * Create a new simple source for notifications.
     * @param title the title
     * @param icon_name the image to show with the notifications.
     * @private
     */
    constructor(title, icon_name){
        this.source = new MessageTray.Source(title, icon_name);
        this._icon_name = icon_name;
    }

    createNotificationIcon() {
        let iconBox = new St.Icon({
            icon_name: this._icon_name,
            icon_size: 48
        });
        if (St.IconType !== undefined){
            iconBox.icon_type = St.IconType.FULLCOLOR; // Backwards compatibility with 3.4
        }
        return iconBox;
    }

    open() {
        this.destroy();
    }
}
