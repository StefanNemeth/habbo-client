
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetSellablePetBreedsEvent extends Event 
    {

        private var _productCode:String;
        private var _sellableBreeds:Array;

        public function CatalogWidgetSellablePetBreedsEvent(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(WidgetEvent.CWE_SELLABLE_PET_BREEDS, _arg_3, _arg_4);
            this._productCode = _arg_1;
            this._sellableBreeds = _arg_2;
        }
        public function get productCode():String
        {
            return (this._productCode);
        }
        public function get sellableBreeds():Array
        {
            if (this._sellableBreeds != null){
                return (this._sellableBreeds.slice());
            };
            return ([]);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// _sellableBreeds = "_-15E" (String#1618, DoABC#2)
// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// CatalogWidgetSellablePetBreedsEvent = "_-eO" (String#23818, DoABC#2)
// _productCode = "_-uv" (String#312, DoABC#2)
// productCode = "_-2co" (String#20558, DoABC#2)


