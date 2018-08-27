
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
    import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class TrophyCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener 
    {

        private static const _SafeStr_10459:int = 0xFFCC00;
        private static const _SafeStr_10460:int = 0xCCCCCC;
        private static const _SafeStr_10461:int = 0xCC6600;

        private var _SafeStr_10438:IBitmapWrapperWindow;
        private var _SafeStr_10462:Map;
        private var _SafeStr_10463:int = 0;
        private var _SafeStr_10464:String = "g";

        public function TrophyCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            if (this._SafeStr_10462 != null){
                this._SafeStr_10462.dispose();
            };
            this._SafeStr_10462 = null;
            super.dispose();
        }
        override public function init():Boolean
        {
            var _local_4:Map;
            var _local_5:String;
            var _local_6:String;
            var _local_7:Map;
            if (!super.init()){
                return (false);
            };
            this._SafeStr_10438 = (window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onSelectProduct);
            events.addEventListener(WidgetEvent.CWE_COLOUR_INDEX, this.onColourIndex);
            events.addEventListener(WidgetEvent.CWE_TEXT_INPUT, this.onTextInput);
            var _local_1:IContainerButtonWindow = (window.findChildByName("ctlg_nextmodel_button") as IContainerButtonWindow);
            var _local_2:IContainerButtonWindow = (window.findChildByName("ctlg_prevmodel_button") as IContainerButtonWindow);
            if (_local_1 != null){
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickNext);
            };
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickPrev);
            };
            this._SafeStr_10462 = new Map();
            var _local_3:Offer;
            for each (_local_3 in page.offers) {
                _local_5 = this.getBaseNameFromProduct(_local_3.localizationId);
                _local_6 = this.getTrophyTypeFromProduct(_local_3.localizationId);
                if (this._SafeStr_10462.getValue(_local_5) == null){
                    this._SafeStr_10462.add(_local_5, new Map());
                };
                _local_7 = (this._SafeStr_10462.getValue(_local_5) as Map);
                _local_7.add(_local_6, _local_3);
            };
            _local_4 = this._SafeStr_10462.getWithIndex(this._SafeStr_10463);
            if (_local_4 != null){
                _local_3 = _local_4.getValue(this._SafeStr_10464);
                if (_local_3 == null){
                    _local_3 = _local_4.getWithIndex(0);
                };
                if (_local_3 != null){
                    events.dispatchEvent(new SelectProductEvent(_local_3));
                };
            };
            events.addEventListener(WidgetEvent.CWE_WIDGETS_INITIALIZED, this.onWidgetsInitialized);
            return (true);
        }
        private function onWidgetsInitialized(_arg_1:CatalogWidgetsInitializedEvent):void
        {
            var _local_2:Array = new Array();
            _local_2.push(_SafeStr_10459);
            _local_2.push(_SafeStr_10460);
            _local_2.push(_SafeStr_10461);
            events.dispatchEvent(new CatalogWidgetColoursEvent(_local_2, "ctlg_clr_40x32_1", "ctlg_clr_40x32_2", "ctlg_clr_40x32_3"));
        }
        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            var _local_4:BitmapData;
            var _local_5:IProduct;
            var _local_6:ImageResult;
            if (_arg_1 == null){
                return;
            };
            var _local_2:Offer = _arg_1.offer;
            var _local_3:IProductData = page.viewer.catalog.getProductData(_local_2.localizationId);
            if (ProductImageConfiguration.hasProductImage(_local_2.localizationId)){
                this.setPreviewFromAsset(ProductImageConfiguration._SafeStr_5075[_local_2.localizationId]);
            }
            else {
                _local_5 = _local_2.productContainer.firstProduct;
                _local_6 = page.viewer.roomEngine.getFurnitureImage(_local_5.productClassId, new Vector3d(2, 0, 0), 64, this, 0, _local_5.extraParam);
                _local_2.previewCallbackId = _local_6.id;
                if (_local_6 != null){
                    _local_4 = _local_6.data;
                };
                this.setPreviewImage(_local_4, true);
            };
        }
        private function onColourIndex(_arg_1:CatalogWidgetColourIndexEvent):void
        {
            var _local_3:Offer;
            if (_arg_1.index == 0){
                this._SafeStr_10464 = "g";
            };
            if (_arg_1.index == 1){
                this._SafeStr_10464 = "s";
            };
            if (_arg_1.index == 2){
                this._SafeStr_10464 = "b";
            };
            var _local_2:Map = this._SafeStr_10462.getWithIndex(this._SafeStr_10463);
            if (_local_2 != null){
                _local_3 = _local_2.getValue(this._SafeStr_10464);
                if (_local_3 == null){
                    _local_3 = _local_2.getWithIndex(0);
                };
                if (_local_3 != null){
                    events.dispatchEvent(new SelectProductEvent(_local_3));
                };
            };
        }
        public function onTextInput(_arg_1:TextInputEvent):void
        {
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(_arg_1.text));
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:Offer;
            if (((((disposed) || ((page == null)))) || ((page.offers == null)))){
                return;
            };
            for each (_local_3 in page.offers) {
                if (_local_3.previewCallbackId == _arg_1){
                    _local_3.previewCallbackId = 0;
                    this.setPreviewImage(_arg_2, true);
                    break;
                };
            };
        }
        private function getBaseNameFromProduct(_arg_1:String):String
        {
            var _local_2:String = this.getTrophyTypeFromProduct(_arg_1);
            if (_local_2.length > 0){
                return (_arg_1.slice(0, ((_arg_1.length - 1) - _local_2.length)));
            };
            return (_arg_1);
        }
        private function getTrophyTypeFromProduct(_arg_1:String):String
        {
            var _local_2:int = _arg_1.indexOf("prizetrophy_2011_");
            if (_local_2 != -1){
                return ("");
            };
            var _local_3:int = (_arg_1.lastIndexOf("_") + 1);
            if (_local_3 <= 0){
                return ("");
            };
            var _local_4:String = _arg_1.substr(_local_3);
            if ((((_local_4.length > 1)) || (((((!((_local_4 == "g"))) && (!((_local_4 == "s"))))) && (!((_local_4 == "b"))))))){
                return ("");
            };
            return (_local_4);
        }
        private function onClickNext(_arg_1:WindowMouseEvent):void
        {
            var _local_3:Offer;
            this._SafeStr_10463++;
            if (this._SafeStr_10463 >= this._SafeStr_10462.length){
                this._SafeStr_10463 = 0;
            };
            var _local_2:Map = this._SafeStr_10462.getWithIndex(this._SafeStr_10463);
            if (_local_2 != null){
                _local_3 = _local_2.getValue(this._SafeStr_10464);
                if (_local_3 == null){
                    _local_3 = _local_2.getWithIndex(0);
                };
                if (_local_3 != null){
                    events.dispatchEvent(new SelectProductEvent(_local_3));
                };
            };
        }
        private function onClickPrev(_arg_1:WindowMouseEvent):void
        {
            var _local_3:Offer;
            this._SafeStr_10463--;
            if (this._SafeStr_10463 < 0){
                this._SafeStr_10463 = (this._SafeStr_10462.length - 1);
            };
            var _local_2:Map = this._SafeStr_10462.getWithIndex(this._SafeStr_10463);
            if (_local_2 != null){
                _local_3 = _local_2.getValue(this._SafeStr_10464);
                if (_local_3 == null){
                    _local_3 = _local_2.getWithIndex(0);
                };
                if (_local_3 != null){
                    events.dispatchEvent(new SelectProductEvent(_local_3));
                };
            };
        }
        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean):void
        {
            var _local_3:Point;
            if (((!(window.disposed)) && (!((this._SafeStr_10438 == null))))){
                if (_arg_1 == null){
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                if (this._SafeStr_10438.bitmap == null){
                    this._SafeStr_10438.bitmap = new BitmapData(this._SafeStr_10438.width, this._SafeStr_10438.height, true, 0xFFFFFF);
                };
                this._SafeStr_10438.bitmap.fillRect(this._SafeStr_10438.bitmap.rect, 0xFFFFFF);
                _local_3 = new Point(((this._SafeStr_10438.width - _arg_1.width) / 2), ((this._SafeStr_10438.height - _arg_1.height) / 2));
                this._SafeStr_10438.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_3, null, null, true);
                this._SafeStr_10438.invalidate();
            };
            if (((_arg_2) && (!((_arg_1 == null))))){
                _arg_1.dispose();
            };
        }
        private function setPreviewFromAsset(_arg_1:String):void
        {
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null){
                this.retrievePreviewAsset(_arg_1);
                return;
            };
            this.setPreviewImage((_local_2.content as BitmapData), false);
        }
        private function retrievePreviewAsset(_arg_1:String):void
        {
            var _local_2:String = page.viewer.catalog.configuration.getKey("image.library.catalogue.url");
            var _local_3 = ((_local_2 + _arg_1) + ".gif");
            Logger.log(("[TrophyCatalogWidget] Retrieve Product Preview Asset: " + _local_3));
            var _local_4:URLRequest = new URLRequest(_local_3);
            var _local_5:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(_arg_1, _local_4, "image/gif");
            _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onPreviewImageReady);
        }
        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                this.setPreviewFromAsset(_local_2.assetName);
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// onSelectProduct = "_-qr" (String#463, DoABC#2)
// onColourIndex = "_-WH" (String#934, DoABC#2)
// onWidgetsInitialized = "_-2Ty" (String#890, DoABC#2)
// _SafeStr_10438 = "_-1es" (String#5641, DoABC#2)
// _SafeStr_10459 = "_-2aa" (String#20468, DoABC#2)
// _SafeStr_10460 = "_-1ZB" (String#17860, DoABC#2)
// _SafeStr_10461 = "_-cf" (String#23739, DoABC#2)
// _SafeStr_10462 = "_-Jf" (String#22992, DoABC#2)
// _SafeStr_10463 = "_-0Sm" (String#15160, DoABC#2)
// _SafeStr_10464 = "_-07T" (String#14343, DoABC#2)
// onTextInput = "_-1C4" (String#16946, DoABC#2)
// onClickNext = "_-1WI" (String#17753, DoABC#2)
// onClickPrev = "_-2aq" (String#20481, DoABC#2)
// getBaseNameFromProduct = "_-1Rc" (String#17569, DoABC#2)
// getTrophyTypeFromProduct = "_-1jK" (String#18258, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// TrophyCatalogWidget = "_-0Qf" (String#15088, DoABC#2)
// CatalogWidgetColourIndexEvent = "_-00G" (String#3567, DoABC#2)
// SetExtraPurchaseParameterEvent = "_-2sO" (String#7128, DoABC#2)
// CatalogWidgetColoursEvent = "_-2Vi" (String#6678, DoABC#2)
// ProductImageConfiguration = "_-28v" (String#6222, DoABC#2)
// TextInputEvent = "_-2kd" (String#6969, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// previewCallbackId = "_-2QR" (String#20063, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// onPreviewImageReady = "_-30x" (String#625, DoABC#2)
// _SafeStr_5075 = "_-Eh" (String#22802, DoABC#2)
// hasProductImage = "_-1Ix" (String#17235, DoABC#2)
// setPreviewImage = "_-27B" (String#448, DoABC#2)
// setPreviewFromAsset = "_-1qV" (String#1768, DoABC#2)
// retrievePreviewAsset = "_-04a" (String#579, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


