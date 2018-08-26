
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.UseObjectMessageParser;

    public class UseObjectMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UseObjectMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UseObjectMessageParser);
        }
        public function getParser():UseObjectMessageParser
        {
            return ((_parser as UseObjectMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// UseObjectMessageEvent = "_-0WA" (String#15286, DoABC#2)
// UseObjectMessageParser = "_-0la" (String#4537, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


