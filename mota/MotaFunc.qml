import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0
import QtAV 1.6
Item {
    function assert(cond, msg){
        if(cond) console.log("***wrong with  "+msg)
    }

    // init APIs
    function initWallPosition(table){

    }
    function initNpcPosition(table1, table2, table3, table4){

    }
    function initNormalNpcTalk(table){

    }
    function initSpcNpcTalk(table){

    }
    function initEnemyPosition(table){

    }
    function initEnemyProperties(n, table1, table2, table3){
        // n is how many, 3 tables : force, def, blood
    }
    function initItemsPosition(table){

    }
    function initItemFunc(msg){
        //can't do right now
    }
    //update APIs
    function downMap(){
        // load cur msg
    }
    function upMap(){
        //load nex msg
    }
    function upDate(){
        //to do
    }
    function upDatePictures(pos,path1, path2){
        // get the position you want to update
        // and update the source
    }


}
