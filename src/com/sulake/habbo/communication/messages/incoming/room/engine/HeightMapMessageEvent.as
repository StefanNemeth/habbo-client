
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapMessageParser;

    public class HeightMapMessageEvent extends MessageEvent 
    {

        public function HeightMapMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HeightMapMessageParser);
        }
        public function getParser():HeightMapMessageParser
        {
            return ((_parser as HeightMapMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// HeightMapMessageEvent = "_-06-" (String#14282, DoABC#2)
// HeightMapMessageParser = "_-2Bb" (String#6278, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


