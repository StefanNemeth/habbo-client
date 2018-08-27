
package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboMessenger extends IUnknown 
    {

        function isOpen():Boolean;
        function toggleMessenger():void;
        function startConversation(_arg_1:int):void;
        function getActiveConversation():IConversation;
        function setFollowingAllowed(_arg_1:int, _arg_2:Boolean):void;
        function setOnlineStatus(_arg_1:int, _arg_2:Boolean):void;

    }
}//package com.sulake.habbo.messenger

// toggleMessenger = "_-2E7" (String#1838, DoABC#2)
// getActiveConversation = "_-0WJ" (String#4233, DoABC#2)
// setFollowingAllowed = "_-32S" (String#7358, DoABC#2)
// setOnlineStatus = "_-0QG" (String#4097, DoABC#2)
// IConversation = "_-1me" (String#5792, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)


