
package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import __AS3__.vec.Vector;
    import flash.display.BitmapData;
    import flash.utils.Timer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import __AS3__.vec.*;

    public class ClubExtendConfirmationDialog 
    {

        private static const _SafeStr_5468:int = 7;
        private static const _SafeStr_5469:String = "your_price_icon";
        private static const _SafeStr_5470:String = "http://images.habbo.com/c_images/catalogue/vip_extend_tsr.png";
        private static const _SafeStr_5471:String = "image/png";
        private static const _SafeStr_5472:int = 2000;
        private static const _SafeStr_5473:int = 75;
        private static const _SafeStr_5474:uint = 0;
        private static const LINK_COLOR_HOVER:uint = 9552639;

        private var _controller:ClubExtendController;
        private var _view:IFrameWindow;
        private var _offer:ClubOfferExtendData;
        private var _SafeStr_5475:IRegionWindow;
        private var _SafeStr_5476:ITextWindow;
        private var _SafeStr_5477:IBitmapWrapperWindow;
        private var _SafeStr_5478:Vector.<BitmapData>;
        private var _SafeStr_5479:Timer;
        private var _SafeStr_5480:Timer;
        private var _animationFrame:int = 0;
        private var _SafeStr_5482:int = 0;
        private var _disposed:Boolean = false;
        private var _localizationKey:String = "catalog.club.extend.";

        public function ClubExtendConfirmationDialog(_arg_1:ClubExtendController, _arg_2:ClubOfferExtendData)
        {
            this._controller = _arg_1;
            this._offer = _arg_2;
            this._SafeStr_5478 = new Vector.<BitmapData>(_SafeStr_5468);
        }
        public function dispose():void
        {
            var _local_1:int;
            if (this._disposed){
                return;
            };
            this._offer = null;
            this._controller = null;
            this.clearAnimation();
            if (this._SafeStr_5475){
                this._SafeStr_5475.removeEventListener(WindowMouseEvent.WME_OUT, this.onMouseOutLaterRegion);
                this._SafeStr_5475.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOverLaterRegion);
                this._SafeStr_5475 = null;
            };
            if (this._SafeStr_5476){
                this._SafeStr_5476 = null;
            };
            if (this._SafeStr_5477){
                this._SafeStr_5477 = null;
            };
            if (this._SafeStr_5478){
                while (_local_1 < _SafeStr_5468) {
                    this._SafeStr_5478[_local_1].dispose();
                    this._SafeStr_5478[_local_1] = null;
                    _local_1++;
                };
                this._SafeStr_5478 = null;
            };
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
            this._disposed = true;
        }
        public function showConfirmation():void
        {
            var _local_2:String;
            var _local_9:IIconWindow;
            var _local_10:BitmapDataAsset;
            var _local_11:BitmapData;
            if (((((!(this._offer)) || (!(this._controller)))) || (this._disposed))){
                return;
            };
            this._view = (this.createWindow("club_extend_confirmation") as IFrameWindow);
            if (!this._view){
                return;
            };
            this._view.procedure = this.windowEventHandler;
            this._view.center();
            if (!this._offer.vip){
                this._localizationKey = (this._localizationKey + "basic.");
                _local_9 = (this._view.findChildByName("club_level_icon") as IIconWindow);
                if (_local_9){
                    _local_9.style = HabboIconType._SafeStr_5487;
                    _local_9.x = (_local_9.x + 15);
                };
            };
            var _local_1:ICoreLocalizationManager = this._controller.localization;
            this._view.findChildByName("normal_price_price").caption = this._offer.originalPrice.toString();
            this._view.findChildByName("you_save_price").caption = this._offer.discountAmount.toString();
            this._view.findChildByName("your_price_price").caption = this._offer.price.toString();
            this._view.title.caption = _local_1.getKey((this._localizationKey + "confirm.caption"));
            this._view.findChildByName("extend_title").caption = _local_1.getKey((this._localizationKey + "confirm.title"));
            this._view.findChildByName("normal_price_label").caption = _local_1.getKey((this._localizationKey + "normal.label"));
            this._view.findChildByName("you_save_label").caption = _local_1.getKey((this._localizationKey + "save.label"));
            this._view.findChildByName("your_price_label").caption = _local_1.getKey((this._localizationKey + "price.label"));
            this._view.findChildByName("buy_now_button").caption = _local_1.getKey((this._localizationKey + "buy.button"));
            this._view.findChildByName("maybe_later_link").caption = _local_1.getKey((this._localizationKey + "later.link"));
            if (this._offer.subscriptionDaysLeft > 1){
                _local_1.registerParameter((this._localizationKey + "expiration_days_left"), "day", this._offer.subscriptionDaysLeft.toString());
                _local_2 = _local_1.getKey((this._localizationKey + "expiration_days_left"));
            }
            else {
                _local_2 = _local_1.getKey((this._localizationKey + "expires_today"));
            };
            this._view.findChildByName("offer_expiration").caption = _local_2;
            this._SafeStr_5475 = (this._view.findChildByName("maybe_later_region") as IRegionWindow);
            this._SafeStr_5476 = (this._view.findChildByName("maybe_later_link") as ITextWindow);
            if (((!(this._SafeStr_5475)) || (!(this._SafeStr_5476)))){
                return;
            };
            this._SafeStr_5475.addEventListener(WindowMouseEvent.WME_OUT, this.onMouseOutLaterRegion);
            this._SafeStr_5475.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseOverLaterRegion);
            var _local_3:BitmapData = this.getBitmapDataFromAsset("icon_credit_0");
            this.setElementBitmapData("normal_price_icon", _local_3);
            this.setElementBitmapData("you_save_icon", _local_3);
            var _local_4:IBitmapWrapperWindow = (this._view.findChildByName("club_teaser") as IBitmapWrapperWindow);
            _local_4.x = 1;
            _local_4.y = (this._view.height - 144);
            _local_4.height = 144;
            _local_4.width = 133;
            this.loadAssetFromUrl("club_teaser", "club_teaser", _SafeStr_5470, _SafeStr_5471, this.onTeaserLoaded);
            var _local_5:IItemListWindow = (this._view.findChildByName("itemlist_vertical") as IItemListWindow);
            if (!_local_5){
                return;
            };
            var _local_6:IWindowContainer = (this._view.findChildByName("total_amount_line") as IWindowContainer);
            if (!_local_6){
                return;
            };
            var _local_7:IWindowContainer = (this._view.findChildByName("background_container") as IWindowContainer);
            if (!_local_7){
                return;
            };
            _local_7.height = ((_local_5.y + _local_6.height) + _local_6.y);
            this._SafeStr_5477 = (this._view.findChildByName(_SafeStr_5469) as IBitmapWrapperWindow);
            if (this._SafeStr_5477 == null){
                return;
            };
            var _local_8:int;
            while (_local_8 < _SafeStr_5468) {
                _local_10 = (this._controller.assets.getAssetByName(("icon_credit_" + _local_8)) as BitmapDataAsset);
                _local_11 = (_local_10.content as BitmapData);
                this._SafeStr_5478[_local_8] = _local_11.clone();
                _local_8++;
            };
            this.startAnimation();
        }
        private function onMouseOutLaterRegion(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_5476){
                this._SafeStr_5476.textColor = _SafeStr_5474;
            };
        }
        private function onMouseOverLaterRegion(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_5476){
                this._SafeStr_5476.textColor = LINK_COLOR_HOVER;
            };
        }
        private function startAnimation():void
        {
            if (this._SafeStr_5479){
                this.clearAnimation();
            };
            this.setAnimationFrame();
            this._SafeStr_5479 = new Timer(_SafeStr_5472);
            this._SafeStr_5479.addEventListener(TimerEvent.TIMER, this.onAnimationTrigger);
            this._SafeStr_5479.start();
        }
        private function clearAnimation():void
        {
            this._animationFrame = 0;
            this._SafeStr_5482 = 0;
            if (this._SafeStr_5480){
                this._SafeStr_5480.stop();
                this._SafeStr_5480 = null;
            };
            if (this._SafeStr_5479){
                this._SafeStr_5479.stop();
                this._SafeStr_5479 = null;
            };
        }
        private function setAnimationFrame():void
        {
            if (!this._SafeStr_5477){
                return;
            };
            if (this._SafeStr_5477.bitmap){
                this._SafeStr_5477.bitmap.dispose();
            };
            if (this._animationFrame < _SafeStr_5468){
                this._SafeStr_5477.bitmap = new BitmapData(this._SafeStr_5477.width, this._SafeStr_5477.height, true, 0);
                this._SafeStr_5477.bitmap.copyPixels(this._SafeStr_5478[this._animationFrame], this._SafeStr_5478[this._animationFrame].rect, new Point(0, 0));
            }
            else {
                Logger.log(("Animation frame " + this._animationFrame));
            };
        }
        private function startAnimationFrame():void
        {
            this._SafeStr_5480 = new Timer(_SafeStr_5473, (_SafeStr_5468 - 1));
            this._SafeStr_5480.addEventListener(TimerEvent.TIMER, this.onAnimationFrame);
            this._SafeStr_5480.addEventListener(TimerEvent.TIMER_COMPLETE, this.onAnimationFrameComplete);
            this._SafeStr_5480.start();
        }
        private function onAnimationTrigger(_arg_1:TimerEvent):void
        {
            this.startAnimationFrame();
        }
        private function onAnimationFrame(_arg_1:TimerEvent):void
        {
            this._animationFrame = (this._animationFrame + 1);
            this.setAnimationFrame();
        }
        private function onAnimationFrameComplete(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_5480){
                this._SafeStr_5480.stop();
                this._SafeStr_5480 = null;
            };
            this._animationFrame = 0;
            this.setAnimationFrame();
            if (this._SafeStr_5482 == 0){
                this._SafeStr_5482 = 1;
                this.startAnimationFrame();
            }
            else {
                this._SafeStr_5482 = 0;
            };
        }
        private function getBitmapDataFromAsset(_arg_1:String):BitmapData
        {
            var _local_2:BitmapDataAsset = (this._controller.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 != null){
                return ((_local_2.content as BitmapData));
            };
            return (null);
        }
        private function setElementBitmapData(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (this._view.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3.bitmap != null){
                _local_3.bitmap.dispose();
            };
            if (((!((_arg_2 == null))) && (!((_local_3 == null))))){
                if (_local_3.width != _arg_2.width){
                    _local_3.width = _arg_2.width;
                };
                if (_local_3.height != _arg_2.height){
                    _local_3.height = _arg_2.height;
                };
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height, true, 0);
                _local_3.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(0, 0));
            };
        }
        private function loadAssetFromUrl(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Function):Boolean
        {
            var _local_6:BitmapData = this.getBitmapDataFromAsset(_arg_2);
            if (_local_6 != null){
                this.setElementBitmapData(_arg_1, _local_6);
                return (true);
            };
            var _local_7:URLRequest = new URLRequest(_arg_3);
            var _local_8:AssetLoaderStruct = this._controller.assets.loadAssetFromFile(_arg_2, _local_7, _arg_4);
            if (!_local_8){
                return (false);
            };
            _local_8.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, _arg_5);
            return (true);
        }
        private function onTeaserLoaded(_arg_1:AssetLoaderEvent):void
        {
            var _local_3:BitmapData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                _local_3 = this.getBitmapDataFromAsset(_local_2.assetName);
                this.setElementBitmapData("club_teaser", _local_3);
            };
        }
        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((((((!(_arg_1)) || (!(_arg_2)))) || (!(this._controller)))) || (!(this._offer)))) || (this._disposed))){
                return;
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "buy_now_button":
                    this._controller.confirmSelection();
                    return;
                case "header_button_close":
                case "maybe_later_region":
                    this._controller.closeConfirmation();
                    return;
            };
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((((!(this._controller)) || (!(this._controller.assets)))) || (!(this._controller.windowManager)))) || (this._disposed))){
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
}//package com.sulake.habbo.catalog.club

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// ClubExtendController = "_-2UZ" (String#6657, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// ClubExtendConfirmationDialog = "_-0oV" (String#4603, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// windowEventHandler = "_-36j" (String#371, DoABC#2)
// _SafeStr_5468 = "_-1lM" (String#18346, DoABC#2)
// _SafeStr_5469 = "_-2RG" (String#20091, DoABC#2)
// _SafeStr_5470 = "_-iK" (String#23973, DoABC#2)
// _SafeStr_5471 = "_-1yE" (String#18896, DoABC#2)
// _SafeStr_5472 = "_-32q" (String#21612, DoABC#2)
// _SafeStr_5473 = "_-2LB" (String#19855, DoABC#2)
// _SafeStr_5474 = "_-1Jd" (String#17264, DoABC#2)
// _SafeStr_5475 = "_-23C" (String#19142, DoABC#2)
// _SafeStr_5476 = "_-39F" (String#21855, DoABC#2)
// _SafeStr_5477 = "_-2DF" (String#19535, DoABC#2)
// _SafeStr_5478 = "_-2D7" (String#19529, DoABC#2)
// _SafeStr_5479 = "_-1Zl" (String#17881, DoABC#2)
// _SafeStr_5480 = "_-0Ok" (String#15017, DoABC#2)
// _animationFrame = "_-1J0" (String#5222, DoABC#2)
// _SafeStr_5482 = "_-18M" (String#16790, DoABC#2)
// _localizationKey = "_-09T" (String#1412, DoABC#2)
// clearAnimation = "_-16P" (String#5001, DoABC#2)
// onMouseOutLaterRegion = "_-0Kf" (String#14866, DoABC#2)
// onMouseOverLaterRegion = "_-3B5" (String#21927, DoABC#2)
// _SafeStr_5487 = "_-2OW" (String#19986, DoABC#2)
// originalPrice = "_-39g" (String#21870, DoABC#2)
// discountAmount = "_-0sy" (String#16160, DoABC#2)
// subscriptionDaysLeft = "_-2yY" (String#21412, DoABC#2)
// getBitmapDataFromAsset = "_-1uG" (String#18727, DoABC#2)
// setElementBitmapData = "_-2Vq" (String#20274, DoABC#2)
// loadAssetFromUrl = "_-2gs" (String#20725, DoABC#2)
// onTeaserLoaded = "_-2d4" (String#20565, DoABC#2)
// startAnimation = "_-1fN" (String#18112, DoABC#2)
// setAnimationFrame = "_-1ky" (String#18331, DoABC#2)
// onAnimationTrigger = "_-9O" (String#22595, DoABC#2)
// startAnimationFrame = "_-156" (String#16657, DoABC#2)
// onAnimationFrame = "_-1Sf" (String#17608, DoABC#2)
// onAnimationFrameComplete = "_-33n" (String#21651, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


