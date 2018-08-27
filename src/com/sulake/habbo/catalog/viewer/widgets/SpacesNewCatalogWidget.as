
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.viewer.IItemGrid;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.IGridItem;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.ProductContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetUpdateRoomPreviewEvent;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;

    public class SpacesNewCatalogWidget extends ItemGridCatalogWidget implements IDisposable, ICatalogWidget, IItemGrid 
    {

        private var _groupNames:Array;
        private var _groups:Array;
        private var _SafeStr_10540:int = 0;
        private var _SafeStr_10541:Array;
        private var _tabs:ISelectorWindow;
        private var _categories:Array;

        public function SpacesNewCatalogWidget(_arg_1:IWindowContainer, _arg_2:ISessionDataManager)
        {
            var _local_3:int;
            var _local_4:IWindow;
            this._groupNames = ["wallpaper", "floor", "landscape"];
            this._groups = new Array();
            this._SafeStr_10541 = [0, 0, 0];
            this._categories = ["group.walls", "group.floors", "group.views"];
            super(_arg_1, _arg_2);
            this._tabs = (_window.findChildByName("groups") as ISelectorWindow);
            if (this._tabs){
                _local_3 = 0;
                while (_local_3 < this._tabs.numSelectables) {
                    _local_4 = this._tabs.getSelectableAt(_local_3);
                    if ((_local_4 is ISelectableWindow)){
                        _local_4.addEventListener(WindowEvent.WE_SELECTED, this.onSelectGroup);
                    };
                    _local_3++;
                };
            };
        }
        override public function dispose():void
        {
            var _local_1:Array;
            var _local_2:Offer;
            super.dispose();
            for each (_local_1 in this._groups) {
                for each (_local_2 in _local_1) {
                    _local_2.dispose();
                };
            };
            this._groups = null;
        }
        override public function init():Boolean
        {
            Logger.log("Init Item Group Catalog Widget (Spaces New)");
            this.createOfferGroups();
            if (!super.init()){
                return (false);
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            this.switchCategory(this._categories[this._SafeStr_10540]);
            this.updateRoomPreview();
            return (true);
        }
        public function onWidgetsInitialized(_arg_1:CatalogWidgetsInitializedEvent):void
        {
            var _local_2:int = this._SafeStr_10541[this._SafeStr_10540];
            var _local_3:Offer = this._groups[this._SafeStr_10540][_local_2];
            this.select((_local_3.productContainer as IGridItem));
        }
        public function selectIndex(_arg_1:int):void
        {
            var _local_2:Offer;
            if ((((_arg_1 > -1)) && ((_arg_1 < _SafeStr_10421.numGridItems)))){
                _local_2 = this._groups[this._SafeStr_10540][_arg_1];
                this.select((_local_2.productContainer as IGridItem));
            };
        }
        override public function select(_arg_1:IGridItem):void
        {
            if (_arg_1 == null){
                return;
            };
            super.select(_arg_1);
            var _local_2:Offer = (_arg_1 as ProductContainer).offer;
            if (_local_2 == null){
                return;
            };
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_local_2.productContainer.firstProduct.extraParam));
            this._SafeStr_10541[this._SafeStr_10540] = (this._groups[this._SafeStr_10540] as Array).indexOf(_local_2);
            this.updateRoomPreview();
        }
        private function updateRoomPreview():void
        {
            var _local_1:int = this._SafeStr_10541[0];
            var _local_2:int = this._SafeStr_10541[1];
            var _local_3:int = this._SafeStr_10541[2];
            var _local_4:Offer = this._groups[0][_local_1];
            var _local_5:Offer = this._groups[1][_local_2];
            var _local_6:Offer = this._groups[2][_local_3];
            if (((((!(_local_5)) || (!(_local_4)))) || (!(_local_6)))){
                return;
            };
            events.dispatchEvent(new CatalogWidgetUpdateRoomPreviewEvent(_local_5.productContainer.firstProduct.extraParam, _local_4.productContainer.firstProduct.extraParam, _local_6.productContainer.firstProduct.extraParam, 64));
        }
        private function createOfferGroups():Boolean
        {
            var _local_1:Offer;
            var _local_2:IProduct;
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            for each (_local_1 in page.offers) {
                if ((((_local_1.pricingModel == Offer._SafeStr_4886)) || ((_local_1.pricingModel == Offer._SafeStr_4887)))){
                    _local_2 = _local_1.productContainer.firstProduct;
                    if (_local_2 != null){
                        _local_3 = _local_2.productClassId;
                        if ((((_local_2.productType == ProductTypeEnum._SafeStr_5019)) || ((_local_2.productType == ProductTypeEnum._SafeStr_5017)))){
                            if (_local_2.furnitureData != null){
                                _local_4 = _local_2.furnitureData.name;
                                _local_5 = this._groupNames.indexOf(_local_4);
                                if (this._groupNames.indexOf(_local_4) == -1){
                                    this._groupNames.push(_local_4);
                                };
                                while (this._groups.length < this._groupNames.length) {
                                    this._groups.push(new Array());
                                };
                                switch (_local_4){
                                    case "floor":
                                        (this._groups[_local_5] as Array).push(_local_1);
                                        break;
                                    case "wallpaper":
                                        (this._groups[_local_5] as Array).push(_local_1);
                                        break;
                                    case "landscape":
                                        (this._groups[_local_5] as Array).push(_local_1);
                                        break;
                                    default:
                                        Logger.log(("[SpacesCatalogWidget] : " + _local_4));
                                };
                            };
                        };
                    };
                };
            };
            page.replaceOffers([], false);
            return (true);
        }
        private function onSelectGroup(_arg_1:WindowEvent):void
        {
            var _local_3:int;
            var _local_2:ISelectableWindow = (_arg_1.target as ISelectableWindow);
            if (_local_2){
                _local_3 = this._tabs.getSelectableIndex(_local_2);
                Logger.log(("select: " + [_local_2.name, _local_3]));
                this.switchCategory(_local_2.name);
            };
        }
        private function switchCategory(_arg_1:String):void
        {
            var _local_3:int;
            if (disposed){
                return;
            };
            if (!this._tabs){
                return;
            };
            this._tabs.setSelected(this._tabs.getSelectableByName(_arg_1));
            var _local_2:int = -1;
            switch (_arg_1){
                case "group.walls":
                    _local_2 = 0;
                    break;
                case "group.floors":
                    _local_2 = 1;
                    break;
                case "group.views":
                    _local_2 = 2;
                    break;
                default:
                    _local_2 = -1;
            };
            if (_local_2 > -1){
                if (_SafeStr_8482 != null){
                    _SafeStr_8482.deActivate();
                };
                _SafeStr_8482 = null;
                this._SafeStr_10540 = _local_2;
                if (_SafeStr_10421){
                    _SafeStr_10421.destroyGridItems();
                };
                page.replaceOffers(this._groups[this._SafeStr_10540], false);
                resetTimer();
                populateItemGrid();
                loadItemGridGraphics();
                if (_SafeStr_5297){
                    _SafeStr_5297.start();
                };
                _local_3 = this._SafeStr_10541[this._SafeStr_10540];
                this.selectIndex(_local_3);
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onWidgetsInitialized = "_-2Ty" (String#890, DoABC#2)
// _SafeStr_10421 = "_-2Kz" (String#19845, DoABC#2)
// loadItemGridGraphics = "_-01L" (String#14105, DoABC#2)
// resetTimer = "_-1sz" (String#18676, DoABC#2)
// _SafeStr_10540 = "_-0yG" (String#1586, DoABC#2)
// _SafeStr_10541 = "_-39I" (String#7496, DoABC#2)
// onSelectGroup = "_-GV" (String#8007, DoABC#2)
// updateRoomPreview = "_-1GS" (String#17133, DoABC#2)
// selectIndex = "_-1xQ" (String#18865, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// ProductContainer = "_-X-" (String#8349, DoABC#2)
// IItemGrid = "_-0i3" (String#4468, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ItemGridCatalogWidget = "_-0OU" (String#4058, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// SpacesNewCatalogWidget = "_-1OF" (String#5316, DoABC#2)
// SetExtraPurchaseParameterEvent = "_-2sO" (String#7128, DoABC#2)
// CatalogWidgetUpdateRoomPreviewEvent = "_-1w1" (String#5958, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// _SafeStr_4886 = "_-04Q" (String#14220, DoABC#2)
// _SafeStr_4887 = "_-0F0" (String#14645, DoABC#2)
// pricingModel = "_-1Lx" (String#17355, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// furnitureData = "_-2GE" (String#6370, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// _SafeStr_5297 = "_-0Gy" (String#355, DoABC#2)
// _groups = "_-3S" (String#2047, DoABC#2)
// getSelectableByName = "_-0EO" (String#3836, DoABC#2)
// _SafeStr_8482 = "_-2IF" (String#618, DoABC#2)
// _tabs = "_-0QO" (String#585, DoABC#2)
// numSelectables = "_-1pQ" (String#5845, DoABC#2)
// getSelectableAt = "_-2Vc" (String#6675, DoABC#2)
// getSelectableIndex = "_-2bS" (String#6782, DoABC#2)


