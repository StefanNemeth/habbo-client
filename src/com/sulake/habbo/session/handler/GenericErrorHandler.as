
package com.sulake.habbo.session.handler
{
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.IRoomHandlerListener;
    import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.session.events.RoomSessionErrorMessageEvent;
    import com.sulake.habbo.session.enum.GenericErrorEnum;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class GenericErrorHandler extends BaseHandler 
    {

        public function GenericErrorHandler(_arg_1:IConnection, _arg_2:IRoomHandlerListener)
        {
            super(_arg_1, _arg_2);
            if (_arg_1 == null){
                return;
            };
            _arg_1.addMessageEvent(new GenericErrorEvent(this.onGenericError));
        }
        private function onGenericError(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:GenericErrorParser = (_arg_1 as GenericErrorEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:IRoomSession = listener.getSession(_xxxRoomId, _SafeStr_6312);
            if (_local_3 == null){
                return;
            };
            switch (_local_2.errorCode){
                case GenericErrorEnum._SafeStr_6392:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_CANT_SET_NOT_OWNER;
                    break;
                case GenericErrorEnum.RSEME_KICKED:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_KICKED;
                    break;
                case GenericErrorEnum.RSEME_GUIDE_EXISTS:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_GUIDE_EXISTS;
                    break;
                case GenericErrorEnum.RSEME_GUIDE_BUSY:
                    _local_4 = RoomSessionErrorMessageEvent.RSEME_GUIDE_BUSY;
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
// GenericErrorHandler = "_-05Z" (String#3676, DoABC#2)
// IRoomHandlerListener = "_-3Fo" (String#7627, DoABC#2)
// RoomSessionErrorMessageEvent = "_-2Xn" (String#6720, DoABC#2)
// GenericErrorEvent = "_-2X" (String#6699, DoABC#2)
// GenericErrorParser = "_-2ft" (String#6864, DoABC#2)
// GenericErrorEnum = "_-Tw" (String#8284, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// RSEME_CANT_SET_NOT_OWNER = "_-11R" (String#16514, DoABC#2)
// RSEME_KICKED = "_-1Ip" (String#17229, DoABC#2)
// RSEME_GUIDE_BUSY = "_-0OL" (String#15002, DoABC#2)
// RSEME_GUIDE_EXISTS = "_-0O6" (String#14993, DoABC#2)
// _SafeStr_6312 = "_-2JJ" (String#19781, DoABC#2)
// onGenericError = "_-1F3" (String#5159, DoABC#2)
// _SafeStr_6392 = "_-2PD" (String#20011, DoABC#2)


