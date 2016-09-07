import QtQuick 2.7
import QtQuick.Controls 2.0
MouseArea {
    focus: true
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    property bool transing: true

    onClicked:{
        self.cancelflick()
        onClickedReport()
    }
    function onClickedReport(){
        cell._onClickedReport()
    }


    // key down
    Keys.onPressed: function(e){
        if(transing){
            console.log('Event.Keys.onPressed: e.key',e.key)
            actor.cur_x = actor.p_x; actor.cur_y = actor.p_y
            if(isLeft(e.key)){
                actor._moveLeft();
            }else if(isRight(e.key)){
                actor._moveRight()
            }else if(isUp(e.key)){
                actor._moveUp()
            }else if(isDown(e.key)){
                actor._moveDown()
            }else if(isGeneralEsc(e.key)){
                onGeneralEscDown();
            }else if(isGeneralE(e.key)){
                onGeneralEDown();
            }
            else
                console.log('***[Event] Keys.onPressed: detected unknown key:'+e.key)
            cell.isHit()
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


    function onGeneralOkDown(){
        talk.advlDown()
        self.cancelflick()
    }

    function onGeneralEDown(){
        var table = ["wall", "npc", "npc2", "enemy"]
        for(var i = 0; i < table.length; i++){
            if(creatWhat === table[i]){
                if( i != table.length - 1) creatWhat = table[i+1]
                else creatWhat = "wall"
                return
            }
        }
    }

    function onGeneralEscDown(){

    }


}
