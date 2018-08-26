
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.CarryObjectMessageParser;

    public class CarryObjectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function CarryObjectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, CarryObjectMessageParser);
        }
        public function getParser():CarryObjectMessageParser
        {
            return ((_parser as CarryObjectMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// CarryObjectMessageEvent = "_-0Fw" (String#14680, DoABC#2)
// CarryObjectMessageParser = "_-2TI" (String#6629, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


