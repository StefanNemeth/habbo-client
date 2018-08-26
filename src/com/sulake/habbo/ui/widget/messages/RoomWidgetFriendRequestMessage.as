
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFriendRequestMessage extends RoomWidgetMessage 
    {

        public static const RWFRM_ACCEPT:String = "RWFRM_ACCEPT";
        public static const RWFRM_DECLINE:String = "RWFRM_DECLINE";

        private var _requestId:int = 0;

        public function RoomWidgetFriendRequestMessage(_arg_1:String, _arg_2:int=0)
        {
            super(_arg_1);
            this._requestId = _arg_2;
        }
        public function get requestId():int
        {
            return (this._requestId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetFriendRequestMessage = "_-2Pw" (String#6560, DoABC#2)
// RWFRM_ACCEPT = "_-31F" (String#21548, DoABC#2)
// RWFRM_DECLINE = "_-05q" (String#14276, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)


