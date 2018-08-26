
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;

    public class CatalogWidget 
    {

        protected var _window:IWindowContainer;
        protected var _events:IEventDispatcher;
        private var _page:ICatalogPage;
        private var _disposed:Boolean;

        public function CatalogWidget(_arg_1:IWindowContainer)
        {
            this._window = _arg_1;
        }
        public function set page(_arg_1:ICatalogPage):void
        {
            this._page = _arg_1;
        }
        public function set events(_arg_1:IEventDispatcher):void
        {
            this._events = _arg_1;
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function get events():IEventDispatcher
        {
            return (this._events);
        }
        public function get page():ICatalogPage
        {
            return (this._page);
        }
        public function dispose():void
        {
            this._events = null;
            this._page = null;
            this._window = null;
            this._disposed = true;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function init():Boolean
        {
            return (true);
        }
        public function closed():void
        {
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _page = "_-1VJ" (String#607, DoABC#2)


