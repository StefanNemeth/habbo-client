
package com.sulake.habbo.communication.messages.parser.friendlist
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InstantMessageErrorMessageParser implements IMessageParser 
    {

        private var _errorCode:int;
        private var _userId:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._errorCode = _arg_1.readInteger();
            this._userId = _arg_1.readInteger();
            return (true);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }
        public function get userId():int
        {
            return (this._userId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.friendlist

// InstantMessageErrorMessageParser = "_-1eQ" (String#5636, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


