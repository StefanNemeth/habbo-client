
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _figure:String;
        private var _race:String;
        private var _gender:String;

        public function RoomObjectAvatarFigureUpdateMessage(_arg_1:String, _arg_2:String=null, _arg_3:String=null)
        {
            this._figure = _arg_1;
            this._gender = _arg_2;
            this._race = _arg_3;
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get race():String
        {
            return (this._race);
        }
        public function get gender():String
        {
            return (this._gender);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarFigureUpdateMessage = "_-0tn" (String#16195, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _race = "_-R-" (String#8229, DoABC#2)


