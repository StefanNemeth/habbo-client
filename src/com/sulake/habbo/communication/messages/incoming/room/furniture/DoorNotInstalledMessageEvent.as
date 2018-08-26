
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.DoorNotInstalledMessageParser;

    public class DoorNotInstalledMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function DoorNotInstalledMessageEvent(_arg_1:Function)
        {
            super(_arg_1, DoorNotInstalledMessageParser);
        }
        public function getParser():DoorNotInstalledMessageParser
        {
            return ((_parser as DoorNotInstalledMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// DoorNotInstalledMessageParser = "_-0cn" (String#4360, DoABC#2)
// DoorNotInstalledMessageEvent = "_-38b" (String#21825, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


