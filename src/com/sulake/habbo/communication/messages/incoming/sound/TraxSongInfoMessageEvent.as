
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;

    public class TraxSongInfoMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function TraxSongInfoMessageEvent(_arg_1:Function)
        {
            super(_arg_1, TraxSongInfoMessageParser);
        }
        public function getParser():TraxSongInfoMessageParser
        {
            return ((this._parser as TraxSongInfoMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// TraxSongInfoMessageParser = "_-Tc" (String#8278, DoABC#2)
// TraxSongInfoMessageEvent = "_-37D" (String#21776, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


