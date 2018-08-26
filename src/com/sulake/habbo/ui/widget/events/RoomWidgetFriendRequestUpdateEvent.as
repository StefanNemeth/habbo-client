
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetFriendRequestUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWFRUE_SHOW_FRIEND_REQUEST:String = "RWFRUE_SHOW_FRIEND_REQUEST";
        public static const RWFRUE_HIDE_FRIEND_REQUEST:String = "RWFRUE_HIDE_FRIEND_REQUEST";

        private var _requestId:int;
        private var _userId:int;
        private var _userName:String;

        public function RoomWidgetFriendRequestUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:int=0, _arg_4:String=null, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this._requestId = _arg_2;
            this._userId = _arg_3;
            this._userName = _arg_4;
        }
        public function get requestId():int
        {
            return (this._requestId);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetFriendRequestUpdateEvent = "_-mJ" (String#8650, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// RWFRUE_SHOW_FRIEND_REQUEST = "_-0R-" (String#15102, DoABC#2)
// RWFRUE_HIDE_FRIEND_REQUEST = "_-12A" (String#16542, DoABC#2)


