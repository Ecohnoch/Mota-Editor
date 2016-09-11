import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
import Mota.Config 1.0

Item {
    x: 100
    property var isWhat: ["wall/wall","wall/wall2","npc","npc2","npc3","npc4","enemy/enemy",  //6
        "enemy/enemy2","enemy/enemy3","enemy/enemy4","enemy/enemy5","enemy/enemy6","enemy/enemy7","enemy/enemy8","enemy/enemy9",
        "enemy/enemy10","enemy/enemy11","enemy/enemy12","enemy/enemy13","enemy/enemy14","enemy/enemy15","enemy/enemy16","enemy/enemy17",
        "enemy/enemy18","enemy/enemy19","enemy/enemy20","enemy/enemy21","enemy/enemy22", //27
        "enemy/enemy23","enemy/enemy24","enemy/enemy25","enemy/enemy26","enemy/enemy27","enemy/enemy28","enemy/enemy29","enemy/enemy30","enemy/enemy31",
        "enemy/enemy32","enemy/enemy33","enemy/enemy34","enemy/enemy35","enemy/enemy36",
        "enemy/enemy37","enemy/enemy38","enemy/enemy39","enemy/enemy40","enemy/enemy41","enemy/enemy42","enemy/enemy43","enemy/enemy44",
        "wall/wall2","wall/wall2","wall/wall3","wall/wall4"]
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
                source: "image/"+isWhat[walls.isWall]+".png"
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

    /************************************************************************/
    /********************Main*Function***************************************/
    /************************************************************************/
    /************************************************************************/
    function isHit(){
        console.log(actor.p_x, wall.itemAt(380).x)
        for(var i = 0; i < 400; i++){
            if(actor.p_x === wall.itemAt(i).x && actor.p_y === wall.itemAt(i).y){
                if(wall.itemAt(i).isWall === 0){
                    musicPlayer.switchTo('cj070.wav')
                }

                else if(wall.itemAt(i).isWall === 1){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    musicPlayer.switchTo(('cj081.wav'))
                    console.log("hit wall !!")
                }
                else if(wall.itemAt(i).isWall === 2){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    musicPlayer.switchTo('cj073.wav')
                    wall.itemAt(i).startTalk(2)
                }
                else if(wall.itemAt(i).isWall === 3){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    musicPlayer.switchTo('cj073.wav')
                    wall.itemAt(i).startTalk()
                    wall.itemAt(i).isWall = 0
                }
                else if(wall.itemAt(i).isWall === 4){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    musicPlayer.switchTo('cj073.wav')
                    wall.itemAt(i).startTalk()
                    wall.itemAt(i).isWall = 1
                }
                else if(wall.itemAt(i).isWall === 5){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    musicPlayer.switchTo('cj073.wav')
                    wall.itemAt(i).startTalk()
                    wall.itemAt(i).isWall = 51
                }
                else if(wall.itemAt(i).isWall >= 6 && wall.itemAt(i).isWall <= 50){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    fight.switchTo('zd02.mp3')
                    fight.timeSet(wall.itemAt(i).isWall, i)
                    wall.itemAt(i).isWall = 0
                }
                else if(wall.itemAt(i).isWall === 51){
                    wall.itemAt(i).isWall = 0
                }
                else if(wall.itemAt(i).isWall === 52){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    ui.showWc(true, wall.itemAt(i).x, wall.itemAt(i).y)
                }
                else if(wall.itemAt(i).isWall === 53){
                    actor.p_x = actor.p_x + 30
                    wall.itemAt(i).isWall = 0
                }

                return
            }
        }
    }

    /************************************************************************/
    /**********************CLicked**&**Creat*********************************/
    /************************************************************************/
    /************************************************************************/

    function _onClickedReport(){
        for(var i = 0; i < 400; i++){
            if(wall.itemAt(i).x<=event.mouseX-100 && wall.itemAt(i).x>=event.mouseX-100-30 && wall.itemAt(i).y
                    <= event.mouseY && wall.itemAt(i).y>= event.mouseY-30){
                if(creatWhat === "empty"){     //empty road
                    wall.itemAt(i).isWall = 0
                    console.log("empty")
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "wall"){   // normal wall
                    wall.itemAt(i).isWall = 1
                    myWall.push(i)
                    ui.upDataFlick2(i)
                    console.log(myWall)
                    return
                }
                else if(creatWhat === "npc"){    //  normal npc, can't disappear
                    wall.itemAt(i).isWall = 2
                    myNpc[0].push(i)
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "npc2"){   // spcial npc, will be road
                    wall.itemAt(i).isWall = 3
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "npc3"){   //spcial npc, will be wall
                    wall.itemAt(i).isWall = 4
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "npc4"){   //spcial npc, will be item1
                    wall.itemAt(i).isWall = 5
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat.substring(0,5) ==="enemy"){    //enemy 1, normal ,cost 100 blood
                    if(creatWhat.length === 5){ wall.itemAt(i).isWall = 6;ui.upDataFlick2(i)}
                    else{
                        var ii = parseInt(creatWhat.substring(5,creatWhat.length))
                        wall.itemAt(i).isWall = ii + 5
                        ui.upDataFlick2(i)
                    }
                    return
                }

                else if(creatWhat ==="speWall"){
                    wall.itemAt(i).isWall = 51
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "speWall2"){
                    wall.itemAt(i).isWall = 52
                    ui.upDataFlick2(i)
                    return
                }
                else if(creatWhat === "speWall3"){
                    wall.itemAt(i).isWall = 53
                    ui.upDataFlick2(i)
                }

                else{
                    for(var j = 1; j <= 50; j++){
                        if(creatWhat == "enemy"+j ){
                            wall.itemAt(i).isWall = j+5
                            ui.upDataFlick2(i)
                            return
                        }
                    }
                    return
                }
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
