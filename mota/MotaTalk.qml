import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x:100
    property var defaultTalkData:[
        "I Love you, will never betry you!",
        "who said I love you?",
        "No, it wont be you",
        "Plz dont say that",
        "you know nothing, yuan tianqi",
    ]

    property var myTalkData:[
        "I Love you, will never betry you!",
        "who said I love you?",
        "No, it wont be you",
        "Plz dont say that",
        "you know nothing, yuan tianqi",
    ]

    function addData(x){
        myTalkData.push(x)
    }

    Rectangle{
        id: advl
        visible: false
        width: 400; height: 60
        x:{
            if(actor.p_x <= 300 && actor.p_y <= 300) return actor.p_x+30
            else if(actor.p_x >= 300 && actor.p_y <= 300) return actor.p_x-170
            else if(actor.p_x <= 300 && actor.p_y >= 300) return actor.p_x-70
            else return actor.p_x - 170
        }
        y: {
            if(actor.p_x <= 300 && actor.p_y <= 300) return actor.p_y+30
            else if(actor.p_x >= 300 && actor.p_y <= 300) return actor.p_y
            else if(actor.p_x <= 300 && actor.p_y >= 300) return actor.p_y-70
            else return actor.p_y - 70
        }

        color: "darkgrey"
        opacity: 0.5
        Repeater{
            visible: advl.visible
            id: plusWhat
            Button{
                enabled: true
                width: 60; height: 30
                x: 50 + index * 50; y: 50
                Rectangle{
                    anchors.fill: parent
                    color:"black"
                }
            }
        }
        Label{
            property int sayWhat:1
            property int sayWhat2:0
            id: hisWords
            x: 20; y: 20
            text: defaultTalkData[sayWhat]
            font.family: uiFont.name
            font.pointSize: 18
            opacity: 0

            NumberAnimation on opacity{
               property var myStarted
               onStarted:{if(myStarted) myStarted()} id: fadeIn; to: 1; duration: 1500; running: false
            }
            NumberAnimation on opacity{
               property var myStopped
               id:fadeOut; to: 0; duration: 1000; running: false; onStopped:
               {if(myStopped) myStopped()}
            }
            function wordsOn(x){
                fadeIn.myStarted = function(){
                    event.transing = false
                    if(x === 2) hisWords.text = myTalkData[sayWhat2]
                    else hisWords.text = defaultTalkData[sayWhat]
                }
                fadeOut.myStopped = function(){
                    advl.visible = false; event.transing = true;
                    if(x === 2 && myTalkData[sayWhat2+1] ) sayWhat2++
                    else if(defaultTalkData[sayWhat+1]) sayWhat++
                }

                console.log("debug+"+sayWhat2+myTalkData[sayWhat2], myTalkData)
                fadeIn.restart()
            }
            function wordsDown(){
                fadeOut.restart()
            }
        }
        function _advlUp(x){
            advl.visible = true; hisWords.wordsOn(x)
        }
        function _advlDown(){
            hisWords.wordsDown()
        }
    }
    function advlUp(x){
        advl._advlUp(x)
    }
    function advlDown(){
        advl._advlDown()
    }
}
