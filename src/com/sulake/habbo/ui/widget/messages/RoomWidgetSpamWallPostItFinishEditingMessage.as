
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSpamWallPostItFinishEditingMessage extends RoomWidgetMessage 
    {

        public static const RWSWPFEE_SEND_POSTIT_DATA:String = "RWSWPFEE_SEND_POSTIT_DATA";

        private var _objectId:int;
        private var _location:String;
        private var _text:String;
        private var _colorHex:String;

        public function RoomWidgetSpamWallPostItFinishEditingMessage(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String)
        {
            super(_arg_1);
            this._objectId = _arg_2;
            this._location = _arg_3;
            this._text = _arg_4;
            this._colorHex = _arg_5;
        }
        public function get location():String
        {
            return (this._location);
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
// RoomWidgetSpamWallPostItFinishEditingMessage = "_-zJ" (String#24665, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _colorHex = "_-0io" (String#821, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)
// RWSWPFEE_SEND_POSTIT_DATA = "_-35M" (String#21708, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)


