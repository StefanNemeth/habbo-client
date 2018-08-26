
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetLetUserInMessage extends RoomWidgetMessage 
    {

        public static const RWLUIM_LET_USER_IN:String = "RWLUIM_LET_USER_IN";

        private var _userName:String;
        private var _canEnter:Boolean;

        public function RoomWidgetLetUserInMessage(_arg_1:String, _arg_2:Boolean)
        {
            super(RWLUIM_LET_USER_IN);
            this._userName = _arg_1;
            this._canEnter = _arg_2;
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get canEnter():Boolean
        {
            return (this._canEnter);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetLetUserInMessage = "_-2Tq" (String#6644, DoABC#2)
// RWLUIM_LET_USER_IN = "_-3G7" (String#22122, DoABC#2)
// _canEnter = "_-2Q2" (String#20044, DoABC#2)
// canEnter = "_-1wn" (String#18835, DoABC#2)


