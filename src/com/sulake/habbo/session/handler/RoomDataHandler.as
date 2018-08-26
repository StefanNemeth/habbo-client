
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.session.events.RoomSessionPropertyUpdateEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class RoomDataHandler extends BaseHandler 
    {

        public function RoomDataHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new GetGuestRoomResultEvent(this.onRoomResult));
        }
        private function onRoomResult(_arg_1:IMessageEvent):void
        {
            var _local_2:GetGuestRoomResultEvent = (_arg_1 as GetGuestRoomResultEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:GetGuestRoomResultMessageParser = _local_2.getParser();
            if (_local_3.roomForward){
                return;
            };
            var _local_4:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_4 == null){
                return;
            };
            var _local_5:GuestRoomData = _local_3.data;
            _local_4.isTradingRoom = _local_5.allowTrading;
            _local_4.arePetsAllowed = _local_5.allowPets;
            listener.events.dispatchEvent(new RoomSessionPropertyUpdateEvent(RoomSessionPropertyUpdateEvent.RSDUE_ALLOW_PETS, _local_4));
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomDataHandler = "_-1Q9" (String#5355, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionPropertyUpdateEvent = "_-2-m" (String#19003, DoABC#2)
// GetGuestRoomResultMessageParser = "_-0lh" (String#4540, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// GetGuestRoomResultEvent = "_-2XI" (String#20334, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSDUE_ALLOW_PETS = "_-1md" (String#18406, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onRoomResult = "_-2-6" (String#18975, DoABC#2)
// isTradingRoom = "_-0eT" (String#4400, DoABC#2)
// allowTrading = "_-0ZL" (String#15416, DoABC#2)
// arePetsAllowed = "_-1f7" (String#5646, DoABC#2)


