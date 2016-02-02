/* GCompris - oware
 *
 * Copyright (C) 2014-2015 Holger Kaelberer <holger.k@elberer.de>
 *
 * Authors:
 *   Holger Kaelberer <holger.k@elberer.de>
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
import QtQuick 2.1
import QtQuick.Controls 1.4
import GCompris 1.0

import "../../core"
import "recyclebin.js" as Activity

ActivityBase {
    id: activity
    property string imagesUrl: boardsUrl+"img/"
    property string soundsUrl: boardsUrl
    property string boardsUrl: "qrc:/gcompris/src/activities/recyclebin/resource/"
    onStart:focus=true
    property var currentBurnableProperty
    property var currentOrganicProperty
    property var currentRecycleProperty
    onStop: {}

    pageComponent: Rectangle {
        id: root
        anchors.fill: parent
        signal start
        signal stop
        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        QtObject{
            id:items
            property Item main: activity.main
            property alias root: root
            property alias imgTopModel:imgTopModel
            property alias imgLeftModel: imgLeftModel
            property alias imgRightModel: imgRightModel
            property alias bar: bar
            property alias recyclebin: recyclebin
            property alias recycleBinData:recycleBinData
            property alias levelBar: levelBar
            property alias bonus:bonus
        }

        onStart: { Activity.start(items) }
        onStop: { Activity.stop() }

        DialogHelp {
            id: dialogHelp
            onClose: home()
        }

        Bar {
            id: bar
            content: BarEnumContent { value: help | home | level | reload }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onPreviousLevelClicked: Activity.previousLevel()
            onNextLevelClicked: Activity.nextLevel()
            onHomeClicked: activity.home()
            onReloadClicked: {
                Activity.initLevel()
            }
        }
        Bonus {
            id: bonus
            Component.onCompleted: win.connect(Activity.nextLevel)
        }
        Column {
            id:progressBar
            anchors{
                bottom:parent.bottom
                right:parent.right
                margins: 10*ApplicationInfo.ratio
            }

            ProgressBar {
                id:levelBar
                value:Activity.levelScore
            }
        }
        IntroMessage {
            id: message
            anchors {
                top: parent.top
                topMargin: 10*ApplicationInfo.ratio
                right: parent.right
                rightMargin: 5
                left: parent.left
                leftMargin: 5
            }
            z: 100
            onIntroDone: {

                info.visible = true
                sun_area.enabled = false
            }
            intro: [
                qsTr("waste are all around screen your task is to clean area"),
                qsTr("Drag and Drop the waste to their respective dustbin")
            ]
        }
        ListView {
            id: listView
            width: parent.width / 5
            height: parent.height*0.5
            anchors.top: listViewVert.bottom
            property int dragItemIndex: -1

            model:imgLeftModel
            delegate: Item {
                id: delegateItem
                width: listView.width
                height: listView.height/Activity.totalSideImg

                Rectangle {
                    id: dragRect
                    width: listView.width
                    height: listView.height/Activity.totalSideImg
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    border.color: Qt.darker(color)
                    Image{
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: dragRect
                        source:url

                    }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: dragRect
                        drag.target: dragRect

                        drag.onActiveChanged: {
                            if (mouseArea.drag.active) {
                                listView.dragItemIndex = index;
                                currentBurnableProperty=burnable;
                                currentOrganicProperty=organic;
                                currentRecycleProperty=recycle;
                            }
                            dragRect.Drag.drop();
                        }
                    }

                    states: [
                        State {
                            when: dragRect.Drag.active
                            ParentChange {
                                target: dragRect
                                parent: root
                            }

                            AnchorChanges {
                                target: dragRect
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]

                    Drag.active: mouseArea.drag.active
                    Drag.hotSpot.x: dragRect.width / 2
                    Drag.hotSpot.y: dragRect.height / 2
                }
            }
        }
        ListView {
            id: listViewRight
            width: parent.width / 5
            height: parent.height*0.5
            anchors.right:root.right
            anchors.top: listViewVert.bottom
            property int dragItemIndex: -1
            model:imgRightModel
            delegate: Item {
                id: delegateItem
                width: listViewRight.width
                height: listViewRight.height/Activity.totalSideImg

                Rectangle {
                    id: dragRect
                    width: listViewRight.width
                    height: listViewRight.height/Activity.totalSideImg
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    border.color: Qt.darker(color)
                    Image{
                        source:url
                        anchors.centerIn: dragRect
                        fillMode: Image.PreserveAspectFit
                    }
                    MouseArea {
                        id: mouseArea
                        anchors.fill: dragRect
                        drag.target: dragRect

                        drag.onActiveChanged: {
                            if (mouseArea.drag.active) {
                                listViewRight.dragItemIndex = index;
                                currentBurnableProperty=burnable;
                                currentOrganicProperty=organic;
                                currentRecycleProperty=recycle;
                            }
                            dragRect.Drag.drop();
                        }
                    }

                    states: [
                        State {
                            when: dragRect.Drag.active
                            ParentChange {
                                target: dragRect
                                parent: root
                            }

                            AnchorChanges {
                                target: dragRect
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]

                    Drag.active: mouseArea.drag.active
                    Drag.hotSpot.x: dragRect.width / 2
                    Drag.hotSpot.y: dragRect.height / 2
                }
            }
        }
        ListView {
            id: listViewVert
            width: parent.width*0.8
            height: parent.height/5
            clip: false
            anchors.horizontalCenter: root.horizontalCenter
            orientation: ListView.Horizontal
            property int dragItemIndex: -1
            model:imgTopModel
            delegate: Item {
                id: delegateItem
                width: root.width/Activity.totalTopImg
                height: listViewVert.height

                Rectangle {
                    id: dragRect
                    width:root.width/Activity.totalTopImg
                    height: listViewVert.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: "transparent"
                    border.color: Qt.darker(color)
                    Image{
                        fillMode: Image.PreserveAspectFit
                        source:url
                        anchors.centerIn: dragRect
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: dragRect
                        drag.target: dragRect

                        drag.onActiveChanged: {
                            if (mouseArea.drag.active) {
                                listViewVert.dragItemIndex = index;
                                currentBurnableProperty=burnable;
                                currentOrganicProperty=organic;
                                currentRecycleProperty=recycle;
                            }
                            dragRect.Drag.drop();
                        }
                    }

                    states: [
                        State {
                            when: dragRect.Drag.active
                            ParentChange {
                                target: dragRect
                                parent: root
                            }

                            AnchorChanges {
                                target: dragRect
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]

                    Drag.active: mouseArea.drag.active
                    Drag.hotSpot.x: dragRect.width / 2
                    Drag.hotSpot.y: dragRect.height / 2
                }
            }
        }

        ListView {
              id:recyclebin
              height:root.height*0.6
              width:root.width*0.6
              anchors.centerIn: parent
              spacing: 4
              clip: false
              model:recycleBinData
              orientation: ListView.Horizontal
              delegate:Component{
                      Image{
                         source:imagesUrl+"recyclebin.png"
                         height:recyclebin.height*0.9
                         width:recyclebin.width*(1/Activity.totalDustBin)*0.8
                         GCText{
                             anchors.centerIn: parent
                             text:name
                         }

                         MouseArea{
                             anchors.fill: parent
                             hoverEnabled: true
                             onEntered:{ parent.height=recyclebin.height }
                             onExited: {parent.height=recyclebin.height*0.8}
                         }
                         DropArea {
                             id: dropArea
                             anchors.fill: parent
                            onEntered: {parent.height=recyclebin.height}
                            onExited: {parent.height=recyclebin.height*0.8}
                             onDropped: {

                                 if(burnable==currentBurnableProperty || organic==currentOrganicProperty || recycle==currentRecycleProperty){
                                     drag.source.destroy()
                                     Activity.score()
                                     listView.dragItemIndex = -1;
                                 }
                             }
                         }
                     }
                }
            }


          ListModel{
              id:imgTopModel
          }
          ListModel{
              id:imgLeftModel
          }
          ListModel{
              id:imgRightModel
          }
          ListModel{
              id:recycleBinData
          }
     }
}
