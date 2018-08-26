
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.room.engine.PlaceObjectErrorMessageEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.room.engine.PlaceObjectErrorMessageParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.enum.PlaceObjectErrorEnum;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class PlaceObjectErrorHandler extends BaseHandler 
    {

        public function PlaceObjectErrorHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new PlaceObjectErrorMessageEvent(this.onPlaceObjectError));
        }
        private function onPlaceObjectError(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:PlaceObjectErrorMessageParser = (_arg_1 as PlaceObjectErrorMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            switch (_local_2.errorCode){
                case PlaceObjectErrorEnum.RSEME_CANT_TRADE_STUFF:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_CANT_TRADE_STUFF;
                    break;
                case PlaceObjectErrorEnum.RSEME_INVALID_ITEM_LOC:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_INVALID_ITEM_LOC;
                    break;
                case PlaceObjectErrorEnum.RSEME_MAX_FURNITURE:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_MAX_FURNITURE;
                    break;
                case PlaceObjectErrorEnum.RSEME_MAX_PETS:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_MAX_PETS;
                    break;
                case PlaceObjectErrorEnum.RSEME_MAX_QUEUE:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_MAX_QUEUE;
                    break;
                case PlaceObjectErrorEnum.RSEME_MAX_SOUND:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_MAX_SOUND;
                    break;
                case PlaceObjectErrorEnum.RSEME_MAX_STICKIES:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_MAX_STICKIES;
                    break;
                default:
                    return;
            };
            if (((listener) && (listener.events))){
                listener.events.dispatchEvent(new RoomSessionErrorMessageEvent(_local_4, _local_3));
            };
        }

    }
}//package com.sulake.habbo.session.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// BaseHandler = "_-1Mx" (String#5291, DoABC#2)
// PlaceObjectErrorHandler = "_-0nG" (String#4576, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// PlaceObjectErrorMessageParser = "_-0H1" (String#3896, DoABC#2)
// PlaceObjectErrorMessageEvent = "_-Z4" (String#23604, DoABC#2)
// PlaceObjectErrorEnum = "_-Ag" (String#7880, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSEME_CANT_TRADE_STUFF = "_-1qQ" (String#18560, DoABC#2)
// RSEME_INVALID_ITEM_LOC = "_-0ad" (String#15460, DoABC#2)
// RSEME_MAX_STICKIES = "_-A0" (String#22618, DoABC#2)
// RSEME_MAX_FURNITURE = "_-3f" (String#22360, DoABC#2)
// RSEME_MAX_QUEUE = "_-0vV" (String#16257, DoABC#2)
// RSEME_MAX_SOUND = "_-37I" (String#21780, DoABC#2)
// RSEME_MAX_PETS = "_-LM" (String#23061, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onPlaceObjectError = "_-Dw" (String#22767, DoABC#2)


