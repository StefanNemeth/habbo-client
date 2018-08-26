
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageParser;

    public class ObjectAddMessageEvent extends MessageEvent 
    {

        public function ObjectAddMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectAddMessageParser);
        }
        public function getParser():ObjectAddMessageParser
        {
            return ((_parser as ObjectAddMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectAddMessageEvent = "_-2WR" (String#20302, DoABC#2)
// ObjectAddMessageParser = "_-0Cc" (String#3802, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


