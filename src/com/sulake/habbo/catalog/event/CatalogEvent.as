
package com.sulake.habbo.catalog.event
{
    import flash.events.Event;

    public class CatalogEvent extends Event 
    {

        public static const CATALOG_INITIALIZED:String = "CATALOG_INITIALIZED";
        public static const CATALOG_NOT_READY:String = "CATALOG_NOT_READY";
        public static const CATALOG_NEW_ITEMS_SHOW:String = "CATALOG_NEW_ITEMS_SHOW";
        public static const CATALOG_NEW_ITEMS_HIDE:String = "CATALOG_NEW_ITEMS_HIDE";

        public function CatalogEvent(_arg_1:String)
        {
            super(_arg_1, false, false);
        }
    }
}//package com.sulake.habbo.catalog.event

// CatalogEvent = "_-Sw" (String#23361, DoABC#2)


