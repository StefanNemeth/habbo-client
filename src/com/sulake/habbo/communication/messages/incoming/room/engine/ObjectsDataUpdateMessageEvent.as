
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageParser;

    public class ObjectsDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectsDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectsDataUpdateMessageParser);
        }
        public function getParser():ObjectsDataUpdateMessageParser
        {
            return ((_parser as ObjectsDataUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectsDataUpdateMessageEvent = "_-2Gx" (String#6385, DoABC#2)
// ObjectsDataUpdateMessageParser = "_-fN" (String#8502, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


