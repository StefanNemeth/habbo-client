
package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.catalog.club.ClubGiftController;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.viewer.Product;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.catalog.viewer.IProductContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Rectangle;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.room.utils.Vector3d;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.XmlAsset;

    public class ClubGiftWidget extends CatalogWidget implements ICatalogWidget 
    {

        private const _SafeStr_10386:int = 31;

        private var _controller:ClubGiftController;
        private var _itemList:IItemListWindow;
        private var _offers:Map;
        private var _SafeStr_10387:IWindowContainer;

        public function ClubGiftWidget(_arg_1:IWindowContainer, _arg_2:ClubGiftController)
        {
            super(_arg_1);
            this._controller = _arg_2;
            this._offers = new Map();
        }
        override public function dispose():void
        {
            super.dispose();
            this._controller = null;
            if (this._SafeStr_10387){
                this._SafeStr_10387.dispose();
                this._SafeStr_10387 = null;
            };
        }
        override public function init():Boolean
        {
            if (!window){
                return (false);
            };
            if (!super.init()){
                return (false);
            };
            this._controller.widget = this;
            var _local_1:IWindowContainer = (window.findChildByName("widget_main_container") as IWindowContainer);
            if (!_local_1){
                _local_1 = (this.createWindow("clubGiftWidget") as IWindowContainer);
                if (!_local_1){
                    return (false);
                };
                window.addChild(_local_1);
                this._itemList = (_local_1.findChildByName("gift_list") as IItemListWindow);
            };
            this.update();
            return (true);
        }
        public function update():void
        {
            this.InfoStandUserView();
            this.updateList();
        }
        private function InfoStandUserView():void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:int;
            var _local_7:int;
            if (((!(this._controller)) || (!(window)))){
                return;
            };
            var _local_1:ITextWindow = (window.findChildByName("info_text") as ITextWindow);
            if (!_local_1){
                return;
            };
            if (this._controller.giftsAvailable > 0){
                _local_2 = "catalog.club_gift.available";
                this._controller.localization.registerParameter(_local_2, "amount", this._controller.giftsAvailable.toString());
            }
            else {
                if (this._controller.daysUntilNextGift > 0){
                    _local_2 = "catalog.club_gift.days_until_next";
                    this._controller.localization.registerParameter(_local_2, "days", this._controller.daysUntilNextGift.toString());
                }
                else {
                    if (this._controller.hasClub){
                        _local_2 = "catalog.club_gift.not_available";
                    }
                    else {
                        _local_2 = "catalog.club_gift.no_club";
                    };
                };
            };
            _local_1.text = this._controller.localization.getKey(_local_2);
            if (!this._controller.purse){
                return;
            };
            var _local_5:ITextWindow = (window.findChildByName("past_club_days") as ITextWindow);
            if (_local_5){
                _local_7 = (this._controller.purse.pastClubDays + this._controller.purse.pastVipDays);
                _local_2 = (((_local_7 >= this._SafeStr_10386)) ? "catalog.club_gift.past_club.long" : "catalog.club_gift.past_club");
                _local_3 = (_local_7 % this._SafeStr_10386);
                _local_4 = (_local_7 / this._SafeStr_10386);
                this._controller.localization.registerParameter(_local_2, "days", _local_3.toString());
                this._controller.localization.registerParameter(_local_2, "months", _local_4.toString());
                _local_5.text = this._controller.localization.getKey(_local_2);
            };
            var _local_6:ITextWindow = (window.findChildByName("past_vip_days") as ITextWindow);
            if (_local_6){
                _local_2 = (((this._controller.purse.pastVipDays >= this._SafeStr_10386)) ? "catalog.club_gift.past_vip.long" : "catalog.club_gift.past_vip");
                _local_3 = (this._controller.purse.pastVipDays % this._SafeStr_10386);
                _local_4 = (this._controller.purse.pastVipDays / this._SafeStr_10386);
                this._controller.localization.registerParameter(_local_2, "days", _local_3.toString());
                this._controller.localization.registerParameter(_local_2, "months", _local_4.toString());
                _local_6.text = this._controller.localization.getKey(_local_2);
            };
        }
        private function updateList():void
        {
            var _local_1:Offer;
            var _local_2:Array;
            var _local_5:IWindow;
            var _local_6:CatalogPageMessageOfferData;
            var _local_7:Array;
            var _local_8:IProductData;
            var _local_9:CatalogPageMessageProductData;
            var _local_10:ClubGiftData;
            var _local_11:IFurnitureData;
            var _local_12:Product;
            if (((((!(this._controller)) || (!(window)))) || (!(page)))){
                return;
            };
            for each (_local_1 in this._offers) {
                _local_1.dispose();
            };
            this._offers.reset();
            _local_2 = this._controller.getOffers();
            if (!_local_2){
                return;
            };
            var _local_3:Map = this._controller.getGiftData();
            if (!_local_3){
                return;
            };
            var _local_4:IItemListWindow = (window.findChildByName("gift_list") as IItemListWindow);
            if (!_local_4){
                return;
            };
            _local_4.IItemListWindow();
            for each (_local_6 in _local_2) {
                _local_7 = new Array();
                _local_8 = this._controller.catalog.getProductData(_local_6.localizationId);
                for each (_local_9 in _local_6.products) {
                    _local_11 = this._controller.catalog.getFurnitureData(_local_9.furniClassId, _local_9.productType);
                    _local_12 = new Product(_local_9.productType, _local_9.furniClassId, _local_9.extraParam, _local_9.productCount, _local_9.expiration, _local_8, _local_11);
                    _local_7.push(_local_12);
                };
                _local_1 = new Offer(_local_6.offerId, _local_6.localizationId, _local_6.priceInCredits, _local_6.priceInActivityPoints, _local_6.activityPointType, _local_6.clubLevel, _local_7, page);
                _local_10 = (_local_3.getValue(_local_1.offerId) as ClubGiftData);
                _local_5 = this.createListItem(_local_1, _local_10);
                if (_local_5){
                    _local_4.addListItem(_local_5);
                    this._offers.add(_local_1.offerId, _local_1);
                };
            };
        }
        private function createListItem(_arg_1:Offer, _arg_2:ClubGiftData):IWindow
        {
            var _local_6:int;
            var _local_7:String;
            var _local_12:int;
            var _local_13:int;
            if (((((((!(_arg_1)) || (!(_arg_1.productContainer)))) || (!(_arg_1.productContainer.firstProduct)))) || (!(_arg_2)))){
                return (null);
            };
            var _local_3:IWindowContainer = (this.createWindow("club_gift_list_item") as IWindowContainer);
            if (!_local_3){
                return (null);
            };
            _local_3.procedure = this.clickHandler;
            var _local_4:IProduct = _arg_1.productContainer.firstProduct;
            if (!_local_4){
                return (null);
            };
            var _local_5:IProductData = _local_4.productData;
            if (!_local_5){
                return (null);
            };
            this.CurrencyIndicatorBase(_local_3.findChildByName("gift_name"), _local_5.name);
            this.CurrencyIndicatorBase(_local_3.findChildByName("gift_desc"), _local_5.description);
            if (_arg_2.isVip){
                _local_6 = (_arg_2.daysRequired - this._controller.purse.pastVipDays);
            }
            else {
                _local_6 = (_arg_2.daysRequired - (this._controller.purse.pastClubDays + this._controller.purse.pastVipDays));
            };
            if (((!(_arg_2.isSelectable)) && ((_local_6 > 0)))){
                if (_arg_2.isVip){
                    _local_7 = "catalog.club_gift.vip_missing";
                }
                else {
                    _local_7 = "catalog.club_gift.club_missing";
                };
                if (_local_6 >= this._SafeStr_10386){
                    _local_7 = (_local_7 + ".long");
                };
                _local_12 = (_local_6 % this._SafeStr_10386);
                _local_13 = (_local_6 / this._SafeStr_10386);
                this._controller.localization.registerParameter(_local_7, "days", _local_12.toString());
                this._controller.localization.registerParameter(_local_7, "months", _local_13.toString());
            }
            else {
                if (this._controller.giftsAvailable > 0){
                    _local_7 = "catalog.club_gift.selectable";
                }
                else {
                    _local_7 = "";
                };
            };
            this.CurrencyIndicatorBase(_local_3.findChildByName("months_required"), (((_local_7.length > 0)) ? this._controller.localization.getKey(_local_7) : ""));
            var _local_8:IIconWindow = (_local_3.findChildByName("vip_icon") as IIconWindow);
            if (_local_8){
                _local_8.visible = _arg_2.isVip;
            };
            var _local_9:IButtonWindow = (_local_3.findChildByName("select_button") as IButtonWindow);
            if (_local_9){
                if (((_arg_2.isSelectable) && ((this._controller.giftsAvailable > 0)))){
                    _local_9.enable();
                }
                else {
                    _local_9.disable();
                };
                _local_9.id = _arg_1.offerId;
            };
            var _local_10:IProductContainer = _arg_1.productContainer;
            if (!_local_10){
                return (null);
            };
            if (((((!(page)) || (!(page.viewer)))) || (!(page.viewer.roomEngine)))){
                return (null);
            };
            var _local_11:IWindowContainer = (_local_3.findChildByName("image_container") as IWindowContainer);
            if (_local_11){
                _local_10.view = _local_11;
                _local_10.initProductIcon(page.viewer.roomEngine);
                _local_11.procedure = this.mouseOverHandler;
                _local_11.id = _arg_1.offerId;
            };
            return (_local_3);
        }
        private function CurrencyIndicatorBase(_arg_1:IWindow, _arg_2:String):void
        {
            var _local_3:ITextWindow = (_arg_1 as ITextWindow);
            if (!_local_3){
                return;
            };
            _local_3.text = _arg_2;
        }
        private function clickHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((((!(_arg_1)) || (!(_arg_2)))) || (!(this._offers)))) || (!(this._controller)))){
                return;
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            if (_arg_2.name != "select_button"){
                return;
            };
            var _local_3:Offer = (this._offers.getValue(_arg_2.id) as Offer);
            if (!_local_3){
                return;
            };
            this._controller.selectGift(_local_3);
        }
        private function mouseOverHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Rectangle;
            if (((((!(_arg_1)) || (!(_arg_2)))) || (!(this._offers)))){
                return;
            };
            if (_arg_2.name != "image_container"){
                return;
            };
            var _local_3:Offer = (this._offers.getValue(_arg_2.id) as Offer);
            if (!_local_3){
                return;
            };
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                _local_4 = new Rectangle();
                _arg_2.WindowController(_local_4);
            };
            if (_arg_1.type == WindowMouseEvent.WME_OUT){
                this.hidePreview();
            };
        }
        private function showPreview(_arg_1:Offer, _arg_2:Rectangle):void
        {
            var _local_5:ImageResult;
            if (((!(_arg_1)) || (!(_arg_1.productContainer)))){
                return;
            };
            if (((((!(page)) || (!(page.viewer)))) || (!(page.viewer.roomEngine)))){
                return;
            };
            var _local_3:IProduct = _arg_1.productContainer.firstProduct;
            if (!_local_3){
                return;
            };
            if (!this._SafeStr_10387){
                this._SafeStr_10387 = (this.createWindow("club_gift_preview") as IWindowContainer);
            };
            if (!this._SafeStr_10387){
                return;
            };
            var _local_4:IBitmapWrapperWindow = (this._SafeStr_10387.findChildByName("image") as IBitmapWrapperWindow);
            if (!_local_4){
                return;
            };
            switch (_local_3.productType){
                case "s":
                    _local_5 = page.viewer.roomEngine.getFurnitureImage(_local_3.productClassId, new Vector3d(90), 64, null, 0, _local_3.extraParam);
                    break;
                case "i":
                    _local_5 = page.viewer.roomEngine.getWallItemImage(_local_3.productClassId, new Vector3d(90), 64, null, 0, _local_3.extraParam);
                    break;
                default:
                    return;
            };
            if (((!(_local_5)) || (!(_local_5.data)))){
                return;
            };
            _local_4.width = _local_5.data.width;
            _local_4.height = _local_5.data.height;
            if (_local_4.bitmap){
                _local_4.bitmap.dispose();
            };
            _local_4.bitmap = new BitmapData(_local_4.width, _local_4.height);
            _local_4.bitmap.draw(_local_5.data);
            _local_5.data.dispose();
            var _local_6:Point = Point.interpolate(_arg_2.topLeft, _arg_2.bottomRight, 0.5);
            this._SafeStr_10387.WindowController(_local_6.subtract(new Point((this._SafeStr_10387.width / 2), (this._SafeStr_10387.height / 2))));
            this._SafeStr_10387.visible = true;
            this._SafeStr_10387.activate();
        }
        private function hidePreview():void
        {
            if (this._SafeStr_10387){
                this._SafeStr_10387.visible = false;
            };
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((!(this._controller)) || (!(this._controller.assets)))) || (!(this._controller.windowManager)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._controller.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (!_local_3){
                return (null);
            };
            return (this._controller.windowManager.buildFromXML(_local_3));
        }

    }
}//package com.sulake.habbo.catalog.viewer.widgets

// _SafeStr_10386 = "_-3Ct" (String#21991, DoABC#2)
// _SafeStr_10387 = "_-3JF" (String#22252, DoABC#2)
// InfoStandUserView = "_-jx" (String#8602, DoABC#2)
// mouseOverHandler = "_-0OC" (String#14996, DoABC#2)
// hidePreview = "_-mZ" (String#24129, DoABC#2)
// showPreview = "_-18e" (String#16798, DoABC#2)
// CatalogPageMessageOfferData = "_-1vw" (String#5957, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// CatalogPageMessageProductData = "_-2mz" (String#7020, DoABC#2)
// ClubGiftController = "_-33f" (String#7378, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// CatalogWidget = "_-1pJ" (String#5844, DoABC#2)
// ICatalogWidget = "_-016" (String#3585, DoABC#2)
// IProductContainer = "_-7f" (String#7816, DoABC#2)
// ClubGiftData = "_-2Io" (String#6416, DoABC#2)
// ClubGiftWidget = "_-2um" (String#7176, DoABC#2)
// Product = "_-2z8" (String#7267, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// clickHandler = "_-34y" (String#630, DoABC#2)
// WindowController = "_-05T" (String#3675, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// localizationId = "_-0nF" (String#4575, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// getFurnitureData = "_-40" (String#7745, DoABC#2)
// productClassId = "_-02F" (String#3609, DoABC#2)
// productType = "_-Sd" (String#8259, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// initProductIcon = "_-0Ft" (String#1438, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// furniClassId = "_-1lo" (String#18367, DoABC#2)
// IItemListWindow = "_-0xF" (String#4796, DoABC#2)
// createListItem = "_-mV" (String#2185, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// daysUntilNextGift = "_-12R" (String#16556, DoABC#2)
// giftsAvailable = "_-GA" (String#22860, DoABC#2)
// selectGift = "_-2IU" (String#19745, DoABC#2)
// getOffers = "_-8a" (String#22564, DoABC#2)
// getGiftData = "_-Ui" (String#23436, DoABC#2)
// isVip = "_-082" (String#14368, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// daysRequired = "_-hE" (String#23939, DoABC#2)
// pastClubDays = "_-2W7" (String#6687, DoABC#2)
// pastVipDays = "_-373" (String#7449, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// WindowController = "_-0OJ" (String#4052, DoABC#2)


