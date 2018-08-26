
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IgnoreResultMessageParser implements IMessageParser 
    {

        protected var _result:int;

        public function IgnoreResultMessageParser()
        {
            this._result = -1;
        }
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
// IgnoreResultMessageParser = "_-1AP" (String#5082, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


