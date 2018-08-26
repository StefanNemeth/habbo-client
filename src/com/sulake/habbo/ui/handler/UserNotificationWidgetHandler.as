
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetUserNotificationMessage;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserNotificationEvent;
    import flash.events.Event;

    public class UserNotificationWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._container = null;
                this._disposed = true;
            };
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RSUN_USER_NOTIFICATION);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
            this._container.roomSession.sendGetUserNotifications();
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetGetUserNotificationMessage.RWGSM_GET_NOTIFICATIONS);
            return (_local_1);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomSessionUserNotificationEvent.RSUN_USER_NOTIFICATION]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!_arg_1){
                return (null);
            };
            switch (_arg_1.type){
                default:
                    Logger.log(_arg_1.type);
            };
            return (null);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionUserNotificationEvent;
            var _local_3:RoomWidgetUserNotificationEvent;
            switch (_arg_1.type){
                case RoomSessionUserNotificationEvent.RSUN_USER_NOTIFICATION:
                    _local_2 = (_arg_1 as RoomSessionUserNotificationEvent);
                    _local_3 = new RoomWidgetUserNotificationEvent(RoomWidgetUserNotificationEvent.RWUNE_NOTIFICATION);
                    _local_3.title = _local_2.title;
                    _local_3.message = _local_2.message;
                    _local_3.parameters = _local_2.parameters;
                    this._container.events.dispatchEvent(_local_3);
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionUserNotificationEvent = "_-0pw" (String#4633, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// UserNotificationWidgetHandler = "_-1x8" (String#5975, DoABC#2)
// RoomWidgetUserNotificationEvent = "_-0ns" (String#4588, DoABC#2)
// RoomWidgetGetUserNotificationMessage = "_-2MG" (String#6488, DoABC#2)
// RWGSM_GET_NOTIFICATIONS = "_-14k" (String#16643, DoABC#2)
// RSUN_USER_NOTIFICATION = "_-0ni" (String#15964, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// RWUNE_NOTIFICATION = "_-0Vj" (String#4221, DoABC#2)


