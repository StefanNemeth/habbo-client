
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.PopularRoomTagsResultMessageParser;

    public class PopularRoomTagsResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function PopularRoomTagsResultEvent(_arg_1:Function)
        {
            super(_arg_1, PopularRoomTagsResultMessageParser);
        }
        public function getParser():PopularRoomTagsResultMessageParser
        {
            return ((this._parser as PopularRoomTagsResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// PopularRoomTagsResultEvent = "_-37E" (String#21777, DoABC#2)
// PopularRoomTagsResultMessageParser = "_-2EG" (String#6326, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


