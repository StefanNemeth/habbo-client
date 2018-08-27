
package com.sulake.habbo.catalog.marketplace
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;

    public class MarketplaceConfirmationDialog implements IGetImageListener 
    {

        private var _SafeStr_7900:MarketPlaceLogic;
        private var _catalog:IHabboCatalog;
        private var _roomEngine:IRoomEngine;
        private var _window:IFrameWindow;
        private var _offer:MarketPlaceOfferData;

        public function MarketplaceConfirmationDialog(_arg_1:MarketPlaceLogic, _arg_2:IHabboCatalog, _arg_3:IRoomEngine)
        {
            this._SafeStr_7900 = _arg_1;
            this._catalog = _arg_2;
            this._roomEngine = _arg_3;
        }
        public function dispose():void
        {
            this._SafeStr_7900 = null;
            this._catalog = null;
            this._roomEngine = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            this._offer = null;
        }
        public function showConfirmation(_arg_1:int, _arg_2:MarketPlaceOfferData):void
        {
            var _local_4:String;
            var _local_5:ILocalization;
            var _local_6:String;
            if (!_arg_2){
                return;
            };
            this._offer = _arg_2;
            if (((((!(this._SafeStr_7900)) || (!(this._catalog)))) || (!(this._catalog.localization)))){
                return;
            };
            if (this._window){
                this._window.dispose();
            };
            this._window = (this.createWindow("marketplace_purchase_confirmation") as IFrameWindow);
            this._window.procedure = this.eventHandler;
            this._window.center();
            var _local_3:ITextWindow = (this._window.findChildByName("header_text") as ITextWindow);
            if (_local_3){
                if (_arg_1 == this._SafeStr_7900._SafeStr_10256){
                    _local_3.text = ("$" + "{catalog.marketplace.confirm_header}");
                };
                if (_arg_1 == this._SafeStr_7900._SafeStr_10257){
                    _local_3.text = ("$" + "{catalog.marketplace.confirm_higher_header}");
                };
            };
            _local_3 = (this._window.findChildByName("item_name") as ITextWindow);
            if (_local_3){
                _local_3.text = ((("$" + "{") + this._SafeStr_7900.getNameLocalizationKey(_arg_2)) + "}");
            };
            _local_3 = (this._window.findChildByName("item_price") as ITextWindow);
            if (_local_3){
                _local_4 = this._catalog.localization.getKey("catalog.marketplace.confirm_price");
                _local_4 = _local_4.replace("%price%", this._offer.price);
                _local_3.text = _local_4;
            };
            _local_3 = (this._window.findChildByName("item_average_price") as ITextWindow);
            if (_local_3){
                _local_5 = this._catalog.localization.getLocalization("catalog.marketplace.offer_details.average_price");
                if (_local_5){
                    _local_4 = _local_5.raw;
                    _local_4 = _local_4.replace("%days%", this._SafeStr_7900.averagePricePeriod.toString());
                    _local_6 = (((this._offer.averagePrice == 0)) ? " - " : this._offer.averagePrice.toString());
                    _local_4 = _local_4.replace("%average%", _local_6);
                    _local_3.text = _local_4;
                }
                else {
                    _local_3.visible = false;
                };
            };
            _local_3 = (this._window.findChildByName("offer_count") as ITextWindow);
            if (_local_3){
                _local_5 = this._catalog.localization.getLocalization("catalog.marketplace.offer_details.offer_count");
                if (_local_5){
                    _local_4 = _local_5.raw;
                    _local_4 = _local_4.replace("%count%", this._offer.offerCount);
                    _local_3.text = _local_4;
                }
                else {
                    _local_3.visible = false;
                };
            };
            this.setImage();
        }
        private function setImage():void
        {
            var _local_1:ImageResult;
            var _local_2:IBitmapWrapperWindow;
            if (((((!(this._offer)) || (!(this._window)))) || (!(this._roomEngine)))){
                return;
            };
            if (!this._offer.image){
                if (this._offer.furniType == 1){
                    _local_1 = this._roomEngine.getFurnitureIcon(this._offer.furniId, this);
                }
                else {
                    if (this._offer.furniType == 2){
                        _local_1 = this._roomEngine.getWallItemIcon(this._offer.furniId, this);
                    };
                };
                if (((_local_1) && (_local_1.data))){
                    this._offer.image = (_local_1.data as BitmapData);
                    this._offer.imageCallback = _local_1.id;
                };
            };
            if (this._offer.image != null){
                _local_2 = (this._window.findChildByName("item_image") as IBitmapWrapperWindow);
                if (_local_2){
                    if (_local_2.bitmap){
                        _local_2.bitmap.dispose();
                        _local_2.bitmap = null;
                    };
                    _local_2.bitmap = new BitmapData(_local_2.width, _local_2.height, true, 0);
                    _local_2.bitmap.draw(this._offer.image, new Matrix(1, 0, 0, 1, ((_local_2.width - this._offer.image.width) / 2), ((_local_2.height - this._offer.image.height) / 2)));
                };
            };
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!(_arg_1)) || (!(_arg_2)))){
                return;
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "buy_button":
                    this._catalog.buyMarketPlaceOffer(this._offer.offerId);
                    this.hide();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.hide();
                    return;
            };
        }
        private function hide():void
        {
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (((this._offer) && ((this._offer.imageCallback == _arg_1)))){
                this._offer.image = _arg_2;
                this.setImage();
            };
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((!(this._catalog)) || (!(this._catalog.assets)))) || (!(this._catalog.windowManager)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (!_local_3){
                return (null);
            };
            return (this._catalog.windowManager.buildFromXML(_local_3));
        }

    }
}//package com.sulake.habbo.catalog.marketplace

// getNameLocalizationKey = "_-0SQ" (String#4147, DoABC#2)
// _SafeStr_10256 = "_-0Ht" (String#14752, DoABC#2)
// _SafeStr_10257 = "_-2hn" (String#20764, DoABC#2)
// imageCallback = "_-3-K" (String#7292, DoABC#2)
// buyMarketPlaceOffer = "_-2t" (String#7137, DoABC#2)
// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// MarketPlaceLogic = "_-8V" (String#7832, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// MarketPlaceOfferData = "_-2vY" (String#7188, DoABC#2)
// MarketplaceConfirmationDialog = "_-ln" (String#8638, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// setImage = "_-1NZ" (String#603, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// _SafeStr_7900 = "_-2lg" (String#6997, DoABC#2)
// furniType = "_-26P" (String#6173, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// offerCount = "_-3Bk" (String#7545, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// raw = "_-Xc" (String#8361, DoABC#2)


