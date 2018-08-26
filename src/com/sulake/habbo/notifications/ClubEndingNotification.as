
package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.window.enum.HabboIconType;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ClubEndingNotification 
    {

        private var _window:IFrameWindow;
        private var _catalog:IHabboCatalog;

        public function ClubEndingNotification(_arg_1:int, _arg_2:Boolean, _arg_3:IAssetLibrary, _arg_4:IHabboWindowManager, _arg_5:IHabboCatalog, _arg_6:IHabboLocalizationManager)
        {
            if (((((((!(_arg_3)) || (!(_arg_4)))) || (!(_arg_5)))) || (!(_arg_6)))){
                return;
            };
            this._catalog = _arg_5;
            _arg_6.registerParameter("notifications.text.club_ending", "days", _arg_1.toString());
            var _local_7:XmlAsset = (_arg_3.getAssetByName("club_ending_notification_xml") as XmlAsset);
            if (_local_7 == null){
                return;
            };
            this._window = (_arg_4.buildFromXML((_local_7.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            var _local_8:IIconWindow = (this._window.findChildByName("club_icon") as IIconWindow);
            if (_local_8){
                if (_arg_2){
                    _local_8.style = HabboIconType._SafeStr_7432;
                }
                else {
                    _local_8.style = HabboIconType._SafeStr_5487;
                };
            };
            this._window.procedure = this.ClubEndingNotification;
            this._window.center();
        }
        public function get visible():Boolean
        {
            return (((this._window) && (this._window.visible)));
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._catalog = null;
        }
        private function ClubEndingNotification(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "open_catalog_button":
                    if (this._catalog){
                        this._catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
                    };
                    this.dispose();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.dispose();
                    return;
            };
        }

    }
}//package com.sulake.habbo.notifications

// ClubEndingNotification = "_-2YI" (String#6732, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboIconType = "_-23Y" (String#6115, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// ClubEndingNotification = "_-34P" (String#217, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// _SafeStr_5487 = "_-2OW" (String#19986, DoABC#2)
// _SafeStr_7432 = "_-22l" (String#19122, DoABC#2)


