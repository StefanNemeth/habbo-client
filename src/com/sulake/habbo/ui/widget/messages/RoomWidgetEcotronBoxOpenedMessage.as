
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage 
    {

        public static const RWEBOM_ECOTRONBOX_OPENED:String = "RWEBOM_ECOTRONBOX_OPENED";

        private var _itemType:String;
        private var _classId:int;

        public function RoomWidgetEcotronBoxOpenedMessage(_arg_1:String, _arg_2:String, _arg_3:int)
        {
            super(_arg_1);
            this._itemType = _arg_2;
            this._classId = _arg_3;
        }
        public function get itemType():String
        {
            return (this._itemType);
        }
        public function get classId():int
        {
            return (this._classId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetEcotronBoxOpenedMessage = "_-0qv" (String#4659, DoABC#2)
// RWEBOM_ECOTRONBOX_OPENED = "_-2Ag" (String#19433, DoABC#2)
// _itemType = "_-0dA" (String#242, DoABC#2)
// _classId = "_-172" (String#597, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)


