
package com.sulake.habbo.communication.messages.parser.navigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatAccessDeniedMessageParser implements IMessageParser 
    {

        private var _userName:String = null;

        public function get userName():String
        {
            return (this._userName);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 != null){
                this._userName = _arg_1.readString();
            };
            return (true);
        }
        public function flush():Boolean
        {
            this._userName = null;
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.navigator

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// FlatAccessDeniedMessageParser = "_-1oe" (String#5835, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


