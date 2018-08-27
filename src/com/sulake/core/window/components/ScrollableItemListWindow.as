
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.utils.IIterator;

    public class ScrollableItemListWindow extends WindowController implements IScrollableListWindow 
    {

        private var __itemList:IItemListWindow;
        private var __scrollBar:IScrollbarWindow;
        private var _autoHideScrollBar:Boolean = true;

        public function ScrollableItemListWindow(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            this._scrollBar.scrollable = this._itemList;
            if (this._scrollBar.testStateFlag(WindowState._SafeStr_9399)){
                this.hideScrollBar();
            };
        }
        override public function dispose():void
        {
            if (this.__scrollBar){
                this.__scrollBar.removeEventListener(WindowEvent.WE_ENABLED, this.scrollBarEventProc);
                this.__scrollBar.removeEventListener(WindowEvent.WE_DISABLED, this.scrollBarEventProc);
                this.__scrollBar = null;
            };
            if (this.__itemList){
                this.__itemList = null;
            };
            super.dispose();
        }
        protected function get _itemList():IItemListWindow
        {
            if (!this.__itemList){
                this.__itemList = (findChildByTag("_ITEMLIST") as IItemListWindow);
            };
            return (this.__itemList);
        }
        protected function get _scrollBar():IScrollbarWindow
        {
            if (!this.__scrollBar){
                this.__scrollBar = (findChildByTag("_SCROLLBAR") as IScrollbarWindow);
                if (this.__scrollBar){
                    this.__scrollBar.addEventListener(WindowEvent.WE_ENABLED, this.scrollBarEventProc);
                    this.__scrollBar.addEventListener(WindowEvent.WE_DISABLED, this.scrollBarEventProc);
                };
            };
            return (this.__scrollBar);
        }
        private function scrollBarEventProc(_arg_1:WindowEvent):void
        {
            if (_arg_1.type == WindowEvent.WE_ENABLED){
                this.showScrollBar();
            }
            else {
                if (_arg_1.type == WindowEvent.WE_DISABLED){
                    this.hideScrollBar();
                };
            };
        }
        private function hideScrollBar():void
        {
            if (this._scrollBar.visible){
                this._scrollBar.visible = false;
                this._itemList.width = _rectangle.width;
            };
        }
        private function showScrollBar():void
        {
            if (!this._scrollBar.visible){
                this._scrollBar.visible = true;
                this._itemList.width = (_rectangle.width - this._scrollBar.width);
            };
        }
        private function updateScrollBarVisibility():void
        {
            if (this._autoHideScrollBar){
                if (this._scrollBar.testStateFlag(WindowState._SafeStr_9399)){
                    if (this._scrollBar.visible){
                        this.hideScrollBar();
                    };
                };
            }
            else {
                if (this._scrollBar.visible){
                    this.showScrollBar();
                };
            };
        }
        protected function isConstructionReady():Boolean
        {
            return (((this._itemList) && (this._scrollBar)));
        }
        public function set autoHideScrollBar(_arg_1:Boolean):void
        {
            this._autoHideScrollBar = _arg_1;
            this.updateScrollBarVisibility();
        }
        public function get autoHideScrollBar():Boolean
        {
            return (this._autoHideScrollBar);
        }
        public function get iterator():IIterator
        {
            return (((this.isConstructionReady()) ? this._itemList.iterator : null));
        }
        public function get scrollH():Number
        {
            return (this._itemList.scrollH);
        }
        public function get scrollV():Number
        {
            return (this._itemList.scrollV);
        }
        public function set scrollH(_arg_1:Number):void
        {
            this._itemList.scrollH = _arg_1;
        }
        public function set scrollV(_arg_1:Number):void
        {
            this._itemList.scrollV = _arg_1;
        }
        public function get maxScrollH():int
        {
            return (this._itemList.maxScrollH);
        }
        public function get maxScrollV():int
        {
            return (this._itemList.maxScrollV);
        }
        public function get visibleRegion():Rectangle
        {
            return (this._itemList.visibleRegion);
        }
        public function get scrollableRegion():Rectangle
        {
            return (this._itemList.scrollableRegion);
        }
        public function get scrollStepH():Number
        {
            return (this._itemList.scrollStepH);
        }
        public function get scrollStepV():Number
        {
            return (this._itemList.scrollStepV);
        }
        public function set scrollStepH(_arg_1:Number):void
        {
            this._itemList.scrollStepH = _arg_1;
        }
        public function set scrollStepV(_arg_1:Number):void
        {
            this._itemList.scrollStepV = _arg_1;
        }
        public function get spacing():int
        {
            return (this._itemList.spacing);
        }
        public function set spacing(_arg_1:int):void
        {
            this._itemList.spacing = _arg_1;
        }
        public function get scaleToFitItems():Boolean
        {
            return (this._itemList.scaleToFitItems);
        }
        public function set scaleToFitItems(_arg_1:Boolean):void
        {
            this._itemList.scaleToFitItems = _arg_1;
        }
        public function get autoArrangeItems():Boolean
        {
            return (this._itemList.autoArrangeItems);
        }
        public function set autoArrangeItems(_arg_1:Boolean):void
        {
            this._itemList.autoArrangeItems = _arg_1;
        }
        public function set resizeOnItemUpdate(_arg_1:Boolean):void
        {
            this._itemList.resizeOnItemUpdate = _arg_1;
        }
        public function get resizeOnItemUpdate():Boolean
        {
            return (this._itemList.resizeOnItemUpdate);
        }
        public function get numListItems():int
        {
            return (this._itemList.numListItems);
        }
        public function addListItem(_arg_1:IWindow):IWindow
        {
            return (this._itemList.addListItem(_arg_1));
        }
        public function addListItemAt(_arg_1:IWindow, _arg_2:uint):IWindow
        {
            return (this._itemList.addListItemAt(_arg_1, _arg_2));
        }
        public function getListItemAt(_arg_1:uint):IWindow
        {
            return (this._itemList.getListItemAt(_arg_1));
        }
        public function getListItemByID(_arg_1:uint):IWindow
        {
            return (this._itemList.getListItemByID(_arg_1));
        }
        public function getListItemByName(_arg_1:String):IWindow
        {
            return (this._itemList.getListItemByName(_arg_1));
        }
        public function getListItemByTag(_arg_1:String):IWindow
        {
            return (this._itemList.getListItemByTag(_arg_1));
        }
        public function getListItemIndex(_arg_1:IWindow):int
        {
            return (this._itemList.getListItemIndex(_arg_1));
        }
        public function removeListItem(_arg_1:IWindow):IWindow
        {
            return (this._itemList.removeListItem(_arg_1));
        }
        public function removeListItemAt(_arg_1:int):IWindow
        {
            return (this._itemList.removeListItemAt(_arg_1));
        }
        public function setListItemIndex(_arg_1:IWindow, _arg_2:int):void
        {
            this._itemList.setListItemIndex(_arg_1, _arg_2);
        }
        public function swapListItems(_arg_1:IWindow, _arg_2:IWindow):void
        {
            this._itemList.swapListItems(_arg_1, _arg_2);
        }
        public function swapListItemsAt(_arg_1:int, _arg_2:int):void
        {
            this._itemList.swapListItemsAt(_arg_1, _arg_2);
        }
        public function groupListItemsWithID(_arg_1:uint, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            return (this._itemList.groupListItemsWithID(_arg_1, _arg_2, _arg_3));
        }
        public function groupListItemsWithTag(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false):uint
        {
            return (this._itemList.groupListItemsWithTag(_arg_1, _arg_2, _arg_3));
        }
        public function removeListItems():void
        {
            this._itemList.removeListItems();
        }
        public function destroyListItems():void
        {
            this._itemList.destroyListItems();
        }
        public function arrangeListItems():void
        {
            this._itemList.arrangeListItems();
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IIterator = "_-6K" (String#7788, DoABC#2)
// IScrollableListWindow = "_-337" (String#7369, DoABC#2)
// ScrollableItemListWindow = "_-Kv" (String#8101, DoABC#2)
// addListItemAt = "_-2CT" (String#6293, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// groupListItemsWithTag = "_-0gQ" (String#4432, DoABC#2)
// removeListItemAt = "_-Td" (String#8279, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// testStateFlag = "_-35A" (String#7410, DoABC#2)
// resizeOnItemUpdate = "_-2es" (String#6849, DoABC#2)
// scaleToFitItems = "_-Xo" (String#8364, DoABC#2)
// getListItemByID = "_-29k" (String#6245, DoABC#2)
// getListItemByTag = "_-Ml" (String#8136, DoABC#2)
// setListItemIndex = "_-2ZB" (String#6748, DoABC#2)
// swapListItems = "_-1We" (String#5485, DoABC#2)
// swapListItemsAt = "_-2JU" (String#6429, DoABC#2)
// groupListItemsWithID = "_-CS" (String#7927, DoABC#2)
// arrangeListItems = "_-0fG" (String#4411, DoABC#2)
// _scrollBar = "_-2z7" (String#906, DoABC#2)
// autoHideScrollBar = "_-1D7" (String#5129, DoABC#2)
// __itemList = "_-1RT" (String#17563, DoABC#2)
// __scrollBar = "_-0FE" (String#14654, DoABC#2)
// _autoHideScrollBar = "_-wJ" (String#24545, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// hideScrollBar = "_-18h" (String#16800, DoABC#2)
// scrollBarEventProc = "_-v0" (String#24491, DoABC#2)
// showScrollBar = "_-2Or" (String#19996, DoABC#2)
// updateScrollBarVisibility = "_-2m8" (String#20924, DoABC#2)
// isConstructionReady = "_-Yj" (String#23588, DoABC#2)


