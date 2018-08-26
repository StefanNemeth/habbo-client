
package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;

    public class RoomSettingsSaveErrorEvent extends MessageEvent implements IMessageEvent 
    {

        public function RoomSettingsSaveErrorEvent(_arg_1:Function)
        {
            super(_arg_1, RoomSettingsSaveErrorMessageParser);
        }
        public function getParser():RoomSettingsSaveErrorMessageParser
        {
            return ((this._parser as RoomSettingsSaveErrorMessageParser));
        }

    }
}//package com.sulake.habbo.communication.messages.incoming.roomsettings

// RoomSettingsSaveErrorMessageParser = "_-33e" (String#7377, DoABC#2)
// RoomSettingsSaveErrorEvent = "_-iy" (String#23997, DoABC#2)
// _parser = "_-2Ja" (String#19793, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// MessageEvent = "_-2qA" (String#7082, DoABC#2)


