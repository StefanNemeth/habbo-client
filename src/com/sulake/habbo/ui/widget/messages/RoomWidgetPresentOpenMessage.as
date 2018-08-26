
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPresentOpenMessage extends RoomWidgetMessage 
    {

        public static const RWVFM_OPEN_PRESENT:String = "RWPOM_OPEN_PRESENT";

        private var _objectId:int;

        public function RoomWidgetPresentOpenMessage(_arg_1:String, _arg_2:int)
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
// RoomWidgetPresentOpenMessage = "_-1ti" (String#18706, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)


