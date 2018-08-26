
package com.sulake.habbo.session.events
{
    import flash.events.Event;
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionEvent extends Event 
    {

        public static const RSE_CREATED:String = "RSE_CREATED";
        public static const RSE_STARTED:String = "RSE_STARTED";
        public static const RSE_ENDED:String = "RSE_ENDED";

        private var _session:IRoomSession;

        public function RoomSessionEvent(_arg_1:String, _arg_2:IRoomSession, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._session = _arg_2;
        }
        public function get session():IRoomSession
        {
            return (this._session);
        }

    }
}//package com.sulake.habbo.session.events

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RSE_CREATED = "_-1XM" (String#17790, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)


