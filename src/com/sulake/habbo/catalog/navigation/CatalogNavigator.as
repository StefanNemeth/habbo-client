
package com.sulake.habbo.catalog.navigation
{
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NodeData;
    import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class CatalogNavigator implements ICatalogNavigator 
    {

        private var _catalog:IHabboCatalog;
        private var _container:IWindowContainer;
        private var _content:IItemListWindow;
        private var _index:ICatalogNode;
        private var _SafeStr_10295:Array;
        private var _scrollBar:IScrollbarWindow;
        private var _SafeStr_10296:String = "magic.credits";
        private var _SafeStr_10297:String = "magic.pixels";
        private var _SafeStr_10298:String = "catalog.page.club";

        public function CatalogNavigator(_arg_1:IHabboCatalog, _arg_2:IWindowContainer)
        {
            var _local_3:IWindow;
            var _local_4:IWindow;
            var _local_5:IWindow;
            super();
            this._catalog = _arg_1;
            this._container = _arg_2;
            this._SafeStr_10295 = [];
            this._content = (this._container.findChildByName("navigationList") as IItemListWindow);
            if (_arg_1.configuration.getBoolean("catalog.show.purse", false)){
                _local_3 = this._container.findChildByName("creditsContainer");
                _local_4 = this._container.findChildByName("pixelsContainer");
                _local_5 = this._container.findChildByName("clubContainer");
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _local_3.addEventListener(WindowMouseEvent.WME_OUT, this.onNavigatorEvent);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _local_4.addEventListener(WindowMouseEvent.WME_OUT, this.onNavigatorEvent);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onNavigatorEvent);
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onNavigatorEvent);
                _local_5.addEventListener(WindowMouseEvent.WME_OUT, this.onNavigatorEvent);
            };
            this._scrollBar = (this._container.findChildByName("navigationListScrollbar") as IScrollbarWindow);
            if (this._scrollBar != null){
                this._scrollBar.visible = false;
                this._scrollBar.addEventListener(WindowEvent.WE_ENABLE, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_ENABLED, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_DISABLE, this.deActivateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_DISABLED, this.deActivateScrollbar);
            };
        }
        public function isInitialized():Boolean
        {
            return (!((this._index == null)));
        }
        public function dispose():void
        {
            this._catalog = null;
            this._container = null;
            this._content = null;
            if (this._index){
                this._index.dispose();
            };
            this._index = null;
            this._SafeStr_10295 = null;
            this._scrollBar = null;
        }
        public function buildCatalogIndex(_arg_1:NodeData):void
        {
            var _local_2:ICatalogNode;
            this._index = null;
            this._index = this.buildIndexNode(_arg_1, 0);
            for each (_local_2 in this._index.children) {
                if (_local_2.isNavigateable){
                    (_local_2 as CatalogNodeRenderable).addToList(this._content);
                };
            };
        }
        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }
        public function activateNode(_arg_1:ICatalogNode):void
        {
            var _local_5:ICatalogNode;
            var _local_6:ICatalogNode;
            var _local_7:int;
            var _local_2 = (this._SafeStr_10295.indexOf(_arg_1) > -1);
            var _local_3:Boolean = _arg_1.isOpen;
            var _local_4:Array = [];
            for each (_local_5 in this._SafeStr_10295) {
                _local_5.deActivate();
                if (_local_5.depth >= _arg_1.depth){
                    _local_4.push(_local_5);
                };
            };
            for each (_local_6 in _local_4) {
                _local_6.close();
                _local_7 = this._SafeStr_10295.indexOf(_local_6);
                this._SafeStr_10295.splice(_local_7, 1);
            };
            _arg_1.activate();
            if (((_local_2) && (_local_3))){
                _arg_1.close();
            }
            else {
                _arg_1.open();
            };
            if (this._SafeStr_10295.indexOf(_arg_1) == -1){
                this._SafeStr_10295.push(_arg_1);
            };
            this._catalog.loadCatalogPage(_arg_1.pageId, -1);
            this._catalog.events.dispatchEvent(new CatalogPageOpenedEvent(_arg_1.pageId, _arg_1.localization));
        }
        public function openPage(_arg_1:String):void
        {
            var _local_2:ICatalogNode = this.getNodeByName(_arg_1);
            if (_local_2 != null){
                this._catalog.loadCatalogPage(_local_2.pageId, -1);
                this.openNavigatorAtNode(_local_2);
            };
        }
        public function openPageById(_arg_1:int, _arg_2:int):void
        {
            var _local_3:ICatalogNode = this.getNodeById(_arg_1, this._index);
            if (_local_3 != null){
                this._catalog.loadCatalogPage(_local_3.pageId, _arg_2);
                this.openNavigatorAtNode(_local_3);
            };
        }
        private function openNavigatorAtNode(_arg_1:ICatalogNode):void
        {
            var _local_2:ICatalogNode;
            var _local_3:ICatalogNode;
            if (_arg_1 == null){
                return;
            };
            for each (_local_2 in this._SafeStr_10295) {
                _local_2.deActivate();
                _local_2.close();
            };
            this._SafeStr_10295 = [];
            _local_3 = _arg_1.parent;
            while (((!((_local_3 == null))) && (!((_local_3.parent == null))))) {
                _local_3.open();
                this._SafeStr_10295.push(_local_3);
                _local_3 = _local_3.parent;
            };
            this.activateNode(_arg_1);
        }
        public function loadFrontPage():void
        {
            var _local_1:ICatalogNode = this.getFirstNavigateable(this._index);
            Logger.log((((("Load front page: " + _local_1.localization) + "(") + _local_1.pageId) + ")"));
            this._catalog.loadCatalogPage(_local_1.pageId, -1);
        }
        public function loadNewAdditionsPage(_arg_1:String):void
        {
            var _local_2:ICatalogNode = this.getFirstNodeByName(_arg_1, this._index);
            if (_local_2 != null){
                this._catalog.loadCatalogPage(_local_2.pageId, -1);
            }
            else {
                this.loadFrontPage();
            };
        }
        private function openCreditsPage():void
        {
            if (this._catalog){
                this._catalog.openCreditsHabblet();
            };
        }
        private function onExternalLink(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.dispose();
        }
        private function openPixelsPage():void
        {
            this.openPage(this._SafeStr_10297);
        }
        private function openClubPage():void
        {
            this._catalog.openCatalogPage(this._SafeStr_10298, true);
        }
        private function getFirstNavigateable(_arg_1:ICatalogNode):ICatalogNode
        {
            var _local_2:ICatalogNode;
            var _local_3:ICatalogNode;
            if (((_arg_1.isNavigateable) && (!((_arg_1 == this._index))))){
                return (_arg_1);
            };
            for each (_local_2 in _arg_1.children) {
                _local_3 = this.getFirstNavigateable(_local_2);
                if (_local_3 != null){
                    return (_local_3);
                };
            };
            return (null);
        }
        private function buildIndexNode(_arg_1:NodeData, _arg_2:int):ICatalogNode
        {
            var _local_5:NodeData;
            var _local_3:Boolean = _arg_1.navigateable;
            var _local_4:ICatalogNode;
            if (!_local_3){
                _local_4 = (new CatalogNode(this, _arg_1, _arg_2) as ICatalogNode);
            }
            else {
                _local_4 = (new CatalogNodeRenderable(this, _arg_1, _arg_2) as ICatalogNode);
            };
            if (_local_4 == null){
                Logger.log("Catalog index node creation failed!");
                return (null);
            };
            _arg_2++;
            for each (_local_5 in _arg_1.nodes) {
                _local_4.addChild(this.buildIndexNode(_local_5, _arg_2));
            };
            return (_local_4);
        }
        private function getNodeByName(_arg_1:String):ICatalogNode
        {
            return (this.getFirstNodeByName(_arg_1, this._index));
        }
        private function getNodeById(pageId:int, node:ICatalogNode):ICatalogNode
        {
            var currentPageId:int;
            var child:ICatalogNode;
            var found:ICatalogNode;
            try {
                currentPageId = node.pageId;
                if ((((currentPageId == pageId)) && (!((node == this._index))))){
                    found = node;
                }
                else {
                    for each (child in node.children) {
                        found = this.getNodeById(pageId, child);
                        if (found != null) break;
                    };
                };
            }
            catch(e:Error) {
                Logger.log((("error when loading node by id " + pageId) + ":"), e);
            };
            return (found);
        }
        private function getFirstNodeByName(localizedName:String, node:ICatalogNode):ICatalogNode
        {
            var child:ICatalogNode;
            var found:ICatalogNode;
            try {
                if ((((node.localization == localizedName)) && (!((node == this._index))))){
                    found = node;
                }
                else {
                    for each (child in node.children) {
                        found = this.getFirstNodeByName(localizedName, child);
                        if (found != null) break;
                    };
                };
            }
            catch(e:Error) {
                Logger.log((("error when loading node by name " + localizedName) + ":"), e);
            };
            return (found);
        }
        private function onNavigatorEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_arg_1.target);
            var _local_3:String = IWindow(_arg_1.target).name;
            switch (_arg_1.type){
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    _local_2.getChildByName("background").color = 4281692560;
                    return;
                case WindowMouseEvent.WME_OUT:
                    _local_2.getChildByName("background").color = 4280767850;
                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    switch (_local_3){
                        case "creditsContainer":
                            this.openCreditsPage();
                            break;
                        case "pixelsContainer":
                            this.openPixelsPage();
                            break;
                        case "clubContainer":
                            this.openClubPage();
                            break;
                    };
                    return;
            };
        }
        private function activateScrollbar(_arg_1:WindowEvent):void
        {
            (_arg_1.target as IWindow).visible = true;
        }
        private function deActivateScrollbar(_arg_1:WindowEvent):void
        {
            (_arg_1.target as IWindow).visible = false;
        }

    }
}//package com.sulake.habbo.catalog.navigation

// buildCatalogIndex = "_-0KM" (String#3963, DoABC#2)
// openPageById = "_-0qZ" (String#4651, DoABC#2)
// loadFrontPage = "_-0fU" (String#4415, DoABC#2)
// loadNewAdditionsPage = "_-2Cc" (String#6295, DoABC#2)
// _SafeStr_10295 = "_-0Am" (String#14478, DoABC#2)
// _SafeStr_10296 = "_-2U4" (String#20203, DoABC#2)
// _SafeStr_10297 = "_-os" (String#24231, DoABC#2)
// _SafeStr_10298 = "_-2M5" (String#19887, DoABC#2)
// activateScrollbar = "_-140" (String#4957, DoABC#2)
// deActivateScrollbar = "_-37C" (String#7450, DoABC#2)
// buildIndexNode = "_-lK" (String#24080, DoABC#2)
// isNavigateable = "_-1Ts" (String#5429, DoABC#2)
// addToList = "_-24g" (String#19209, DoABC#2)
// loadCatalogPage = "_-2Go" (String#6383, DoABC#2)
// getNodeByName = "_-1sx" (String#18675, DoABC#2)
// openNavigatorAtNode = "_-Ym" (String#23590, DoABC#2)
// getNodeById = "_-um" (String#24481, DoABC#2)
// getFirstNavigateable = "_-16A" (String#16703, DoABC#2)
// getFirstNodeByName = "_-1ed" (String#18083, DoABC#2)
// onExternalLink = "_-022" (String#575, DoABC#2)
// openPixelsPage = "_-23J" (String#19145, DoABC#2)
// openClubPage = "_-vB" (String#24498, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ICatalogNavigator = "_-24D" (String#6126, DoABC#2)
// CatalogNavigator = "_-11c" (String#4908, DoABC#2)
// NodeData = "_-02P" (String#3615, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// ICatalogNode = "_-0Td" (String#4172, DoABC#2)
// CatalogNode = "_-148" (String#4959, DoABC#2)
// CatalogNodeRenderable = "_-20S" (String#6056, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// openCreditsHabblet = "_-0D5" (String#3811, DoABC#2)
// navigateable = "_-0EP" (String#14623, DoABC#2)
// nodes = "_-7H" (String#22513, DoABC#2)
// openPage = "_-6Z" (String#2052, DoABC#2)
// CatalogPageOpenedEvent = "_-EN" (String#22786, DoABC#2)
// openCreditsPage = "_-1Sy" (String#5413, DoABC#2)
// isInitialized = "_-1Cr" (String#840, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// _scrollBar = "_-2z7" (String#906, DoABC#2)
// WE_ENABLE = "_-0b-" (String#15474, DoABC#2)
// WE_DISABLE = "_-37c" (String#21791, DoABC#2)


