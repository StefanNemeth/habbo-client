
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.UsersMessageParser;

    public class UsersMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UsersMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UsersMessageParser);
        }
        public function getParser():UsersMessageParser
        {
            return ((_parser as UsersMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// UsersMessageParser = "_-3Iv" (String#7687, DoABC#2)
// UsersMessageEvent = "_-2MA" (String#19891, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


