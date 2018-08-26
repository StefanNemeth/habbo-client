
package com.sulake.habbo.communication.messages.parser.handshake
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DisconnectReasonParser implements IMessageParser 
    {

        private var _reason:int;

        public function DisconnectReasonParser()
        {
            this._reason = -1;
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._reason = _arg_1.readInteger();
            return (true);
        }
        public function get reason():int
        {
            return (this._reason);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.handshake

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// DisconnectReasonParser = "_-Ei" (String#7964, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// _reason = "_-10m" (String#831, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


