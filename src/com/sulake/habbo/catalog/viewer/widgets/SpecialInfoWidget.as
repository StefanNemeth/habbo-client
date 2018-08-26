
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;

    public class SpecialInfoWidget extends CatalogWidget implements ICatalogWidget 
    {

        public function SpecialInfoWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onPreviewProduct);
            return (true);
        }
        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            _window.visible = false;
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onPreviewProduct = "_-r4" (String#2207, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// SpecialInfoWidget = "_-id" (String#23984, DoABC#2)


