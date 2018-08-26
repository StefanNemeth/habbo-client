
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.room.IRoomEngine;

    public class MultiProductContainer extends SingleProductContainer 
    {

        public function MultiProductContainer(_arg_1:Offer, _arg_2:Array)
        {
            super(_arg_1, _arg_2);
        }
        override public function initProductIcon(_arg_1:IRoomEngine):void
        {
            super.initProductIcon(_arg_1);
            var _local_2:IWindow = _view.findChildByName("multiContainer");
            if (_local_2){
                _local_2.visible = true;
            };
            var _local_3:ITextWindow = (_view.findChildByName("multiCounter") as ITextWindow);
            if (_local_3){
                _local_3.text = ("x" + firstProduct.productCount);
            };
            this.setClubIconLevel(offer.clubLevel);
        }

    }
}//package com.sulake.habbo.catalog.viewer

// Offer = "_-0m2" (String#4550, DoABC#2)
// SingleProductContainer = "_-1RF" (String#5380, DoABC#2)
// MultiProductContainer = "_-2MD" (String#6486, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// setClubIconLevel = "_-09M" (String#3745, DoABC#2)


