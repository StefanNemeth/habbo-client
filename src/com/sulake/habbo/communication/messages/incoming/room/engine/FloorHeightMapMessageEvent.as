
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.FloorHeightMapMessageParser;

    public class FloorHeightMapMessageEvent extends MessageEvent 
    {

        public function FloorHeightMapMessageEvent(_arg_1:Function)
        {
            super(_arg_1, FloorHeightMapMessageParser);
        }
        public function getParser():FloorHeightMapMessageParser
        {
            return ((_parser as FloorHeightMapMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// FloorHeightMapMessageEvent = "_-1x5" (String#18851, DoABC#2)
// FloorHeightMapMessageParser = "_-9G" (String#7849, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


