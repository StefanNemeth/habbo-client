
package com.sulake.habbo.friendbar.utils
{
    public class LinkTarget 
    {

        public static const NONE:uint = 0;
        public static const _SafeStr_10974:uint = 1;
        public static const ROOM:uint = 2;
        public static const ACHIEVEMENTS:uint = 3;
        public static const _SafeStr_10975:uint = 4;
        public static const RSFRE_FRIEND_REQUEST:uint = 5;

        private var _text:String;
        private var _type:uint;
        private var _identifier:uint;
        private var _extraData:String;

        public function LinkTarget(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:String=null)
        {
            this._text = _arg_1;
            this._type = _arg_2;
            this._identifier = _arg_3;
            this._extraData = _arg_4;
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get type():uint
        {
            return (this._type);
        }
        public function get identifier():uint
        {
            return (this._identifier);
        }
        public function get extraData():String
        {
            return (this._extraData);
        }

    }
}//package com.sulake.habbo.friendbar.utils

// _SafeStr_10974 = "_-0Ib" (String#14784, DoABC#2)
// _SafeStr_10975 = "_-2Dk" (String#19556, DoABC#2)
// _extraData = "_-29m" (String#19394, DoABC#2)
// LinkTarget = "_-1HG" (String#1650, DoABC#2)
// RSFRE_FRIEND_REQUEST = "_-2Wu" (String#20318, DoABC#2)
// _identifier = "_-1Ax" (String#1628, DoABC#2)


