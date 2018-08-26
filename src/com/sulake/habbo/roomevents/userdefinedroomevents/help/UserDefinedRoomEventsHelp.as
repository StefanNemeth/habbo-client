
package com.sulake.habbo.roomevents.userdefinedroomevents.help
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;

    public class UserDefinedRoomEventsHelp 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _SafeStr_8301:IWindowContainer;
        private var _window:IFrameWindow;
        private var _view:IWindowContainer;
        private var _SafeStr_8302:int = 0;
        private var _localizations:Array;
        private var _SafeStr_8303:IContainerButtonWindow;
        private var _SafeStr_8304:IContainerButtonWindow;

        public function UserDefinedRoomEventsHelp(_arg_1:HabboUserDefinedRoomEvents)
        {
            this._SafeStr_5221 = _arg_1;
        }
        public function dispose():void
        {
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this.initLocalizations();
            this._window = IFrameWindow(this._SafeStr_5221.getXmlWindow("ude_help"));
            this._SafeStr_8301 = IWindowContainer(this.find(this._window, "help_container"));
            this._SafeStr_8304 = (this._SafeStr_8301.findChildByName("button_previous") as IContainerButtonWindow);
            if (this._SafeStr_8304){
                this._SafeStr_8304.procedure = this.onButtonClick;
            };
            this._SafeStr_8303 = (this._SafeStr_8301.findChildByName("button_next") as IContainerButtonWindow);
            if (this._SafeStr_8303){
                this._SafeStr_8303.procedure = this.onButtonClick;
            };
            var _local_1:IWindow = this._window.findChildByTag("close");
            _local_1.procedure = this.onWindowClose;
            this._window.center();
        }
        public function open(_arg_1:int=-1, _arg_2:int=-1):void
        {
            this.prepareWindow();
            this.ICatalogNavigator();
            this._window.visible = true;
            if (_arg_1 >= 0){
                this._window.x = _arg_1;
            };
            if (_arg_2 >= 0){
                this._window.y = _arg_2;
            };
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                this.close();
            };
        }
        public function close():void
        {
            if (this._window){
                this._window.visible = false;
            };
        }
        private function find(_arg_1:IWindowContainer, _arg_2:String):IWindow
        {
            var _local_3:IWindow = _arg_1.findChildByName(_arg_2);
            if (_local_3 == null){
                throw (new Error((("Window element with name: " + _arg_2) + " cannot be found!")));
            };
            return (_local_3);
        }
        public function toggle():void
        {
            this._window.visible = !(this._window.visible);
        }
        private function ICatalogNavigator():void
        {
            this.localize();
            this.checkButtons();
        }
        private function checkButtons():void
        {
            if (this._SafeStr_8302 >= (this._localizations.length - 1)){
                this._SafeStr_8303.disable();
            }
            else {
                this._SafeStr_8303.enable();
            };
            if (this._SafeStr_8302 <= 0){
                this._SafeStr_8304.disable();
            }
            else {
                this._SafeStr_8304.enable();
            };
        }
        private function nextPage():void
        {
            this._SafeStr_8302++;
            this._SafeStr_8302 = Math.min(this._SafeStr_8302, (this._localizations.length - 1));
            this.ICatalogNavigator();
        }
        private function previousPage():void
        {
            this._SafeStr_8302--;
            this._SafeStr_8302 = Math.max(this._SafeStr_8302, 0);
            this.ICatalogNavigator();
        }
        private function initLocalizations():void
        {
            var _local_2:ILocalization;
            var _local_3:ILocalization;
            var _local_4:ILocalization;
            this._localizations = [];
            var _local_1:int = 1;
            while (this._SafeStr_5221.localization.getLocalization((("wiredfurni.help." + _local_1) + ".title"))) {
                _local_2 = this._SafeStr_5221.localization.getLocalization((("wiredfurni.help." + _local_1) + ".title"));
                _local_3 = this._SafeStr_5221.localization.getLocalization((("wiredfurni.help." + _local_1) + ".img"));
                _local_4 = this._SafeStr_5221.localization.getLocalization((("wiredfurni.help." + _local_1) + ".text"));
                this._localizations.push([_local_2, _local_3, _local_4]);
                _local_1++;
            };
        }
        private function onButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                switch (_arg_2.name){
                    case "button_previous":
                        this.previousPage();
                        return;
                    case "button_next":
                        this.nextPage();
                        return;
                };
            };
        }
        private function localize():void
        {
            var _local_4:String;
            var _local_1:ITextWindow = (this.find(this._window, "help_title") as ITextWindow);
            var _local_2:ITextWindow = (this.find(this._window, "help_text") as ITextWindow);
            var _local_3:IBitmapWrapperWindow = (this.find(this._window, "help_image") as IBitmapWrapperWindow);
            if (((!(this._localizations)) || ((this._localizations.length == 0)))){
                return;
            };
            if (_local_1){
                _local_1.text = ILocalization(this._localizations[this._SafeStr_8302][0]).value;
            };
            if (_local_2){
                _local_2.text = ILocalization(this._localizations[this._SafeStr_8302][2]).value;
            };
            if (_local_3){
                _local_4 = ILocalization(this._localizations[this._SafeStr_8302][1]).value;
                this.setPreviewFromAsset(_local_4);
            };
        }
        private function PendingImage(_arg_1:IBitmapWrapperWindow, _arg_2:BitmapData):void
        {
            if (_arg_2 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.disposed){
                return;
            };
            var _local_3:int = ((_arg_1.width - _arg_2.width) / 2);
            var _local_4:int = ((_arg_1.height - _arg_2.height) / 2);
            if (_arg_1.bitmap == null){
                _arg_1.bitmap = new BitmapData(_arg_1.width, _arg_1.height, true, 0xFFFFFF);
            };
            _arg_1.bitmap.fillRect(_arg_1.bitmap.rect, 0xFFFFFF);
            _arg_1.bitmap.copyPixels(_arg_2, _arg_2.rect, new Point(_local_3, _local_4), null, null, false);
            _arg_1.invalidate();
        }
        private function setPreviewFromAsset(_arg_1:String):void
        {
            if (((((!(_arg_1)) || (!(this._SafeStr_5221)))) || (!(this._SafeStr_5221.assets)))){
                return;
            };
            var _local_2:BitmapDataAsset = (this._SafeStr_5221.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null){
                this.PendingImage(_arg_1);
                return;
            };
            var _local_3:IBitmapWrapperWindow = (this.find(this._window, "help_image") as IBitmapWrapperWindow);
            if (_local_3){
                this.PendingImage(_local_3, (_local_2.content as BitmapData));
            };
        }
        private function PendingImage(_arg_1:String):void
        {
            if (((((!(_arg_1)) || (!(this._SafeStr_5221)))) || (!(this._SafeStr_5221.assets)))){
                return;
            };
            var _local_2:String = this._SafeStr_5221.configuration.getKey("image.library.catalogue.url");
            var _local_3 = ((_local_2 + _arg_1) + ".gif");
            Logger.log(("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _local_3));
            var _local_4:URLRequest = new URLRequest(_local_3);
            var _local_5:AssetLoaderStruct = this._SafeStr_5221.assets.loadAssetFromFile(_arg_1, _local_4, "image/gif");
            if (!_local_5){
                return;
            };
            _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.PendingImage);
        }
        private function PendingImage(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (_local_2 != null){
                this.setPreviewFromAsset(_local_2.assetName);
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.help

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// UserDefinedRoomEventsHelp = "_-2tb" (String#7150, DoABC#2)
// PendingImage = "_-1IU" (String#302, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// PendingImage = "_-30x" (String#625, DoABC#2)
// localize = "_-2KD" (String#6450, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// _SafeStr_8301 = "_-OM" (String#23182, DoABC#2)
// _SafeStr_8302 = "_-3C" (String#21958, DoABC#2)
// _SafeStr_8303 = "_-1Dh" (String#17012, DoABC#2)
// _SafeStr_8304 = "_-gG" (String#23904, DoABC#2)
// initLocalizations = "_-1MJ" (String#17372, DoABC#2)
// onButtonClick = "_-1S0" (String#1689, DoABC#2)
// ICatalogNavigator = "_-6Z" (String#2052, DoABC#2)
// checkButtons = "_-c6" (String#23718, DoABC#2)
// nextPage = "_-UK" (String#23422, DoABC#2)
// previousPage = "_-1SN" (String#17596, DoABC#2)
// setPreviewFromAsset = "_-1qV" (String#1768, DoABC#2)
// PendingImage = "_-04a" (String#579, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


