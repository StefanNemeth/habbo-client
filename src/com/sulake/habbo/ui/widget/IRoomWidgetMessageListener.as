
package com.sulake.habbo.ui.widget
{
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;

    public interface IRoomWidgetMessageListener 
    {

        function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent;

    }
}//package com.sulake.habbo.ui.widget

// IRoomWidgetMessageListener = "_-2FI" (String#6349, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)


