
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.NoSuchFlatMessageParser;

    public class NoSuchFlatEvent extends MessageEvent implements IMessageEvent 
    {

        public function NoSuchFlatEvent(_arg_1:Function)
        {
            super(_arg_1, NoSuchFlatMessageParser);
        }
        public function getParser():NoSuchFlatMessageParser
        {
            return ((this._parser as NoSuchFlatMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// NoSuchFlatEvent = "_-0fA" (String#15636, DoABC#2)
// NoSuchFlatMessageParser = "_-3Fj" (String#7625, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


