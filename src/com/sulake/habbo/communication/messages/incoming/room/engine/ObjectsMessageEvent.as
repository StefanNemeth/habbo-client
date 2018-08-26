
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageParser;

    public class ObjectsMessageEvent extends MessageEvent 
    {

        public function ObjectsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectsMessageParser);
        }
        public function getParser():ObjectsMessageParser
        {
            return ((_parser as ObjectsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectsMessageEvent = "_-22v" (String#19131, DoABC#2)
// ObjectsMessageParser = "_-25T" (String#6150, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


