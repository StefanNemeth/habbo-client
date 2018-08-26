
package com.sulake.habbo.communication.messages.incoming.advertisement
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdMessageParser;

    public class RoomAdMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomAdMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RoomAdMessageParser);
        }
        public function getParser():RoomAdMessageParser
        {
            return ((this._parser as RoomAdMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.advertisement

// RoomAdMessageEvent = "_-1vW" (String#18778, DoABC#2)
// RoomAdMessageParser = "_-0w3" (String#4770, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


