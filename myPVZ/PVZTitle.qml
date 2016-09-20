import QtQuick 2.7

Image{
    id: titleBg
    x: 0; y:0
    source: "res/images/surface/SurfaceNomal.png"

    function switchTo(num){   // 0 - 6
        var stat = ['Nomal', 'Advence', 'Mini','IQ', 'Option',
                'Help', 'Exit'];
        // my fault to name the normal into nomal...
        titleBg.source = "res/images/surface/Surface"+stat[num]+'.png'
    }

    Image{
        id: items
        x: 0; y: 0
        visible: false
        source: "res/images/surface/MenuYYNormal.png"
        function swithTo(path){
            items.source = "res/images/surface/"+path+'.png'
        }
        function swithFlag(s){
            itemEvent.flag = s;
        }
        function startListening(){
            items.visible = true
            itemEvent.focus = true
            itemEvent.enabled = true
            itemEvent.hoverEnabled = true
        }
        function quitListening(){
            items.visible = false
            itemEvent.focus = false
            itemEvent.enabled = false
        }
        function menuClick(){
            itemEvent.myClicked()
        }

        MouseArea{
            id: itemEvent
            property string flag: "options"  //  options, help, quit
            property int area: 0
            property int mouse: titleEvent.mouseX
            anchors.fill: parent
            hoverEnabled: true

            function changeFlag(f){
                itemEvent.flag = f
            }

            onMouseChanged: {
                enterInArea(titleEvent.mouseX, titleEvent.mouseY, flag)
                if(itemEvent.flag === "options"){
                    titleEvent.options()
                }else if(itemEvent.flag === "help"){
                    titleEvent.help()
                }else if(itemEvent.flag === "quit"){
                    titleEvent.quit()
                }
            }

            function myClicked(){
                console.log("clicked")
                if(itemEvent.flag === "options"){
                    if(itemEvent.area == 2){
                        music.bgmSwith = !music.bgmSwith
                    }else if(itemEvent.area == 3){
                        music.seSwith = !music.seSwith
                    }else if(itemEvent.area == 1){
                        titleEvent.titleUnLock()
                    }
                }else if(itemEvent.flag == "help"){
                    if(itemEvent.area == 4){
                        titleEvent.titleUnLock()
                    }
                }else if(itemEvent.flag == "quit"){
                    if(itemEvent.area == 5){
                        console.log("sure to quit")
                    }else if(itemEvent.area == 6){
                        titleEvent.titleUnLock()
                    }
                }
            }


            function enterInArea(x, y, flag){
                if(flag === "options"){
                    if(x >= 290 && x <= 611 && y >= 456 && y <= 524){
                        area = 1;
                    }else if(x >= 494 && x <= 521 && y >= 222 & y <= 241){
                        area = 2;
                    }else if(x >= 494 && x <= 525 && y >= 284 && y <= 308){
                        area = 3;
                    }else
                        area = 7;
                }else if(flag === "help"){
                    if(x >= 366 && x <= 540 && y >= 521 && y <= 557)
                        area = 4
                }else if(flag === "quit"){
                    if(x >= 283 && x <= 440 && y >= 363 && y <= 401){
                        area = 5
                    }else if(x >= 447 && x <= 604 && y >= 368 && y <= 402){
                        area = 6
                    }
                }else if(flag === "nothing"){
                    area = 0
                }
                else
                    area = 7
            }
        }
    }

    MouseArea{
        id: titleEvent
        anchors.fill: parent
        hoverEnabled: true

        property int area: 0
        property string flag: "title" // menu

        onMouseXChanged: {
            if(flag == "title"){
                area = enterInTheArea(mouseX, mouseY)
            }else{
                area = 0
            }
            titleBg.switchTo(area)
        }

        onClicked:{
            if(flag == "title"){
                if(area === 0) console.log("do nothing")
                else if(area === 1){
                    console.log("start game!")
                }else if(area === 2){
                    console.log("start Mini Game!!")
                }else if(area === 3){
                    console.log("start IQ Game!!!")
                }else if(area === 4){
                    items.swithFlag("options")
                    titleLock()
                    options()

                    console.log("* options")
                }else if(area === 5){
                    items.swithFlag("help")
                    titleLock()
                    help()
                    console.log("* help")
                }else if(area === 6){
                    items.swithFlag("quit")
                    titleLock()
                    quit()
                    console.log("* quit")
                }
            }else{
                items.menuClick()
            }
        }
        function enterInTheArea(x, y){
            if(x >= 481 && x <= 789 && y >= 99 && y <= 214){
                return 1
            }else if(x >= 474 && x <= 776 && y >= 198 && y <= 320){
                return 2
            }else if(x >= 479 && x <= 750 && y >= 307 && y <= 424 ){
                return 3
            }else if(x >= 640 && x <= 719 && y >= 478 && y <= 521){
                return 4
            }else if(x >= 725 && x <= 791 && y >= 517 && y <= 544){
                return 5
            }else if(x >= 799 && x <= 873 && y >= 503 && y <= 538){
                return 6
            }else{
                return 0
            }
        }

        function options(){
            var flag1 = '', flag2 = '', flag3 = ''
            if(music.bgmSwith) flag1 = 'Y'
            else flag1 = 'N'
            if(music.seSwith) flag2 = 'Y'
            else flag2 = 'N'
            if(area == 1) flag3 = 'Highlight'
            else flag3 = 'Normal'
            items.swithTo('Menu'+flag1+flag2+flag3)
        }
        function help(){
            if(itemEvent.area == 4){
                items.swithTo('HelpWidgetHighlight')
            }else
                items.swithTo('HelpWidgetNormal')
        }
        function quit(){
            if(itemEvent.area == 5){
                items.swithTo('ExitMainWidgetOK')
            }else if(itemEvent.area == 6){
                items.swithTo('ExitMainWidgetCancel')
            }else
                items.swithTo('ExitMainWidgetNormal')
        }

        function titleLock(){
            titleEvent.flag = "menu"
            items.startListening()

        }
        function titleUnLock(){
            titleEvent.flag = "title"
            titleEvent.enabled = true
            items.quitListening()
        }
    }
}
