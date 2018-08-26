
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageParser;

    public class ObjectRemoveMessageEvent extends MessageEvent 
    {

        public function ObjectRemoveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectRemoveMessageParser);
        }
        public function getParser():ObjectRemoveMessageParser
        {
            return ((_parser as ObjectRemoveMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectRemoveMessageEvent = "_-36g" (String#21754, DoABC#2)
// ObjectRemoveMessageParser = "_-06f" (String#3694, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


