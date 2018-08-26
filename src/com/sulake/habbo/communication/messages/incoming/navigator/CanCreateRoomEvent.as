
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;

    public class CanCreateRoomEvent extends MessageEvent implements IMessageEvent 
    {

        public function CanCreateRoomEvent(_arg_1:Function)
        {
            super(_arg_1, CanCreateRoomMessageParser);
        }
        public function getParser():CanCreateRoomMessageParser
        {
            return ((this._parser as CanCreateRoomMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// CanCreateRoomMessageParser = "_-303" (String#7305, DoABC#2)
// CanCreateRoomEvent = "_-1fL" (String#18111, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


