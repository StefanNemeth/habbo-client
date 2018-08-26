
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DoorbellMessageParser implements IMessageParser 
    {

        private var _userName:String;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._userName = _arg_1.readString();
            return (true);
        }
        public function flush():Boolean
        {
            this._userName = null;
            return (true);
        }
        public function get userName():String
        {
            return (this._userName);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// DoorbellMessageParser = "_-aH" (String#8426, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


