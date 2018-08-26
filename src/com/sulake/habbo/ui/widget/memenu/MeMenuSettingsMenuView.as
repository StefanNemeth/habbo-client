
package com.sulake.habbo.ui.widget.memenu
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.XmlAsset;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MeMenuSettingsMenuView implements IMeMenuView 
    {

        private var _widget:MeMenuWidget;
        private var _window:IWindowContainer;

        public function init(_arg_1:MeMenuWidget, _arg_2:String):void
        {
            this._widget = _arg_1;
            this.createWindow(_arg_2);
        }
        public function dispose():void
        {
            this._widget = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        private function createWindow(_arg_1:String):void
        {
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("memenu_settings_menu") as XmlAsset);
            if (_local_2){
                this._window = (this._widget.windowManager.buildFromXML((_local_2.content as XML)) as IWindowContainer);
            };
            if (this._window == null){
                throw (new Error("Failed to construct settings window from XML!"));
            };
            this._window.name = _arg_1;
            this._window.procedure = this.ClubEndingNotification;
            if (((!(ExternalInterface.available)) || (!((this._widget.config.getKey("has.identity") == "1"))))){
                this._window.findChildByName("character_settings").disable();
            }
            else {
                this._window.findChildByName("identity_text").visible = false;
            };
        }
        private function ClubEndingNotification(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "character_settings":
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "avatars");
                    this._widget.hide();
                    return;
                case "sound_settings":
                    this._widget.MeMenuWidget(MeMenuWidget._SafeStr_3862);
                    return;
                case "back":
                    this._widget.MeMenuWidget(MeMenuWidget._SafeStr_3858);
                    return;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.memenu

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// MeMenuWidget = "_-02H" (String#3610, DoABC#2)
// IMeMenuView = "_-Y6" (String#8372, DoABC#2)
// MeMenuSettingsMenuView = "_-2G5" (String#6367, DoABC#2)
// _SafeStr_3858 = "_-1Lr" (String#17351, DoABC#2)
// _SafeStr_3862 = "_-0X-" (String#15314, DoABC#2)
// MeMenuWidget = "_-0hX" (String#15729, DoABC#2)
// ClubEndingNotification = "_-34P" (String#217, DoABC#2)


