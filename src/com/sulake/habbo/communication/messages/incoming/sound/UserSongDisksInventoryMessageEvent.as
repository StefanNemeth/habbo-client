
package com.sulake.habbo.communication.messages.incoming.sound
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;

    public class UserSongDisksInventoryMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function UserSongDisksInventoryMessageEvent(_arg_1:Function)
        {
            super(_arg_1, UserSongDisksInventoryMessageParser);
        }
        public function getParser():UserSongDisksInventoryMessageParser
        {
            return ((this._parser as UserSongDisksInventoryMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.sound

// UserSongDisksInventoryMessageParser = "_-BX" (String#7901, DoABC#2)
// UserSongDisksInventoryMessageEvent = "_-1In" (String#17227, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


