
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;

    public class RoomSettingsSavedEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSavedEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsSavedMessageParser);
        }
        public function getParser():RoomSettingsSavedMessageParser
        {
            return ((this._parser as RoomSettingsSavedMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// RoomSettingsSavedMessageParser = "_-2XT" (String#6711, DoABC#2)
// RoomSettingsSavedEvent = "_-QI" (String#23262, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


