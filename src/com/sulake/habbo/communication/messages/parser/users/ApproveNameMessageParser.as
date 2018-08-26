
package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ApproveNameMessageParser implements IMessageParser 
    {

        private var _result:int;
        private var _nameValidationInfo:String;

        public function get result():int
        {
            return (this._result);
        }
        public function get nameValidationInfo():String
        {
            return (this._nameValidationInfo);
        }
        public function flush():Boolean
        {
            this._result = -1;
            this._nameValidationInfo = null;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._result = _arg_1.readInteger();
            this._nameValidationInfo = _arg_1.readString();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.users

// ApproveNameMessageParser = "_-1i-" (String#5708, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _nameValidationInfo = "_-2R" (String#619, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


