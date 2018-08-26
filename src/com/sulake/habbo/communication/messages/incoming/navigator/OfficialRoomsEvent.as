
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;

    public class OfficialRoomsEvent extends MessageEvent implements IMessageEvent 
    {

        public function OfficialRoomsEvent(_arg_1:Function)
        {
            super(_arg_1, OfficialRoomsMessageParser);
        }
        public function getParser():OfficialRoomsMessageParser
        {
            return ((this._parser as OfficialRoomsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// OfficialRoomsMessageParser = "_-28N" (String#6209, DoABC#2)
// OfficialRoomsEvent = "_-o0" (String#24191, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


