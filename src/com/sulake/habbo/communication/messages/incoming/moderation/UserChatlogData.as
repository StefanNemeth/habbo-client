
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChatlogData 
    {

        private var _userId:int;
        private var _userName:String;
        private var _rooms:Array;

        public function UserChatlogData(_arg_1:IMessageDataWrapper)
        {
            this._rooms = new Array();
            super();
            this._userId = _arg_1.readInteger();
            this._userName = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._rooms.push(new RoomChatlogData(_arg_1));
                _local_3++;
            };
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get userName():String
        {
            return (this._userName);
        }
        public function get rooms():Array
        {
            return (this._rooms);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomChatlogData = "_-2h1" (String#6893, DoABC#2)
// UserChatlogData = "_-3BV" (String#7540, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _rooms = "_-36o" (String#456, DoABC#2)


