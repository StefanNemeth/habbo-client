
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetClothingChangeUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWCCUE_SHOW_GENDER_SELECTION:String = "RWCCUE_SHOW_GENDER_SELECTION";
        public static const RWCCUE_SHOW_CLOTHING_EDITOR:String = "RWCCUE_SHOW_CLOTHING_EDITOR";

        private var _objectId:int = -1;
        private var _objectCategory:int = -1;
        private var _roomId:int = -1;
        private var _roomCategory:int = -1;

        public function RoomWidgetClothingChangeUpdateEvent(_arg_1:String, _arg_2:int=0, _arg_3:int=0, _arg_4:int=0, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_6, _arg_7);
            this._objectId = _arg_2;
            this._objectCategory = _arg_3;
            this._roomId = _arg_4;
            this._roomCategory = _arg_5;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectCategory():int
        {
            return (this._objectCategory);
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetClothingChangeUpdateEvent = "_-0RK" (String#4119, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// RWCCUE_SHOW_GENDER_SELECTION = "_-0dg" (String#15572, DoABC#2)
// RWCCUE_SHOW_CLOTHING_EDITOR = "_-0Zz" (String#15440, DoABC#2)


