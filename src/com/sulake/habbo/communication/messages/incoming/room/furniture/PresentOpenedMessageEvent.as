
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageParser;

    public class PresentOpenedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PresentOpenedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PresentOpenedMessageParser);
        }
        public function getParser():PresentOpenedMessageParser
        {
            return ((_parser as PresentOpenedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// PresentOpenedMessageEvent = "_-1Zb" (String#17874, DoABC#2)
// PresentOpenedMessageParser = "_-25F" (String#6147, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


