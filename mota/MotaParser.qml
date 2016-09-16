import QtGraphicalEffects 1.0
import QtQuick 2.7
import QtQuick.Controls 2.0

Item {
    id: motaParser
    visible: false
    function myTrim(s){
        return s.trim().replace(/\s*$/,'')
    }
    // aux functions
    function isCreat(s){
        return myTrim(s).substring(0,5) === 'creat'
    }
    function isClear(s){
        return myTrim(s).substring(0,5) === 'clear'
    }

    function isNpc(s){
        return myTrim(s).substring(0,3) === 'npc'
    }
    function isEnemy(s){
        return myTrim(s).substring(0,5) ==='enemy'
    }
    function isMe(s){
        return myTrim(s).substring(0,2) === 'me'
    }
    function isBgm(s){
        return myTrim(s).substring(0,3) === 'bgm'
    }
    function isSe(s){
        return myTrim(s).substring(0,2) === 'se'
    }

    function isTransfer(s){
        return myTrim(s).substring(0, 8) === 'transfer'
    }
    function isFast(s){
        return myTrim(s).substring(0, 4) === 'fast'
    }

    function isDistinguish(s){
        return myTrim(s).charAt(0) === ','
    }

    // main function
    function changeCreat(s){
        var ss = ''
        if(myTrim(s).charAt(0) === '+'){
            s = s.substring(1, s.length)
            if(isCreat(s)){
                ss = myTrim(s.substring(6,s.length))
                func.creat(ss)
                return
            }
            else if(isClear(s)){
                func.clear()
            }
        }
        else if(myTrim(s).charAt(0) === '@'){
            s = s.substring(1, s.length)
            if(isTransfer(s)){
                ss = myTrim(s.substring(8, s.length))
                var pos111; var a; var b
                for(var iii = 0; iii < ss.length; iii++){
                    if(ss.charAt(iii) === ',' && !pos111){
                        pos111 = iii
                        a = parseInt(myTrim(ss.substring(0, pos111)))
                        b = parseInt(myTrim(ss.substring(pos111+1, ss.length)))
                        func.transfer(a,b)
                        return
                    }
                }
            }
            else if(isFast(s)){
                ss = parseFloat(myTrim(s.substring(5, s.length)))
                func.fastFight(ss)
                return
            }
        }

        else if(myTrim(s).charAt(0) === '*'){
            s = s.substring(1, s.length)
            if(isNpc(s)){
                ss = myTrim(s.substring(4, s.length))
                func.addNpcTalk(ss)
                return
            }
            else if(isEnemy(s)){
                var myB; var myF; var myD; var pos1; var pos2
                var num = parseInt(myTrim(s.substring(5,6)))
                ss =myTrim(s.substring(6, s.length))
                for(var i = 0; i <= ss.length; i++){
                    if(ss.charAt(i) === ',' && !pos1) pos1 = i
                    else if(ss.charAt(i) === ',' && pos1) pos2 = i
                }
                myB = parseInt(myTrim(ss.substring(0, pos1)))
                myF = parseInt(myTrim(ss.substring(pos1+1, pos2)))
                myD = parseInt(myTrim(ss.substring(pos2+1, ss.length)))
                func.editEnemyX(num, myB, myF, myD)
                return
            }
            else if(isMe(s)){
                var myB2; var myF2; var myD2; var pos11; var pos22
                ss =myTrim(s.substring(3, s.length))
                for(var ii = 0; ii <= ss.length; ii++){
                    if(ss.charAt(ii) === ',' && !pos11) pos11 = ii
                    else if(ss.charAt(ii) === ',' && pos11) pos22 = ii
                }
                myB2 = parseInt(myTrim(ss.substring(0, pos11)))
                myF2 = parseInt(myTrim(ss.substring(pos11+1, pos22)))
                myD2 = parseInt(myTrim(ss.substring(pos22+1, ss.length)))
                func.editMe(myB2, myF2, myD2)
                return
            }
            else if(isBgm(s)){
                ss = parseFloat(myTrim(s.substring(4,s.length)))
                func.editBgmVolume(ss)
                return
            }
            else if(isSe(s)){
                ss = parseFloat(myTrim(s.substring(3,s.length)))
                func.editSeVolume(ss)
                return
            }

            return
        }
        else
            return
    }


    //do something, will use

    function processBasicCommand(command){
        myEval(command)
    }
    function processCommand(command){
        return myEval(command)
    }
    function myEval(exp){
        var result=null
        result=eval(exp)
        return result
    }

}
