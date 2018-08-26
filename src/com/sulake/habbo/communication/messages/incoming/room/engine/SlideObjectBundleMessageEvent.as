
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.SlideObjectBundleMessageParser;

    public class SlideObjectBundleMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function SlideObjectBundleMessageEvent(_arg_1:Function)
        {
            super(_arg_1, SlideObjectBundleMessageParser);
        }
        public function getParser():SlideObjectBundleMessageParser
        {
            return ((_parser as SlideObjectBundleMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// SlideObjectBundleMessageEvent = "_-35" (String#21695, DoABC#2)
// SlideObjectBundleMessageParser = "_-255" (String#6143, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


