
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.ViralFurniStatusEvent;
    import com.sulake.habbo.communication.messages.incoming.room.furniture.ViralFurniGiftReceivedEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniStatusMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionViralFurniStatusEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.ViralFurniGiftReceivedMessageParser;

    public class ViralFurniHandler extends BaseHandler 
    {

        public function ViralFurniHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new ViralFurniStatusEvent(this.onViralFurniStatus));
            _arg_1.addMessageEvent(new ViralFurniGiftReceivedEvent(this.onViralGiftReceived));
        }
        private function onViralFurniStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:ViralFurniStatusEvent = (_arg_1 as ViralFurniStatusEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ViralFurniStatusMessageParser = _local_2.getParser();
            var _local_4:int = _local_3.roomId;
            var _local_5:int = _local_3.roomCategory;
            var _local_6:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_6 == null){
                return;
            };
            var _local_7:RoomSessionViralFurniStatusEvent = new RoomSessionViralFurniStatusEvent(RoomSessionViralFurniStatusEvent.RSVFS_STATUS, _local_6);
            _local_7.campaignID = _local_3.campaignID;
            _local_7.objectId = _local_3.objectId;
            _local_7.status = _local_3.status;
            _local_7.shareId = _local_3.shareId;
            _local_7.firstClickUserName = _local_3.firstClickUserName;
            _local_7.itemCategory = _local_3.itemCategory;
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(_local_7);
            };
        }
        private function onViralGiftReceived(_arg_1:IMessageEvent):void
        {
            var _local_2:ViralFurniGiftReceivedEvent = (_arg_1 as ViralFurniGiftReceivedEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:ViralFurniGiftReceivedMessageParser = _local_2.getParser();
            var _local_4:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_4 == null){
                return;
            };
            var _local_5:RoomSessionViralFurniStatusEvent = new RoomSessionViralFurniStatusEvent(RoomSessionViralFurniStatusEvent.RSVFS_RECEIVED, _local_4);
            _local_5.firstClickUserName = _local_3.firstClickUserName;
            _local_5.giftWasReceived = _local_3.giftWasReceived;
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(_local_5);
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// ViralFurniHandler = "_-0rV" (String#4676, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionViralFurniStatusEvent = "_-2OF" (String#6524, DoABC#2)
// ViralFurniGiftReceivedEvent = "_-35d" (String#21717, DoABC#2)
// ViralFurniStatusEvent = "_-yK" (String#24627, DoABC#2)
// ViralFurniGiftReceivedMessageParser = "_-vR" (String#8792, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSVFS_STATUS = "_-W" (String#23492, DoABC#2)
// RSVFS_RECEIVED = "_-3n" (String#22366, DoABC#2)
// shareId = "_-0L" (String#14876, DoABC#2)
// firstClickUserName = "_-0jN" (String#15804, DoABC#2)
// giftWasReceived = "_-1AI" (String#16872, DoABC#2)
// itemCategory = "_-3Bq" (String#21955, DoABC#2)
// campaignID = "_-09Z" (String#14429, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onViralFurniStatus = "_-34p" (String#21689, DoABC#2)
// onViralGiftReceived = "_-b" (String#23670, DoABC#2)


