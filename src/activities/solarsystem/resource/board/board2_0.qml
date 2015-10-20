/* GCompris
 *
 * Copyright (C) 2015 Bruno Coudoin <bruno.coudoin@gcompris.net>
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   Pulkit Gupta <pulkitgenius@gmail.com> (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0

QtObject {
   property string instruction: qsTr("Drag and Drop the Dwarf planets to their respective position")
   property variant levels: [
        {
            "pixmapfile" : "images/stars.jpg",
            "type" : "SHAPE_BACKGROUND_IMAGE",
        },
        {
            "pixmapfile" : "images/ceres.png",
            "x" : "0.3",
            "y" : "0.3",
            "height":"0.15",
            "width":"0.15",
            "toolTipText":"Ceres"
        },
        {
            "pixmapfile" : "images/pluto.png",
            "x" : "0.6",
            "y" : "0.6",
            "height":"0.15",
            "width":"0.15",
            "toolTipText":"Pluto"
        },
        {
            "pixmapfile" : "images/eris.png",
            "x" : "0.9",
            "y" : "0.9",
            "height":"0.15",
            "width":"0.15",
            "toolTipText":"Eris"
        }
   ]
}
