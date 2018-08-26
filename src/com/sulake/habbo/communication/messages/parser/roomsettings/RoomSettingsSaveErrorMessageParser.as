
package com.sulake.habbo.communication.messages.parser.roomsettings
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsSaveErrorMessageParser implements IMessageParser 
    {

        public static const _SafeStr_5564:int = 1;
        public static const _SafeStr_5565:int = 2;
        public static const _SafeStr_5566:int = 3;
        public static const _SafeStr_5567:int = 4;
        public static const _SafeStr_5568:int = 5;
        public static const _SafeStr_5569:int = 6;
        public static const _SafeStr_5570:int = 7;
        public static const _SafeStr_5571:int = 8;
        public static const _SafeStr_5572:int = 9;
        public static const _SafeStr_5573:int = 10;
        public static const _SafeStr_5574:int = 11;
        public static const _SafeStr_5575:int = 12;

        private var _roomId:int;
        private var _errorCode:int;
        private var _info:String;

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            this._roomId = _arg_1.readInteger();
            this._errorCode = _arg_1.readInteger();
            this._info = _arg_1.readString();
            return (true);
        }
        public function flush():Boolean
        {
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
        public function get info():String
        {
            return (this._info);
        }

    }
}//package com.sulake.habbo.communication.messages.parser.roomsettings

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomSettingsSaveErrorMessageParser = "_-33e" (String#7377, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _errorCode = "_-2il" (String#127, DoABC#2)
// _SafeStr_5564 = "_-Mt" (String#23122, DoABC#2)
// _SafeStr_5565 = "_-1fs" (String#18132, DoABC#2)
// _SafeStr_5566 = "_-36b" (String#21750, DoABC#2)
// _SafeStr_5567 = "_-2pa" (String#21062, DoABC#2)
// _SafeStr_5568 = "_-0Xj" (String#15344, DoABC#2)
// _SafeStr_5569 = "_-12x" (String#16578, DoABC#2)
// _SafeStr_5570 = "_-2OU" (String#19985, DoABC#2)
// _SafeStr_5571 = "_-d7" (String#23763, DoABC#2)
// _SafeStr_5572 = "_-2BB" (String#19451, DoABC#2)
// _SafeStr_5573 = "_-1KG" (String#17285, DoABC#2)
// _SafeStr_5574 = "_-2XS" (String#20340, DoABC#2)
// _SafeStr_5575 = "_-Vh" (String#23480, DoABC#2)
// _info = "_-0ry" (String#4686, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


