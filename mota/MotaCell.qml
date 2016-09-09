import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x: 100
    property var isWhat: ["wall","wall2","npc","npc2","npc3","npc4","enemy",  //6
        "npc5","enemy3","enemy4","enemy5","enemy6","enemy7","enemy8","enemy9","","","","","","","","","","","","","", //27
        "","","","","","","","","","","","","","","","","","","","","","","",
        "wall2"]
    Repeater{
        id: wall
        model: 400
        Rectangle{
            property int isWall
            isWall:{
                if(index%20 == 0|| index%20 ==19 ||index <= 20 || index >= 380) return 1 //must be
                else return 0
            }
            id: walls
            width: 30; height: 30
            x: bord[index%20]; y: bord[Math.floor(index/20)]
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
                }return
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
                    return
                }
                else if(creatWhat === "wall"){   // normal wall
                    wall.itemAt(i).isWall = 1
                    myWall.push(i)
                    console.log(myWall)
                    return
                }
                else if(creatWhat === "npc"){    //  normal npc, can't disappear
                    wall.itemAt(i).isWall = 2
                    myNpc[0].push(i)
                    console.log(myNpc)
                    return
                }
                else if(creatWhat === "npc2"){   // spcial npc, will be road
                    wall.itemAt(i).isWall = 3
                    myNpc[1].push(i)
                    console.log(myNpc)
                    return
                }
                else if(creatWhat === "npc3"){   //spcial npc, will be wall
                    wall.itemAt(i).isWall = 4
                    myNpc[2].push(i)
                    console.log(myNpc)
                    return
                }
                else if(creatWhat === "npc4"){   //spcial npc, will be item1
                    wall.itemAt(i).isWall = 5
                    myNpc[3].push(i)
                    console.log(myNpc)
                    return
                }
                else if(creatWhat ==="enemy"){    //enemy 1, normal ,cost 100 blood
                    wall.itemAt(i).isWall = 6
                    return
                }
                else if(creatWhat ==="speWall"){
                    wall.itemAt(i).isWall = 51
                    return
                }

                else{
                    for(var j = 1; j <= 50; j++){
                        if(creatWhat == "enemy"+j ){
                            wall.itemAt(i).isWall = j+5
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
