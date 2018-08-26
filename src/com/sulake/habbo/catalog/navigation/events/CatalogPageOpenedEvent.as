
package com.sulake.habbo.catalog.navigation.events
{
    import flash.events.Event;

    public class CatalogPageOpenedEvent extends Event 
    {

        public static const CATALOG_PAGE_OPENED:String = "CATALOG_PAGE_OPENED";

        private var _pageId:int;
        private var _pageLocalization:String;

        public function CatalogPageOpenedEvent(_arg_1:int, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(CATALOG_PAGE_OPENED, _arg_3, _arg_4);
            this._pageId = _arg_1;
            this._pageLocalization = _arg_2;
        }
        public function get pageId():int
        {
            return (this._pageId);
        }
        public function get pageLocalization():String
        {
            return (this._pageLocalization);
        }

    }
}//package com.sulake.habbo.catalog.navigation.events

// _pageId = "_-251" (String#366, DoABC#2)
// _pageLocalization = "_-BU" (String#22672, DoABC#2)
// pageLocalization = "_-2Re" (String#20106, DoABC#2)
// CatalogPageOpenedEvent = "_-EN" (String#22786, DoABC#2)


