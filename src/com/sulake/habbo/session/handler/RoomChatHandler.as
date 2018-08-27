
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.room.chat.FloodControlMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationParser;
    import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageParser;

    public class RoomChatHandler extends BaseHandler 
    {

        public function RoomChatHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new ChatMessageEvent(this.onRoomChat));
            _arg_1.addMessageEvent(new WhisperMessageEvent(this.onRoomWhisper));
            _arg_1.addMessageEvent(new ShoutMessageEvent(this.onRoomShout));
            _arg_1.addMessageEvent(new RespectNotificationMessageEvent(this.onRespectNotification));
            _arg_1.addMessageEvent(new PetRespectNotificationEvent(this.onPetRespectNotification));
            _arg_1.addMessageEvent(new FloodControlMessageEvent(this.onFloodControl));
        }
        private function onRoomChat(_arg_1:IMessageEvent):void
        {
            var _local_2:ChatMessageEvent;
            var _local_3:IRoomSession;
            var _local_4:String;
            var _local_5:int;
            var _local_6:ChatMessageParser;
            if (((listener) && (listener.events))){
                _local_2 = (_arg_1 as ChatMessageEvent);
                if (((_local_2) && (_local_2.getParser()))){
                    _local_3 = listener.getSession(_xxxRoomId, _SafeStr_6312);
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = RoomSessionChatEvent.RSCE_CHAT_EVENT;
                    _local_5 = RoomSessionChatEvent._SafeStr_3620;
                    _local_6 = _local_2.getParser();
                    if (_local_6.trackingId != -1){
                        _local_3.receivedChatWithTrackingId(_local_6.trackingId);
                    };
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_4, _local_3, _local_6.userId, _local_6.text, _local_5, _local_6.links));
                };
            };
        }
        private function onRespectNotification(_arg_1:IMessageEvent):void
        {
            var _local_3:IRoomSession;
            var _local_4:String;
            var _local_5:int;
            var _local_6:IUserData;
            var _local_7:String;
            var _local_2:RespectNotificationMessageEvent = (_arg_1 as RespectNotificationMessageEvent);
            if (((listener) && (listener.events))){
                _local_3 = listener.getSession(_xxxRoomId, _SafeStr_6312);
                if (_local_3 == null){
                    return;
                };
                _local_4 = RoomSessionChatEvent.RSCE_CHAT_EVENT;
                _local_5 = RoomSessionChatEvent._SafeStr_4788;
                _local_6 = _local_3.userDataManager.getUserData(_local_2.userId);
                if (_local_6 == null){
                    return;
                };
                _local_7 = "";
                listener.events.dispatchEvent(new RoomSessionChatEvent(_local_4, _local_3, _local_6.id, _local_7, _local_5));
            };
        }
        private function onPetRespectNotification(_arg_1:PetRespectNotificationEvent):void
        {
            if ((((((_arg_1 == null)) || ((listener == null)))) || ((listener.events == null)))){
                return;
            };
            var _local_2:PetRespectNotificationParser = _arg_1.getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            var _local_4:String = RoomSessionChatEvent.RSCE_CHAT_EVENT;
            var _local_5:int = RoomSessionChatEvent._SafeStr_4789;
            var _local_6:IUserData = _local_3.userDataManager.getPetUserData(_local_2.petData.id);
            if (_local_6 == null){
                return;
            };
            listener.events.dispatchEvent(new RoomSessionChatEvent(_local_4, _local_3, _local_6.id, "", _local_5));
        }
        private function onRoomWhisper(_arg_1:IMessageEvent):void
        {
            var _local_2:WhisperMessageEvent;
            var _local_3:IRoomSession;
            var _local_4:String;
            var _local_5:int;
            var _local_6:ChatMessageParser;
            if (((listener) && (listener.events))){
                _local_2 = (_arg_1 as WhisperMessageEvent);
                if (((_local_2) && (_local_2.getParser()))){
                    _local_3 = listener.getSession(_xxxRoomId, _SafeStr_6312);
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = RoomSessionChatEvent.RSCE_CHAT_EVENT;
                    _local_5 = RoomSessionChatEvent._SafeStr_3621;
                    _local_6 = _local_2.getParser();
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_4, _local_3, _local_6.userId, _local_6.text, _local_5, _local_6.links));
                };
            };
        }
        private function onRoomShout(_arg_1:IMessageEvent):void
        {
            var _local_2:ShoutMessageEvent;
            var _local_3:IRoomSession;
            var _local_4:String;
            var _local_5:int;
            var _local_6:ChatMessageParser;
            if (((listener) && (listener.events))){
                _local_2 = (_arg_1 as ShoutMessageEvent);
                if (((_local_2) && (_local_2.getParser()))){
                    _local_3 = listener.getSession(_xxxRoomId, _SafeStr_6312);
                    if (_local_3 == null){
                        return;
                    };
                    _local_4 = RoomSessionChatEvent.RSCE_CHAT_EVENT;
                    _local_5 = RoomSessionChatEvent._SafeStr_3622;
                    _local_6 = _local_2.getParser();
                    listener.events.dispatchEvent(new RoomSessionChatEvent(_local_4, _local_3, _local_6.userId, _local_6.text, _local_5, _local_6.links));
                };
            };
        }
        private function onFloodControl(_arg_1:IMessageEvent):void
        {
            var _local_2:FloodControlMessageParser;
            var _local_3:IRoomSession;
            var _local_4:int;
            if (((listener) && (listener.events))){
                _local_2 = (_arg_1 as FloodControlMessageEvent).getParser();
                _local_3 = listener.getSession(_xxxRoomId, _SafeStr_6312);
                if (_local_3 == null){
                    return;
                };
                _local_4 = _local_2.seconds;
                Logger.log((("received flood control event for " + _local_4) + " seconds"));
                listener.events.dispatchEvent(new RoomSessionChatEvent(RoomSessionChatEvent.RSCE_FLOOD_EVENT, _local_3, -1, ("" + _local_4), 0, null));
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// RoomChatHandler = "_-9B" (String#7846, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RespectNotificationMessageEvent = "_-0xG" (String#16323, DoABC#2)
// RoomSessionChatEvent = "_-2e3" (String#6834, DoABC#2)
// ShoutMessageEvent = "_-Gi" (String#22877, DoABC#2)
// ChatMessageEvent = "_-f7" (String#23850, DoABC#2)
// FloodControlMessageEvent = "_-Zv" (String#23628, DoABC#2)
// PetRespectNotificationParser = "_-1Te" (String#5426, DoABC#2)
// ChatMessageParser = "_-06O" (String#3689, DoABC#2)
// PetRespectNotificationEvent = "_-247" (String#19180, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// WhisperMessageEvent = "_-h1" (String#23932, DoABC#2)
// FloodControlMessageParser = "_-1ML" (String#5281, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSCE_CHAT_EVENT = "_-0km" (String#15857, DoABC#2)
// RSCE_FLOOD_EVENT = "_-2Pn" (String#20035, DoABC#2)
// _SafeStr_4788 = "_-1rK" (String#18597, DoABC#2)
// _SafeStr_4789 = "_-2ut" (String#21273, DoABC#2)
// onFloodControl = "_-xP" (String#8832, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onRoomChat = "_-2P1" (String#20002, DoABC#2)
// onRoomWhisper = "_-0gD" (String#15682, DoABC#2)
// onRoomShout = "_-0Oj" (String#15016, DoABC#2)
// onRespectNotification = "_-27V" (String#6191, DoABC#2)
// onPetRespectNotification = "_-57" (String#22424, DoABC#2)
// trackingId = "_-189" (String#16783, DoABC#2)
// receivedChatWithTrackingId = "_-FR" (String#7981, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// getPetUserData = "_-2Rz" (String#6606, DoABC#2)


