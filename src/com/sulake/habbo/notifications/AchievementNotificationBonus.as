
package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AchievementNotificationBonus 
    {

        private const _SafeStr_12095:String = "achievement_bg_001_png";

        private var _window:IFrameWindow;
        private var _localizations:IHabboLocalizationManager;
        private var _assets:IAssetLibrary;

        public function AchievementNotificationBonus(_arg_1:int, _arg_2:String, _arg_3:IAssetLibrary, _arg_4:IHabboWindowManager, _arg_5:IHabboLocalizationManager)
        {
            if (((((!(_arg_3)) || (!(_arg_4)))) || (!(_arg_5)))){
                return;
            };
            this._assets = _arg_3;
            this._localizations = _arg_5;
            var _local_6:XmlAsset = (_arg_3.getAssetByName("achievement_notification_bonus_xml") as XmlAsset);
            if (_local_6 == null){
                return;
            };
            this._window = (_arg_4.buildFromXML((_local_6.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            this._window.procedure = this.eventHandler;
            this._window.center();
            this.setText("bonus_points", ("+" + String(_arg_1)));
            if (((_arg_2) && (!((_arg_2 == ""))))){
                this._localizations.registerParameter("notifications.achievement.bonus_received.name", "realname", _arg_2);
                this.setText("bonus_info", this._localizations.getKey("notifications.achievement.bonus_received.name"));
            };
            var _local_7:BitmapData = ((_arg_3.getAssetByName(this._SafeStr_12095) as BitmapDataAsset).content as BitmapData);
            var _local_8:IBitmapWrapperWindow = (this._window.findChildByName("achievement_bg") as IBitmapWrapperWindow);
            _local_8.bitmap = new BitmapData(_local_8.width, _local_8.height, true, 0);
            _local_8.bitmap.copyPixels(_local_7, _local_7.rect, new Point(0, (_local_8.height - _local_7.height)), null, null, true);
            this._window.header.controls.visible = false;
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._localizations = null;
            this._assets = null;
        }
        private function setText(_arg_1:String, _arg_2:String):void
        {
            if (this._window == null){
                return;
            };
            var _local_3:ITextWindow = (this._window.findChildByName(_arg_1) as ITextWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.text = _arg_2;
        }
        private function setImage(_arg_1:String, _arg_2:BitmapData):void
        {
            if (this._window == null){
                return;
            };
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName(_arg_1) as IBitmapWrapperWindow);
            if (_local_3 == null){
                return;
            };
            _local_3.bitmap = _arg_2;
        }
        private function eventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "close":
                    this.dispose();
                    return;
            };
        }

    }
}//package com.sulake.habbo.notifications

// _SafeStr_12095 = "_-60" (String#22466, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AchievementNotificationBonus = "_-1fj" (String#5661, DoABC#2)
// eventHandler = "_-34P" (String#217, DoABC#2)
// setImage = "_-1NZ" (String#603, DoABC#2)
// setText = "_-1vu" (String#243, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)


