
package com.sulake.room.events
{
    import flash.events.Event;

    public class RoomContentLoadedEvent extends Event 
    {

        public static const RCLE_SUCCESS:String = "RCLE_SUCCESS";
        public static const RCLE_FAILURE:String = "RCLE_FAILURE";
        public static const RCLE_CANCEL:String = "RCLE_CANCEL";

        private var _contentType:String;

        public function RoomContentLoadedEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this._contentType = _arg_2;
        }
        public function get contentType():String
        {
            return (this._contentType);
        }

    }
}//package com.sulake.room.events

// RoomContentLoadedEvent = "_-0sn" (String#16153, DoABC#2)
// RCLE_SUCCESS = "_-2gW" (String#20711, DoABC#2)
// RCLE_FAILURE = "_-2Qp" (String#20081, DoABC#2)
// RCLE_CANCEL = "_-OH" (String#23179, DoABC#2)
// _contentType = "_-Pl" (String#23237, DoABC#2)
// contentType = "_-1bf" (String#17960, DoABC#2)


