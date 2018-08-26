
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageParser;

    public class ApproveNameMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ApproveNameMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ApproveNameMessageParser);
        }
        public function getParser():ApproveNameMessageParser
        {
            return ((_parser as ApproveNameMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// ApproveNameMessageEvent = "_-2DN" (String#19542, DoABC#2)
// ApproveNameMessageParser = "_-1i-" (String#5708, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


