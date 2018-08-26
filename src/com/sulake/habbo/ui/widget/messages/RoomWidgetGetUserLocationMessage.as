
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetGetUserLocationMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_GET_USER_LOCATION:String = "RWGOI_MESSAGE_GET_USER_LOCATION";

        private var _userId:int;
        private var _userType:int;

        public function RoomWidgetGetUserLocationMessage(_arg_1:int, _arg_2:int)
        {
            super(RWGOI_MESSAGE_GET_USER_LOCATION);
            this._userId = _arg_1;
            this._userType = _arg_2;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userType():int
        {
            return (this._userType);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetGetUserLocationMessage = "_-2z-" (String#7262, DoABC#2)
// RWGOI_MESSAGE_GET_USER_LOCATION = "_-kp" (String#24062, DoABC#2)
// _userType = "_-1N3" (String#1672, DoABC#2)
// userType = "_-0Dh" (String#14596, DoABC#2)


