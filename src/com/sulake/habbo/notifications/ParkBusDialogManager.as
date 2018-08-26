
package com.sulake.habbo.notifications
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class ParkBusDialogManager 
    {

        private var _assets:IAssetLibrary;
        private var _localization:IHabboLocalizationManager;
        private var _windowManager:IHabboWindowManager;
        private var _window:IFrameWindow;

        public function ParkBusDialogManager(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboLocalizationManager)
        {
            this._assets = _arg_2;
            this._localization = _arg_3;
            this._windowManager = _arg_1;
        }
        public function dispose():void
        {
            this.disposeWindow();
            this._windowManager = null;
            this._assets = null;
        }
        private function disposeWindow(_arg_1:WindowEvent=null):void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        public function handleParkBusCannotEnter(_arg_1:String):void
        {
            var _local_4:IWindow;
            this.disposeWindow();
            if ((((this._assets == null)) || ((this._windowManager == null)))){
                return;
            };
            var _local_2:XmlAsset = (this._assets.getAssetByName("layout_parkbus_notification_xml") as XmlAsset);
            var _local_3:XML = (_local_2.content as XML);
            this._window = (this._windowManager.buildFromXML(_local_3) as IFrameWindow);
            this._window.center();
            var _local_5:ITextWindow = (this._window.findChildByName("hubu_reason") as ITextWindow);
            if (_local_5 != null){
                _local_5.text = _arg_1;
            };
            _local_4 = this._window.findChildByName("hubu_link1");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
                _local_4.mouseThreshold = 0;
            };
            _local_4 = this._window.findChildByName("hubu_link2");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
                _local_4.mouseThreshold = 0;
            };
            _local_4 = this._window.findChildByTag("close");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onLinkClick);
            };
        }
        private function onLinkClick(_arg_1:WindowMouseEvent):void
        {
            switch (_arg_1.target.name){
                case "hubu_link1":
                    if (this._localization.getKey("hubu.info.url1").length > 0){
                        this.openExternalLink(this._localization.getKey("hubu.info.url1"));
                    };
                    return;
                case "hubu_link2":
                    if (this._localization.getKey("hubu.info.url2").length > 0){
                        this.openExternalLink(this._localization.getKey("hubu.info.url2"));
                    };
                    return;
                case "header_button_close":
                    this.disposeWindow();
                    return;
            };
        }
        private function openExternalLink(_arg_1:String):void
        {
            HabboWebTools.navigateToURL(_arg_1, "habboMain");
        }

    }
}//package com.sulake.habbo.notifications

// openExternalLink = "_-0kn" (String#823, DoABC#2)
// disposeWindow = "_-0-u" (String#804, DoABC#2)
// handleParkBusCannotEnter = "_-33L" (String#21635, DoABC#2)
// onLinkClick = "_-1Li" (String#17345, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ParkBusDialogManager = "_-1Ta" (String#5425, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)


