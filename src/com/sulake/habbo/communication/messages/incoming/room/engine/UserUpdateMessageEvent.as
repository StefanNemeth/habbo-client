
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UserUpdateMessageParser;

    public class UserUpdateMessageEvent extends MessageEvent 
    {

        public function UserUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserUpdateMessageParser);
        }
        public function getParser():UserUpdateMessageParser
        {
            return ((_parser as UserUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UserUpdateMessageEvent = "_-0CW" (String#14549, DoABC#2)
// UserUpdateMessageParser = "_-2BT" (String#6276, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


