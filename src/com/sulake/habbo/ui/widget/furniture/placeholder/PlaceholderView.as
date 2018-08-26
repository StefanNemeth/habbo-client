
package com.sulake.habbo.ui.widget.furniture.placeholder
{
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PlaceholderView 
    {

        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;

        public function PlaceholderView(_arg_1:IAssetLibrary, _arg_2:IHabboWindowManager)
        {
            this._assetLibrary = _arg_1;
            this._windowManager = _arg_2;
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        public function toggleWindow():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this.hideWindow();
            }
            else {
                this.showWindow();
            };
        }
        public function showWindow():void
        {
            if (this._window == null){
                this.createWindow();
            };
            if (this._window == null){
                return;
            };
            this._window.visible = true;
            this._window.x = 200;
        }
        private function createWindow():void
        {
            var _local_1:XmlAsset = (this._assetLibrary.getAssetByName("placeholder") as XmlAsset);
            if ((((_local_1 == null)) || ((_local_1.content == null)))){
                return;
            };
            this._window = (this._windowManager.createWindow("habbohelp_window", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(-300, 300, 10, 10), null) as IWindowContainer);
            this._window.buildFromXML((_local_1.content as XML));
            this._window.tags.push("habbo_help_window");
            this._window.background = true;
            this._window.color = 33554431;
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.procedure = this.onWindowClose;
            };
        }
        public function hideWindow():void
        {
            if (this._window != null){
                this._window.visible = false;
            };
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideWindow();
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.placeholder

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// PlaceholderView = "_-0wE" (String#828, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// showWindow = "_-2ve" (String#21300, DoABC#2)
// toggleWindow = "_-bC" (String#23677, DoABC#2)
// hideWindow = "_-0Lm" (String#3998, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)


