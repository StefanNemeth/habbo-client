
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.CfhChatlogMessageParser;

    public class CfhChatlogEvent extends MessageEvent implements IMessageEvent 
    {

        public function CfhChatlogEvent(_arg_1:Function)
        {
            super(_arg_1, CfhChatlogMessageParser);
        }
        public function getParser():CfhChatlogMessageParser
        {
            return ((_parser as CfhChatlogMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// CfhChatlogEvent = "_-ax" (String#23668, DoABC#2)
// CfhChatlogMessageParser = "_-2Gb" (String#6379, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


