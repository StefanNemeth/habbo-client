
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChangeEmailMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_3493:String = "rwcem_change_email";

        private var _newEmail:String;

        public function RoomWidgetChangeEmailMessage(_arg_1:String)
        {
            super(_SafeStr_3493);
            this._newEmail = _arg_1;
        }
        public function get newEmail():String
        {
            return (this._newEmail);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetChangeEmailMessage = "_-2iU" (String#6920, DoABC#2)
// _SafeStr_3493 = "_-1A8" (String#16863, DoABC#2)
// _newEmail = "_-16d" (String#5008, DoABC#2)
// newEmail = "_-3EG" (String#22047, DoABC#2)


