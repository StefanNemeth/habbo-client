
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;
    import com.sulake.habbo.catalog.viewer.Offer;

    public class SelectProductEvent extends Event 
    {

        private var _offer:Offer;

        public function SelectProductEvent(_arg_1:Offer, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_SELECT_PRODUCT, _arg_2, _arg_3);
            this._offer = _arg_1;
        }
        public function get offer():Offer
        {
            return (this._offer);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// Offer = "_-0m2" (String#4550, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)


