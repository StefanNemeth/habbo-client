
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorUserInfoMessageParser;

    public class ModeratorUserInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorUserInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorUserInfoMessageParser);
        }
        public function getParser():ModeratorUserInfoMessageParser
        {
            return ((_parser as ModeratorUserInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// ModeratorUserInfoEvent = "_-24q" (String#19216, DoABC#2)
// ModeratorUserInfoMessageParser = "_-0E5" (String#3829, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


