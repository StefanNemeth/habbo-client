
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetPlayListModificationMessage extends RoomWidgetMessage 
    {

        public static const RWPLAM_ADD_TO_PLAYLIST:String = "RWPLAM_ADD_TO_PLAYLIST";
        public static const RWPLAM_REMOVE_FROM_PLAYLIST:String = "RWPLAM_REMOVE_FROM_PLAYLIST";

        private var _diskId:int;
        private var _slotNumber:int;

        public function RoomWidgetPlayListModificationMessage(_arg_1:String, _arg_2:int=-1, _arg_3:int=-1)
        {
            super(_arg_1);
            this._slotNumber = _arg_2;
            this._diskId = _arg_3;
        }
        public function get diskId():int
        {
            return (this._diskId);
        }
        public function get slotNumber():int
        {
            return (this._slotNumber);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetPlayListModificationMessage = "_-tW" (String#8759, DoABC#2)
// RWPLAM_ADD_TO_PLAYLIST = "_-1Ju" (String#17270, DoABC#2)
// RWPLAM_REMOVE_FROM_PLAYLIST = "_-26-" (String#19259, DoABC#2)
// _diskId = "_-08o" (String#3736, DoABC#2)
// _slotNumber = "_-0Er" (String#14637, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// slotNumber = "_-xM" (String#24583, DoABC#2)


