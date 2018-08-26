
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;

    public class RoomSettingsErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsErrorMessageParser);
        }
        public function getParser():RoomSettingsErrorMessageParser
        {
            return ((this._parser as RoomSettingsErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// RoomSettingsErrorEvent = "_-1sV" (String#18654, DoABC#2)
// RoomSettingsErrorMessageParser = "_-zc" (String#8872, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


