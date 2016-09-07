import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6

Item {
    x: 100


    Label{
        id: logo1
        width: 100; height: 40
        x: -80; y: 20
        text: "By:"
        color: "black"
        font.family: uiFont.name
        font.pointSize: 30
    }
    Label{
        width: 100; height: 40
        x: -80; y: 55
        text: "cy"
        color: "black"
        font.family: uiFont.name
        font.pointSize: 30
    }
    Label{
        width: 100; height: 40
        x: -90; y: 300
        text:"creat:"
        font.family: uiFont.name
        font.pointSize: 18
        Text{
            y:20
            text: creatWhat
            font.family: uiFont.name
            font.pointSize: 18
        }
    }


    ListView{
        x: -90; y: 150
        width: 100; height: 400
        id: properties
        model: 6
        property var data: ['blo','for','def','mon','exp', 'itm']
        delegate: Label{
            text: properties.data[index]+' '+actor.mainTable[index]
            color: "black"
            font.family: uiFont.name
            font.pointSize: 12
        }
    }


}
