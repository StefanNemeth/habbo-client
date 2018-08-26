
package com.sulake.habbo.communication.messages.parser.room.chat
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserTypingMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _userId:int = 0;
        private var _isTyping:Boolean = false;

        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get isTyping():Boolean
        {
            return (this._isTyping);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;
            this._isTyping = false;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            this._userId = _arg_1.readInteger();
            this._isTyping = (_arg_1.readInteger() == 1);
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.chat

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// UserTypingMessageParser = "_-0cL" (String#4351, DoABC#2)
// _isTyping = "_-2z6" (String#624, DoABC#2)
// isTyping = "_-1wh" (String#18831, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


