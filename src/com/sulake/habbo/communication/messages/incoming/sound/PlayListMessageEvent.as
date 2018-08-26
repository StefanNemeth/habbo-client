
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;

    public class PlayListMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function PlayListMessageEvent(_arg_1:Function)
        {
            super(_arg_1, PlayListMessageParser);
        }
        public function getParser():PlayListMessageParser
        {
            return ((this._parser as PlayListMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// PlayListMessageEvent = "_-2L7" (String#19852, DoABC#2)
// PlayListMessageParser = "_-PK" (String#8191, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


