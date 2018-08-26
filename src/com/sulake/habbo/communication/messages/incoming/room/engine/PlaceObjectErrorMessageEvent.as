
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.PlaceObjectErrorMessageParser;

    public class PlaceObjectErrorMessageEvent extends MessageEvent 
    {

        public function PlaceObjectErrorMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PlaceObjectErrorMessageParser);
        }
        public function getParser():PlaceObjectErrorMessageParser
        {
            return ((_parser as PlaceObjectErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// PlaceObjectErrorMessageParser = "_-0H1" (String#3896, DoABC#2)
// PlaceObjectErrorMessageEvent = "_-Z4" (String#23604, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


