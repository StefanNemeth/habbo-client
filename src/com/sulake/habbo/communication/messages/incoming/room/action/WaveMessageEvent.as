
package com.sulake.habbo.communication.messages.incoming.room.action
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.action.WaveMessageParser;

    public class WaveMessageEvent extends MessageEvent 
    {

        public function WaveMessageEvent(_arg_1:Function)
        {
            super(_arg_1, WaveMessageParser);
        }
        public function getParser():WaveMessageParser
        {
            return ((_parser as WaveMessageParser));
        }
        public function get isWaving():Boolean
        {
            return (this.getParser().isWaving);
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.action

// WaveMessageEvent = "_-47" (String#22383, DoABC#2)
// WaveMessageParser = "_-1ck" (String#5615, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// isWaving = "_-0Ph" (String#15050, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


