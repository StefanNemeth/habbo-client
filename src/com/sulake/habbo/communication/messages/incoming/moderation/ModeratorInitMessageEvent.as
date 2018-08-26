
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitMessageParser;

    public class ModeratorInitMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorInitMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorInitMessageParser);
        }
        public function getParser():ModeratorInitMessageParser
        {
            return ((_parser as ModeratorInitMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// ModeratorInitMessageEvent = "_-3CW" (String#21976, DoABC#2)
// ModeratorInitMessageParser = "_-1ZK" (String#5549, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


