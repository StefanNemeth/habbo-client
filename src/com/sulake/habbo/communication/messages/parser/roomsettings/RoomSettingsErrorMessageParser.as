
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsErrorMessageParser implements IMessageParser 
    {

        private var _roomId:int;
        private var _errorCode:int;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomId = _arg_1.readInteger();
            this._errorCode = _arg_1.readInteger();
            return (true);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._errorCode = 0;
            return (true);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get errorCode():int
        {
            return (this._errorCode);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomSettingsErrorMessageParser = "_-zc" (String#8872, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


