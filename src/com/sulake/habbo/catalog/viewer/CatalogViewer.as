
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.HabboCatalog;
    import flash.events.Event;

    public class CatalogViewer implements ICatalogViewer 
    {

        private var _catalog:IHabboCatalog;
        private var _container:IWindowContainer;
        private var _roomEngine:IRoomEngine;
        private var _habboCatalog:HabboCatalog;
        private var _page:ICatalogPage;

        public function CatalogViewer(_arg_1:IHabboCatalog, _arg_2:IWindowContainer, _arg_3:IRoomEngine)
        {
            this._catalog = _arg_1;
            this._container = _arg_2;
            this._roomEngine = _arg_3;
        }
        public function get roomEngine():IRoomEngine
        {
            return (this._roomEngine);
        }
        public function set habboCatalog(_arg_1:HabboCatalog):void
        {
            this._habboCatalog = _arg_1;
        }
        public function get habboCatalog():HabboCatalog
        {
            return (this._habboCatalog);
        }
        public function dispose():void
        {
            if (this._page){
                this._page.dispose();
                this._page = null;
            };
            this._catalog = null;
            this._container = null;
            this._roomEngine = null;
        }
        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }
        public function showCatalogPage(_arg_1:int, _arg_2:String, _arg_3:IPageLocalization, _arg_4:Array, _arg_5:int):void
        {
            Logger.log(("[Catalog Viewer] Show Catalog Page: " + [_arg_1, _arg_2, _arg_4.length, _arg_5]));
            if (this._page != null){
                if (this._page.pageId == _arg_1){
                    if (_arg_5 > -1){
                        this._page.selectOffer(_arg_5);
                    };
                    return;
                };
                this._container.removeChild(this._page.window);
                this._page.dispose();
            };
            var _local_6:ICatalogPage = new CatalogPage(this, _arg_1, _arg_2, _arg_3, _arg_4, this._habboCatalog);
            this._page = _local_6;
            if (_local_6.window != null){
                this._container.addChild(_local_6.window);
            }
            else {
                Logger.log(("[CatalogViewer] No window for page: " + _arg_2));
            };
            this._container.visible = true;
            if (_arg_5 > -1){
                _local_6.selectOffer(_arg_5);
            };
        }
        public function catalogWindowClosed():void
        {
            if (this._page != null){
                this._page.closed();
            };
        }
        public function dispatchWidgetEvent(_arg_1:Event):Boolean
        {
            return (this._page.dispatchWidgetEvent(_arg_1));
        }
        public function getCurrentLayoutCode():String
        {
            if (this._page == null){
                return ("");
            };
            return (this._page.layoutCode);
        }

    }
}//package com.sulake.habbo.catalog.viewer

// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// ICatalogViewer = "_-Ve" (String#8313, DoABC#2)
// CatalogViewer = "_-0IW" (String#3924, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// CatalogPage = "_-0jJ" (String#4486, DoABC#2)
// _page = "_-1VJ" (String#607, DoABC#2)
// showCatalogPage = "_-0nw" (String#4589, DoABC#2)
// dispatchWidgetEvent = "_-2V-" (String#1888, DoABC#2)
// getCurrentLayoutCode = "_-nh" (String#2189, DoABC#2)
// _habboCatalog = "_-1Ia" (String#17217, DoABC#2)
// habboCatalog = "_-2De" (String#19551, DoABC#2)
// selectOffer = "_-26U" (String#6175, DoABC#2)
// catalogWindowClosed = "_-2fZ" (String#20672, DoABC#2)


