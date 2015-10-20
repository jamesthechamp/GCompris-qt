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
   property string instruction: qsTr("Drag and Drop the planets to their respective position")
   property variant levels: [
       {
            "pixmapfile" : "images/stars.jpg",
            "type" : "SHAPE_BACKGROUND_IMAGE",
        },
      {
          "pixmapfile" : "images/Mercury.png",
          "x" : "0.2",
          "y" : "0.2",
          "height":"0.1",
          "width":"0.1",
          "toolTipText":"Mercury"
      },
      {
          "pixmapfile" : "images/vinus.png",
          "x" : "0.3",
          "y" : "0.3",
          "height":"0.11",
          "width":"0.11",
            "toolTipText":"Venus"
      },
      {
          "pixmapfile" : "images/earth.png",
          "x" : "0.4",
          "y" : "0.4",
          "height":"0.12",
          "width":"0.12",
            "toolTipText":"Earth"
      },
      {
          "pixmapfile" : "images/Mars.png",
          "x" : "0.5",
          "y" : "0.5",
          "height":"0.1",
          "width":"0.1",
            "toolTipText":"Mars"
       },
      {
          "pixmapfile" : "images/jupiter.png",
          "x" : "0.6",
          "y" : "0.6",
          "height":"0.2",
          "width":"0.2",
            "toolTipText":"Jupiter"
      },
      {
          "pixmapfile" : "images/planet-saturn.png",
          "x" : "0.7",
          "y" : "0.7",
          "height":"0.15",
          "width":"0.15",
            "toolTipText":"Saturn"
      },
      {
          "pixmapfile" : "images/uranus.png",
          "x" : "0.8",
          "y" : "0.8",
          "height":"0.13",
          "width":"0.13",
            "toolTipText":"Uranus"
      },
      {
          "pixmapfile" : "images/neptune.png",
          "x" : "0.9",
          "y" : "0.9",
          "height":"0.12",
          "width":"0.12",
            "toolTipText":"Neptune"
      }

   ]
}
