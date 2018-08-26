
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisitData 
    {

        private var _isPublic:Boolean;
        private var _roomId:int;
        private var _roomName:String;
        private var _enterHour:int;
        private var _enterMinute:int;

        public function RoomVisitData(_arg_1:IMessageDataWrapper)
        {
            this._isPublic = _arg_1.readBoolean();
            this._roomId = _arg_1.readInteger();
            this._roomName = _arg_1.readString();
            this._enterHour = _arg_1.readInteger();
            this._enterMinute = _arg_1.readInteger();
        }
        public function get isPublic():Boolean
        {
            return (this._isPublic);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomName():String
        {
            return (this._roomName);
        }
        public function get enterHour():int
        {
            return (this._enterHour);
        }
        public function get enterMinute():int
        {
            return (this._enterMinute);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomVisitData = "_-0MU" (String#4011, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _isPublic = "_-2nD" (String#898, DoABC#2)
// isPublic = "_-2lD" (String#20891, DoABC#2)
// _enterHour = "_-0IH" (String#14770, DoABC#2)
// _enterMinute = "_-YT" (String#23579, DoABC#2)
// enterHour = "_-0oR" (String#15992, DoABC#2)
// enterMinute = "_-0DZ" (String#14591, DoABC#2)


