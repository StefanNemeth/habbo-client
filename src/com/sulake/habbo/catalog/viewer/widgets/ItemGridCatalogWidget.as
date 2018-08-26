
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.habbo.catalog.viewer.IDragAndDropDoneReceiver;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import flash.utils.Timer;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetInitPurchaseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.catalog.viewer.BundleProductContainer;

    public class ItemGridCatalogWidget extends CatalogWidget implements ICatalogWidget, IItemGrid, IDragAndDropDoneReceiver 
    {

        protected var _SafeStr_10421:IItemGridWindow;
        protected var _SafeStr_10422:XML;
        protected var _SafeStr_8482:IGridItem;
        private var _SafeStr_10423:int = 0;
        protected var _SafeStr_5297:Timer;
        protected var _SafeStr_7794:Boolean = true;
        private var _SafeStr_10424:int = 0;
        private var _scrollBar:IScrollbarWindow;
        protected var _session:ISessionDataManager;

        public function ItemGridCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager)
        {
            super(_arg_1);
            this._scrollBar = (_window.findChildByName("itemGridScrollbar") as IScrollbarWindow);
            if (this._scrollBar != null){
                this._scrollBar.visible = false;
                this._scrollBar.addEventListener(WindowEvent.WE_ENABLE, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_ENABLED, this.activateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_DISABLE, this.deActivateScrollbar);
                this._scrollBar.addEventListener(WindowEvent.WE_DISABLED, this.deActivateScrollbar);
            };
            this._session = _arg_2;
        }
        override public function dispose():void
        {
            if (this._SafeStr_5297 != null){
                this._SafeStr_5297.stop();
                this._SafeStr_5297.removeEventListener(TimerEvent.TIMER, this.loadItemGridGraphics);
                this._SafeStr_5297 = null;
            };
            if (this._SafeStr_10421 != null){
                this._SafeStr_10421.destroyGridItems();
                this._SafeStr_10421 = null;
            };
            this._SafeStr_10422 = null;
            this._SafeStr_8482 = null;
            super.dispose();
        }
        override public function init():Boolean
        {
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10421 = (_window.findChildByName("itemGrid") as IItemGridWindow);
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            this._SafeStr_10422 = (_local_1.content as XML);
            this.populateItemGrid();
            if (this._SafeStr_7794){
                this._SafeStr_5297 = new Timer(25);
                this._SafeStr_5297.addEventListener(TimerEvent.TIMER, this.loadItemGridGraphics);
                this._SafeStr_5297.start();
            }
            else {
                this.loadItemGridGraphics();
            };
            return (true);
        }
        public function select(_arg_1:IGridItem):void
        {
            if (this._SafeStr_8482 != null){
                this._SafeStr_8482.deActivate();
            };
            this._SafeStr_8482 = _arg_1;
            _arg_1.activate();
            var _local_2:Offer = (_arg_1 as ProductContainer).offer;
            if (_local_2 != null){
                events.dispatchEvent(new SelectProductEvent(_local_2));
                if (_local_2.productContainer.firstProduct.productType == ProductTypeEnum._SafeStr_5019){
                    events.dispatchEvent(new SetExtraPurchaseParameterEvent(_local_2.productContainer.firstProduct.extraParam));
                };
            };
        }
        public function startDragAndDrop(_arg_1:IGridItem):Boolean
        {
            var _local_2:Offer = (_arg_1 as ProductContainer).offer;
            if (_local_2 != null){
                if (this._session.hasUserRight(null, _local_2.clubLevel)){
                    (page.viewer.catalog as HabboCatalog).requestSelectedItemToMover(this, _local_2);
                };
            };
            return (true);
        }
        public function onDragAndDropDone(_arg_1:Boolean):void
        {
            if (disposed){
                return;
            };
            if (_arg_1){
                events.dispatchEvent(new CatalogWidgetInitPurchaseEvent(false));
            };
        }
        public function stopDragAndDrop():void
        {
        }
        protected function populateItemGrid():void
        {
            var _local_1:Offer;
            for each (_local_1 in page.offers) {
                this.createGridItem(_local_1);
                _local_1.productContainer.grid = this;
            };
        }
        protected function resetTimer():void
        {
            if (this._SafeStr_5297 != null){
                this._SafeStr_5297.reset();
            };
            this._SafeStr_10424 = 0;
        }
        protected function loadItemGridGraphics(_arg_1:TimerEvent=null):void
        {
            var _local_3:int;
            var _local_4:Offer;
            if (disposed){
                return;
            };
            if (_arg_1 != null){
            };
            var _local_2:int = page.offers.length;
            if (_local_2 > 0){
                _local_3 = 0;
                while (_local_3 < 3) {
                    if ((((this._SafeStr_10424 >= 0)) && ((this._SafeStr_10424 < _local_2)))){
                        _local_4 = page.offers[this._SafeStr_10424];
                        this.loadGraphics(_local_4);
                        _local_4.productContainer.grid = this;
                    };
                    this._SafeStr_10424++;
                    if (this._SafeStr_10424 >= _local_2){
                        this.resetTimer();
                        return;
                    };
                    _local_3++;
                };
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
        protected function createGridItem(_arg_1:Offer):void
        {
            var _local_2:IWindowContainer = (page.viewer.catalog.windowManager.buildFromXML(this._SafeStr_10422) as IWindowContainer);
            this._SafeStr_10421.IItemGridWindow(_local_2);
            _arg_1.productContainer.view = _local_2;
            _arg_1.productContainer.setClubIconLevel(_arg_1.clubLevel);
            if ((page.viewer.catalog as HabboCatalog).isDraggable(_arg_1)){
                (_arg_1.productContainer as IGridItem).ProductGridItem(true);
            };
            if (_arg_1.pricingModel == Offer._SafeStr_4888){
                this._SafeStr_10423++;
                (_arg_1.productContainer as BundleProductContainer).setBundleCounter(this._SafeStr_10423);
            };
        }
        protected function loadGraphics(_arg_1:Offer):void
        {
            if (((!((_arg_1 == null))) && (!(_arg_1.disposed)))){
                _arg_1.productContainer.initProductIcon(page.viewer.roomEngine);
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// activateScrollbar = "_-140" (String#4957, DoABC#2)
// deActivateScrollbar = "_-37C" (String#7450, DoABC#2)
// _SafeStr_10421 = "_-2Kz" (String#19845, DoABC#2)
// _SafeStr_10422 = "_-2c4" (String#1909, DoABC#2)
// _SafeStr_10423 = "_-1t8" (String#18683, DoABC#2)
// _SafeStr_10424 = "_-3D6" (String#21999, DoABC#2)
// loadItemGridGraphics = "_-01L" (String#14105, DoABC#2)
// requestSelectedItemToMover = "_-Xj" (String#23551, DoABC#2)
// stopDragAndDrop = "_-1PY" (String#17490, DoABC#2)
// createGridItem = "_-1sQ" (String#18649, DoABC#2)
// resetTimer = "_-1sz" (String#18676, DoABC#2)
// loadGraphics = "_-2m3" (String#20920, DoABC#2)
// isDraggable = "_-0PX" (String#15044, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IDragAndDropDoneReceiver = "_-Vz" (String#8320, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// BundleProductContainer = "_-1p3" (String#5839, DoABC#2)
// ItemGridCatalogWidget = "_-0OU" (String#4058, DoABC#2)
// SetExtraPurchaseParameterEvent = "_-2sO" (String#7128, DoABC#2)
// CatalogWidgetInitPurchaseEvent = "_-2yJ" (String#7244, DoABC#2)
// _session = "_-32Q" (String#627, DoABC#2)
// IItemGridWindow = "_-2vh" (String#7192, DoABC#2)
// onDragAndDropDone = "_-05o" (String#3681, DoABC#2)
// _SafeStr_4888 = "_-2gY" (String#20713, DoABC#2)
// pricingModel = "_-1Lx" (String#17355, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// setClubIconLevel = "_-09M" (String#3745, DoABC#2)
// ProductGridItem = "_-2tF" (String#7142, DoABC#2)
// startDragAndDrop = "_-Di" (String#7945, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// setBundleCounter = "_-0U2" (String#15206, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _SafeStr_7794 = "_-aa" (String#8430, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// _scrollBar = "_-2z7" (String#906, DoABC#2)
// WE_ENABLE = "_-0b-" (String#15474, DoABC#2)
// WE_DISABLE = "_-37c" (String#21791, DoABC#2)


