
package com.sulake.habbo.session
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IRoomSessionManager extends IUnknown 
    {

        function set roomEngineReady(_arg_1:Boolean):void;
        function RoomSessionManager(_arg_1:Boolean, _arg_2:int, _arg_3:String="", _arg_4:String=""):Boolean;
        function RoomSessionManager(_arg_1:IRoomSession):Boolean;
        function getSession(_arg_1:int, _arg_2:int):IRoomSession;
        function get events():IEventDispatcher;
        function get sessionStarting():Boolean;

    }
}//package com.sulake.habbo.session

// sessionStarting = "_-0Wy" (String#4247, DoABC#2)
// RoomSessionManager = "_-Fa" (String#7986, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// roomEngineReady = "_-0Qo" (String#4107, DoABC#2)
// RoomSessionManager = "_-j1" (String#8577, DoABC#2)


