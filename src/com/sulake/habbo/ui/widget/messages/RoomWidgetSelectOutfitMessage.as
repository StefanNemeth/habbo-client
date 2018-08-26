
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetSelectOutfitMessage extends RoomWidgetMessage 
    {

        public static const _SafeStr_3580:String = "select_outfit";

        private var _outfitId:int;

        public function RoomWidgetSelectOutfitMessage(_arg_1:int)
        {
            super(_SafeStr_3580);
            this._outfitId = _arg_1;
        }
        public function get outfitId():int
        {
            return (this._outfitId);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetSelectOutfitMessage = "_-2cP" (String#6801, DoABC#2)
// _SafeStr_3580 = "_-30-" (String#21501, DoABC#2)
// _outfitId = "_-1cV" (String#17990, DoABC#2)
// outfitId = "_-1CO" (String#16961, DoABC#2)


