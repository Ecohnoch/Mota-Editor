import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Rectangle{
    id: self
    color: "darkgray"
    // font for UI
    FontLoader {id: uiFont; source:'qrc:/font/PingFangM.ttf'}
    Text{
        id: fail
        anchors.centerIn: self
        text: 'fail!!'
        font.family: uiFont.name
        font.pixelSize: 40
    }
    property var bord: [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360, 390,
        420, 450, 480, 510, 540, 570]
    property var myWall: []
    property var myNpc: [[],[],[],[]]
    property var myEnemy: []
    property var myItem1: []
    property var level1:[]
    property string creatWhat: "wall"

    MotaFunc {
        id: func
    }
    MotaParser{
        id: parser
    }


    MotaCell{
        id: cell
    }

    MotaActor{
        id: actor
    }

    MotaFight{
        id: fight
    }

    MotaTalk{
        id: talk
    }

    MotaUI{
        id: ui
    }


    MotaEvent{
        id: event
    }


}
