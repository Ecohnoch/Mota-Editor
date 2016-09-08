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
    property var bord: [0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260,
        280, 300, 320, 340, 360, 380]
    property var myWall: []
    property var myNpc: [[],[],[],[]]
    property var myEnemy: []
    property var myItem1: []
    property var level1:[]
    property string creatWhat: "wall"

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

    Rectangle{
        id: editor
        x: 2; y:356
        width: 100; height: 20
        color: "white"
        Rectangle{
            x: 5; y: editor.height + 5
            width: 20; height: 20
            color: "black"
        }

        Rectangle{
            x:10; y: editor.height + 10
            width: 10; height: 10
            color: "green"
        }
        Label{
            id: isSuc
            width: 60; height:10
            x: 60; y: editor.height + 5
            text: "added!"
            opacity: 0
        }

        NumberAnimation {
            id: fadeIn; target: isSuc
            property: "opacity"; running: false
            duration: 1000; to: 1
            onStopped: { fadeOut.restart()}
        }
        NumberAnimation {
            id: fadeOut; target: isSuc
            property: "opacity"; running: false
            duration: 1000; to: 0
        }

        function clicked(){
            fadeIn.restart()
        }
    }




    Flickable {
          id: flick
          visible: true
          x: 2; y: 360
          width: 100; height: 20;
          contentWidth: edit.paintedWidth
          contentHeight: edit.paintedHeight
          clip: true

          function ensureVisible(r)
          {
              if (contentX >= r.x)
                  contentX = r.x;
              else if (contentX+width <= r.x+r.width)
                  contentX = r.x+r.width-width;
              if (contentY >= r.y)
                  contentY = r.y;
              else if (contentY+height <= r.y+r.height)
                  contentY = r.y+r.height-height;
          }
          TextEdit {
              id: edit
              width: flick.width
              height: flick.height
              focus: false
              wrapMode: TextEdit.Wrap
              onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
          }
          function getText(){
              edit.enabled = false
              edit.focus = false; event.focus = true
              return edit.text
          }
          function addText(){
              edit.enabled = true
              edit.focus = true; event.focus = false
          }
      }
    function addflick(){
        flick.addText()
    }

    function cancelflick(){
        talk.addData(flick.getText())
    }

    MotaEvent{
        id: event
    }


}
