
package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.recycler.RecyclerStatusMessageParser;

    public class RecyclerStatusMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public static const _SafeStr_8289:int = 1;
        public static const _SafeStr_8290:int = 2;
        public static const _SafeStr_8291:int = 3;

        public function RecyclerStatusMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RecyclerStatusMessageParser);
        }
        public function getParser():RecyclerStatusMessageParser
        {
            return ((_parser as RecyclerStatusMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.recycler

// RecyclerStatusMessageParser = "_-0fr" (String#4422, DoABC#2)
// RecyclerStatusMessageEvent = "_-8f" (String#22567, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_8289 = "_-30N" (String#21516, DoABC#2)
// _SafeStr_8290 = "_-0Oe" (String#15014, DoABC#2)
// _SafeStr_8291 = "_-2kW" (String#20866, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


