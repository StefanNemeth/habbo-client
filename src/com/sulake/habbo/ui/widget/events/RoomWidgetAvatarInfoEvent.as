
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetAvatarInfoEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWAIE_AVATAR_INFO:String = "RWAIE_AVATAR_INFO";

        private var _userId:int;
        private var _userName:String;
        private var _allowNameChange:Boolean;
        private var _roomIndex:int;

        public function RoomWidgetAvatarInfoEvent(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(RWAIE_AVATAR_INFO, _arg_5, _arg_6);
            this._userId = _arg_1;
            this._userName = _arg_2;
            this._roomIndex = _arg_3;
            this._allowNameChange = _arg_4;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get roomIndex():int
        {
            return (this._roomIndex);
        }
        public function get allowNameChange():Boolean
        {
            return (this._allowNameChange);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetAvatarInfoEvent = "_-2sQ" (String#7129, DoABC#2)
// _roomIndex = "_-1S2" (String#362, DoABC#2)
// RWAIE_AVATAR_INFO = "_-2QK" (String#20059, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// _allowNameChange = "_-21h" (String#1802, DoABC#2)


