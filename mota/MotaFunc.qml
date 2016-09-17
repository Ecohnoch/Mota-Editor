import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
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
        return 0
    }


    // assert
    function assert(cond, msg){
        if(cond) console.log("*** with ", msg)
        return
    }
    //something else
    function addProp(i){
        var addNum = [2, 4, 6, 8]
        if(i >= 56 && i <= 59){
            actor.force += addNum[i-56]
        }else{
            actor.defend += addNum[i-60]
        }
    }
    function changeWOrS(i){
        //64 65 66 67
        var addNum = [10, 20, 30, 40]
        if(i >= 64 && i <= 67){
            actor.force += addNum[i-64]
            actor.weapen = 'w'+(i-63)
        }else{
            actor.defend += addNum[i-68]
            actor.weapen = 's'+(i-68)
        }
        console.log("get new equip!!!")
    }

   /**********************TWO****************************************************/
   /*********************MAIN****************************************************/
   /******************FUNCTIONS**************************************************/

    //must be
    function creatCell( i, creatWhat){
        if(creatWhat === "empty"){     //empty road
            cell.changeIsWall(i, 0)
            console.log("empty")
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "wall"){   // normal wall
            cell.changeIsWall(i, 1)
            myWall.push(i)
            ui.upDataFlick2(i)
            console.log(myWall)
            return
        }
        else if(creatWhat === "npc"){    //  normal npc, can't disappear
            cell.changeIsWall(i, 2)
            myNpc[0].push(i)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "npc2"){   // spcial npc, will be road
            cell.changeIsWall(i, 3)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "npc3"){   //spcial npc, will be wall
            cell.changeIsWall(i, 4)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "npc4"){   //spcial npc, will be item1
            cell.changeIsWall(i, 5)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat.substring(0,5) ==="enemy"){    //enemy 1, normal ,cost 100 blood
            if(creatWhat.length === 5){ cell.changeIsWall(i, 6);ui.upDataFlick2(i)}
            else{
                var ii = parseInt(creatWhat.substring(5,creatWhat.length))
                cell.changeIsWall(i, ii+5)
                ui.upDataFlick2(i)
            }
            return
        }

        else if(creatWhat ==="speWall"){
            cell.changeIsWall(i, 51)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "speWall2"){
            cell.changeIsWall(i, 52)
            ui.upDataFlick2(i)
            return
        }
        else if(creatWhat === "speWall3"){
            cell.changeIsWall(i, 53)
            ui.upDataFlick2(i)
        }
        else if(creatWhat === "downStair"){
            cell.changeIsWall(i, 54)
            ui.upDataFlick2(i)
        }
        else if(creatWhat === "upStair"){
            cell.changeIsWall(i, 55)
            ui.upDataFlick2(i)
        }
        else if(creatWhat.substring(0,4) === "item"){
            var iii = parseInt(creatWhat.substring(4,creatWhat.length))
            cell.changeIsWall(i, 55+iii)
            ui.upDataFlick2(i)
        }
        else if(creatWhat.substring(0,5) === 'equip'){
            var iiii = parseInt(creatWhat.substring(5, creatWhat.length))
            cell.changeIsWall(i, 63+iii)
            ui.upDataFlick2(i)
        }
        else{
            for(var j = 1; j <= 50; j++){
                if(creatWhat === "enemy"+j ){
                    cell.changeIsWall(i, j+5)
                    ui.upDataFlick2(i)
                    return
                }
            }
            return
        }
    }
    //hit what
    function hitWhat(n,i){
        if(i === 0){
            music.switchToSe('cj070.wav')
        }

        else if(i === 1){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchToSe('cj081.wav')
            console.log("hit wall !!")
        }
        else if(i === 2){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchToSe('cj078.wav')
            deal.isMoney = true
            deal.dealsShow()
        }
        else if(i === 3){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchToSe('cj078.wav')
            deal.isMoney = false
            deal.dealsShow()
        }
        else if(i === 4){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchToSe('cj078.wav')
            cell.cellTalk(n)
            cell.changeIsWall(n, 0)
        }
        else if(i === 5){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchToSe('cj078.wav')
            cell.cellTalk(n)//wall.itemAt(i).startTalk()
            cell.changeIsWall(n, 1)//wall.itemAt(i).isWall = 1
        }
        else if(i >= 6 && i <= 50){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
            music.switchTo('zd02.mp3')
            fight.timeSet(i, n)
            cell.changeIsWall(n, 0)//wall.itemAt(i).isWall = 0
        }
        else if(i === 51){
            cell.changeIsWall(n, 0)//wall.itemAt(i).isWall = 0
        }
        else if(i === 52){
            actor.p_x = actor.cur_x; actor.p_y = actor.cur_y
        }
        else if(i === 53){
            actor.p_x = actor.p_x + 30
            cell.changeIsWall(n , 0)//wall.itemAt(i).isWall = 0
        }
        else if(i === 54){
            func.changeStairs(--level)
        }
        else if(i === 55){
            func.changeStairs(++level)
        }
        else if(i >= 56 && i <= 63){
            music.switchToSe('cj062.wav')
            func.addProp(i)
            cell.changeIsWall(n, 0)//wall.itemAt(i).isWall = 0
        }
        else if(i >= 64 && i <= 71){
            music.switchToSe('cj062.wav')
            func.changeWOrS(i)
            cell.changeIsWall(n, 0)//wall.itemAt(i).isWall = 0
        }
    }

    /***********************************************************************/
    /*******************************orders**********************************/
    /***********************************************************************/
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
        _editVolume(x)
        assert(x>1||x<0 , "volume only can be 0-1!")
        console.log("edit bgm volume to "+x)
    }
    function editSeVolume(x){
        musicPlayer.volume = x
        assert(x>1||x<0,  "volume only can be 0-1!")
        console.log("edit bgm volume to "+x)
    }
}
