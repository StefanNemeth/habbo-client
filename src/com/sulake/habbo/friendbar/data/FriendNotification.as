
package com.sulake.habbo.friendbar.data
{
    public class FriendNotification 
    {

        public static const _SafeStr_10917:int = -1;
        public static const _SafeStr_10926:int = 0;
        public static const TYPE_ACHIEVEMENT:int = 1;
        public static const _SafeStr_10927:int = 2;

        public var typeCode:int = -1;
        public var message:String;
        public var viewOnce:Boolean;

        public function FriendNotification(_arg_1:int, _arg_2:String, _arg_3:Boolean)
        {
            this.typeCode = _arg_1;
            this.message = _arg_2;
            this.viewOnce = _arg_3;
        }
        public static function typeCodeToString(_arg_1:int):String
        {
            switch (_arg_1){
                case _SafeStr_10917:
                    return ("instant_message");
                case _SafeStr_10926:
                    return ("room_event");
                case TYPE_ACHIEVEMENT:
                    return ("achievement");
                case _SafeStr_10927:
                    return ("quest");
            };
            return ("unknown");
        }

    }
}//package com.sulake.habbo.friendbar.data

// _SafeStr_10917 = "_-0Pj" (String#15051, DoABC#2)
// viewOnce = "_-3JO" (String#22260, DoABC#2)
// typeCodeToString = "_-AL" (String#22630, DoABC#2)
// _SafeStr_10926 = "_-hv" (String#23961, DoABC#2)
// _SafeStr_10927 = "_-0RU" (String#15120, DoABC#2)
// typeCode = "_-vq" (String#24522, DoABC#2)


