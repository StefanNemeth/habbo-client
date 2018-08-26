
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;

    public class CanCreateRoomEventEvent extends MessageEvent implements IMessageEvent 
    {

        public function CanCreateRoomEventEvent(_arg_1:Function)
        {
            super(_arg_1, CanCreateRoomEventMessageParser);
        }
        public function getParser():CanCreateRoomEventMessageParser
        {
            return ((this._parser as CanCreateRoomEventMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// CanCreateRoomEventMessageParser = "_-cN" (String#8463, DoABC#2)
// CanCreateRoomEventEvent = "_-2E4" (String#19572, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


