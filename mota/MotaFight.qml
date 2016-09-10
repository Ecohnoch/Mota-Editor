import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x: 100
    property var efor: [15, 20, 30,35,40,45,50,55,60,65]
    property var edef: [5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    property var eblo: [100, 200, 400, 500, 600, 700, 800, 900, 1000]

    AVPlayer{
        id: bgm
        volume: 1
        loops: Animation.Infinite
        autoLoad: true
        autoPlay: true
        source: "bgm/ScriabinPrelude.m4a"
        function _switchTo(path){
            bgm.stop()
            bgm.source = "bgm/"+path
            bgm.loops = Animation.Infinite
            bgm.play()
        }
    }
    function switchTo(path){
        bgm._switchTo(path)
    }
    function _editVolume(x){
        bgm.volume = x
    }


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
    function _timeSet(t){
        fightStart.interval = t
    }

    function timeSet(num,i){
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
        if(delBlood <= 0) {return }  //can't fight, play music keng~
        if(myDel <= 0) myDel = 0
        fightBg.visible = true
        event.transing = false
        fightBg.fightUI(realX)
        fightStart.times++
        actor.e_blood = actor.e_blood - delBlood
        actor.blood = actor.blood - myDel
        if(actor.blood <= 1000) musicPlayer.switchTo('gz_bgj.wav')
        else musicPlayer.switchTo('gz_gj.wav')

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
            switchTo('ScriabinPrelude.m4a')
            event.transing = true
            console.log("fight end!!!!")
        }
    }


}
