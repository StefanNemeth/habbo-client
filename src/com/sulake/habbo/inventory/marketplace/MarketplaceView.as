
package com.sulake.habbo.inventory.marketplace
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class MarketplaceView implements IGetImageListener 
    {

        private var _windowManager:IHabboWindowManager;
        private var _assetLibrary:IAssetLibrary;
        private var _view:IFrameWindow;
        private var _SafeStr_4830:MarketplaceModel;
        private var _roomEngine:IRoomEngine;
        private var _localization:IHabboLocalizationManager;
        private var _config:IHabboConfigurationManager;
        private var _disposed:Boolean = false;
        private var _SafeStr_8588:int;
        private var _SafeStr_8589:int;
        private var _SafeStr_8590:String;

        public function MarketplaceView(_arg_1:MarketplaceModel, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IRoomEngine, _arg_5:IHabboLocalizationManager, _arg_6:IHabboConfigurationManager)
        {
            this._SafeStr_4830 = _arg_1;
            this._assetLibrary = _arg_3;
            this._windowManager = _arg_2;
            this._roomEngine = _arg_4;
            this._localization = _arg_5;
            this._config = _arg_6;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._SafeStr_4830 = null;
                this._assetLibrary = null;
                this._windowManager = null;
                this._roomEngine = null;
                this._localization = null;
                this._config = null;
                this.disposeView();
                this._disposed = true;
            };
        }
        private function disposeView():void
        {
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
        }
        public function MarketplaceView(_arg_1:int, _arg_2:int):void
        {
            if (this._localization){
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "price", _arg_1.toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "count", _arg_2.toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.info", "free", (_arg_2 - 1).toString());
                this._localization.registerParameter("inventory.marketplace.buy_tokens.buy", "price", _arg_1.toString());
            };
            this._view = (this.createWindow("buy_marketplace_tokens_xml") as IFrameWindow);
            if (this._view == null){
                return;
            };
            this._view.procedure = this.clickHandler;
            this._view.center();
        }
        public function MarketplaceView(_arg_1:IItem):void
        {
            var _local_4:ImageResult;
            var _local_5:String;
            var _local_6:String;
            if (((((((!(_arg_1)) || (!(this._localization)))) || (!(this._roomEngine)))) || (!(this._SafeStr_4830)))){
                return;
            };
            this._view = (this.createWindow("make_marketplace_offer_xml") as IFrameWindow);
            if (!this._view){
                return;
            };
            var _local_2:ITextFieldWindow = (this._view.findChildByName("price_input") as ITextFieldWindow);
            if (_local_2 != null){
                _local_2.restrict = "0-9";
            };
            this.MarketplaceView();
            this._localization.registerParameter("inventory.marketplace.make_offer.expiration_info", "time", this._SafeStr_4830.expirationHours.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.min_price", "minprice", this._SafeStr_4830.offerMinPrice.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.max_price", "maxprice", this._SafeStr_4830.offerMaxPrice.toString());
            var _local_3:uint = 4293848814;
            if ((_arg_1 is FloorItem)){
                _local_4 = this._roomEngine.getFurnitureImage(_arg_1.type, new Vector3d(180, 0, 0), 32, this, _local_3, String(_arg_1.extra));
            }
            else {
                _local_4 = this._roomEngine.getWallItemImage(_arg_1.type, new Vector3d(180, 0, 0), 32, this, _local_3, _arg_1.stuffData);
            };
            if (!_local_4){
                return;
            };
            this._SafeStr_8588 = _local_4.id;
            this.MarketplaceView(_local_4.data);
            if ((_arg_1 is FloorItem)){
                _local_5 = ("roomItem.name." + _arg_1.type);
                _local_6 = ("roomItem.desc." + _arg_1.type);
            }
            else {
                _local_5 = ("wallItem.name." + _arg_1.type);
                _local_6 = ("wallItem.desc." + _arg_1.type);
            };
            if (_arg_1.category == FurniCategory._SafeStr_7055){
                _local_5 = (("poster_" + _arg_1.stuffData) + "_name");
                _local_6 = (("poster_" + _arg_1.stuffData) + "_desc");
            };
            this._SafeStr_8590 = this._localization.getKey(_local_5);
            this.CurrencyIndicatorBase("furni_name", ((("$" + "{") + _local_5) + "}"));
            this.CurrencyIndicatorBase("furni_desc", ((("$" + "{") + _local_6) + "}"));
            this._view.procedure = this.clickHandler;
            this._view.center();
            var _local_7:ITextWindow = (this._view.findChildByName("average_price") as ITextWindow);
            if (_local_7){
                _local_7.visible = false;
            };
            this._SafeStr_4830.MarketplaceModel();
        }
        private function MarketplaceView(_arg_1:BitmapData):void
        {
            if ((((_arg_1 == null)) || ((this._view == null)))){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._view.findChildByName("furni_image") as IBitmapWrapperWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:BitmapData = new BitmapData(_local_2.width, _local_2.height, true, 0);
            var _local_4:int = ((_local_3.width - _arg_1.width) * 0.5);
            var _local_5:int = ((_local_3.height - _arg_1.height) * 0.5);
            _local_3.draw(_arg_1, new Matrix(1, 0, 0, 1, _local_4, _local_5));
            _local_2.bitmap = _local_3;
        }
        private function CurrencyIndicatorBase(_arg_1:String, _arg_2:String):void
        {
            if (this._view == null){
                return;
            };
            var _local_3:ITextWindow = (this._view.findChildByName(_arg_1) as ITextWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.text = _arg_2;
        }
        public function MarketplaceView(_arg_1:int):void
        {
            if (this._localization){
                this._localization.registerParameter("inventory.marketplace.no_credits.info", "price", _arg_1.toString());
            };
            this._view = (this.createWindow("marketplace_no_credits_xml") as IFrameWindow);
            if (this._view == null){
                return;
            };
            this._view.procedure = this.clickHandler;
            this._view.center();
        }
        private function showConfirmation():void
        {
            this._localization.registerParameter("inventory.marketplace.confirm_offer.info", "furniname", this._SafeStr_8590);
            this._localization.registerParameter("inventory.marketplace.confirm_offer.info", "price", this._SafeStr_8589.toString());
            var _local_1:String = ("$" + "{inventory.marketplace.confirm_offer.title}");
            var _local_2:String = ("$" + "{inventory.marketplace.confirm_offer.info}");
            this._windowManager.confirm(_local_1, _local_2, 0, this.MarketplaceView);
        }
        private function MarketplaceView(_arg_1:IConfirmDialog, _arg_2:WindowEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            _arg_1.dispose();
            if (this._SafeStr_4830 == null){
                return;
            };
            if (_arg_2.type == WindowEvent.WE_OK){
                this._SafeStr_4830.MarketplaceModel(this._SafeStr_8589);
            };
            this._SafeStr_4830.MarketplaceModel();
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if ((((this._assetLibrary == null)) || ((this._windowManager == null)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._assetLibrary.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null){
                return (null);
            };
            return (this._windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function clickHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:ITextFieldWindow;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "buy_tokens_button":
                        this._SafeStr_4830.MarketplaceModel();
                        this.disposeView();
                        break;
                    case "cancel_buy_tokens_button":
                    case "cancel_make_offer_button":
                    case "cancel_no_credits_button":
                    case "header_button_close":
                        this._SafeStr_4830.MarketplaceModel();
                        this.disposeView();
                        break;
                    case "make_offer_button":
                        _local_3 = (this._view.findChildByName("price_input") as ITextFieldWindow);
                        if (_local_3 != null){
                            this._SafeStr_8589 = parseInt(_local_3.text);
                            this.showConfirmation();
                        };
                        this.disposeView();
                        break;
                    case "get_credits_button":
                        this._SafeStr_4830.MarketplaceModel();
                        this.CatalogNavigator();
                        this.disposeView();
                        break;
                };
            };
            if (_arg_1.type == WindowEvent.WE_CHANGE){
                if (_arg_2.name == "price_input"){
                    this.MarketplaceView();
                };
            };
        }
        private function CatalogNavigator():void
        {
            var _local_1:String;
            if (((ExternalInterface.available) && (("true" == this._config.getKey("client.credits.embed.enabled"))))){
                ExternalInterface.call("FlashExternalInterface.openHabblet", "credits");
            }
            else {
                _local_1 = this._config.getKey("link.format.credits");
                if (_local_1 != ""){
                    this._windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.MarketplaceView);
                    HabboWebTools.navigateToURL(_local_1, "habboMain");
                };
            };
        }
        private function MarketplaceView():void
        {
            if (this._view == null){
                return;
            };
            var _local_1:ITextFieldWindow = (this._view.findChildByName("price_input") as ITextFieldWindow);
            if (_local_1 == null){
                return;
            };
            var _local_2:int = parseInt(_local_1.text);
            if (_local_2 > this._SafeStr_4830.offerMaxPrice){
                _local_1.text = this._SafeStr_4830.offerMaxPrice.toString();
                _local_2 = this._SafeStr_4830.offerMaxPrice;
            };
            var _local_3:int = Math.max(Math.ceil(((this._SafeStr_4830.commission * 0.01) * _local_2)), 1);
            var _local_4:int = (_local_2 + _local_3);
            var _local_5:IButtonWindow = (this._view.findChildByName("make_offer_button") as IButtonWindow);
            var _local_6:ITextWindow = (this._view.findChildByName("final_price") as ITextWindow);
            if ((((_local_5 == null)) || ((_local_6 == null)))){
                return;
            };
            this._localization.registerParameter("inventory.marketplace.make_offer.final_price", "commission", _local_3.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.final_price", "finalprice", _local_4.toString());
            if (_local_2 < this._SafeStr_4830.offerMinPrice){
                _local_6.text = ("$" + "{inventory.marketplace.make_offer.min_price}");
                _local_5.disable();
            }
            else {
                _local_6.text = ("$" + "{inventory.marketplace.make_offer.final_price}");
                _local_5.enable();
            };
        }
        public function MarketplaceView(_arg_1:int):void
        {
            var _local_2:String;
            if (_arg_1 == 1){
                _local_2 = ("$" + "{inventory.marketplace.result.title.success}");
            }
            else {
                _local_2 = ("$" + "{inventory.marketplace.result.title.failure}");
            };
            var _local_3 = ((("$" + "{inventory.marketplace.result.") + _arg_1) + "}");
            this._windowManager.alert(_local_2, _local_3, 0, this.MarketplaceView);
        }
        private function MarketplaceView(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._SafeStr_4830.MarketplaceModel();
            _arg_1.dispose();
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            if (this._SafeStr_8588 == _arg_1){
                this.MarketplaceView(_arg_2);
            };
        }
        public function MarketplaceView(_arg_1:String, _arg_2:String):void
        {
            this._windowManager.alert(_arg_1, _arg_2, 0, this.MarketplaceView);
        }
        public function MarketplaceView(_arg_1:int, _arg_2:int):void
        {
            if (((((!(this._view)) || (!(this._localization)))) || (!(this._SafeStr_4830)))){
                return;
            };
            var _local_3:ITextWindow = (this._view.findChildByName("average_price") as ITextWindow);
            if (!_local_3){
                return;
            };
            var _local_4:int = Math.floor((_arg_1 / (1 + (this._SafeStr_4830.commission * 0.01))));
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "days", _arg_2.toString());
            var _local_5:String = (((_arg_1 == 0)) ? " - " : _arg_1.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "price", _local_5);
            var _local_6:String = (((_local_4 == 0)) ? " - " : _local_4.toString());
            this._localization.registerParameter("inventory.marketplace.make_offer.average_price", "price_no_commission", _local_6);
            _local_3.visible = true;
        }

    }
}//package com.sulake.habbo.inventory.marketplace

// ImageResult = "_-31w" (String#21576, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// MarketplaceView = "_-Z7" (String#8395, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// clickHandler = "_-34y" (String#630, DoABC#2)
// _SafeStr_4830 = "_-0XB" (String#112, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
// disposeView = "_-jU" (String#2169, DoABC#2)
// offerMinPrice = "_-026" (String#14129, DoABC#2)
// offerMaxPrice = "_-2pR" (String#21056, DoABC#2)
// expirationHours = "_-0xj" (String#16342, DoABC#2)
// MarketplaceModel = "_-0DN" (String#14585, DoABC#2)
// MarketplaceModel = "_-3Fc" (String#22102, DoABC#2)
// MarketplaceModel = "_-1Ap" (String#16895, DoABC#2)
// MarketplaceModel = "_-sH" (String#24372, DoABC#2)
// MarketplaceView = "_-0GY" (String#14701, DoABC#2)
// MarketplaceView = "_-0F1" (String#14646, DoABC#2)
// MarketplaceView = "_-eW" (String#23823, DoABC#2)
// MarketplaceView = "_-3Fu" (String#22112, DoABC#2)
// MarketplaceView = "_-0TT" (String#15190, DoABC#2)
// _SafeStr_8588 = "_-37H" (String#21779, DoABC#2)
// _SafeStr_8589 = "_-23N" (String#19147, DoABC#2)
// _SafeStr_8590 = "_-2l4" (String#20884, DoABC#2)
// MarketplaceView = "_-393" (String#21848, DoABC#2)
// MarketplaceView = "_-1yH" (String#18899, DoABC#2)
// MarketplaceView = "_-0IC" (String#14765, DoABC#2)
// MarketplaceView = "_-oU" (String#24213, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// CatalogNavigator = "_-1Sy" (String#5413, DoABC#2)
// MarketplaceView = "_-p0" (String#24236, DoABC#2)


