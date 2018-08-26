
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatSelectAvatarMessage extends RoomWidgetMessage 
    {

        public static const RWCSAM_MESSAGE_SELECT_AVATAR:String = "RWCSAM_MESSAGE_SELECT_AVATAR";

        private var _objectId:int;
        private var _userName:String;
        private var _roomId:int;
        private var _roomCategory:int;

        public function RoomWidgetChatSelectAvatarMessage(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int)
        {
            super(_arg_1);
            this._objectId = _arg_2;
            this._roomId = _arg_4;
            this._userName = _arg_3;
            this._roomCategory = _arg_5;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetChatSelectAvatarMessage = "_-3-" (String#21461, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCSAM_MESSAGE_SELECT_AVATAR = "_-2R1" (String#20086, DoABC#2)


