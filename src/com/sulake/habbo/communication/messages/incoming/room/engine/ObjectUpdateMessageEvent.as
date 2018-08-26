
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageParser;

    public class ObjectUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectUpdateMessageParser);
        }
        public function getParser():ObjectUpdateMessageParser
        {
            return ((_parser as ObjectUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectUpdateMessageEvent = "_-06L" (String#14301, DoABC#2)
// ObjectUpdateMessageParser = "_-3Da" (String#7589, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


