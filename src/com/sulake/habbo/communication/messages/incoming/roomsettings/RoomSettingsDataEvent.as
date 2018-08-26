
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;

    public class RoomSettingsDataEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsDataEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsDataMessageParser);
        }
        public function getParser():RoomSettingsDataMessageParser
        {
            return ((this._parser as RoomSettingsDataMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// RoomSettingsDataEvent = "_-6N" (String#22479, DoABC#2)
// RoomSettingsDataMessageParser = "_-0dz" (String#4391, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


