import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x: 100

    Repeater{
        id: wall
        model: 400
        Rectangle{
            property int isWall
            isWall:{
                if(index%20 == 0|| index%20 ==19 ||index <= 20 || index >= 380) return 1
                else return 0
            }
            id: walls
            width: 20; height: 20
            x: bord[index%20]; y: bord[Math.floor(index/20)]
            Image{
                id: background
                source: {
                    if(walls.isWall === 1) return "image/wall2.png"
                    else if(walls.isWall === 2) return "image/npc.png"
                    else if(walls.isWall === 3) return "image/npc2.png"
                    else if(walls.isWall === 6) return "image/enemy.png"
                    else if(walls.isWall === 51) return "image/item2.png"
                    else if(walls.isWall === 0) return "image/wall.png"
                }
                // if on fight
                NumberAnimation on opacity{
                    id: cur1; duration: 500; to: 0.4; running:false
                    onStopped:{ cur2.restart()}
                }
                NumberAnimation on opacity{
                    id: cur2; duration: 300; to: 1; running: false
                    onStopped:{ cur3.restart()}
                }
                NumberAnimation on opacity{
                    id: cur3; duration: 300; to: 0; running: false
                    onStopped:{ bloodCost(walls.isWall); walls.isWall = 0; background.opacity = 1 }
                    function bloodCost(i){
                        if(i===6){
                            actor.blood = actor.blood - 100
                            actor.money = actor.money + 10
                            actor.exp = actor.exp + 10
                        }
                        if(actor.blood <= 0) { event.transing = false;
                            cell.visible = false; fight.visible = false}
                    }
                }
                //for fight
                function play(){
                    cur1.restart()
                }
            }

            function startTalk(){
                talk.advlUp()
            }

            function startFight(){
                background.play()
            }
            function startHave(){
                isWall = 0
            }
        }
    }
    //main function
    function isHit(){
        console.log(actor.p_x, wall.itemAt(380).x)
        for(var i = 0; i < 400; i++){
            if(actor.p_x === wall.itemAt(i).x && actor.p_y === wall.itemAt(i).y){
                if(wall.itemAt(i).isWall === 1){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    console.log("hit wall !!")
                }
                else if(wall.itemAt(i).isWall === 2){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    wall.itemAt(i).startTalk()
                }
                else if(wall.itemAt(i).isWall === 3){
                    wall.itemAt(i).startTalk()
                    wall.itemAt(i).isWall = 0
                }

                else if(wall.itemAt(i).isWall === 6){
                    actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
                    wall.itemAt(i).startFight()
                }else if(wall.itemAt(i).isWall === 51){
                    wall.itemAt(i).startHave()
                }return
            }
        }
    }

    function _onClickedReport(){
        for(var i = 0; i < 400; i++){
            if(wall.itemAt(i).x<=event.mouseX-100 && wall.itemAt(i).x>=event.mouseX-100-20 && wall.itemAt(i).y
                    <= event.mouseY && wall.itemAt(i).y>= event.mouseY-20){
                if(creatWhat === "wall"){
                    wall.itemAt(i).isWall = 1
                    myWall.push(i)
                    console.log(myWall)
                    return
                }
                else if(creatWhat === "npc"){
                    wall.itemAt(i).isWall = 2
                    myNpc.push(i)
                    console.log(myNpc)
                }
                else if(creatWhat === "npc2"){
                    wall.itemAt(i).isWall = 3
                    console.log(myNpc)
                }

                else if(creatWhat ==="enemy"){
                    wall.itemAt(i).isWall = 6
                    myEnemy.push(i)
                    console.log(myEnemy)
                }
                return
            }
        }
    }
}
