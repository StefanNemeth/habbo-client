
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetVoteMessage extends RoomWidgetMessage 
    {

        public static const RWE_ROOM_VOTE:String = "RWVM_VOTE_MESSAGE";

        private var _vote:int;

        public function RoomWidgetVoteMessage(_arg_1:int)
        {
            super(RWE_ROOM_VOTE);
            this._vote = _arg_1;
        }
        public function get vote():int
        {
            return (this._vote);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetVoteMessage = "_-0ie" (String#4475, DoABC#2)
// RWE_ROOM_VOTE = "_-1yq" (String#18921, DoABC#2)
// _vote = "_-1EJ" (String#5148, DoABC#2)
// vote = "_-AW" (String#7878, DoABC#2)


