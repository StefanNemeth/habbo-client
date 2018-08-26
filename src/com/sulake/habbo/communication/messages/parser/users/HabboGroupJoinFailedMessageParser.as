
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupJoinFailedMessageParser implements IMessageParser 
    {

        private var _reason:int;

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
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HabboGroupJoinFailedMessageParser = "_-0ce" (String#4355, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// _reason = "_-10m" (String#831, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


