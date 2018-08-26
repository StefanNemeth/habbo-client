
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageParser;

    public class OneWayDoorStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function OneWayDoorStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, OneWayDoorStatusMessageParser);
        }
        public function getParser():OneWayDoorStatusMessageParser
        {
            return ((_parser as OneWayDoorStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// OneWayDoorStatusMessageEvent = "_-316" (String#21542, DoABC#2)
// OneWayDoorStatusMessageParser = "_-0CN" (String#3797, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


