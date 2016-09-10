import QtQuick 2.7
import QtQuick.Controls 2.0
MouseArea {
    focus: true
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    property bool transing: true
    function onClickedReport(){
        cell._onClickedReport()
    }

    onClicked: function(e) {
        musicPlayer.switchTo('cj058.wav')
        if(ui.isShowEnemyOn === true){
            ui.enemyHide()
        }

        if(!transing){ return}
        // main
        if(isButtonRight(e.button))
            onGeneralButtonRightDown()
        else if(isButtonLeft(e.button))
            onGeneralButtonnLeftDown()
    }
    // key down
    Keys.onPressed: function(e){
        //test
        if(transing){
            console.log('Event.Keys.onPressed: e.key',e.key)
            actor.cur_x = actor.p_x; actor.cur_y = actor.p_y
            if(isLeft(e.key)){
                actor._moveLeft();cell.isHit()
            }else if(isRight(e.key)){
                actor._moveRight();cell.isHit()
            }else if(isUp(e.key)){
                actor._moveUp();cell.isHit()
            }else if(isDown(e.key)){
                actor._moveDown();cell.isHit()
            }else if(isGeneralEsc(e.key)){
                onGeneralEscDown();
            }else if(isGeneralE(e.key)){
                onGeneralEDown();
            }
            else
                console.log('***[Event] Keys.onPressed: detected unknown key:'+e.key)
        }else{
            if(isGeneralOk(e.key)){
                onGeneralOkDown(e.key)
            }
        }
    }

    // aux functions
    function isGeneralOk(key){
        return key===Qt.Key_Enter || key===Qt.Key_Return || key===Qt.Key_Space || key===Qt.LeftButton
    }
    function isGeneralEsc(key){
        return key===Qt.Key_Escape || key===Qt.RightButton
    }
    function isUp(key){
        return key===Qt.Key_Up || key===Qt.Key_W || key==='wheelUp'
    }
    function isDown(key){
        return key===Qt.Key_Down || key===Qt.Key_S || key==='wheelDown'
    }
    function isLeft(key){
        return key===Qt.Key_Left || key===Qt.Key_A
    }
    function isRight(key){
        return key===Qt.Key_Right || key===Qt.Key_D
    }
    function isGeneralE(key){
        return key===Qt.Key_E
    }
    function isButtonRight(key){
        return key===Qt.RightButton
    }
    function isButtonLeft(key){
        return key===Qt.LeftButton
    }


    function onGeneralOkDown(){
        talk.advlDown()
    }

    function onGeneralEDown(){
        var table = ["empty","wall","npc","npc2", "npc3","npc4","enemy","enemy2","enemy3","enemy4","enemy5","enemy6",
                "enemy7","enemy8","enemy9","enemy10","enemy11","enemy12","enemy13","enemy14","enemy15","enemy16","enemy17","enemy18","enemy19","enemy20"
                     ,"enemy21","enemy22","enemy23","enemy24","enemy25","enemy26","enemy27","enemy28","enemy29","enemy30","enemy31","enemy32"
                     ,"enemy33","enemy34","enemy35","enemy36","enemy37","enemy38","enemy39","enemy40","enemy41","enemy42","speWall","speWall2","speWall3"]
        for(var i = 0; i < table.length; i++){
            if(creatWhat === table[i]){
                musicPlayer.switchTo('cj003.wav')
                if( i != table.length - 1) creatWhat = table[i+1]
                else creatWhat = "empty"
                if(creatWhat === "npc") ui.showEditor()
                return
            }
        }
    }

    function onGeneralEscDown(){

    }
    function onGeneralButtonRightDown(){
        cell._onRightClicked()
        console.log("right button clicked")
    }
    function onGeneralButtonnLeftDown(){
        ui.doClicked(mouseX, mouseY)
    }


}
