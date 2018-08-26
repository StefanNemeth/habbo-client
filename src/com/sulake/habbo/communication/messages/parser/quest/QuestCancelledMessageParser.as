
package com.sulake.habbo.communication.messages.parser.quest
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class QuestCancelledMessageParser implements IMessageParser 
    {

        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.quest

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// QuestCancelledMessageParser = "_-2Lc" (String#6475, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


