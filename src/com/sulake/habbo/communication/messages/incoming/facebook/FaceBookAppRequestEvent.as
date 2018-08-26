
package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookAppRequestMessageParser;

    public class FaceBookAppRequestEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookAppRequestEvent(_arg_1:Function)
        {
            super(_arg_1, FaceBookAppRequestMessageParser);
        }
        public function getParser():FaceBookAppRequestMessageParser
        {
            return ((_parser as FaceBookAppRequestMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.facebook

// FaceBookAppRequestEvent = "_-26B" (String#6168, DoABC#2)
// FaceBookAppRequestMessageParser = "_-07e" (String#3714, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


