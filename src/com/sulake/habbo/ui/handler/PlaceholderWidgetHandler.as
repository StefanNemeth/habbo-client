
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class PlaceholderWidgetHandler implements IRoomWidgetHandler 
    {

        private var _container:IRoomWidgetHandlerContainer = null;

        public function dispose():void
        {
            this._container = null;
        }
        public function get disposed():Boolean
        {
            return (false);
        }
        public function get type():String
        {
            return (null);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function getWidgetMessages():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PLACEHOLDER]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetShowPlaceholderEvent;
            switch (_arg_1.type){
                default:
                    _local_2 = new RoomWidgetShowPlaceholderEvent(RoomWidgetShowPlaceholderEvent.RWSPE_SHOW_PLACEHOLDER);
                    this._container.events.dispatchEvent(_local_2);
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return (null);
        }
        public function processEvent(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// PlaceholderWidgetHandler = "_-VN" (String#23465, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetShowPlaceholderEvent = "_-3-p" (String#7300, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLACEHOLDER = "_-2S8" (String#20125, DoABC#2)
// RWSPE_SHOW_PLACEHOLDER = "_-1-S" (String#16446, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)


