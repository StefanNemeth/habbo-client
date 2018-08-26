
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _postureType:String;
        private var _parameter:String;

        public function RoomObjectAvatarPostureUpdateMessage(_arg_1:String, _arg_2:String="")
        {
            this._postureType = _arg_1;
            this._parameter = _arg_2;
        }
        public function get postureType():String
        {
            return (this._postureType);
        }
        public function get parameter():String
        {
            return (this._parameter);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarPostureUpdateMessage = "_-0OI" (String#15001, DoABC#2)
// postureType = "_-1It" (String#17232, DoABC#2)
// _postureType = "_-2PF" (String#20012, DoABC#2)
// _parameter = "_-083" (String#1410, DoABC#2)


