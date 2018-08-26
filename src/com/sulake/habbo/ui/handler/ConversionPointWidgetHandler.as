
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetConversionPointMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class ConversionPointWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_ROOM_VOTE);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomWidgetConversionPointMessage.RWCPM_CONVERSION_POINT]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetConversionPointMessage;
            switch (_arg_1.type){
                case RoomWidgetConversionPointMessage.RWCPM_CONVERSION_POINT:
                    _local_2 = (_arg_1 as RoomWidgetConversionPointMessage);
                    if (_local_2 == null){
                        return (null);
                    };
                    this._container.roomSession.RoomSession(_local_2.category, _local_2.pointType, _local_2.action, _local_2.extraString, _local_2.extraInt);
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// ConversionPointWidgetHandler = "_-1xM" (String#18862, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// RWCPM_CONVERSION_POINT = "_-0hK" (String#15721, DoABC#2)
// pointType = "_-0xk" (String#16343, DoABC#2)
// extraString = "_-0hC" (String#15718, DoABC#2)
// extraInt = "_-2G0" (String#19645, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// RoomSession = "_-0C0" (String#1425, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)


