
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;

    public class PlayListSongAddedMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListSongAddedMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PlayListSongAddedMessageParser);
        }
        public function getParser():PlayListSongAddedMessageParser
        {
            return ((this._parser as PlayListSongAddedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// PlayListSongAddedMessageEvent = "_-2z0" (String#21427, DoABC#2)
// PlayListSongAddedMessageParser = "_-19g" (String#5070, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


