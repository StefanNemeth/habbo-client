
package com.sulake.habbo.messenger
{
    public interface IConversation 
    {

        function get id():int;
        function get name():String;
        function get selected():Boolean;
        function get messages():Array;
        function get newMessageArrived():Boolean;
        function get figure():String;
        function get followingAllowed():Boolean;
        function get disposed():Boolean;

    }
}//package com.sulake.habbo.messenger

// IConversation = "_-1me" (String#5792, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)


