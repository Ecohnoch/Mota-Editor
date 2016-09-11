import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
import Mota.Config 1.0
Item {
    //APIs


    //init to do
    function changeStairs(i){
        myWall = json[i].myWall
        for(var ii = 0; ii < 4; ii++){
            myNpc[ii] = json[i].myNpc[ii+1]
        }
    }

    function init(index){
        var i,j
        //wall
        for(i = 0; i < myWall.length; i++){
            if(index === myWall[i]){
                return 1
            }
        }
        //npc
        for(i = 0; i < 4; i++){
            for(j = 0; j < myNpc[i].length; j++){
                if(index === myNpc[i][j]){
                    return i+2
                }
            }
        }


//        for(i = 0; i < myNpc[].length; i++){
//            if(index === myNpc.npc1[i]){
//                return 2
//            }
//        }
//        for(i = 0; i < myNpc.npc2.length; i++){
//            if(index === myNpc.npc2[i]){
//                return 3
//            }
//        }
//        for(i = 0; i < myNpc.npc3.length; i++){
//            if(index === myNpc.npc3[i]){
//                return 4
//            }
//        }
//        for(i = 0; i < myNpc.npc4.length; i++){
//            if(index === myNpc.npc4[i]){
//                return 5
//            }
//        }
        return 0
    }

    // assert
    function assert(cond, msg){
        if(cond) console.log("*** with ", msg)
        return
    }

    //  +
    function creat(s){
        creatWhat = s
        console.log("creat "+s)
    }
    function clear(){
        cell.clear()
        console.log("clear!")
    }
    function quit(){
        Qt.quit()
    }

    //  @
    function transfer(a, b){
        actor.p_x = 30*(a-1); actor.p_y = 30*(b-1)
        console.log(actor.p_x, actor.p_y)
        if(actor.p_x <= 30 || actor.p_x >= 570 || actor.p_y <= 30 || actor.p_y >= 570){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            console.log("***"+"transfer wrong!" )
        }
    }
    function fastFight(t){
        fight._timeSet(t*1000)
        assert(t<0.3||t>2, "t can only be 0.3 - 2")
        console.log("fast fight!!")
    }

    //  *
    function addNpcTalk(s){
        talk.myTalkData.push(s)
        console.log("add npc words!")
    }
    function editEnemyX(x, blo, force, def){
        fight.eblo[x-1] = blo
        fight.efor[x-1] = force
        fight.edef[x-1] = def
        console.log("edit enemy "+x+ "with",blo,force,def)
    }
    function editMe(blo, force, def){
        actor.blood = blo
        actor.force = force
        actor.defend = def
        console.log("edit me "+"with",blo, force, def)
    }
    function editBgmVolume(x){
        fight._editVolume(x)
        assert(x>1||x<0 , "volume only can be 0-1!")
        console.log("edit bgm volume to "+x)
    }
    function editSeVolume(x){
        musicPlayer.volume = x
        assert(x>1||x<0,  "volume only can be 0-1!")
        console.log("edit bgm volume to "+x)
    }

    //



}
