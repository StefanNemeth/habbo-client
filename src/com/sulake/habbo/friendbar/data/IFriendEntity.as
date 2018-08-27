
package com.sulake.habbo.friendbar.data
{
    import __AS3__.vec.Vector;

    public interface IFriendEntity 
    {

        function get id():int;
        function get name():String;
        function get gender():int;
        function get online():Boolean;
        function get allowFollow():Boolean;
        function get figure():String;
        function get categoryId():int;
        function get motto():String;
        function get lastAccess():String;
        function get realName():String;
        function get notifications():Vector.<FriendNotification>;
        function get logEventId():int;
        function set logEventId(_arg_1:int):void;
        function getNextLogEventId():int;

    }
}//package com.sulake.habbo.friendbar.data

// lastAccess = "_-Es" (String#7968, DoABC#2)
// allowFollow = "_-1Va" (String#5466, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// logEventId = "_-Vm" (String#8316, DoABC#2)
// getNextLogEventId = "_-0OK" (String#4053, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)


