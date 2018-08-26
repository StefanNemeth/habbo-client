
package com.sulake.habbo.communication.messages.incoming.room.engine
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.engine.PublicRoomObjectsMessageParser;

    public class PublicRoomObjectsMessageEvent extends MessageEvent 
    {

        public function PublicRoomObjectsMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PublicRoomObjectsMessageParser);
        }
        public function getParser():PublicRoomObjectsMessageParser
        {
            return ((_parser as PublicRoomObjectsMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.room.engine

// PublicRoomObjectsMessageEvent = "_-25B" (String#6145, DoABC#2)
// PublicRoomObjectsMessageParser = "_-if" (String#8570, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


