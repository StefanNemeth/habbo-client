
package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public interface IRoomWidgetHandler extends IDisposable 
    {

        function get type():String;
        function set container(_arg_1:IRoomWidgetHandlerContainer):void;
        function IRoomWidgetHandler():Array;
        function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent;
        function IRoomWidgetHandler():Array;
        function IRoomWidgetHandler(_arg_1:Event):void;
        function update():void;

    }
}//package com.sulake.habbo.ui

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)


