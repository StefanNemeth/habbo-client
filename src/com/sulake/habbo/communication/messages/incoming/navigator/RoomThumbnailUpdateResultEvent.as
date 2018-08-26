
package com.sulake.habbo.communication.messages.incoming.navigator
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomThumbnailUpdateResultMessageParser;

    public class RoomThumbnailUpdateResultEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomThumbnailUpdateResultEvent(_arg_1:Function)
        {
            super(_arg_1, RoomThumbnailUpdateResultMessageParser);
        }
        public function getParser():RoomThumbnailUpdateResultMessageParser
        {
            return ((this._parser as RoomThumbnailUpdateResultMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.navigator

// RoomThumbnailUpdateResultMessageParser = "_-2v2" (String#7180, DoABC#2)
// RoomThumbnailUpdateResultEvent = "_-VE" (String#23458, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


