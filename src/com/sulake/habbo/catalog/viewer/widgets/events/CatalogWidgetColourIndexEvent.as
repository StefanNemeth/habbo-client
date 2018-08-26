
package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetColourIndexEvent extends Event 
    {

        private var _index:int = 0;

        public function CatalogWidgetColourIndexEvent(_arg_1:int, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(WidgetEvent.CWE_COLOUR_INDEX, _arg_2, _arg_3);
            this._index = _arg_1;
        }
        public function get index():int
        {
            return (this._index);
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets.events

// CatalogWidgetColourIndexEvent = "_-00G" (String#3567, DoABC#2)


