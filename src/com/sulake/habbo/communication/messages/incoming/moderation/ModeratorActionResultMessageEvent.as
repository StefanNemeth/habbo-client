
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorActionResultMessageParser;

    public class ModeratorActionResultMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorActionResultMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorActionResultMessageParser);
        }
        public function getParser():ModeratorActionResultMessageParser
        {
            return ((_parser as ModeratorActionResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// ModeratorActionResultMessageEvent = "_-2a-" (String#20441, DoABC#2)
// ModeratorActionResultMessageParser = "_-2-r" (String#6043, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


