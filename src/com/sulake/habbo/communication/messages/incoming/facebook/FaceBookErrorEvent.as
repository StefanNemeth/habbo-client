
package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookErrorMessageParser;

    public class FaceBookErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookErrorEvent(_arg_1:Function)
        {
            super(_arg_1, FaceBookErrorMessageParser);
        }
        public function getParser():FaceBookErrorMessageParser
        {
            return ((_parser as FaceBookErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.facebook

// FaceBookErrorEvent = "_-0LT" (String#3990, DoABC#2)
// FaceBookErrorMessageParser = "_-18S" (String#5047, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


