import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
Item {
    x: 100
    Image{
        id: people
        width: 30; height: 30
        source: "image/actor.png"
        x: p_x; y: p_y
    }
    property int p_x: 30
    property int p_y: 540
    property int cur_x: 30
    property int cur_y: 540
    property int blood: 1000
    property int force: 10
    property int defend: 10
    property int e_blood: 0
    property int e_force: 0
    property int e_defend: 0
    property int money: 10
    property int exp: 10
    property int item1: 0
    property int item2: 0
    property int item3: 0
    property var mainTable: [blood, force, defend, money, exp, item1, creatWhat]
    property var e_table: [e_blood, e_force, e_defend]
    property var e_name: 'none'


    //control actor
    function _moveLeft(){
        actor.p_x = actor.p_x - 30
    }
    function _moveRight(){
        actor.p_x = actor.p_x + 30
    }
    function _moveUp(){
        actor.p_y = actor.p_y - 30
    }
    function _moveDown(){
        actor.p_y = actor.p_y + 30
    }
}
