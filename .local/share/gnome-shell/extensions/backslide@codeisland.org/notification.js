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

import St from 'gi://St';
import * as MessageTray from 'resource:///org/gnome/shell/ui/messageTray.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';

/**
 * A simple to use class for showing notifications.
 */
export class Notification {

    /**
     * Issue a simple notification.
     * @param title the notification-title
     * @param body the notification text.
     */
    notify(title, body){

        const source = MessageTray.getSystemSource();
        const notification = new MessageTray.Notification({
            source,
            title: title,
            body: body,
            bodyMarkup: true
        });
        notification.setIconName("dialog-error");
        source.addNotification(notification);
    }
}