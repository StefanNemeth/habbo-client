
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetSettingsMessage;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetStoreSettingsMessage;

    public class MeMenuSoundSettingsView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;
        private var _SafeStr_3945:MeMenuSoundSettingsSlider;
        private var _SafeStr_3946:BitmapData;
        private var _SafeStr_3947:BitmapData;
        private var _SafeStr_3948:BitmapData;
        private var _SafeStr_3949:BitmapData;
        private var _volume:Number = 1;

        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            this._widget = _arg_1;
            this.createWindow(_arg_2);
        }
        public function dispose():void
        {
            this.saveVolume(this._volume);
            this._widget = null;
            if (this._window != null){
                this._window.dispose();
            };
            this._window = null;
            if (this._SafeStr_3945 != null){
                this._SafeStr_3945.dispose();
            };
            this._SafeStr_3945 = null;
            if (this._SafeStr_3946){
                this._SafeStr_3946.dispose();
                this._SafeStr_3946 = null;
            };
            if (this._SafeStr_3947){
                this._SafeStr_3947.dispose();
                this._SafeStr_3947 = null;
            };
            if (this._SafeStr_3948){
                this._SafeStr_3948.dispose();
                this._SafeStr_3948 = null;
            };
            if (this._SafeStr_3949){
                this._SafeStr_3949.dispose();
                this._SafeStr_3949 = null;
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function updateSettings(_arg_1:RoomWidgetSettingsUpdateEvent):void
        {
            this._volume = _arg_1.volume;
            if (this._SafeStr_3945 != null){
                this._SafeStr_3945.setValue(this._volume);
            };
            this.updateSoundIcons();
        }
        private function createWindow(_arg_1:String):void
        {
            var _local_3:IWindow;
            var _local_5:BitmapDataAsset;
            var _local_6:IWindow;
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("memenu_settings") as XmlAsset);
            if (_local_2){
                this._window = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            };
            if (this._window == null){
                throw (new Error("Failed to construct sound settings window from XML!"));
            };
            this._window.name = _arg_1;
            var _local_4:int;
            while (_local_4 < this._window.numChildren) {
                _local_3 = this._window.getChildAt(_local_4);
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _local_4++;
            };
            _local_5 = (this._widget.assets.getAssetByName("sounds_off_color") as BitmapDataAsset);
            if (((!((_local_5 == null))) && (!((_local_5.content == null))))){
                this._SafeStr_3946 = (_local_5.content as BitmapData).clone();
            };
            _local_5 = (this._widget.assets.getAssetByName("sounds_off_white") as BitmapDataAsset);
            if (((!((_local_5 == null))) && (!((_local_5.content == null))))){
                this._SafeStr_3947 = (_local_5.content as BitmapData).clone();
            };
            _local_5 = (this._widget.assets.getAssetByName("sounds_on_color") as BitmapDataAsset);
            if (((!((_local_5 == null))) && (!((_local_5.content == null))))){
                this._SafeStr_3948 = (_local_5.content as BitmapData).clone();
            };
            _local_5 = (this._widget.assets.getAssetByName("sounds_on_white") as BitmapDataAsset);
            if (((!((_local_5 == null))) && (!((_local_5.content == null))))){
                this._SafeStr_3949 = (_local_5.content as BitmapData).clone();
            };
            this._SafeStr_3945 = new MeMenuSoundSettingsSlider(this, (this._window.findChildByName("volume_container") as IWindowContainer), this._widget.assets, 0, 1);
            this.updateSoundIcons();
            _local_6 = this._window.findChildByName("sounds_off");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onButtonOver);
                _local_6.addEventListener(WindowMouseEvent.WME_OUT, this.onButtonOut);
            };
            _local_6 = this._window.findChildByName("sounds_on");
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onButtonClicked);
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onButtonOver);
                _local_6.addEventListener(WindowMouseEvent.WME_OUT, this.onButtonOut);
            };
            this._widget.messageListener.processWidgetMessage(new RoomWidgetGetSettingsMessage(RoomWidgetGetSettingsMessage.RWGSM_GET_SETTINGS));
        }
        private function updateSoundIcons():void
        {
            if (this._volume == 0){
                this.setBitmapWrapperContent("sounds_on_icon", this._SafeStr_3949);
                this.setBitmapWrapperContent("sounds_off_icon", this._SafeStr_3946);
            }
            else {
                this.setBitmapWrapperContent("sounds_on_icon", this._SafeStr_3948);
                this.setBitmapWrapperContent("sounds_off_icon", this._SafeStr_3947);
            };
        }
        private function setBitmapWrapperContent(_arg_1:String, _arg_2:BitmapData):void
        {
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (((!((_local_3 == null))) && (!((_arg_2 == null))))){
                _local_3.bitmap = _arg_2.clone();
            };
        }
        private function onButtonOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "sounds_off_icon":
                case "sounds_off":
                    this.setBitmapWrapperContent("sounds_off_icon", this._SafeStr_3946);
                    return;
                case "sounds_on_icon":
                case "sounds_on":
                    this.setBitmapWrapperContent("sounds_on_icon", this._SafeStr_3948);
                    return;
            };
        }
        private function onButtonOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "sounds_off":
                    if (this._volume != 0){
                        this.setBitmapWrapperContent("sounds_off_icon", this._SafeStr_3947);
                    };
                    return;
                case "sounds_on":
                    if (this._volume != 1){
                        this.setBitmapWrapperContent("sounds_on_icon", this._SafeStr_3949);
                    };
                    return;
            };
        }
        private function onButtonClicked(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "sounds_off":
                    this.saveVolume(0, false);
                    return;
                case "sounds_on":
                    this.saveVolume(1, false);
                    return;
                case "back_btn":
                    this._widget.changeView(MeMenuWidget._SafeStr_3861);
                    return;
                default:
                    Logger.log(("Me Menu Settings View: unknown button: " + _local_3));
            };
        }
        public function saveVolume(_arg_1:Number, _arg_2:Boolean=true):void
        {
            var _local_3:RoomWidgetStoreSettingsMessage;
            if (_arg_2){
                _local_3 = new RoomWidgetStoreSettingsMessage(RoomWidgetStoreSettingsMessage.RWSSM_STORE_SOUND);
            }
            else {
                _local_3 = new RoomWidgetStoreSettingsMessage(RoomWidgetStoreSettingsMessage.RWSSM_PREVIEW_SOUND);
            };
            _local_3.volume = _arg_1;
            this._widget.messageListener.processWidgetMessage(_local_3);
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// RoomWidgetSettingsUpdateEvent = "_-1WG" (String#5478, DoABC#2)
// IMeMenuView = "_-Y6" (String#8372, DoABC#2)
// MeMenuSoundSettingsView = "_-2Vd" (String#6676, DoABC#2)
// RoomWidgetStoreSettingsMessage = "_-33h" (String#7379, DoABC#2)
// RoomWidgetGetSettingsMessage = "_-2lr" (String#7003, DoABC#2)
// MeMenuSoundSettingsSlider = "_-4n" (String#7761, DoABC#2)
// RWSSM_STORE_SOUND = "_-1fr" (String#18131, DoABC#2)
// RWSSM_PREVIEW_SOUND = "_-1Z6" (String#17856, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// RWGSM_GET_SETTINGS = "_-065" (String#14285, DoABC#2)
// _SafeStr_3861 = "_-1HH" (String#17161, DoABC#2)
// changeView = "_-0hX" (String#15729, DoABC#2)
// updateSettings = "_-2GL" (String#19655, DoABC#2)
// onButtonClicked = "_-2k0" (String#247, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_3945 = "_-Oo" (String#23196, DoABC#2)
// _SafeStr_3946 = "_-2Bq" (String#19476, DoABC#2)
// _SafeStr_3947 = "_-0wC" (String#16281, DoABC#2)
// _SafeStr_3948 = "_-0dS" (String#15564, DoABC#2)
// _SafeStr_3949 = "_-1nI" (String#18436, DoABC#2)
// saveVolume = "_-1-3" (String#16432, DoABC#2)
// updateSoundIcons = "_-xb" (String#24592, DoABC#2)
// onButtonOver = "_-0Ui" (String#15233, DoABC#2)
// onButtonOut = "_-1x2" (String#18848, DoABC#2)
// setBitmapWrapperContent = "_-0e9" (String#15592, DoABC#2)


