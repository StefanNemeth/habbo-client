
package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.IgnoreResultMessageParser;

    public class IgnoreResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function IgnoreResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, IgnoreResultMessageParser);
        }
        public function get result():int
        {
            return ((_parser as IgnoreResultMessageParser).result);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.users

// IgnoreResultMessageEvent = "_-2UA" (String#6651, DoABC#2)
// IgnoreResultMessageParser = "_-1AP" (String#5082, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


