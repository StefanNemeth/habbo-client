
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FriendNotificationMessageParser implements IMessageParser 
    {

        private var _typeCode:int = -1;
        private var _avatarId:String;
        private var _message:String;

        public function get typeCode():int
        {
            return (this._typeCode);
        }
        public function get avatarId():String
        {
            return (this._avatarId);
        }
        public function get message():String
        {
            return (this._message);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._avatarId = _arg_1.readString();
            this._typeCode = _arg_1.readInteger();
            this._message = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FriendNotificationMessageParser = "_-0Ns" (String#14984, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _avatarId = "_-0qk" (String#592, DoABC#2)
// _typeCode = "_-1wZ" (String#18824, DoABC#2)
// typeCode = "_-vq" (String#24522, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


