
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomChatlogData 
    {

        private var _isPublic:Boolean;
        private var _roomId:int;
        private var _roomName:String;
        private var _chatlog:Array;

        public function RoomChatlogData(_arg_1:IMessageDataWrapper)
        {
            this._chatlog = new Array();
            super();
            this._isPublic = _arg_1.readBoolean();
            this._roomId = _arg_1.readInteger();
            this._roomName = _arg_1.readString();
            var _local_2:int = _arg_1.readInteger();
            var _local_3:int;
            while (_local_3 < _local_2) {
                this._chatlog.push(new ChatlineData(_arg_1));
                _local_3++;
            };
            Logger.log(((((((("READ ROOMCHATLOGDATA: " + this._isPublic) + ", ") + this._roomId) + ", ") + this._roomName) + ", ") + this.chatlog.length));
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
        public function get chatlog():Array
        {
            return (this._chatlog);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomChatlogData = "_-2h1" (String#6893, DoABC#2)
// ChatlineData = "_-0ap" (String#4320, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// readBoolean = "_-0ZR" (String#1499, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// _isPublic = "_-2nD" (String#898, DoABC#2)
// _chatlog = "_-ib" (String#23982, DoABC#2)
// chatlog = "_-26z" (String#19292, DoABC#2)
// isPublic = "_-2lD" (String#20891, DoABC#2)


