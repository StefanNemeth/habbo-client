
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpResultMessageParser implements IMessageParser 
    {

        private var _resultType:int;

        public function get resultType():int
        {
            return (this._resultType);
        }
        public function flush():Boolean
        {
            this._resultType = -1;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._resultType = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// CallForHelpResultMessageParser = "_-0Hy" (String#3915, DoABC#2)
// _resultType = "_-Ti" (String#23395, DoABC#2)
// resultType = "_-3m" (String#22365, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


