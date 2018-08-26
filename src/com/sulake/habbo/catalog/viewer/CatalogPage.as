
package com.sulake.habbo.catalog.viewer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.catalog.viewer.widgets.CatalogWidgetEnum;
    import com.sulake.habbo.catalog.viewer.widgets.ItemGroupCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PurseCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
    import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetsInitializedEvent;
    import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
    import flash.events.Event;

    public class CatalogPage implements ICatalogPage 
    {

        protected static const _SafeStr_5031:String = "ctlg_";

        protected var _SafeStr_5032:XML;
        protected var _window:IWindowContainer;
        private var _viewer:ICatalogViewer;
        private var _pageId:int;
        private var _layoutCode:String;
        private var _offers:Array;
        private var _localization:IPageLocalization;
        private var _SafeStr_5035:Array;
        private var _SafeStr_5036:EventDispatcher;
        private var _catalog:HabboCatalog;
        private var _SafeStr_5037:ItemGridCatalogWidget;

        public function CatalogPage(_arg_1:ICatalogViewer, _arg_2:int, _arg_3:String, _arg_4:IPageLocalization, _arg_5:Array, _arg_6:HabboCatalog)
        {
            var _local_7:CatalogPageMessageOfferData;
            var _local_8:Array;
            var _local_9:IProductData;
            var _local_10:CatalogPageMessageProductData;
            var _local_11:Offer;
            var _local_12:IFurnitureData;
            var _local_13:Product;
            this._SafeStr_5035 = [];
            super();
            this._viewer = _arg_1;
            this._pageId = _arg_2;
            this._layoutCode = _arg_3;
            this._localization = _arg_4;
            this._offers = new Array();
            this._catalog = _arg_6;
            for each (_local_7 in _arg_5) {
                _local_8 = new Array();
                _local_9 = this._viewer.catalog.getProductData(_local_7.localizationId);
                for each (_local_10 in _local_7.products) {
                    _local_12 = this._viewer.catalog.getFurnitureData(_local_10.furniClassId, _local_10.productType);
                    _local_13 = new Product(_local_10.productType, _local_10.furniClassId, _local_10.extraParam, _local_10.productCount, _local_10.expiration, _local_9, _local_12);
                    _local_8.push(_local_13);
                };
                _local_11 = new Offer(_local_7.offerId, _local_7.localizationId, _local_7.priceInCredits, _local_7.priceInActivityPoints, _local_7.activityPointType, _local_7.clubLevel, _local_8, this);
                if (_local_11.productContainer != null){
                    this._offers.push(_local_11);
                }
                else {
                    _local_11.dispose();
                };
            };
            this._SafeStr_5036 = new EventDispatcher();
            this._SafeStr_5035 = new Array();
            this.init();
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function get viewer():ICatalogViewer
        {
            return (this._viewer);
        }
        public function get pageId():int
        {
            return (this._pageId);
        }
        public function get layoutCode():String
        {
            return (this._layoutCode);
        }
        public function get offers():Array
        {
            return (this._offers);
        }
        public function get localization():IPageLocalization
        {
            return (this._localization);
        }
        public function get links():Array
        {
            return (this._localization.PageLocalization(this._layoutCode));
        }
        public function get hasLinks():Boolean
        {
            return (this._localization.hasLinks(this._layoutCode));
        }
        public function ICatalogPage(_arg_1:int):void
        {
            var _local_2:Offer;
            var _local_3:IGridItem;
            if (this._SafeStr_5037 != null){
                Logger.log(("selecting offer " + _arg_1));
                for each (_local_2 in this._offers) {
                    if (_local_2.offerId == _arg_1){
                        _local_3 = (_local_2.productContainer as IGridItem);
                        this._SafeStr_5037.select(_local_3);
                    };
                };
            };
        }
        public function dispose():void
        {
            var _local_1:ICatalogWidget;
            var _local_2:Offer;
            for each (_local_1 in this._SafeStr_5035) {
                _local_1.dispose();
            };
            this._SafeStr_5035 = null;
            this._localization.dispose();
            for each (_local_2 in this._offers) {
                _local_2.dispose();
            };
            this._offers = [];
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_5036 != null){
                this._SafeStr_5036.dispose();
                this._SafeStr_5036 = null;
            };
            this._viewer = null;
            this._SafeStr_5032 = null;
            this._pageId = 0;
            this._layoutCode = "";
        }
        public function init():void
        {
            if (this.createWindow(this.layoutCode)){
                this.CatalogPage();
            };
        }
        public function closed():void
        {
            var _local_1:ICatalogWidget;
            if (this._SafeStr_5035 != null){
                for each (_local_1 in this._SafeStr_5035) {
                    _local_1.closed();
                };
            };
        }
        protected function createWindow(_arg_1:String):Boolean
        {
            var _local_2:String = (_SafeStr_5031 + _arg_1);
            var _local_3:XmlAsset = (this.viewer.catalog.assets.getAssetByName(_local_2) as XmlAsset);
            if (_local_3 == null){
                Logger.log(("Could not find asset for layout " + _local_2));
                return (false);
            };
            this._SafeStr_5032 = (_local_3.content as XML);
            this._window = (this.viewer.catalog.windowManager.buildFromXML(this._SafeStr_5032) as IWindowContainer);
            if (this._window == null){
                Logger.log(("Could not create layout " + _arg_1));
                return (false);
            };
            return (true);
        }
        private function localize():void
        {
        }
        private function CatalogPage():void
        {
            this.CatalogPage(this._window);
            this.CatalogPage();
        }
        private function CatalogPage(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            var _local_3:IWindowContainer;
            if (_arg_1 != null){
                _local_2 = 0;
                while (_local_2 < _arg_1.numChildren) {
                    _local_3 = (_arg_1.getChildAt(_local_2) as IWindowContainer);
                    if (_local_3 != null){
                        this.createWidget(_local_3);
                        this.CatalogPage(_local_3);
                    };
                    _local_2++;
                };
            };
        }
        private function createWidget(_arg_1:IWindowContainer):void
        {
            if (_arg_1 == null){
                return;
            };
            switch (_arg_1.name){
                case CatalogWidgetEnum._SafeStr_5045:
                    if (this._SafeStr_5037 == null){
                        this._SafeStr_5037 = new ItemGridCatalogWidget(_arg_1, this._catalog.sessionDataManager);
                        this._SafeStr_5035.push(this._SafeStr_5037);
                    };
                    return;
                case CatalogWidgetEnum._SafeStr_5046:
                    this._SafeStr_5035.push(new ItemGroupCatalogWidget(_arg_1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum._SafeStr_5047:
                    this._SafeStr_5035.push(new ProductViewCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5049:
                    this._SafeStr_5035.push(new SongDiskProductViewCatalogWidget(_arg_1, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum._SafeStr_5050:
                    this._SafeStr_5035.push(new SingleViewCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5051:
                    this._SafeStr_5035.push(new PurchaseCatalogWidget(_arg_1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum._SafeStr_5052:
                    this._SafeStr_5035.push(new PurseCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5053:
                    this._SafeStr_5035.push(new ColourGridCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5054:
                    this._SafeStr_5035.push(new TraxPreviewCatalogWidget(_arg_1, this._catalog.soundManager));
                    return;
                case CatalogWidgetEnum._SafeStr_5055:
                    this._SafeStr_5035.push(new RedeemItemCodeCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5056:
                    this._SafeStr_5035.push(new SpacesCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5057:
                    this._SafeStr_5035.push(new SpacesNewCatalogWidget(_arg_1, this._catalog.sessionDataManager));
                    return;
                case CatalogWidgetEnum._SafeStr_5058:
                    this._SafeStr_5035.push(new RoomPreviewCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5059:
                    this._SafeStr_5035.push(new TrophyCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5060:
                    this._SafeStr_5035.push(new PetsCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5061:
                    this._SafeStr_5035.push(new NewPetsCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5062:
                    this._SafeStr_5035.push(new TextInputCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5063:
                    this._SafeStr_5035.push(new SpecialInfoWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5064:
                    this._SafeStr_5035.push(new RecyclerCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5065:
                    this._SafeStr_5035.push(new RecyclerPrizesCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5066:
                    this._SafeStr_5035.push(new MarketPlaceCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5067:
                    this._SafeStr_5035.push(new MarketPlaceOwnItemsCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5069:
                    this._SafeStr_5035.push(new ClubGiftWidget(_arg_1, this._catalog.getClubGiftController()));
                    return;
                case CatalogWidgetEnum._SafeStr_5070:
                    this._SafeStr_5035.push(new ClubBuyCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5071:
                    this._SafeStr_5035.push(new ActivityPointDisplayCatalogWidget(_arg_1));
                    return;
                case CatalogWidgetEnum._SafeStr_5072:
                    this._SafeStr_5035.push(new MadMoneyCatalogWidget(_arg_1));
                    return;
            };
        }
        private function CatalogPage():void
        {
            var _local_1:ICatalogWidget;
            var _local_2:Array = [];
            for each (_local_1 in this._SafeStr_5035) {
                _local_1.page = this;
                _local_1.events = this._SafeStr_5036;
                if (!_local_1.init()){
                    _local_2.push(_local_1);
                };
            };
            this.CatalogPage(_local_2);
            this.CatalogPage();
            this._SafeStr_5036.dispatchEvent(new CatalogWidgetsInitializedEvent());
        }
        private function CatalogPage():void
        {
            var _local_1:ICatalogWidget = new LocalizationCatalogWidget(this._window);
            this._SafeStr_5035.push(_local_1);
            _local_1.page = this;
            _local_1.events = this._SafeStr_5036;
            _local_1.init();
        }
        private function CatalogPage(_arg_1:Array):void
        {
            var _local_2:ICatalogWidget;
            var _local_3:ICatalogWidget;
            var _local_4:int;
            if ((((_arg_1 == null)) || ((_arg_1.length == 0)))){
                return;
            };
            for each (_local_2 in this._SafeStr_5035) {
                if (_local_2.window != null){
                    for each (_local_3 in _arg_1) {
                        if (_local_3.window != null){
                            if (_local_3.window.getChildIndex(_local_2.window) >= 0){
                                if (_arg_1.indexOf(_local_2) < 0){
                                    _arg_1.push(_local_2);
                                };
                                break;
                            };
                        };
                    };
                };
            };
            for each (_local_3 in _arg_1) {
                if (_local_3.window != null){
                    this._window.removeChild(_local_3.window);
                    _local_3.window.dispose();
                };
                _local_4 = this._SafeStr_5035.indexOf(_local_3);
                if (_local_4 >= 0){
                    this._SafeStr_5035.splice(_local_4, 1);
                };
                _local_3.dispose();
            };
        }
        public function dispatchWidgetEvent(_arg_1:Event):Boolean
        {
            if (this._SafeStr_5036 != null){
                return (this._SafeStr_5036.dispatchEvent(_arg_1));
            };
            return (false);
        }
        public function replaceOffers(_arg_1:Array, _arg_2:Boolean=false):void
        {
            var _local_3:Offer;
            if (_arg_2){
                for each (_local_3 in this._offers) {
                    _local_3.dispose();
                };
            };
            this._offers = _arg_1;
        }

    }
}//package com.sulake.habbo.catalog.viewer

// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// IPageLocalization = "_-0gS" (String#4433, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ICatalogViewer = "_-Ve" (String#8313, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// ClubGiftWidget = "_-2um" (String#7176, DoABC#2)
// IGridItem = "_-1oJ" (String#5825, DoABC#2)
// Product = "_-2z8" (String#7267, DoABC#2)
// CatalogPage = "_-0jJ" (String#4486, DoABC#2)
// ActivityPointDisplayCatalogWidget = "_-0T-" (String#4159, DoABC#2)
// NewPetsCatalogWidget = "_-260" (String#6161, DoABC#2)
// ItemGridCatalogWidget = "_-0OU" (String#4058, DoABC#2)
// ColourGridCatalogWidget = "_-Vd" (String#23478, DoABC#2)
// CatalogWidgetsInitializedEvent = "_-0-E" (String#14021, DoABC#2)
// PurseCatalogWidget = "_-3I4" (String#22204, DoABC#2)
// ProductViewCatalogWidget = "_-gM" (String#8516, DoABC#2)
// SingleViewCatalogWidget = "_-0aE" (String#4306, DoABC#2)
// SongDiskProductViewCatalogWidget = "_-1Xx" (String#5518, DoABC#2)
// TrophyCatalogWidget = "_-0Qf" (String#15088, DoABC#2)
// PurchaseCatalogWidget = "_-2be" (String#6786, DoABC#2)
// RedeemItemCodeCatalogWidget = "_-2hi" (String#20762, DoABC#2)
// MadMoneyCatalogWidget = "_-hh" (String#23954, DoABC#2)
// SpecialInfoWidget = "_-id" (String#23984, DoABC#2)
// TextInputCatalogWidget = "_-3LC" (String#22333, DoABC#2)
// RecyclerPrizesCatalogWidget = "_-MH" (String#8127, DoABC#2)
// LocalizationCatalogWidget = "_-2Y0" (String#6726, DoABC#2)
// MarketPlaceCatalogWidget = "_-kk" (String#8620, DoABC#2)
// CatalogWidgetEnum = "_-0hx" (String#15746, DoABC#2)
// RoomPreviewCatalogWidget = "_-DO" (String#7939, DoABC#2)
// RecyclerCatalogWidget = "_-0cp" (String#4362, DoABC#2)
// SpacesNewCatalogWidget = "_-1OF" (String#5316, DoABC#2)
// SpacesCatalogWidget = "_-0bb" (String#4335, DoABC#2)
// ItemGroupCatalogWidget = "_-b3" (String#8442, DoABC#2)
// PetsCatalogWidget = "_-rp" (String#8733, DoABC#2)
// TraxPreviewCatalogWidget = "_-JI" (String#8069, DoABC#2)
// MarketPlaceOwnItemsCatalogWidget = "_-2Di" (String#6316, DoABC#2)
// PageLocalization = "_-Eu" (String#7970, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// dispatchWidgetEvent = "_-2V-" (String#1888, DoABC#2)
// ICatalogPage = "_-26U" (String#6175, DoABC#2)
// _SafeStr_5031 = "_-3H5" (String#22167, DoABC#2)
// _SafeStr_5032 = "_-0Tq" (String#4176, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// _layoutCode = "_-0WC" (String#4230, DoABC#2)
// _SafeStr_5035 = "_-0aF" (String#4307, DoABC#2)
// _SafeStr_5036 = "_-0xe" (String#16339, DoABC#2)
// _SafeStr_5037 = "_-Rr" (String#23319, DoABC#2)
// furniClassId = "_-1lo" (String#18367, DoABC#2)
// CatalogPage = "_-2YP" (String#20373, DoABC#2)
// localize = "_-2KD" (String#6450, DoABC#2)
// CatalogPage = "_-2tC" (String#21210, DoABC#2)
// CatalogPage = "_-1dp" (String#18051, DoABC#2)
// createWidget = "_-2kN" (String#1932, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// _SafeStr_5045 = "_-0Fu" (String#14678, DoABC#2)
// _SafeStr_5046 = "_-1Y-" (String#17815, DoABC#2)
// _SafeStr_5047 = "_-2Uu" (String#20234, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// _SafeStr_5049 = "_-2l5" (String#20885, DoABC#2)
// _SafeStr_5050 = "_-1Pc" (String#17493, DoABC#2)
// _SafeStr_5051 = "_-0Ox" (String#15022, DoABC#2)
// _SafeStr_5052 = "_-3I" (String#22201, DoABC#2)
// _SafeStr_5053 = "_-24V" (String#19200, DoABC#2)
// _SafeStr_5054 = "_-1vx" (String#18794, DoABC#2)
// _SafeStr_5055 = "_-IS" (String#22947, DoABC#2)
// _SafeStr_5056 = "_-1Jy" (String#17272, DoABC#2)
// _SafeStr_5057 = "_-0cl" (String#15544, DoABC#2)
// _SafeStr_5058 = "_-59" (String#22426, DoABC#2)
// _SafeStr_5059 = "_-3-I" (String#21473, DoABC#2)
// _SafeStr_5060 = "_-O4" (String#23171, DoABC#2)
// _SafeStr_5061 = "_-13P" (String#16594, DoABC#2)
// _SafeStr_5062 = "_-2uB" (String#21247, DoABC#2)
// _SafeStr_5063 = "_-2ys" (String#21422, DoABC#2)
// _SafeStr_5064 = "_-3AZ" (String#21904, DoABC#2)
// _SafeStr_5065 = "_-0T" (String#15170, DoABC#2)
// _SafeStr_5066 = "_-1QA" (String#17516, DoABC#2)
// _SafeStr_5067 = "_-0e5" (String#15588, DoABC#2)
// getClubGiftController = "_-3B" (String#21920, DoABC#2)
// _SafeStr_5069 = "_-3Lb" (String#22349, DoABC#2)
// _SafeStr_5070 = "_-1Bq" (String#16934, DoABC#2)
// _SafeStr_5071 = "_-0Yj" (String#15388, DoABC#2)
// _SafeStr_5072 = "_-0LI" (String#14886, DoABC#2)
// CatalogPage = "_-2ea" (String#20629, DoABC#2)
// CatalogPage = "_-21c" (String#19078, DoABC#2)


