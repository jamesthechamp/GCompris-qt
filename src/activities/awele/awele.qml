

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
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import GCompris 1.0

import "../../core"
import "."
import "awele.js" as Activity
import "engine.js" as Engine
ActivityBase{
    id: activity
    property bool player: true
    property string value: "4"
    onStart:focus=true
    onStop: {}

    pageComponent:Image{
        id: background
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: parent.width
        source: Activity.url + "/background.jpg"
        signal start
        signal stop

        Component.onCompleted: {
            activity.start.connect(start)
            activity.stop.connect(stop)
        }

        // Add here the QML items you need to access in javascript
        QtObject{
            id:items
            property Item main: activity.main
            property alias background: background
            property alias row: rowButton
            property alias textOneSource: playerOneText
            property alias textTwoSource: playerTwoText
            property alias repeator: repeator
        }

        onStart:{ Activity.start(items) }
        onStop: {Activity.stop()}

        Rectangle{
            id:playerOneScore
            width: parent.width*0.1
            height:parent.height*0.1
            border.color:"black"
            border.width: 2
            anchors {
                left: parent.left
                leftMargin:10*ApplicationInfo.ratio
                topMargin: 10*ApplicationInfo.ratio
                top:parent.top
            }
            radius:5
            color:"yellow"
            GCText {
                id:playerOneText
                color: "white"
                property var textSource: "player one:<br />"+Activity.playerOnePoints
                anchors.horizontalCenter: parent.horizontalCenter
                fontSize: smallSize
                text: textSource
                horizontalAlignment: Text.AlignHCenter
                wrapMode: TextEdit.WordWrap
            }
        }
        Rectangle{
            id:playerTwoScore
            width: parent.width*0.1
            height:parent.height*0.1
            border.color:"black"
            border.width: 2
            anchors {
                right: parent.right
                rightMargin:10*ApplicationInfo.ratio
                topMargin: 10*ApplicationInfo.ratio
                top:parent.top
            }
            radius:5
            color:"green"
            GCText {
                id: playerTwoText
                color: "white"
                property var textSource: "player Two:<br />"+Activity.playerTwoPoints
                anchors.horizontalCenter: parent.horizontalCenter
                fontSize: smallSize
                text: textSource
                horizontalAlignment: Text.AlignHCenter
                wrapMode: TextEdit.WordWrap
            }
        }

        Rectangle{
            id:turnBox
            width: parent.width*0.1
            height:parent.height*0.1
            border.color:"black"
            border.width: 2
            property var playerTurn:{((player)?"One":"Two")}

            anchors {
                horizontalCenter: parent.horizontalCenter
                topMargin: 10*ApplicationInfo.ratio
                top:parent.top
            }
            radius:5
            color:"#130000"
            GCText {
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                fontSize: smallSize
                text: "player<br />"+parent.playerTurn+" turn"
                horizontalAlignment: Text.AlignHCenter
                wrapMode: TextEdit.WordWrap
            }
        }

        Image {
            id: board
            source: Activity.url + "/awele_board.png"
            anchors.centerIn: parent
            width:parent.width*0.6
            height: parent.height*0.5
       }

        Grid {
            id:boardGrid
            columns:6
            rows:2
            spacing: 15
            anchors {
                centerIn: board
                top : board.top
                topMargin: 5
                margins: 5
            }

            Repeater{
                id:repeator
                model:12
                    Rectangle {
                        color: "transparent"
                        height: board.height*0.4
                        width: board.width*(1/7)
                        radius: width*0.6
                        property var value: Activity.getValueByIndex(index)

                        Text{
                            text:value
                            color: "white"
                            font.bold: true
                            font.family: "Helvetica"
                            font.pixelSize:24
                            anchors.centerIn: parent
                        }
                        Repeater {
                            model: value
                            anchors.fill: parent
                            anchors.centerIn: parent
                            property var angle:Activity.getAngle(index,value)
                            Image {
                                source: Activity.url+"graine1.png"
                                x:Activity.getX(sourceSize.height,index,value)
                                y:Activity.getY(sourceSize.height,index,value)
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                    console.log("value and index",parent.parent.x,parent.parent.y,value,index)
                                    }
                                }
                            }
                        }
                     }
                 }
            }

        Row {
            id:rowButton
            spacing: 40*ApplicationInfo.ratio
            width: board.width*0.6
            anchors {
                top: board.bottom
                horizontalCenter: board.horizontalCenter
            }
            Repeater {
                    id:rowButtonRepeator
                    model:6
                    Image {
                       property var sourceString: Activity.url + "bouton"+(index+1)+".png"
                       source: sourceString
                       MouseArea {
                           anchors.fill:parent
                           onClicked:{
                               console.log("value",player,Activity.getValueByIndex(index,player),index);
                               var level=1;
                               Activity.newAi(level,index);
//                                if(Activity.getValueByIndex(index)!=0){
//                                   Activity.swap(index,player);
//                                   player=!player;
//                                   sourceString=Activity.url + "bouton"+(index+1)+"_clic.png";
//                                }
//                                else{
//                                    console.log("click 0",player,index);
//                                }
                                Activity.updateValues();
                                Activity.updateScores();
                                sourceString: Activity.url + "bouton"+(index+1)+".png"
                           }

                       }
                    }
               }
          }
        Bar {
            id: bar
            content: BarEnumContent { value: help | home }
            onHelpClicked: {
                displayDialog(dialogHelp)
            }
            onHomeClicked: activity.home()
        }
    }
}
