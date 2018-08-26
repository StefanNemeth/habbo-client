
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NewConsoleMessageMessageParser implements IMessageParser 
    {

        private var _senderId:int;
        private var _messageText:String;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._senderId = _arg_1.readInteger();
            this._messageText = _arg_1.readString();
            return (true);
        }
        public function get senderId():int
        {
            return (this._senderId);
        }
        public function get messageText():String
        {
            return (this._messageText);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// NewConsoleMessageMessageParser = "_-01u" (String#14124, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _senderId = "_-31K" (String#909, DoABC#2)
// _messageText = "_-2h2" (String#896, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


