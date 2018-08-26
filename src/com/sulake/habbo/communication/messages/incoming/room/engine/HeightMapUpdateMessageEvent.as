
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.HeightMapUpdateMessageParser;

    public class HeightMapUpdateMessageEvent extends MessageEvent 
    {

        public function HeightMapUpdateMessageEvent(_arg_1:Function)
        {
            super(_arg_1, HeightMapUpdateMessageParser);
        }
        public function getParser():HeightMapUpdateMessageParser
        {
            return ((_parser as HeightMapUpdateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// HeightMapUpdateMessageEvent = "_-2Rn" (String#20111, DoABC#2)
// HeightMapUpdateMessageParser = "_-1HT" (String#5198, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


