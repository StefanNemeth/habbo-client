
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageParser;

    public class ObjectDataUpdateMessageEvent extends MessageEvent 
    {

        public function ObjectDataUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ObjectDataUpdateMessageParser);
        }
        public function getParser():ObjectDataUpdateMessageParser
        {
            return ((_parser as ObjectDataUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ObjectDataUpdateMessageEvent = "_-344" (String#21661, DoABC#2)
// ObjectDataUpdateMessageParser = "_-2K4" (String#6444, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


