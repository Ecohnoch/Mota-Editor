import QtQuick 2.7
import QtMultimedia 5.4

Item {
    Video{
        id: musicPlayer
        volume: 1
        property var myStarted
        property var myStopped
        autoPlay: false
        function _switchTo(path){
            musicPlayer.stop()
            musicPlayer.source = "bgm/"+path
            musicPlayer.play()
        }
    }
    Video{
        id: bgm
        volume: 0.7
        autoPlay: true
        source: "bgm/Balloon.mp3"
        onStopped: {bgm.play()}
        function _switchTo(path){
            bgm.stop()
            bgm.source = "bgm/"+path
            bgm.play()
        }
    }
    function switchTo(path){
        bgm._switchTo(path)
    }
    function switchToSe(path){
        musicPlayer._switchTo(path)
    }

    function _editVolume(x){
        bgm.volume = x
    }

}
