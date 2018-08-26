
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChangeEmailResultParser implements IMessageParser 
    {

        private var _result:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._result = _arg_1.readInteger();
            return (true);
        }
        public function get result():int
        {
            return (this._result);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// ChangeEmailResultParser = "_-1nm" (String#5814, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


