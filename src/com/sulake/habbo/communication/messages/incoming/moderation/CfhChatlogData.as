
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CfhChatlogData 
    {

        private var _callId:int;
        private var _callerUserId:int;
        private var _reportedUserId:int;
        private var _chatRecordId:int;
        private var _room:RoomChatlogData;

        public function CfhChatlogData(_arg_1:IMessageDataWrapper)
        {
            this._callId = _arg_1.readInteger();
            this._callerUserId = _arg_1.readInteger();
            this._reportedUserId = _arg_1.readInteger();
            this._chatRecordId = _arg_1.readInteger();
            this._room = new RoomChatlogData(_arg_1);
            Logger.log(("READ CFHCHATLOGDATA: callId: " + this._callId));
        }
        public function get callId():int
        {
            return (this._callId);
        }
        public function get callerUserId():int
        {
            return (this._callerUserId);
        }
        public function get reportedUserId():int
        {
            return (this._reportedUserId);
        }
        public function get chatRecordId():int
        {
            return (this._chatRecordId);
        }
        public function get room():RoomChatlogData
        {
            return (this._room);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomChatlogData = "_-2h1" (String#6893, DoABC#2)
// CfhChatlogData = "_-34O" (String#7397, DoABC#2)
// _reportedUserId = "_-0gc" (String#819, DoABC#2)
// _room = "_-1eJ" (String#1732, DoABC#2)
// _callId = "_-36N" (String#21743, DoABC#2)
// _callerUserId = "_-dM" (String#23774, DoABC#2)
// _chatRecordId = "_-9i" (String#7857, DoABC#2)
// callerUserId = "_-0hf" (String#15734, DoABC#2)
// chatRecordId = "_-M6" (String#23087, DoABC#2)


