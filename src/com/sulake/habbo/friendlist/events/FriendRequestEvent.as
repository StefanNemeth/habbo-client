
package com.sulake.habbo.friendlist.events
{
    import flash.events.Event;

    public class FriendRequestEvent extends Event 
    {

        public static const RWDE_ACCEPTED:String = "FRE_ACCEPTED";
        public static const FRE_DECLINED:String = "FRE_DECLINED";

        private var _requestId:int;

        public function FriendRequestEvent(_arg_1:String, _arg_2:int, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._requestId = _arg_2;
        }
        public function get requestId():int
        {
            return (this._requestId);
        }

    }
}//package com.sulake.habbo.friendlist.events

// FriendRequestEvent = "_-1SF" (String#17590, DoABC#2)
// _requestId = "_-1GH" (String#301, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// FRE_DECLINED = "_-2IY" (String#19749, DoABC#2)


