import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x:100
    property var talkData: ['I Love you, will never betry you!',
        'who said I love you?',  'No, it wont be you','Plz dont say that',
        'you know nothing, yuan tianqi', 'I know everything, I am the..',
        'yes, if you are here', 'No, never do that!', 'you will be punished']

    function addData(x){
        talkData.push(x)
    }

    Rectangle{
        id: advl
        visible: false
        width: 400; height: 60
        x:{
            if(actor.p_x <= 200 && actor.p_y <= 200) return actor.p_x+20
            else if(actor.p_x >= 200 && actor.p_y <= 200) return actor.p_x-180
            else if(actor.p_x <= 200 && actor.p_y >= 200) return actor.p_x-80
            else return actor.p_x - 180
        }
        y: {
            if(actor.p_x <= 200 && actor.p_y <= 200) return actor.p_y+20
            else if(actor.p_x >= 200 && actor.p_y <= 200) return actor.p_y
            else if(actor.p_x <= 200 && actor.p_y >= 200) return actor.p_y-80
            else return actor.p_y - 80
        }

        color: "darkgrey"
        opacity: 0.5
        Label{
            property int sayWhat:0
            id: hisWords
            x: 20; y: 20
            text: talkData[sayWhat]
            font.family: uiFont.name
            font.pointSize: 11
            opacity: 0
            NumberAnimation on opacity{
               onStarted:{event.transing = false} id: fadeIn; to: 1; duration: 1500; running: false
            }
            NumberAnimation on opacity{
               id:fadeOut; to: 0; duration: 1000; running: false; onStopped:{ advl.visible = false; event.transing = true; hisWords.sayWhat++}
            }
            function wordsOn(){
                fadeIn.restart()
            }
            function wordsDown(){
                fadeOut.restart()
            }
        }

        Label{
            id: myWords
        }
        function _advlUp(){
            advl.visible = true; hisWords.wordsOn()
        }
        function _advlDown(){
            hisWords.wordsDown()
        }
    }
    function advlUp(){
        advl._advlUp()
    }
    function advlDown(){
        advl._advlDown()
    }
}
