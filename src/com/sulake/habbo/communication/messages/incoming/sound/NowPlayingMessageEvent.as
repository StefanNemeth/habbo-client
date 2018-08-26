
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;

    public class NowPlayingMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function NowPlayingMessageEvent(_arg_1:Function)
        {
            super(_arg_1, NowPlayingMessageParser);
        }
        public function getParser():NowPlayingMessageParser
        {
            return ((this._parser as NowPlayingMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// NowPlayingMessageEvent = "_-0NW" (String#14973, DoABC#2)
// NowPlayingMessageParser = "_-2On" (String#6536, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


