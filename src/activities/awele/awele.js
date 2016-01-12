    /* GCompris - ActivityInfo.qml
 *
 * Copyright (C) 2015 shivanshbajaj <>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
.pragma library
.import QtQuick 2.1 as Quick

.import "engine.js" as Engine

var url="qrc:/gcompris/src/activities/awele/resource/"
var playerOnePoints=0;
var playerTwoPoints=0;
var items;
var stack=[];
var set=Engine.returnBoard();

function start(items_){
    items=items_;
    init();
}

function init(){
    playerOnePoints=0;
    playerTwoPoints=0;
    console.log("init");
    set=Engine.returnBoard()
    stack=[];
    updateValues();
}

function twoPlayer(move,player){
    Engine.nextPlayer=(player+2)%2;
    if(player){
        Engine.makeMoveComplete(6+move);
        console.log(Engine.scoreHouse);
    }
    else{
        Engine.makeMoveComplete(move);
        console.log(Engine.scoreHouse);
    }
}

function newAi(level,move,player){
//    console.log("in ailevel1",move,level);
//    Engine.makePlayerMove(move,undefined);
//    updateValues();
//    updateScores();
//    Engine.makeAiMove(level,undefined);
//    updateValues();
//    updateScores();
   // console.log(move,"move");

    var computerTurn=0;
    var computerHeuristic;
    Engine.makeMove(move,player);
    updateValues();
    updateScores();
    //console.log("move player",set);
    console.log("algo",set);
    computerHeuristic=Engine.makeAimove();
   // console.log("computer HEURISTIC",computerHeuristic);
    updateValues();
    updateScores();
}

function updateScores(){
//    playerOnePoints=Engine.scoringHouse(0,this)
//    playerTwoPoints=Engine.scoringHouse(1,this)
//    items.textOneSource.textSource="player one:<br />"+playerOnePoints
//    items.textTwoSource.textSource="player Two:<br />"+playerTwoPoints
//   // console.log(items.textOneSource.textSource,items.textTwoSource.textSource);
}

function updateValues(){
    var i,j;
    j=0;
    //set=[1,2,3,4,5,6,7,8,9,10,11,12]
    set=Engine.returnBoard()
    console.log(set);
//    for (i=0;i<12;i++){
////        items.repeator.itemAt(i).value=set[i];
////        items.repeator.itemAt(6+i).value=set[6+i];
//        if(i>=6){
//             items.repeator.itemAt(i).value=set[11-i];
//        }
//        else{
//            items.repeator.itemAt(i).value=set[i+6];
//        }
//    }
    for(i=11;i>5;i--){
        items.repeator.itemAt(j).value=set[i];
        j++;
    }
    console.log(j);
    for(i=0;i<6;i++){
        items.repeator.itemAt(j).value=set[i];
        j++;
    }
}

function getValueByIndex(index,player){

  // console.log("index",index,player);

    if(player){
        //console.log("less 6",set[index+5]);
        return (set[index]);
    }
    else{
        //        console.log("less 6",set[index%6]);
        return (set[index+6]);
    }
}

function getX(radius,index,value){
  //  console.log("value is",index,value);
    var step=(2*Math.PI)*index/value;
    return radius*Math.cos(step);
}

function getY(radius,index,value){
  //  console.log("value is",index,value);
    var step=(2*Math.PI)*index/value;
    return radius*Math.sin(step);
}
function swap(move,player){
    var count=move;
    var row=((player)?1:0);
    var temp=set[row][move];
    var i=row;
    set[row][count]=0;
   // console.log(set[row][count]);
    while(temp>0){
        if(i){
            if(count==5){
                i=0;
                set[i][count]++;
                if(set[i][count]==3 || set[i][count]==2)
                    stack.push([i,count]);
                else
                    stack=[];
                count--;
                if(temp>1){
                    set[i][count]++;
                    if(set[i][count]==3 || set[i][count]==2)
                        stack.push([i,count]);
                    else
                        stack=[];
                    temp--;
                }
            }
            else{
                set[i][count+1]++;
                if(set[i][count+1]==3 || set[i][count+1]==2)
                    stack.push([i,count+1]);
                    else
                        stack=[];
                    count++;
            }
        }
        else {
            if(count==0){
                i=1;
                set[i][count]++;
                if(set[i][count]==3 || set[i][count]==2)
                    stack.push([i,count]);
                else
                    stack=[];
                count++;
                if(temp>1){
                    set[i][count]++;
                    if(set[i][count]==3 || set[i][count]==2)
                        stack.push([i,count]);
                    else
                        stack=[];
                    temp--;
                }
            }
            else{
                set[i][count-1]++;
                if(set[i][count-1]==3 || set[i][count-1]==2)
                    stack.push([i,count-1]);
                else
                    stack=[];
                count--;
            }
        }
        console.log(set[0],set[1]);
        temp--;
    }
    var variable;
    if(stack!=[]){
        console.log("out",stack);
        for(var count=0;count<stack.length;count++){
            variable=stack[count];
             console.log("count",count,i,row,variable);
             if(row!=i){
                if(row){
                     playerOnePoints=playerOnePoints+set[variable[0]][variable[1]];
                    console.log("score1",playerOnePoints,variable[0],variable[1]);
                    set[variable[0]][variable[1]]=0;
                }
                else{
                     playerTwoPoints=playerTwoPoints+set[variable[0]][variable[1]];
                    console.log("score2",variable,playerOnePoints,variable[0],variable[1]);
                    set[variable[0]][variable[1]]=0;
                }
            }
        }
    }
}


