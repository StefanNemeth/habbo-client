
package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueCloseNotificationMessageParser implements IMessageParser 
    {

        private var _closeReason:int;

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._closeReason = _arg_1.readInteger();
            return (true);
        }
        public function get closeReason():int
        {
            return (this._closeReason);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.help

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// IssueCloseNotificationMessageParser = "_-02p" (String#3626, DoABC#2)
// _closeReason = "_-3Hy" (String#22200, DoABC#2)
// closeReason = "_-1kC" (String#18296, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


