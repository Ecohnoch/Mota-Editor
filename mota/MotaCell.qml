import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import Mota.Config 1.0

Item {
    x: 100
    property var isWhat: ["wall/wall","wall/wall2","actors/moneyNpc","actors/moneyNpc","actors/npc","actors/npc","enemy/enemy",  //6
        "enemy/enemy2","enemy/enemy3","enemy/enemy4","enemy/enemy5","enemy/enemy6","enemy/enemy7","enemy/enemy8","enemy/enemy9",
        "enemy/enemy10","enemy/enemy11","enemy/enemy12","enemy/enemy13","enemy/enemy14","enemy/enemy15","enemy/enemy16","enemy/enemy17",
        "enemy/enemy18","enemy/enemy19","enemy/enemy20","enemy/enemy21","enemy/enemy22", //27
        "enemy/enemy23","enemy/enemy24","enemy/enemy25","enemy/enemy26","enemy/enemy27","enemy/enemy28","enemy/enemy29","enemy/enemy30","enemy/enemy31",
        "enemy/enemy32","enemy/enemy33","enemy/enemy34","enemy/enemy35","enemy/enemy36",
        "enemy/enemy37","enemy/enemy38","enemy/enemy39","enemy/enemy40","enemy/enemy41","enemy/enemy42","enemy/enemy43","enemy/enemy44",
        "wall/wall2","wall/wall2","wall/wall3","wall/wall4",//54
        "special/down_floor","special/up_floor",  //54 55
        "item/blo1","item/blo2","item/blo3","item/blo4","item/def1","item/def2","item/def3","item/def4",
        "item/w1","item/w2","item/w3","item/w4","item/s1","item/s2","item/s3","item/s4" //71
    ]
    Repeater{
        id: wall
        model: 400
        Rectangle{
            property int isWall
            isWall:initMap(index)
            function initMap(index){
                if(index%20 == 0|| index%20 ==19 ||index <= 20 || index >= 380) return 1 //must be
                else{
                    return func.init(index)
                }
            }

            id: walls
            width: 30; height: 30
            x: bord[index%20]; y: bord[Math.floor(index/20)]
            Image{
                id: realBackgroud
                source: "image/wall/wall.png"
            }
            Image{
                id: background
                source: "image/"+isWhat[isWall]+".png"
            }

            function startTalk(x){
                talk.advlUp(x)
            }

            function startHave(){
                isWall = 0
            }
        }
    }

    //some func
    function clear(){
        for(var i = 0; i < 400; i++){
            if(!(i%20 == 0|| i%20 ==19 ||i <= 20 || i >= 380)){
                wall.itemAt(i).isWall = 0
                myWall.pop()
            }
        }
        console.log("clear!!")
    }
    function cellTalk(i){
        wall.itemAt(i).startTalk()
    }

    /************************************************************************/
    /********************Main*Function***************************************/
    /************************************************************************/
    /************************************************************************/
    function isHit(){
        console.log(actor.p_x, wall.itemAt(380).x)
        for(var i = 0; i < 400; i++){
            if(actor.p_x === wall.itemAt(i).x && actor.p_y === wall.itemAt(i).y){
                func.hitWhat(i, wall.itemAt(i).isWall)
                return
            }
        }
    }

    /************************************************************************/
    /**********************CLicked**&**Creat*********************************/
    /************************************************************************/
    /************************************************************************/

    function changeIsWall(i,newNum){
        wall.itemAt(i).isWall = newNum
    }

    function _onClickedReport(){
        for(var i = 0; i < 400; i++){
            if(wall.itemAt(i).x<=event.mouseX-100 && wall.itemAt(i).x>=event.mouseX-100-30 && wall.itemAt(i).y
                    <= event.mouseY && wall.itemAt(i).y>= event.mouseY-30){
                func.creatCell(i, creatWhat)
            }
        }
    }
    function _onRightClicked(){
        for(var i = 0; i < 400; i++){
            if(wall.itemAt(i).x<=event.mouseX-100 && wall.itemAt(i).x>=event.mouseX-100-30 && wall.itemAt(i).y
                    <= event.mouseY && wall.itemAt(i).y>= event.mouseY-30){
                if(wall.itemAt(i).isWall >= 6 && wall.itemAt(i).isWall <= 50){
                    actor.e_blood = fight.eblo[wall.itemAt(i).isWall-6]
                    actor.e_defend = fight.edef[wall.itemAt(i).isWall-6]
                    actor.e_force = fight.efor[wall.itemAt(i).isWall-6]
                    actor.e_name = fight.ename[wall.itemAt(i).isWall-6]
                    ui.enemyShow(event.mouseX, event.mouseY)
                }
                else return
                return
            }
        }
    }
    function checkIsOverFlow(table){
        if(table.length === 400){
            console.log( "stack over flow")
            // to do, fuck the repeat
        }
    }
}
