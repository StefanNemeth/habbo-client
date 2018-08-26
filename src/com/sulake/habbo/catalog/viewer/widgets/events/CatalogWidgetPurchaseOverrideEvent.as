
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetPurchaseOverrideEvent extends Event 
    {

        private var _callback:Function;

        public function CatalogWidgetPurchaseOverrideEvent(_arg_1:Function, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_PURCHASE_OVERRIDE, _arg_2, _arg_3);
            this._callback = _arg_1;
        }
        public function get callback():Function
        {
            return (this._callback);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// CatalogWidgetPurchaseOverrideEvent = "_-0IB" (String#3920, DoABC#2)
// _callback = "_-0t2" (String#593, DoABC#2)


