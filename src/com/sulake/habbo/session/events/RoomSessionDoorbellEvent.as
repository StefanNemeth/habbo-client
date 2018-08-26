
package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionDoorbellEvent extends RoomSessionEvent 
    {

        public static const RSDE_DOORBELL:String = "RSDE_DOORBELL";
        public static const RWDE_REJECTED:String = "RSDE_REJECTED";
        public static const RWDE_ACCEPTED:String = "RSDE_ACCEPTED";

        private var _userName:String = "";

        public function RoomSessionDoorbellEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            this._userName = _arg_3;
        }
        public function get userName():String
        {
            return (this._userName);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionDoorbellEvent = "_-30k" (String#7320, DoABC#2)
// RSDE_DOORBELL = "_-0bt" (String#15507, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// RWDE_REJECTED = "_-1MV" (String#17378, DoABC#2)


