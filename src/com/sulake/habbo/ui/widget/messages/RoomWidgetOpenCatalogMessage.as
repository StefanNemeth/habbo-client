
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenCatalogMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_OPEN_CATALOG:String = "RWGOI_MESSAGE_OPEN_CATALOG";
        public static const RWOCM_CLUB_MAIN:String = "RWOCM_CLUB_MAIN";
        public static const RWOCM_PIXELS:String = "RWOCM_PIXELS";
        public static const RWOCM_CREDITS:String = "RWOCM_CREDITS";
        public static const RWOCM_SHELLS:String = "RWOCM_SHELLS";

        private var _pageKey:String = "";

        public function RoomWidgetOpenCatalogMessage(_arg_1:String)
        {
            super(RWGOI_MESSAGE_OPEN_CATALOG);
            this._pageKey = _arg_1;
        }
        public function get pageKey():String
        {
            return (this._pageKey);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetOpenCatalogMessage = "_-2Cg" (String#6297, DoABC#2)
// RWGOI_MESSAGE_OPEN_CATALOG = "_-1a6" (String#17899, DoABC#2)
// RWOCM_CLUB_MAIN = "_-1FR" (String#17091, DoABC#2)
// RWOCM_PIXELS = "_-0H3" (String#14720, DoABC#2)
// RWOCM_CREDITS = "_-1o5" (String#18466, DoABC#2)
// RWOCM_SHELLS = "_-dw" (String#23799, DoABC#2)
// _pageKey = "_-1z7" (String#18932, DoABC#2)
// pageKey = "_-2Wl" (String#20314, DoABC#2)


