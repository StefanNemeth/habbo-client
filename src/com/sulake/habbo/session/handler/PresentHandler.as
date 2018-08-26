
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.furniture.PresentOpenedMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionPresentEvent;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class PresentHandler extends BaseHandler 
    {

        public function PresentHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new PresentOpenedMessageEvent(this.onPresentOpened));
        }
        private function onPresentOpened(_arg_1:IMessageEvent):void
        {
            var _local_2:PresentOpenedMessageParser = (_arg_1 as PresentOpenedMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:int = _local_2.roomId;
            var _local_4:int = _local_2.roomCategory;
            var _local_5:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_5 == null){
                return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionPresentEvent(RoomSessionPresentEvent.RSPE_PRESENT_OPENED, _local_5, _local_2.classId, _local_2.itemType, _local_2.productCode));
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// PresentHandler = "_-2vt" (String#7198, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionPresentEvent = "_-30Q" (String#7312, DoABC#2)
// PresentOpenedMessageEvent = "_-1Zb" (String#17874, DoABC#2)
// PresentOpenedMessageParser = "_-25F" (String#6147, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSPE_PRESENT_OPENED = "_-1eK" (String#18071, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onPresentOpened = "_-0H2" (String#14719, DoABC#2)


