
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage 
    {

        public static const RWSUM_STICKIE_SEND_UPDATE:String = "RWSUM_STICKIE_SEND_UPDATE";
        public static const RWSUM_STICKIE_SEND_DELETE:String = "RWSUM_STICKIE_SEND_DELETE";

        private var _objectId:int;
        private var _text:String;
        private var _colorHex:String;

        public function RoomWidgetStickieSendUpdateMessage(_arg_1:String, _arg_2:int, _arg_3:String="", _arg_4:String="")
        {
            super(_arg_1);
            this._objectId = _arg_2;
            this._text = _arg_3;
            this._colorHex = _arg_4;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get colorHex():String
        {
            return (this._colorHex);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetStickieSendUpdateMessage = "_-1vS" (String#5950, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWSUM_STICKIE_SEND_UPDATE = "_-0Zu" (String#15438, DoABC#2)
// RWSUM_STICKIE_SEND_DELETE = "_-v1" (String#24492, DoABC#2)
// _colorHex = "_-0io" (String#821, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)


