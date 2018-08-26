
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetFurniActionMessage extends RoomWidgetMessage 
    {

        public static const RWFUAM_ROTATE:String = "RWFUAM_ROTATE";
        public static const RWFAM_MOVE:String = "RWFAM_MOVE";
        public static const RWFAM_PICKUP:String = "RWFAM_PICKUP";
        public static const RWFAM_USE:String = "RWFAM_USE";
        public static const RWFAM_OPEN_WELCOME_GIFT:String = "RWFAM_OPEN_WELCOME_GIFT";
        public static const RWFAM_SAVE_STUFF_DATA:String = "RWFAM_SAVE_STUFF_DATA";

        private var _furniId:int = 0;
        private var _furniCategory:int = 0;
        private var _objectData:String;

        public function RoomWidgetFurniActionMessage(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:String=null)
        {
            super(_arg_1);
            this._furniId = _arg_2;
            this._furniCategory = _arg_3;
            this._objectData = _arg_4;
        }
        public function get furniId():int
        {
            return (this._furniId);
        }
        public function get furniCategory():int
        {
            return (this._furniCategory);
        }
        public function get objectData():String
        {
            return (this._objectData);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetFurniActionMessage = "_-02g" (String#3622, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWFUAM_ROTATE = "_-1J1" (String#17237, DoABC#2)
// RWFAM_MOVE = "_-07t" (String#14359, DoABC#2)
// RWFAM_PICKUP = "_-0VQ" (String#15258, DoABC#2)
// RWFAM_USE = "_-7c" (String#22527, DoABC#2)
// RWFAM_OPEN_WELCOME_GIFT = "_-2ef" (String#20633, DoABC#2)
// RWFAM_SAVE_STUFF_DATA = "_-0oi" (String#16001, DoABC#2)
// _furniCategory = "_-25E" (String#19227, DoABC#2)
// _objectData = "_-1Ih" (String#17222, DoABC#2)
// furniCategory = "_-UL" (String#23423, DoABC#2)


