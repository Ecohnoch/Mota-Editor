import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtMultimedia 5.4
import Mota.Config 1.0

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
    property int level: 1
    property var json: Config.get()
    property var myWall: json[1].myWall
    property var myNpc: [json[1].myNpc[1],json[1].myNpc[2],json[1].myNpc[3],json[1].myNpc[4]]
    property var myEnemy: [json[1].myEnemy[1],[],[],[],[],[]]
    property var myItem: []
    property var level1:[]
    property string creatWhat: "wall"
    MotaMusic{
        id:music
    }

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

    MotaDeal{
        id: deal
    }

    MotaEvent{
        id: event
    }
    MotaUI{
        id: ui
    }

}
