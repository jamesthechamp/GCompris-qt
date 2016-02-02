.pragma library
.import QtQuick 2.0 as Quick
.import GCompris 1.0 as GCompris //for ApplicationInfo
var items;
var currentLevel=0;
var totalSideImg=0;
var totalTopImg=0;
var totalLevelImg=0;
var totalDustBin=2;
var totalImgLeft=0;
var levelScore=0.0;
function start(items_){
    items=items_;
    currentLevel=0;
    initLevel()
}

function score(){
    totalImgLeft--;
    levelScore=1-(totalImgLeft/totalLevelImg);
    items.levelBar.value=levelScore
    if(levelScore==1){
        items.bonus.good("smiley");
    }
}

function initLevel(){
    items.levelBar.value=0.0;
    items.imgTopModel.clear();
    items.imgLeftModel.clear();
    items.imgRightModel.clear();
    items.recycleBinData.clear();
    items.bar.level=currentLevel+1;
    if(currentLevel==0){
        totalDustBin=2
        items.recycleBinData.append({"name":"burnable","burnable":0,"organic":-1,"recycle":-1})
        items.recycleBinData.append({"name":"non-burnable","burnable":1,"organic":-11,"recycle":-1})
    }
    if(currentLevel==1){
        totalDustBin=2
        items.recycleBinData.append({"name":"organic","organic":0,"burnable":-1,"recycle":-1})
        items.recycleBinData.append({"name":"inorganic","organic":1,"burnable":-1,"recycle":-11})
    }
    if(currentLevel==2){
        totalDustBin=3
        items.recycleBinData.append({"name":"recycle1","recycle":1,"organic":-1,"burnable":-1})
        items.recycleBinData.append({"name":"recycle2","recycle":2,"organic":-1,"burnable":-1})
        items.recycleBinData.append({"name":"recycle3","recycle":3,"organic":-1,"burnable":-1})
    }
    getLevelData();
}

function getLevelData(){
    var levelPic=getImage(currentLevel);
    var length=Math.floor(levelPic.length/4);
    totalLevelImg=levelPic.length
    totalImgLeft=levelPic.length
    totalSideImg=length
    totalTopImg=levelPic.length-length
    var j=0;
    for(var i=0;i<  length;i++){

        items.imgTopModel.append({
                                 "name":levelPic[j]["name"],
                                 "url":levelPic[j]["source"],
                                 "burnable":levelPic[j]["burnable"],
                                 "organic":levelPic[j]["organic"],
                                 "recycle":levelPic[j]["recycle"]
                                 });
        j++;
        items.imgRightModel.append({
                                 "name":levelPic[j]["name"],
                                 "url":levelPic[j]["source"],
                                 "burnable":levelPic[j]["burnable"],
                                 "organic":levelPic[j]["organic"],
                                 "recycle":levelPic[j]["recycle"]
                                   });
        j++;
        items.imgLeftModel.append({
                                 "name":levelPic[j]["name"],
                                 "url":levelPic[j]["source"],
                                 "burnable":levelPic[j]["burnable"],
                                 "organic":levelPic[j]["organic"],
                                 "recycle":levelPic[j]["recycle"]
                                 });
        j++;
    }
    for(i=j;i<=levelPic.length-1;i++){
        items.imgTopModel.append({
                                 "name":levelPic[i]["name"],
                                 "url":levelPic[i]["source"],
                                 "burnable":levelPic[j]["burnable"],
                                 "organic":levelPic[j]["organic"],
                                 "recycle":levelPic[j]["recycle"]
                                 });
    }
}

function nextLevel(){
    if((currentLevel)>=2)
        currentLevel=0
    else
        currentLevel++;
    initLevel();
}

function previousLevel(){
    if((currentLevel)>0){
        currentLevel--;
    initLevel();
    }
}
function stop(){
}

function getImage(level){
    var out=returnDataBase(level);
    return(out);
}

function returnDataBase(level){
    var dataBase=[{"name":"food","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/food.png","level":[1,1,0],"burnable":0,"organic":0,"recycle":0},
              {"name":"clothes","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/clothes.png","level":[1,1,0],"burnable":0,"organic":0,"recycle":0},
              {"name":"wastepaper","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/wastepaper.png","level":[1,1,1],"burnable":0,"organic":0,"recycle":0},
              {"name":"woodchip","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/woodchip.png","level":[1,1,0],"burnable":0,"organic":0,"recycle":0},
              {"name":"aluminiumfoil","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/aluminiumfoil.png","level":[1,1,0],"burnable":1,"organic":1,"recycle":0},
              {"name":"glass","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/glass.png","level":[0,1,1],"burnable":1,"organic":1,"recycle":1},
              {"name":"plastic","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/plastic.png","level":[1,1,1],"burnable":1,"organic":1,"recycle":0},
              {"name":"polystrene","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/polystrene.png","level":[1,1,0],"burnable":1,"organic":1,"recycle":0},
              {"name":"can","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/can.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":1},
              {"name":"glassbottle","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/glassbottle.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":1},
              {"name":"glassbottle","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/gglassbottle3.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":1},
              {"name":"cardboard","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/cardboard.png","level":[0,1,1],"burnable":0,"organic":0,recycle:2},
              {"name":"magazine","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/magazine.png","level":[0,1,1],"burnable":0,"organic":0,"recycle":2},
              {"name":"newspaper","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/newsletter.png","level":[0,1,1],"burnable":0,"organic":0,"recycle":2},
              {"name":"copypaper","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/copypaper.png","level":[0,1,1],"burnable":0,"organic":0,"recycle":2},
              {"name":"container","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/container.png","level":[0,1,1],"burnable":0,"organic":0,"recycle":2},
              {"name":"cables","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/cables.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":3},
              {"name":"drycell","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/drycell.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":3},
              {"name":"lamp","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/lamp.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":3},
              {"name":"candy","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/candy.png","level":[1,0,1],"burnable":1,"organic":1,"recycle":3},
              {"name":"fluorescent","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/fluorescent.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":3},
              {"name":"oncan","source":"qrc:/gcompris/src/activities/recyclebin/resource/img/oncan.png","level":[0,0,1],"burnable":1,"organic":1,"recycle":3}]
    var out=[];
    var i;
    for (i in dataBase){
        if(dataBase[i]["level"][level]==1)
           out.push(dataBase[i]);

        }

    return out
}
