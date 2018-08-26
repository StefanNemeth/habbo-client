
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.SoundSettingsParser;

    public class SoundSettingsEvent extends MessageEvent implements IMessageEvent 
    {

        public function SoundSettingsEvent(_arg_1:Function)
        {
            super(_arg_1, SoundSettingsParser);
        }
        public function getParser():SoundSettingsParser
        {
            return ((this._parser as SoundSettingsParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// SoundSettingsEvent = "_-0Zh" (String#15431, DoABC#2)
// SoundSettingsParser = "_-WA" (String#8325, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


