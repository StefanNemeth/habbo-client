
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;

    public class JukeboxSongDisksMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxSongDisksMessageEvent(_arg_1:Function)
        {
            super(_arg_1, JukeboxSongDisksMessageParser);
        }
        public function getParser():JukeboxSongDisksMessageParser
        {
            return ((this._parser as JukeboxSongDisksMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// JukeboxSongDisksMessageEvent = "_-0c1" (String#15514, DoABC#2)
// JukeboxSongDisksMessageParser = "_-23t" (String#6119, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


