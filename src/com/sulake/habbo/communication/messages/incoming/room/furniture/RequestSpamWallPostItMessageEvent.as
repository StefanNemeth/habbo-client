
package com.sulake.habbo.communication.messages.incoming.room.furniture
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;

    public class RequestSpamWallPostItMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function RequestSpamWallPostItMessageEvent(_arg_1:Function)
        {
            super(_arg_1, RequestSpamWallPostItMessageParser);
        }
        public function getParser():RequestSpamWallPostItMessageParser
        {
            return ((_parser as RequestSpamWallPostItMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.furniture

// RequestSpamWallPostItMessageEvent = "_-1v-" (String#18755, DoABC#2)
// RequestSpamWallPostItMessageParser = "_-0QR" (String#4101, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


