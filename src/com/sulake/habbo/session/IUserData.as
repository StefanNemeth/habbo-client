
package com.sulake.habbo.session
{
    public interface IUserData 
    {

        function get id():int;
        function get name():String;
        function get custom():String;
        function get achievementScore():int;
        function get type():int;
        function get figure():String;
        function get sex():String;
        function get groupID():String;
        function get groupStatus():int;
        function get xp():int;
        function get webID():int;
        function set figure(_arg_1:String):void;
        function set name(_arg_1:String):void;
        function set sex(_arg_1:String):void;
        function set custom(_arg_1:String):void;
        function set achievementScore(_arg_1:int):void;
        function set groupID(_arg_1:String):void;

    }
}//package com.sulake.habbo.session

// IUserData = "_-0n7" (String#4570, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// groupStatus = "_-1Sq" (String#5411, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)


