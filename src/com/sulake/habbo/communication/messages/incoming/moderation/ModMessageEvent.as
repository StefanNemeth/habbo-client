
package com.sulake.habbo.communication.messages.incoming.moderation
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.moderation.ModMessageParser;

    public class ModMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ModMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ModMessageParser);
        }
        public function getParser():ModMessageParser
        {
            return ((_parser as ModMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.moderation

// ModMessageEvent = "_-2Uh" (String#20226, DoABC#2)
// ModMessageParser = "_-2IO" (String#6409, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


