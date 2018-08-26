
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.ViralTeaserActiveMessageParser;

    public class ViralTeaserActiveMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ViralTeaserActiveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, ViralTeaserActiveMessageParser);
        }
        public function getParser():ViralTeaserActiveMessageParser
        {
            return ((_parser as ViralTeaserActiveMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// ViralTeaserActiveMessageEvent = "_-2mO" (String#20934, DoABC#2)
// ViralTeaserActiveMessageParser = "_-36i" (String#7444, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


