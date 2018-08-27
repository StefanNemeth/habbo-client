
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.room.IGetImageListener;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import flash.geom.Point;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.viewer.RoomPreviewer;
    import flash.display.DisplayObject;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.catalog.viewer.BundleProductContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
    import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
    import com.sulake.habbo.avatar.animation.IAnimationLayerData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.avatar.enum.AvatarAction;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import flash.geom.Matrix;
    import flash.display.BlendMode;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class ProductViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener 
    {

        private var _bundlePreview:BitmapData;
        private var _productName:ITextWindow;
        private var _productDescription:ITextWindow;
        private var _SafeStr_10438:IBitmapWrapperWindow;
        private var _SafeStr_10439:IWindowContainer;
        private var _SafeStr_10440:IDisplayObjectWrapper;
        private var _SafeStr_10441:Point;
        private var _SafeStr_10442:IItemGridWindow;
        private var _SafeStr_10443:IScrollbarWindow;
        protected var _SafeStr_10422:XML;
        private var _SafeStr_10444:Array;

        public function ProductViewCatalogWidget(_arg_1:IWindowContainer)
        {
            super(_arg_1);
        }
        override public function dispose():void
        {
            super.dispose();
            this._bundlePreview = null;
            if (this._SafeStr_10439 != null){
                this._SafeStr_10439.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickRoomView);
                this._SafeStr_10439 = null;
            };
        }
        override public function init():Boolean
        {
            var _local_3:RoomPreviewer;
            var _local_4:DisplayObject;
            if (!super.init()){
                return (false);
            };
            this._productName = (_window.findChildByName("ctlg_product_name") as ITextWindow);
            this._productDescription = (_window.findChildByName("ctlg_description") as ITextWindow);
            this._SafeStr_10438 = (_window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            this._SafeStr_10439 = (_window.findChildByName("room_canvas_container") as IWindowContainer);
            if (this._SafeStr_10439 != null){
                this._SafeStr_10439.visible = false;
                this._SafeStr_10440 = (this._SafeStr_10439.findChildByName("room_canvas") as IDisplayObjectWrapper);
                _local_3 = (page.viewer.catalog as HabboCatalog).roomPreviewer;
                if (((!((this._SafeStr_10440 == null))) && (!((_local_3 == null))))){
                    this._SafeStr_10439.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClickRoomView);
                    _local_3.reset();
                    _local_4 = _local_3.getRoomCanvas(this._SafeStr_10440.width, this._SafeStr_10440.height);
                    if (_local_4 != null){
                        this._SafeStr_10440.setDisplayObject(_local_4);
                    };
                }
                else {
                    this._SafeStr_10439 = null;
                    this._SafeStr_10440 = null;
                };
            };
            this._SafeStr_10441 = new Point(this._SafeStr_10438.x, this._SafeStr_10438.y);
            this._SafeStr_10442 = (_window.findChildByName("bundleGrid") as IItemGridWindow);
            this._SafeStr_10443 = (_window.findChildByName("bundleGridScrollbar") as IScrollbarWindow);
            if (this._SafeStr_10442 == null){
                Logger.log("[ProductViewCatalogWidget] Bundle Grid not initialized!");
            };
            var _local_1:XmlAsset = (page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset);
            this._SafeStr_10422 = (_local_1.content as XML);
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset);
            this._bundlePreview = (_local_2.content as BitmapData);
            events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT, this.onPreviewProduct);
            return (true);
        }
        private function onPreviewProduct(_arg_1:SelectProductEvent):void
        {
            var _local_2:Offer;
            var _local_4:String;
            var _local_5:String;
            var _local_6:BitmapData;
            var _local_7:Point;
            var _local_8:RoomPreviewer;
            var _local_9:IProduct;
            var _local_10:ImageResult;
            var _local_11:BundleProductContainer;
            var _local_12:String;
            var _local_13:IHabboWindowManager;
            var _local_14:IWindowContainer;
            var _local_15:uint;
            var _local_16:BitmapData;
            var _local_17:HabboCatalog;
            var _local_18:IAvatarImage;
            var _local_19:String;
            var _local_20:Point;
            var _local_21:Point;
            var _local_22:IAvatarDataContainer;
            var _local_23:ISpriteDataContainer;
            var _local_24:IAnimationLayerData;
            if (_arg_1 == null){
                return;
            };
            this.removeEffectSprites();
            _local_2 = _arg_1.offer;
            if (this._SafeStr_10442 != null){
                this._SafeStr_10442.visible = false;
                this._SafeStr_10442.destroyGridItems();
            };
            if (this._SafeStr_10443 != null){
                this._SafeStr_10443.visible = false;
            };
            var _local_3:IProductData = page.viewer.catalog.getProductData(_local_2.localizationId);
            if (_local_3 != null){
                _local_4 = (("${" + _local_3.name) + "}");
                _local_5 = (("${" + _local_3.description) + "}");
            }
            else {
                _local_4 = (("${" + _local_2.localizationId) + "}");
                _local_5 = (("${" + _local_2.localizationId) + "}");
            };
            this._productName.text = _local_4;
            this._productDescription.text = _local_5;
            this._productName.height = (this._productName.textHeight + 5);
            this._productDescription.y = (this._productName.y + this._productName.height);
            this._productDescription.height = Math.max(130, (this._productDescription.textHeight + 5));
            if (ProductImageConfiguration.hasProductImage(_local_2.localizationId)){
                this.setPreviewFromAsset(ProductImageConfiguration._SafeStr_5075[_local_2.localizationId]);
                if (this._SafeStr_10439 != null){
                    this._SafeStr_10439.visible = false;
                };
            }
            else {
                _local_7 = new Point(0, 0);
                _local_8 = (page.viewer.catalog as HabboCatalog).roomPreviewer;
                switch (_local_2.pricingModel){
                    case Offer._SafeStr_4888:
                        _local_6 = this._bundlePreview.clone();
                        if (this._SafeStr_10442 != null){
                            this._SafeStr_10442.visible = true;
                            _local_11 = (_local_2.productContainer as BundleProductContainer);
                            _local_11.populateItemGrid(this._SafeStr_10442, this._SafeStr_10443, this._SafeStr_10422);
                            this._SafeStr_10442.scrollV = 0;
                        };
                        if (this._SafeStr_10439 != null){
                            this._SafeStr_10439.visible = false;
                        };
                        break;
                    case Offer._SafeStr_4886:
                    case Offer._SafeStr_4887:
                        _local_9 = _local_2.productContainer.firstProduct;
                        if (this._SafeStr_10439 != null){
                            if ((((((_local_9.productType == ProductTypeEnum._SafeStr_5017)) || ((_local_9.productType == ProductTypeEnum._SafeStr_5019)))) || ((_local_9.productType == ProductTypeEnum._SafeStr_5021)))){
                                this._SafeStr_10439.visible = true;
                            }
                            else {
                                this._SafeStr_10439.visible = false;
                            };
                        };
                        switch (_local_9.productType){
                            case ProductTypeEnum._SafeStr_5017:
                                if (((!((_local_8 == null))) && (!((this._SafeStr_10440 == null))))){
                                    _local_8.addFurnitureIntoRoom(_local_9.productClassId, new Vector3d(90, 0, 0));
                                }
                                else {
                                    _local_10 = page.viewer.roomEngine.getFurnitureImage(_local_9.productClassId, new Vector3d(90, 0, 0), 64, this, 0, _local_9.extraParam);
                                    _local_2.previewCallbackId = _local_10.id;
                                };
                                break;
                            case ProductTypeEnum._SafeStr_5019:
                                if (((!((_local_8 == null))) && (!((this._SafeStr_10440 == null))))){
                                    _local_8.addWallItemIntoRoom(_local_9.productClassId, new Vector3d(90, 0, 0), _local_9.extraParam);
                                }
                                else {
                                    _local_10 = page.viewer.roomEngine.getWallItemImage(_local_9.productClassId, new Vector3d(90, 0, 0), 64, this, 0, _local_9.extraParam);
                                    _local_2.previewCallbackId = _local_10.id;
                                };
                                break;
                            case ProductTypeEnum._SafeStr_5021:
                                if (((!((_local_8 == null))) && (!((this._SafeStr_10440 == null))))){
                                    _local_12 = (page.viewer.catalog as HabboCatalog).sessionDataManager.figure;
                                    _local_8.addAvatarIntoRoom(_local_12, _local_9.productClassId);
                                }
                                else {
                                    _local_13 = page.viewer.catalog.windowManager;
                                    _local_14 = (_window.findChildByName("pixelsBackground") as IWindowContainer);
                                    _local_15 = 4291611852;
                                    if (_local_14 != null){
                                        _local_14.visible = true;
                                        _local_15 = _local_14.color;
                                    };
                                    _local_6 = new BitmapData(this._SafeStr_10438.width, this._SafeStr_10438.height, false, _local_15);
                                    _local_16 = null;
                                    _local_17 = (page.viewer.catalog as HabboCatalog);
                                    if (_local_17.avatarRenderManager != null){
                                        _local_19 = _local_17.sessionDataManager.figure;
                                        _local_18 = _local_17.avatarRenderManager.createAvatarImage(_local_19, AvatarScaleType._SafeStr_4336);
                                        if (_local_18 != null){
                                            _local_18.setDirection(AvatarSetType._SafeStr_4458, 3);
                                            _local_18.initActionAppends();
                                            _local_18.appendAction(AvatarAction._SafeStr_4479, AvatarAction._SafeStr_9991);
                                            _local_18.appendAction(AvatarAction._SafeStr_6564, _local_9.productClassId);
                                            _local_18.endActionAppends();
                                            _local_18.updateAnimationByFrames(1);
                                            _local_18.updateAnimationByFrames(1);
                                            _local_16 = _local_18.getImage(AvatarSetType._SafeStr_4457, true);
                                            _local_20 = new Point(0, 0);
                                            if (_local_16 != null){
                                                _local_22 = _local_18.avatarSpriteData;
                                                if (_local_22 != null){
                                                };
                                                _local_20.x = ((_local_6.width - _local_16.width) / 2);
                                                _local_20.y = ((_local_6.height - _local_16.height) / 2);
                                                for each (_local_23 in _local_18.getSprites()) {
                                                    if (_local_23.id == "avatar"){
                                                        _local_24 = _local_18.getLayerData(_local_23);
                                                        _local_7.x = _local_24.dx;
                                                        _local_7.y = _local_24.dy;
                                                    };
                                                };
                                            };
                                            _local_21 = new Point(0, (_local_16.height - 16));
                                            this.addEffectSprites(_local_6, _local_18, _local_7, _local_20.add(_local_21), false);
                                            _local_6.copyPixels(_local_16, _local_16.rect, _local_20, null, null, true);
                                            this.addEffectSprites(_local_6, _local_18, _local_7, _local_20.add(_local_21));
                                        };
                                    };
                                    if (_local_18){
                                        _local_18.dispose();
                                    };
                                };
                                break;
                            case ProductTypeEnum._SafeStr_5023:
                                break;
                            default:
                                Logger.log(("[ProductViewCatalogWidget] Unknown Product Type: " + _local_9.productType));
                        };
                        if (_local_10 != null){
                            _local_6 = _local_10.data;
                        };
                        break;
                    default:
                        Logger.log(("[ProductViewCatalogWidget] Unknown pricing model" + _local_2.pricingModel));
                };
                this.setPreviewImage(_local_6, true, _local_7);
            };
            _window.invalidate();
        }
        private function addEffectSprites(_arg_1:BitmapData, _arg_2:IAvatarImage, _arg_3:Point, _arg_4:Point, _arg_5:Boolean=true):void
        {
            var _local_6:ISpriteDataContainer;
            var _local_7:int;
            var _local_8:IAnimationLayerData;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:String;
            var _local_15:BitmapDataAsset;
            var _local_16:BitmapData;
            var _local_17:Number;
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Matrix;
            for each (_local_6 in _arg_2.getSprites()) {
                _local_7 = _window.getChildIndex(this._SafeStr_10438);
                _local_8 = _arg_2.getLayerData(_local_6);
                _local_9 = 0;
                _local_10 = _local_6.getDirectionOffsetX(_arg_2.getDirection());
                _local_11 = _local_6.getDirectionOffsetY(_arg_2.getDirection());
                _local_12 = _local_6.getDirectionOffsetZ(_arg_2.getDirection());
                _local_13 = 0;
                if (!_arg_5){
                    if (_local_12 >= 0) continue;
                }
                else {
                    if (_local_12 < 0) continue;
                };
                if (_local_6.hasDirections){
                    _local_13 = _arg_2.getDirection();
                };
                if (_local_8 != null){
                    _local_9 = _local_8.animationFrame;
                    _local_10 = (_local_10 + _local_8.dx);
                    _local_11 = (_local_11 + _local_8.dy);
                    _local_13 = (_local_13 + _local_8.directionOffset);
                };
                if (_local_13 < 0){
                    _local_13 = (_local_13 + 8);
                };
                if (_local_13 > 7){
                    _local_13 = (_local_13 - 8);
                };
                _local_14 = ((((((_arg_2.getScale() + "_") + _local_6.member) + "_") + _local_13) + "_") + _local_9);
                _local_15 = _arg_2.getAsset(_local_14);
                if (_local_15 != null){
                    _local_16 = (_local_15.content as BitmapData).clone();
                    _local_17 = 1;
                    _local_18 = ((_arg_4.x - (1 * _local_15.offset.x)) + _local_10);
                    _local_19 = ((_arg_4.y - (1 * _local_15.offset.y)) + _local_11);
                    if (_local_6.ink == 33){
                        _local_20 = new Matrix(1, 0, 0, 1, (_local_18 - _arg_3.x), (_local_19 - _arg_3.y));
                        _arg_1.draw(_local_16, _local_20, null, BlendMode.ADD, null, false);
                    }
                    else {
                        _arg_1.copyPixels(_local_16, _local_16.rect, new Point((_local_18 - _arg_3.x), (_local_19 - _arg_3.y)));
                    };
                };
            };
        }
        private function removeEffectSprites():void
        {
            var _local_1:IBitmapWrapperWindow;
            for each (_local_1 in this._SafeStr_10444) {
                _window.removeChild(_local_1);
                _local_1.dispose();
                _local_1 = null;
            };
            this._SafeStr_10444 = new Array();
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:Offer;
            if (((((disposed) || ((page == null)))) || ((page.offers == null)))){
                return;
            };
            for each (_local_3 in page.offers) {
                if (_local_3.previewCallbackId == _arg_1){
                    this.setPreviewImage(_arg_2, true);
                    _local_3.previewCallbackId = 0;
                    break;
                };
            };
        }
        private function setPreviewImage(_arg_1:BitmapData, _arg_2:Boolean, _arg_3:Point=null):void
        {
            var _local_4:Point;
            if (((!((this._SafeStr_10438 == null))) && (!(window.disposed)))){
                if (_arg_1 == null){
                    _arg_1 = new BitmapData(1, 1);
                    _arg_2 = true;
                };
                if (this._SafeStr_10438.bitmap == null){
                    this._SafeStr_10438.bitmap = new BitmapData(this._SafeStr_10438.width, this._SafeStr_10438.height, true, 0xFFFFFF);
                };
                this._SafeStr_10438.bitmap.fillRect(this._SafeStr_10438.bitmap.rect, 0xFFFFFF);
                _local_4 = new Point(((this._SafeStr_10438.width - _arg_1.width) / 2), ((this._SafeStr_10438.height - _arg_1.height) / 2));
                this._SafeStr_10438.bitmap.copyPixels(_arg_1, _arg_1.rect, _local_4, null, null, true);
                this._SafeStr_10438.invalidate();
                this._SafeStr_10438.x = this._SafeStr_10441.x;
                this._SafeStr_10438.y = this._SafeStr_10441.y;
                if (_arg_3 != null){
                    this._SafeStr_10438.x = (this._SafeStr_10438.x + _arg_3.x);
                    this._SafeStr_10438.y = (this._SafeStr_10438.y + _arg_3.y);
                };
            };
            if (_arg_2){
                _arg_1.dispose();
            };
        }
        private function setPreviewFromAsset(_arg_1:String):void
        {
            if (((((((((!(_arg_1)) || (!(page)))) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.assets)))){
                return;
            };
            var _local_2:BitmapDataAsset = (page.viewer.catalog.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null){
                this.retrievePreviewAsset(_arg_1);
                return;
            };
            this.setPreviewImage((_local_2.content as BitmapData), false);
        }
        private function retrievePreviewAsset(_arg_1:String):void
        {
            if (((((((((!(_arg_1)) || (!(page)))) || (!(page.viewer)))) || (!(page.viewer.catalog)))) || (!(page.viewer.catalog.configuration)))){
                return;
            };
            var _local_2:String = page.viewer.catalog.configuration.getKey("image.library.catalogue.url");
            var _local_3 = ((_local_2 + _arg_1) + ".gif");
            Logger.log(("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _local_3));
            var _local_4:URLRequest = new URLRequest(_local_3);
            if (!page.viewer.catalog.assets){
                return;
            };
            var _local_5:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(_arg_1, _local_4, "image/gif");
            if (!_local_5){
                return;
            };
            _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onPreviewImageReady);
        }
        private function onPreviewImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                this.setPreviewFromAsset(_local_2.assetName);
            };
        }
        private function onClickRoomView(_arg_1:WindowMouseEvent):void
        {
            var _local_2:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if (_local_2 != null){
                _local_2.changeRoomObjectState();
            };
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// avatarSpriteData = "_-13z" (String#4955, DoABC#2)
// _SafeStr_10422 = "_-2c4" (String#1909, DoABC#2)
// _productDescription = "_-65" (String#7783, DoABC#2)
// _SafeStr_10438 = "_-1es" (String#5641, DoABC#2)
// _SafeStr_10439 = "_-24i" (String#19211, DoABC#2)
// _SafeStr_10440 = "_-2eg" (String#20634, DoABC#2)
// _SafeStr_10441 = "_-bR" (String#23690, DoABC#2)
// _SafeStr_10442 = "_-3Ho" (String#22194, DoABC#2)
// _SafeStr_10443 = "_-qX" (String#24294, DoABC#2)
// _SafeStr_10444 = "_-00j" (String#14083, DoABC#2)
// onClickRoomView = "_-0mB" (String#15902, DoABC#2)
// roomPreviewer = "_-1vc" (String#18781, DoABC#2)
// onPreviewProduct = "_-r4" (String#2207, DoABC#2)
// removeEffectSprites = "_-2l2" (String#20883, DoABC#2)
// addEffectSprites = "_-2Q6" (String#20048, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ProductTypeEnum = "_-11z" (String#16536, DoABC#2)
// RoomPreviewer = "_-fc" (String#23871, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IAvatarDataContainer = "_-2OR" (String#6528, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// BundleProductContainer = "_-1p3" (String#5839, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// ProductViewCatalogWidget = "_-gM" (String#8516, DoABC#2)
// ProductImageConfiguration = "_-28v" (String#6222, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// updateAnimationByFrames = "_-05f" (String#3680, DoABC#2)
// getImage = "_-eg" (String#2150, DoABC#2)
// getSprites = "_-3Go" (String#7642, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// getDirectionOffsetX = "_-1Oo" (String#5331, DoABC#2)
// getDirectionOffsetY = "_-31k" (String#7340, DoABC#2)
// getDirectionOffsetZ = "_-3HQ" (String#7657, DoABC#2)
// hasDirections = "_-1RM" (String#5383, DoABC#2)
// animationFrame = "_-gS" (String#8520, DoABC#2)
// directionOffset = "_-25H" (String#6148, DoABC#2)
// getScale = "_-1EW" (String#5151, DoABC#2)
// initActionAppends = "_-2j7" (String#6936, DoABC#2)
// appendAction = "_-1hS" (String#5696, DoABC#2)
// _SafeStr_4479 = "_-Dm" (String#22761, DoABC#2)
// endActionAppends = "_-1gH" (String#5667, DoABC#2)
// _SafeStr_4886 = "_-04Q" (String#14220, DoABC#2)
// _SafeStr_4887 = "_-0F0" (String#14645, DoABC#2)
// _SafeStr_4888 = "_-2gY" (String#20713, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// pricingModel = "_-1Lx" (String#17355, DoABC#2)
// previewCallbackId = "_-2QR" (String#20063, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// addFurnitureIntoRoom = "_-2hJ" (String#20743, DoABC#2)
// addWallItemIntoRoom = "_-0bD" (String#15485, DoABC#2)
// addAvatarIntoRoom = "_-03t" (String#14198, DoABC#2)
// changeRoomObjectState = "_-W1" (String#8322, DoABC#2)
// getRoomCanvas = "_-HZ" (String#8028, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// _SafeStr_5017 = "_-1-l" (String#16457, DoABC#2)
// _SafeStr_5019 = "_-Ok" (String#23195, DoABC#2)
// _SafeStr_5021 = "_-h-" (String#23930, DoABC#2)
// _SafeStr_5023 = "_-hJ" (String#23942, DoABC#2)
// onPreviewImageReady = "_-30x" (String#625, DoABC#2)
// populateItemGrid = "_-2Ws" (String#892, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// _SafeStr_5075 = "_-Eh" (String#22802, DoABC#2)
// hasProductImage = "_-1Ix" (String#17235, DoABC#2)
// _productName = "_-09X" (String#1413, DoABC#2)
// _SafeStr_6564 = "_-1eZ" (String#18081, DoABC#2)
// setPreviewImage = "_-27B" (String#448, DoABC#2)
// setPreviewFromAsset = "_-1qV" (String#1768, DoABC#2)
// retrievePreviewAsset = "_-04a" (String#579, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9991 = "_-1nY" (String#18442, DoABC#2)


