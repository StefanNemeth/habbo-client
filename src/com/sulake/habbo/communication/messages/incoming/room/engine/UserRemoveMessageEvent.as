
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserRemoveMessageParser;

    public class UserRemoveMessageEvent extends MessageEvent 
    {

        public function UserRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserRemoveMessageParser);
        }
        public function getParser():UserRemoveMessageParser
        {
            return ((_parser as UserRemoveMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UserRemoveMessageParser = "_-0h" (String#4445, DoABC#2)
// UserRemoveMessageEvent = "_-2U" (String#20197, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


