
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorRoomInfoMessageParser;

    public class ModeratorRoomInfoEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModeratorRoomInfoEvent(_arg_1:Function)
        {
            super(_arg_1, ModeratorRoomInfoMessageParser);
        }
        public function getParser():ModeratorRoomInfoMessageParser
        {
            return ((_parser as ModeratorRoomInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// ModeratorRoomInfoEvent = "_-0m0" (String#15897, DoABC#2)
// ModeratorRoomInfoMessageParser = "_-1aP" (String#5567, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


