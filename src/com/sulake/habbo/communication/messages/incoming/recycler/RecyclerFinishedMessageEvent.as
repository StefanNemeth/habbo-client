
package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerFinishedMessageParser;

    public class RecyclerFinishedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_8287:int = 1;
        public static const _SafeStr_8288:int = 2;

        public function RecyclerFinishedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RecyclerFinishedMessageParser);
        }
        public function getParser():RecyclerFinishedMessageParser
        {
            return ((_parser as RecyclerFinishedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.recycler

// RecyclerFinishedMessageEvent = "_-Iu" (String#22964, DoABC#2)
// RecyclerFinishedMessageParser = "_-0EN" (String#3835, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_8287 = "_-Qo" (String#23277, DoABC#2)
// _SafeStr_8288 = "_-2lB" (String#20889, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


