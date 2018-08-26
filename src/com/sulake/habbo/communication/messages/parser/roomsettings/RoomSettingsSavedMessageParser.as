
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsSavedMessageParser implements IMessageParser 
    {

        private var _roomId:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomId = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            return (true);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomSettingsSavedMessageParser = "_-2XT" (String#6711, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


