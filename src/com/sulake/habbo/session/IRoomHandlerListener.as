
package com.sulake.habbo.session
{
    import flash.events.IEventDispatcher;

    public interface IRoomHandlerListener 
    {

        function sessionUpdate(_arg_1:int, _arg_2:int, _arg_3:String):void;
        function sessionReinitialize(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void;
        function getSession(_arg_1:int, _arg_2:int):IRoomSession;
        function get events():IEventDispatcher;

    }
}//package com.sulake.habbo.session

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)


