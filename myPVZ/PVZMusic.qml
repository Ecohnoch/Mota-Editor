import QtQuick 2.7
import QtMultimedia 5.4

Video {
    property bool bgmSwith: false
    property bool seSwith: false

    id: bgm
    source: "res/audio/Faster.mp3"
    autoPlay: true
    onStopped: bgm.play()

    function switchTo(path){
        music.source = "res/audio/" + path
    }

    Video{
        id: se
        source:""
        autoPlay: false
    }
    function stopBgm(bool){
        if(bool) bgm.pause()
        else bgm.play()
    }
    function stopSe(bool){
        if(bool) se.volume = 0
        else se.volume = 1
    }
}
