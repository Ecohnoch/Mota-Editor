import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
Item {
    x: 100
    Rectangle{
        id: editor
        x: -90; y:500
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
            x: 45; y: editor.height + 8
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
          x: editor.x; y: editor.y+5
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
              font.pixelSize: 12
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
          function clearText(){

          }
      }
    function addflick(){
        flick.addText()
    }

    function cancelflick(){
        talk.addData(flick.getText())
    }
    Image{
        id: logo
        source: "image/ui2.png"
        x: -100; y: 20
    }

    Label{
        width: 100; height: 40
        x: -90; y: 450
        text:"creat:"
        font.family: uiFont.name
        font.pointSize: 18
        Text{
            y:20
            text: creatWhat
            font.family: uiFont.name
            font.pointSize: 18
            color: "red"
        }
    }

    Image{
        id: uiBg
        source: "image/ui1.png"
        x: -100; y: 140
    }

    function doClicked(x, y){
        if(x >= editor.x+100 && x <= editor.x+editor.width+100 && y >=editor.y &&
                y<= editor.y+editor.height){
            addflick()
        }else if(x >= editor.x+5+100 && x <= editor.x+25+100 && y >= editor.y+25 &&
                y<= editor.y+45){
            cancelflick();editor.clicked()
            console.log("text input!!")
        }else{
            event.onClickedReport()
            console.log(x, y)
        }
    }
}
