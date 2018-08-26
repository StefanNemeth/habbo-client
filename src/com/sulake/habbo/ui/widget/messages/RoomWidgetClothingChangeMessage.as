
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetClothingChangeMessage extends RoomWidgetMessage 
    {

        public static const RWCCM_REQUEST_EDITOR:String = "RWCCM_REQUEST_EDITOR";

        private var _objectId:int = 0;
        private var _objectCategory:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _gender:String = "";

        public function RoomWidgetClothingChangeMessage(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int)
        {
            super(_arg_1);
            this._gender = _arg_2;
            this._objectId = _arg_3;
            this._objectCategory = _arg_4;
            this._roomId = _arg_5;
            this._roomCategory = _arg_6;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectCategory():int
        {
            return (this._objectCategory);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get gender():String
        {
            return (this._gender);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetClothingChangeMessage = "_-2Tf" (String#6638, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCCM_REQUEST_EDITOR = "_-14O" (String#16632, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)


