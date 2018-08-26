
package com.sulake.habbo.communication.messages.parser.sound
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class SoundSettingsParser implements IMessageParser 
    {

        private var _volume:int;

        public function get volume():int
        {
            return (this._volume);
        }
        public function flush():Boolean
        {
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._volume = _arg_1.readInteger();
            return (true);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.sound

// SoundSettingsParser = "_-WA" (String#8325, DoABC#2)
// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


