
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;

    public class SingleViewCatalogWidget extends ProductViewCatalogWidget implements ICatalogWidget 
    {

        public function SingleViewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            return (true);
        }
        public function onWidgetsInitialized(_arg_1:CatalogWidgetsInitializedEvent):void
        {
            if (page.offers.length == 0){
                return;
            };
            var _local_2:Offer = page.offers[0];
            events.dispatchEvent(new SelectProductEvent(_local_2));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onWidgetsInitialized = "_-2Ty" (String#890, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// ProductViewCatalogWidget = "_-gM" (String#8516, DoABC#2)
// SingleViewCatalogWidget = "_-0aE" (String#4306, DoABC#2)


