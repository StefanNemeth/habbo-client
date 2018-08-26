
package com.sulake.habbo.ui.widget.loadingbar
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.MouseEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetInterstitialUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.display.Bitmap;
    import com.sulake.core.window.components.IDisplayObjectWrapper;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.Event;

    public class LoadingBarWidget extends RoomWidgetBase 
    {

        private var _window:IBorderWindow;
        private var _config:IHabboConfigurationManager;
        private var _image:BitmapData;
        private var _clickUrl:String = "";
        private var _SafeStr_4499:Sprite = null;

        public function LoadingBarWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_5;
        }
        override public function dispose():void
        {
            if (this._SafeStr_4499 != null){
                this._SafeStr_4499.removeEventListener(MouseEvent.CLICK, this.clickHandler);
                this._SafeStr_4499 = null;
            };
            if (this._image != null){
                this._image.dispose();
                this._image = null;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._config = null;
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetInterstitialUpdateEvent.RWIUE_SHOW, this.onShowInterstitial);
            _arg_1.addEventListener(RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW, this.onShowLoadingBar);
            _arg_1.addEventListener(RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR, this.onHideLoadingBar);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetInterstitialUpdateEvent.RWIUE_SHOW, this.onShowInterstitial);
            _arg_1.removeEventListener(RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW, this.onShowLoadingBar);
            _arg_1.removeEventListener(RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR, this.onHideLoadingBar);
        }
        private function onShowInterstitial(_arg_1:RoomWidgetInterstitialUpdateEvent):void
        {
            var _local_5:Bitmap;
            if (_arg_1 == null){
                return;
            };
            if (!this.createWindow()){
                return;
            };
            if (this._image != null){
                this._image.dispose();
            };
            this._image = _arg_1.image;
            this._clickUrl = _arg_1.clickUrl;
            var _local_2:IDisplayObjectWrapper = (this._window.findChildByName("image") as IDisplayObjectWrapper);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = Math.max(0, (this._image.width - _local_2.width));
            var _local_4:int = Math.max(0, (this._image.height - _local_2.height));
            this._window.scale(_local_3, _local_4);
            if (this._SafeStr_4499 == null){
                this._SafeStr_4499 = new Sprite();
                this._SafeStr_4499.addChild(new Bitmap(this._image));
                this._SafeStr_4499.addEventListener(MouseEvent.CLICK, this.clickHandler);
            }
            else {
                _local_5 = (this._SafeStr_4499.getChildAt(0) as Bitmap);
                if (_local_5 != null){
                    _local_5.bitmapData = this._image;
                };
            };
            _local_2.setDisplayObject(this._SafeStr_4499);
            this._window.visible = true;
            this._window.center();
        }
        private function onShowLoadingBar(_arg_1:RoomWidgetLoadingBarUpdateEvent):void
        {
            if ((((_arg_1 == null)) || (!((_arg_1.type == RoomWidgetLoadingBarUpdateEvent.RWIUE_SHOW))))){
                return;
            };
            if (!this.createWindow()){
                return;
            };
            this._window.visible = true;
            this._window.center();
        }
        private function onHideLoadingBar(_arg_1:RoomWidgetLoadingBarUpdateEvent):void
        {
            if ((((_arg_1 == null)) || (!((_arg_1.type == RoomWidgetLoadingBarUpdateEvent.RWLBUW_HIDE_LOADING_BAR))))){
                return;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function createWindow():Boolean
        {
            var _local_4:int;
            if (this._window != null){
                return (true);
            };
            var _local_1:XmlAsset = (assets.getAssetByName("room_loading_bar") as XmlAsset);
            if (_local_1 == null){
                return (false);
            };
            this._window = (windowManager.buildFromXML((_local_1.content as XML)) as IBorderWindow);
            if (this._window == null){
                return (false);
            };
            this._window.visible = false;
            var _local_2:IRegionWindow = (this._window.findChildByName("region") as IRegionWindow);
            if (_local_2 != null){
            };
            var _local_3:IDisplayObjectWrapper = (this._window.findChildByName("image") as IDisplayObjectWrapper);
            if (_local_3 != null){
                _local_4 = _local_3.height;
                this._window.scale(0, -(_local_4));
            };
            return (true);
        }
        private function showInterface():void
        {
            if (!this.createWindow()){
                return;
            };
            this._window.visible = true;
            this._window.center();
        }
        private function clickHandler(_arg_1:Event):void
        {
            if (this._clickUrl != ""){
                HabboWebTools.HTMLTextController(this._clickUrl);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.loadingbar

// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IDisplayObjectWrapper = "_-FC" (String#2078, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// LoadingBarWidget = "_-21L" (String#6072, DoABC#2)
// RoomWidgetLoadingBarUpdateEvent = "_-0ux" (String#4743, DoABC#2)
// RoomWidgetInterstitialUpdateEvent = "_-198" (String#5059, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// _image = "_-35u" (String#78, DoABC#2)
// _clickUrl = "_-2-C" (String#303, DoABC#2)
// _SafeStr_4499 = "_-2dR" (String#20581, DoABC#2)
// clickHandler = "_-34y" (String#630, DoABC#2)
// RWIUE_SHOW = "_-32i" (String#21606, DoABC#2)
// onShowInterstitial = "_-Qi" (String#23274, DoABC#2)
// onShowLoadingBar = "_-cg" (String#23740, DoABC#2)
// RWLBUW_HIDE_LOADING_BAR = "_-0-1" (String#14011, DoABC#2)
// onHideLoadingBar = "_-0SE" (String#15143, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)


