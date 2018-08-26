
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetInitPurchaseEvent extends Event 
    {

        private var _enableBuyAsGift:Boolean = true;

        public function CatalogWidgetInitPurchaseEvent(_arg_1:Boolean=true, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_INIT_PURCHASE, _arg_2, _arg_3);
            this._enableBuyAsGift = _arg_1;
        }
        public function get enableBuyAsGift():Boolean
        {
            return (this._enableBuyAsGift);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// _enableBuyAsGift = "_-3y" (String#22375, DoABC#2)
// enableBuyAsGift = "_-2q4" (String#21084, DoABC#2)
// CatalogWidgetInitPurchaseEvent = "_-2yJ" (String#7244, DoABC#2)


