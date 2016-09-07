import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
Item {
    x: 100
    Image{
        id: people
        width: 20; height: 20
        source: "image/actor.png"
        x: p_x; y: p_y
    }
    property int p_x: 20
    property int p_y: 360
    property int cur_x: 20
    property int cur_y: 360
    property int blood: 1000
    property int force: 10
    property int defend: 10
    property int money: 10
    property int exp: 10
    property int item1: 0
    property int item2: 0
    property int item3: 0
    property var mainTable: [blood, force, defend, money, exp, item1, creatWhat]


    //control actor
    function _moveLeft(){
        actor.p_x = actor.p_x - 20
    }
    function _moveRight(){
        actor.p_x = actor.p_x + 20
    }
    function _moveUp(){
        actor.p_y = actor.p_y - 20
    }
    function _moveDown(){
        actor.p_y = actor.p_y + 20
    }
}
