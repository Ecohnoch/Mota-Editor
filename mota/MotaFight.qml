import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x: 100
    Image{
        id: fightBg
        visible: false
        width: 400; height: 400
        x: 100; y: 100
        source: "image/ui4.png"
        Image{
            id: fight1
            source:""
            width: 30; height: 30
            x: 20; y: 20
        }
        Image{
            id: fight2
            source: ""
            width: 30; height: 30
            x: 333; y: 20
        }
        function fightUI(x){
            fight1.source = "image/actor.png"
            fight2.source = "image/"+cell.isWhat[x+6]+".png"
            console.log(x)
        }
        Repeater{
            id: fight1repeater
            model: 3
            Text{
                x: 46; y:138+(index)*100
                text: actor.mainTable[index]
                font.family: "Arial"
                font.pixelSize: 22
                color: "red"
            }
        }
        Repeater{
            id: fight2repeater
            model: 3
            Text{
                x: 294 ;y: 138+(index)*100
                text: actor.e_table[index]
                font.family: "Arial"
                font.pixelSize: 22
                color: "red"
            }
        }
    }
/*
    Rectangle{
        id: fightBg
        visible: false
        color: "darkgrey"
        width: 400; height: 400
        x: 100; y: 100
        Label{
            id: fight1Name
            width: 60; height: 30
            x: fight1.x - 20; y: fight1.y + 40
            text: "shuai qi xiong"
            color: "steelblue"
            font.family: uiFont.name
            font.pointSize: 15
        }
        Repeater{
            id: fight1List
            property var name: ['b ', 'f ', 'd ']
            model: 3
            Text{
                width: 80; height: 200
                x: 5; y: 100 + 100*index
                text: fight1List.name[index] + actor.mainTable[index]
                font.family: uiFont.name
                font.pointSize: 20
            }
        }

        Image{
            id: fight2
            source: ""
            width: 30; height: 30
            x: vs.x + 150; y: 40
        }
        Label{
            id: fight2Name
            width: 60; height: 30
            x: fight2.x - 20; y: fight2.y + 40
            text: "yuan tian qi"
            color: "steelblue"
            font.family: uiFont.name
            font.pointSize: 15
        }
        Repeater{
            id: fight2List
            property var name: [' b', ' f', ' d']
            model: 3
            Text{
                width: 80; height: 200
                x: vs.x + 120; y: 100 + 100*index
                text: actor.e_table[index] + fight2List.name[index]
                font.family: uiFont.name
                font.pointSize: 20
            }
        }

        Label{
            id: vs
            text: "VS"
            color: "orange"
            width: 20; height: 20
            x: 190; y: 190
            font.family: uiFont.name
            font.pixelSize: 20
        }
        Label{
            id: fighting
            text: "Fighting!"
            color: "pink"
            width: 100; height: 20
            x: 160; y: 220
            font.family: uiFont.name
            font.pixelSize: 20
            opacity: 0
        }

        NumberAnimation {
            id: fadeIn; target: fighting; running: true
            property: "opacity"; duration: 1500; to: 1; onStopped:{fadeOut.restart()}
        }

        NumberAnimation {
            id: fadeOut; target: fighting; property: "opacity"
            duration: 1500; to: 0; running: false
        }
        function fightUI(x){
            fight1.source = "image/actor.png"
            fight2.source = "image/"+cell.isWhat[x+6]+".png"
            console.log(x)
        }
        function fadeStart(){
            fadeIn.restart()
        }
    }*/
    property var efor: [15, 20, 30]
    property var edef: [5, 6, 7]
    property var eblo: [100, 200, 400]

    Timer{
        id: fightStart
        interval: 1000
        running:false
        property int myNumber: 0
        property int myFight: 0
        onTriggered: {
              startFight(myNumber, myFight)
        }
        property int times: 0
    }

    function timeSet(num,i){
        fightBg.visible = true
        fightStart.myNumber = num
        fightStart.myFight = i
        fightStart.restart()
    }
    function startFight(x, i){
        var realX = x - 6
        var delBlood = actor.force - actor.e_defend
        var myDel = actor.e_force - actor.defend
        if(fightStart.times === 0){
            actor.e_force = efor[realX]; actor.e_defend = edef[realX]; actor.e_blood = eblo[realX]
        }
        if(actor.force <= actor.e_defend) {return }  //can't fight, play music keng~
        event.transing = false
        fightBg.fightUI(realX)
        fightStart.times++
        actor.e_blood = actor.e_blood - delBlood
        actor.blood = actor.blood - myDel

        if(actor.blood <= 0){
            event.transing = false; cell.visible = false; fight.visible = false
            return
        }
        else if(actor.e_blood>0){
            fightStart.restart()
        }
        else if(actor.e_blood <= 0){
            fightStart.times = 0
            fightStart.stop()
            fightBg.visible = false
            event.transing = true
            console.log("fight end!!!!")
        }
    }


}
