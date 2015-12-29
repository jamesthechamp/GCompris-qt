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

var INVALID_MOVE=-1;
var scoreHouse=[0,0];
var lastMove=0;

function isGameOver(board){
    var i;
    for (i = 0; i < 12; i++) {
        if (board[i])
            return false;
    }
    return true;
}

function makePlayerMove(move,board){
    /*
    if (!isValidMove()){
        console.log(false);
        return false;
    }*/
    console.log("in player",board,move);
    board=makeMove(0,move,board);
    return board;
}

function makeAiMove(depth,board){
    console.log("in ai");
    console.log("board")
    var heuristicValue;
    var move;
    [heuristicValue,move]=alphaBetaPrune(depth,-200,200,heuristicValue,board);
    console.log("value is",heuristicValue,move)
    board=makeMove(1,move,board);
    return board;
}

function alphaBetaPrune(depth,a,b,heuristicValue,board){
    console.log("in algo",depth,a,b,heuristicValue,board)
    if (depth == 0 || isGameOver(board)) {

        heuristicValue = heuristicEvaluation();
        console.log("<br /><br />leaf",heuristicValue);
        return [INVALID_MOVE,heuristicValue];
	}
    var childHeuristics;
    var bestMove;
    var row=0;
    var i;
    for (i=0;i<12;i++){
        console.log("board",board);
        var temp = makeMove(row,i,board);
        console.log("temp",temp);
        if(isValidMove(i,temp))
            continue;
        console.log("valid continue");
        [bestMove,childHeuristics]=alphaBetaPrune(depth-1,a,b,childHeuristics,temp);
        if(row){
            if(b > childHeuristics){
                b=childHeuristics;
                bestMove=lastMove;
            }
            if(a>=childHeuristics)
                break;
        }
        else{
            if(a < childHeuristics){
                a=childHeuristics;
                bestMove=lastMove;
            }
            if(b<=childHeuristics)
                break;
        }
    }
    console.log("row",row);
    heuristicValue=row ? b : a;
    console.log(bestMove,heuristicValue);
    return [bestMove,heuristicValue];
    
}

function makeMove(row,y,board){
    console.log("make Move",board);
    var barRow=(row+1)%2;
    var i=y;
    while(board[y]){
        i++;
        if(i>11){
            console.log("board11",board[11]);
            i=0;
        }
        console.log("i",i);
        if(i==y)
            i++;
        board[y]--;
        board[i]++;
    }
    var capture=[];
    if((board[i]==2 || board[i]==3)&&((barRow*6 <= i) && (i < (barRow*6 + 6))))
        capture[i%6] = true;
    while (capture[i%6] && i%6) {
        i--;
        if (board[i] == 2 || board[i] == 3)
            capture[i%6] = true;
    }
    var allSeedsCaptured = true;
    for (i = barRow*6; i < (barRow*6 + 6); i++) {
        if (!capture[i%6] && board[i])
            allSeedsCaptured = false;
    }
    if(allSeedsCaptured){
        for(i=barRow*6;i<(barRow*6+6);i++){
            if(capture[i%6]){
                scoreHouse[x]+=board[i];
                board[i]=0;
            }
        }
    }
    var playerSideEmpty=true;
    for(i=row*6;i<row*6+6;i++){
        if(board[i]){
            playerSideEmpty=false;
            break;
        }
    }

    if(playerSideEmpty){
        var oppenentCanGiveSeeds=false;
        for(i=barRow*6;i<(barRow*6+6);i++){
            if(board[i]>=(barRow+1)*6-i){
                oppenentCanGiveSeeds=true;
                break;
            }
        }
        if(oppenentCanGiveSeeds){
            for(i=barRow*6;i<(barRow*6+6);i++){
                scoreHouse[barRow]+=board[i];
                board[i]=0;
            }
        }

    }

    row=barRow;
    lastMove=y;
    console.log(lastMove,board);

    return board;
}

function scoringHouse(i){
    if(i==0 || i==1)
        return scoreHouse[i];
}

function isValidMove(i,set){
    console.log("ininvalid",i,set)
    if(set[i]==0)
        return false;
//    var i;
//    var sum=0;
    //for(i=0;i<6;i++){
      //  sum=sum+set[!x][i]
    //}
    //adding zero petleft
    return true;
}
function heuristicEvaluation(){
    var playerScore=[];
    var i;
    for(i=0;i<2;i++){
        playerScore[i]=scoreHouse[i];
        if(playerScore[i]>24){
            playerScore[i]+=100;
        }
    }
    return playerScore[0]-playerScore[1];
}
