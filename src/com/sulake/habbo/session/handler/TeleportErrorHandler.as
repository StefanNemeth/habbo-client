
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DoorOtherEndDeletedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.DoorNotInstalledMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DoorOtherEndDeletedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DoorNotInstalledMessageParser;

    public class TeleportErrorHandler extends BaseHandler 
    {

        public function TeleportErrorHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new DoorOtherEndDeletedMessageEvent(this.onDoorOtherEndDeletedMessage));
            _arg_1.addMessageEvent(new DoorNotInstalledMessageEvent(this.onDoorNotInstalledMessage));
        }
        private function onDoorOtherEndDeletedMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorOtherEndDeletedMessageParser = (_arg_1 as DoorOtherEndDeletedMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(RoomSessionErrorMessageEvent.RSEME_DOOR_OTHER_DELETED, _local_3));
            };
        }
        private function onDoorNotInstalledMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorNotInstalledMessageParser = (_arg_1 as DoorNotInstalledMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(RoomSessionErrorMessageEvent.RSEME_DOOR_NOT_INSTALLED, _local_3));
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// TeleportErrorHandler = "_-1iD" (String#5714, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// DoorOtherEndDeletedMessageEvent = "_-38w" (String#21840, DoABC#2)
// DoorOtherEndDeletedMessageParser = "_-EG" (String#7958, DoABC#2)
// DoorNotInstalledMessageParser = "_-0cn" (String#4360, DoABC#2)
// DoorNotInstalledMessageEvent = "_-38b" (String#21825, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSEME_DOOR_OTHER_DELETED = "_-1tU" (String#18697, DoABC#2)
// RSEME_DOOR_NOT_INSTALLED = "_-3CD" (String#21969, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onDoorOtherEndDeletedMessage = "_-uF" (String#24461, DoABC#2)
// onDoorNotInstalledMessage = "_-U1" (String#23410, DoABC#2)


