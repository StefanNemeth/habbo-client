
package com.sulake.habbo.notifications
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class ClubPromoNotification 
    {

        private var _window:IFrameWindow;
        private var _catalog:IHabboCatalog;

        public function ClubPromoNotification(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary, _arg_4:IHabboWindowManager, _arg_5:IHabboCatalog, _arg_6:IHabboLocalizationManager)
        {
            if (((((((!(_arg_3)) || (!(_arg_4)))) || (!(_arg_5)))) || (!(_arg_6)))){
                return;
            };
            this._catalog = _arg_5;
            var _local_7:XmlAsset = (_arg_3.getAssetByName("club_promo_notification_xml") as XmlAsset);
            if (_local_7 == null){
                return;
            };
            this._window = (_arg_4.buildFromXML((_local_7.content as XML)) as IFrameWindow);
            if (this._window == null){
                return;
            };
            this.CurrencyIndicatorBase("regular_price_text", _arg_1);
            this.CurrencyIndicatorBase("discount_text", (_arg_2 - _arg_1));
            this.CurrencyIndicatorBase("your_price_text", _arg_2);
            this._window.findChildByName("benefits_text").setParamFlag(WindowParam._SafeStr_7434);
            this._window.procedure = this.ClubEndingNotification;
            this._window.x = 74;
            this._window.y = ((this._window.context.getDesktopWindow().height / 2) - (this._window.height / 2));
        }
        private function CurrencyIndicatorBase(_arg_1:String, _arg_2:int):void
        {
            this._window.findChildByName(_arg_1).caption = ("" + _arg_2);
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
                case "benefits_text":
                    this.ClubPromoNotification();
                    return;
                case "header_button_close":
                case "cancel_button":
                    this.dispose();
                    return;
            };
        }
        private function ClubPromoNotification():void
        {
            var _local_1:IHabboConfigurationManager = this._catalog.configuration;
            var _local_2:String = _local_1.getKey("link.format.club", "credits/habboclub");
            if (_local_2 != ""){
                this._catalog.windowManager.alert("${catalog.alert.external.link.title}", "${catalog.alert.external.link.desc}", 0, this.ClubPromoNotification);
                HabboWebTools.navigateToURL(_local_2, "habboMain");
            };
        }
        private function ClubPromoNotification(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.notifications

// ClubPromoNotification = "_-qv" (String#24311, DoABC#2)
// ClubPromoNotification = "_-2IG" (String#19738, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ClubPromoNotification = "_-1jo" (String#5749, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// ClubEndingNotification = "_-34P" (String#217, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)


