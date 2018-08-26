
package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboBroadcastMessageParser implements IMessageParser 
    {

        private var _messageText:String = "";

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._messageText = _arg_1.readString();
            return (true);
        }
        public function get messageText():String
        {
            return (this._messageText);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.notifications

// HabboBroadcastMessageParser = "_-05N" (String#3673, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _messageText = "_-2h2" (String#896, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


