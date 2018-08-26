
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxPlayListFullMessageParser;

    public class JukeboxPlayListFullMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function JukeboxPlayListFullMessageEvent(_arg_1:Function)
        {
            super(_arg_1, JukeboxPlayListFullMessageParser);
        }
        public function getParser():JukeboxPlayListFullMessageParser
        {
            return ((this._parser as JukeboxPlayListFullMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// JukeboxPlayListFullMessageEvent = "_-0kw" (String#15863, DoABC#2)
// JukeboxPlayListFullMessageParser = "_-2Ah" (String#6259, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


