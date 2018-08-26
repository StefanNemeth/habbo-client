
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetEcotronBoxOpenMessage extends RoomWidgetMessage 
    {

        public static const RWEBOM_OPEN_ECOTRONBOX:String = "RWEBOM_OPEN_ECOTRONBOX";

        private var _objectId:int;

        public function RoomWidgetEcotronBoxOpenMessage(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            this._objectId = _arg_2;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetEcotronBoxOpenMessage = "_-1bG" (String#17946, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWEBOM_OPEN_ECOTRONBOX = "_-0Mx" (String#14952, DoABC#2)


