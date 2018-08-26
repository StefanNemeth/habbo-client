
package com.sulake.habbo.room.messages
{
    public class RoomObjectAvatarFlatControlUpdateMessage extends RoomObjectUpdateStateMessage 
    {

        private var _isAdmin:Boolean = false;
        private var _rawData:String;

        public function RoomObjectAvatarFlatControlUpdateMessage(_arg_1:String)
        {
            this._rawData = _arg_1;
            if (((!((_arg_1 == null))) && (!((_arg_1.indexOf("useradmin") == -1))))){
                this._isAdmin = true;
            };
        }
        public function get isAdmin():Boolean
        {
            return (this._isAdmin);
        }
        public function get rawData():String
        {
            return (this._rawData);
        }

    }
}//package com.sulake.habbo.room.messages

// RoomObjectUpdateStateMessage = "_-2WY" (String#6691, DoABC#2)
// RoomObjectAvatarFlatControlUpdateMessage = "_-0bw" (String#15508, DoABC#2)
// rawData = "_-1ug" (String#18745, DoABC#2)
// isAdmin = "_-1O3" (String#17436, DoABC#2)
// _isAdmin = "_-2og" (String#21031, DoABC#2)
// _rawData = "_-0xs" (String#16348, DoABC#2)


