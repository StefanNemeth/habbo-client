
package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenMessageParser implements IMessageParser 
    {

        private var _stuffId:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._stuffId = _arg_1.readInteger();
            return (true);
        }
        public function get stuffId():int
        {
            return (this._stuffId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.userdefinedroomevents

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// OpenMessageParser = "_-m5" (String#8645, DoABC#2)
// _stuffId = "_-0wq" (String#4787, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


