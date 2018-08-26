
package com.sulake.habbo.messenger.domain
{
    public class Message 
    {

        public static const _SafeStr_4666:int = 1;
        public static const _SafeStr_4667:int = 2;
        public static const _SafeStr_4668:int = 3;
        public static const _SafeStr_4669:int = 4;
        public static const _SafeStr_4670:int = 5;
        public static const _SafeStr_4671:int = 6;

        private var _type:int;
        private var _senderId:int;
        private var _messageText:String;
        private var _time:String;

        public function Message(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            this._type = _arg_1;
            this._senderId = _arg_2;
            this._messageText = _arg_3;
            this._time = _arg_4;
        }
        public function get messageText():String
        {
            return (this._messageText);
        }
        public function get time():String
        {
            return (this._time);
        }
        public function get senderId():int
        {
            return (this._senderId);
        }
        public function get type():int
        {
            return (this._type);
        }

    }
}//package com.sulake.habbo.messenger.domain

// Message = "_-0r8" (String#4665, DoABC#2)
// _senderId = "_-31K" (String#909, DoABC#2)
// _messageText = "_-2h2" (String#896, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// _SafeStr_4666 = "_-1Un" (String#17696, DoABC#2)
// _SafeStr_4667 = "_-0T3" (String#15172, DoABC#2)
// _SafeStr_4668 = "_-F2" (String#22815, DoABC#2)
// _SafeStr_4669 = "_-372" (String#21770, DoABC#2)
// _SafeStr_4670 = "_-256" (String#19223, DoABC#2)
// _SafeStr_4671 = "_-28X" (String#19351, DoABC#2)
// _time = "_-0d1" (String#15550, DoABC#2)


