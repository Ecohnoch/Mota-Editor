import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
Item {
    x: 100
    // wc
    SpriteSequence{
        id: wc1
        interpolate: false
        visible: false
        // sprites
        sprites:[
            Sprite{
                name: 'still'
                source: 'image/wall/wall3.png'
                frameCount: 1
                frameWidth: 30
                frameHeight: 30
                frameDuration: 1000
                to: {'turn': 1}
            },
            Sprite{
                name: 'turn'
                source: 'image/wall/wall3.png'
                frameX: 30
                frameCount: 1
                frameDuration: 100
                to: {'turn2': 1}
            },
            Sprite{
                name: 'turn2'
                source: 'image/wall/wall3.png'
                frameX: 60
                frameCount: 1
                frameDuration: 100
                to: {'turn3': 1}
            },
            Sprite{
                name: 'turn3'
                source: 'image/wall/wall3.png'
                frameX: 0
                frameY: 30
                frameCount: 1
                frameDuration: 100
                to: {'turn4': 1}
            },
            Sprite{
                name: 'turn4'
                source: 'image/wall/wall3.png'
                frameX: 30
                frameY: 30
                frameCount: 1
                frameDuration: 100
                to: {'turn5': 1}
            },
            Sprite{
                name: 'turn5'
                source: 'image/wall/wall3.png'
                frameX: 60
                frameY: 30
                frameCount: 1
                frameDuration: 100
                to: {'still': 1}
            },
            Sprite{
                name: 'turn6'
                source: 'image/wall/wall3.png'
                frameX: 0
                frameY: 60
                frameCount: 1
                frameDuration: 100
                to: {'turn7': 1}
            },
            Sprite{
                name: 'turn7'
                source: 'image/wall/wall3.png'
                frameX: 30
                frameY: 60
                frameCount: 1
                frameDuration: 100
                to: {'turn8': 1}
            },
            Sprite{
                name: 'turn8'
                source: 'image/wall/wall3.png'
                frameX: 60
                frameY: 60
                frameCount: 1
                frameDuration: 100
                to: {'turn9': 1}
            },
            Sprite{
                name: 'turn9'
                source: 'image/wall/wall3.png'
                frameX: 0
                frameY: 90
                frameCount: 1
                frameDuration: 100
                to: {'turn10': 1}
            },
            Sprite{
                name: 'turn10'
                source: 'image/wall/wall3.png'
                frameX: 30
                frameY: 90
                frameCount: 1
                frameDuration: 100
                to: {'turn11': 1}
            },
            Sprite{
                name: 'turn11'
                source: 'image/wall/wall3.png'
                frameX: 60
                frameY: 90
                frameCount: 1
                frameDuration: 100
            }
        ]
    }// end of wc1
    function showWc(show,x,y){
        if(show){
            console.log("wc shows!!!!!!!")
            wc1.x = x; wc1.y = y
            wc1.visible=true
            wc1.jumpTo('still')
        }else
            wc1.visible=false
    }

    Rectangle{
        id: editor
        visible: true
        x: -90; y:500
        width: 90; height: 20
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
            text: "done!"
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
        parser.changeCreat(flick.getText())
        console.log("debug"+creatWhat)
    }
    function showEditor(){
        edit.visible = true
        flick.visible = true
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
        Repeater{
            model: 5
            Text{
                x: 50; y: 31+index*35
                text: actor.mainTable[index]
                font.family:  "Arial"
                font.pixelSize: 22
            }
        }
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

    Image{
        id: showEnemy
        visible: false
        width: 100; height: 100
        source: "image/enemyBg.png"
        Repeater{
            model: 3
            Text{
                width: 40; height: 80
                x: 50; y: 0+index*33
                text: actor.e_table[index]
            }
        }
    }

           /*Rectangle{
               width:enemyeditor.width; height:enemyeditor.height
               x: enemyeditor.x; y: enemyeditor.y
               color: "white"
           }

           TextEdit{
               id: enemyeditor
               width: 40; height: 20
               x: 40; y: 15+index*30
           }
           function enemyEdit(text){
               if(index == 0) actor.e_blood = parseInt(text)
               else if(index == 1) actor.e_force = parseInt(text)
               else actor.e_defend = parseInt(text)
           }
       }*/

   property bool isShowEnemyOn: false
   function enemyShow(x, y){
       isShowEnemyOn = true
       showEnemy.x = x-100; showEnemy.y = y
       showEnemy.visible = true; event.transing = false
   }
   function enemyHide(){
       isShowEnemyOn = false
       showEnemy.visible = false; event.transing = true
   }
}
