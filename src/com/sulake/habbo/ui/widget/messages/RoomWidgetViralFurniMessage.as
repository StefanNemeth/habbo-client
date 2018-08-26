
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetViralFurniMessage extends RoomWidgetMessage 
    {

        public static const RWVFM_VIRAL_FOUND:String = "RWVFM_VIRAL_FOUND";
        public static const RWVFM_OPEN_PRESENT:String = "RWVFM_OPEN_PRESENT";

        private var _objectId:int;

        public function RoomWidgetViralFurniMessage(_arg_1:String)
        {
            super(_arg_1);
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function set objectId(_arg_1:int):void
        {
            this._objectId = _arg_1;
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetViralFurniMessage = "_-2jy" (String#6954, DoABC#2)
// RWVFM_VIRAL_FOUND = "_-22P" (String#19106, DoABC#2)
// RWVFM_OPEN_PRESENT = "_-Bb" (String#22674, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)


