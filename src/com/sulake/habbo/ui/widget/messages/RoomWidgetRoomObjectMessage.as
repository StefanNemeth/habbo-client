
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetRoomObjectMessage extends RoomWidgetMessage 
    {

        public static const RWROM_GET_OBJECT_INFO:String = "RWROM_GET_OBJECT_INFO";
        public static const RWROM_GET_OBJECT_NAME:String = "RWROM_GET_OBJECT_NAME";
        public static const RWROM_SELECT_OBJECT:String = "RWROM_SELECT_OBJECT";
        public static const RWROM_GET_OWN_CHARACTER_INFO:String = "RWROM_GET_OWN_CHARACTER_INFO";
        public static const RWROM_GET_AVATAR_LIST:String = "RWROM_GET_AVATAR_LIST";

        private var _id:int = 0;
        private var _category:int = 0;

        public function RoomWidgetRoomObjectMessage(_arg_1:String, _arg_2:int, _arg_3:int)
        {
            super(_arg_1);
            this._id = _arg_2;
            this._category = _arg_3;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RWROM_GET_OBJECT_INFO = "_-cp" (String#23747, DoABC#2)
// RWROM_GET_OBJECT_NAME = "_-1vl" (String#18788, DoABC#2)
// RWROM_SELECT_OBJECT = "_-1RI" (String#17557, DoABC#2)
// RWROM_GET_OWN_CHARACTER_INFO = "_-1C2" (String#16944, DoABC#2)
// RWROM_GET_AVATAR_LIST = "_-1JP" (String#17252, DoABC#2)


