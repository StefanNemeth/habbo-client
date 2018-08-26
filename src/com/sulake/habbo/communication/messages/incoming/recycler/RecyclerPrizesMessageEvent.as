
package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerPrizesMessageParser;

    public class RecyclerPrizesMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RecyclerPrizesMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RecyclerPrizesMessageParser);
        }
        public function getParser():RecyclerPrizesMessageParser
        {
            return ((_parser as RecyclerPrizesMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.recycler

// RecyclerPrizesMessageParser = "_-J7" (String#8064, DoABC#2)
// RecyclerPrizesMessageEvent = "_-095" (String#14412, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


