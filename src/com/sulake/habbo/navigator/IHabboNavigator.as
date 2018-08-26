
package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboNavigator extends IUnknown 
    {

        function get events():IEventDispatcher;
        function goToHomeRoom():Boolean;
        function performTagSearch(_arg_1:String):void;
        function showOwnRooms():void;
        function goToRoom(_arg_1:int, _arg_2:Boolean, _arg_3:String="", _arg_4:int=-1):void;

    }
}//package com.sulake.habbo.navigator

// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// goToHomeRoom = "_-LH" (String#8108, DoABC#2)
// showOwnRooms = "_-0Z5" (String#4281, DoABC#2)
// performTagSearch = "_-29O" (String#6238, DoABC#2)


