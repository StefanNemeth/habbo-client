
package com.sulake.habbo.communication.messages.incoming.facebook
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.facebook.FaceBookAuthenticateMessageParser;

    public class FaceBookAuthenticateEvent extends MessageEvent implements IMessageEvent 
    {

        public function FaceBookAuthenticateEvent(_arg_1:Function)
        {
            super(_arg_1, FaceBookAuthenticateMessageParser);
        }
        public function getParser():FaceBookAuthenticateMessageParser
        {
            return ((_parser as FaceBookAuthenticateMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.facebook

// FaceBookAuthenticateEvent = "_-11l" (String#4911, DoABC#2)
// FaceBookAuthenticateMessageParser = "_-1cW" (String#5610, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


