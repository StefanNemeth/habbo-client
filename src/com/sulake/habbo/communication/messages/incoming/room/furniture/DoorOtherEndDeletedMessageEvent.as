
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DoorOtherEndDeletedMessageParser;

    public class DoorOtherEndDeletedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DoorOtherEndDeletedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DoorOtherEndDeletedMessageParser);
        }
        public function getParser():DoorOtherEndDeletedMessageParser
        {
            return ((_parser as DoorOtherEndDeletedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// DoorOtherEndDeletedMessageEvent = "_-38w" (String#21840, DoABC#2)
// DoorOtherEndDeletedMessageParser = "_-EG" (String#7958, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


