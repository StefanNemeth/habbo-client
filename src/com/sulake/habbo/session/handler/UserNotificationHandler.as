
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.users.UserNotificationMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionUserNotificationEvent;

    public class UserNotificationHandler extends BaseHandler 
    {

        public function UserNotificationHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new UserNotificationMessageEvent(this.onUserNotification));
        }
        override public function dispose():void
        {
            if (!disposed){
                super.dispose();
            };
        }
        private function onUserNotification(_arg_1:UserNotificationMessageEvent):void
        {
            var _local_2:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            var _local_3:RoomSessionUserNotificationEvent = new RoomSessionUserNotificationEvent(RoomSessionUserNotificationEvent.RSUN_USER_NOTIFICATION, _local_2);
            _local_3.title = _arg_1.title;
            _local_3.message = _arg_1.message;
            _local_3.parameters = _arg_1.parameters;
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// UserNotificationHandler = "_-0pD" (String#4617, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionUserNotificationEvent = "_-0pw" (String#4633, DoABC#2)
// UserNotificationMessageEvent = "_-1WK" (String#17755, DoABC#2)
// RSUN_USER_NOTIFICATION = "_-0ni" (String#15964, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)


