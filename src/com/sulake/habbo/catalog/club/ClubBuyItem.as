
package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.catalog.viewer.ICatalogPage;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;

    public class ClubBuyItem 
    {

        private var _offer:ClubBuyOfferData;
        private var _window:IWindowContainer;
        private var _page:ICatalogPage;

        public function ClubBuyItem(_arg_1:ClubBuyOfferData, _arg_2:ICatalogPage)
        {
            var _local_3:XML;
            var _local_5:ILocalization;
            var _local_7:int;
            super();
            this._offer = _arg_1;
            this._page = _arg_2;
            if (_arg_1.vip){
                if (_arg_1.upgrade){
                    _local_3 = this.getAssetXML("club_buy_vip_upgrade_item");
                }
                else {
                    _local_3 = this.getAssetXML("club_buy_vip_item");
                };
            }
            else {
                _local_3 = this.getAssetXML("club_buy_hc_item");
            };
            this._window = (this._page.viewer.catalog.windowManager.buildFromXML(_local_3) as IWindowContainer);
            var _local_4:ICoreLocalizationManager = (_arg_2.viewer.catalog as HabboCatalog).localization;
            if (_arg_1.upgrade){
                _local_7 = (((_arg_1.periods)==0) ? 1 : _arg_1.periods);
                if (_arg_1.upgradeHcPeriodToVip){
                    _local_5 = _local_4.getLocalization("catalog.club.item.header.upgradehctovip");
                }
                else {
                    _local_4.registerParameter("catalog.club.item.header.upgrade", "months", String(_local_7));
                    _local_5 = _local_4.getLocalization("catalog.club.item.header.upgrade");
                };
            }
            else {
                _local_4.registerParameter("catalog.club.item.header", "months", String(_arg_1.periods));
                _local_5 = _local_4.getLocalization("catalog.club.item.header");
            };
            this._window.findChildByName("item_header").caption = _local_5.value;
            _local_4.registerParameter("catalog.club.price", "price", String(_arg_1.price));
            _local_5 = _local_4.getLocalization("catalog.club.price");
            this._window.findChildByName("item_price").caption = _local_5.value;
            var _local_6:IButtonWindow = (this._window.findChildByName("item_buy") as IButtonWindow);
            if (_local_6 != null){
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBuy);
            };
        }
        public function dispose():void
        {
            this._window.dispose();
        }
        private function onBuy(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ClubBuyController = (this._page.viewer.catalog as HabboCatalog).getClubBuyController();
            (this._page.viewer.catalog as HabboCatalog).showPurchaseConfirmation(this._offer, this._page.pageId);
        }
        private function getAssetXML(_arg_1:String):XML
        {
            if (((((((!(this._page)) || (!(this._page.viewer)))) || (!(this._page.viewer.catalog)))) || (!(this._page.viewer.catalog.assets)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._page.viewer.catalog.assets.getAssetByName(_arg_1) as XmlAsset);
            if (_local_2 == null){
                return (null);
            };
            return ((_local_2.content as XML));
        }
        public function get window():IWindow
        {
            return (this._window);
        }

    }
}//package com.sulake.habbo.catalog.club

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ClubBuyController = "_-2RB" (String#6584, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// ICatalogPage = "_-0mL" (String#4556, DoABC#2)
// ClubBuyItem = "_-zp" (String#8878, DoABC#2)
// _page = "_-1VJ" (String#607, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// upgradeHcPeriodToVip = "_-1Gg" (String#17139, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)
// onBuy = "_-1Lc" (String#17340, DoABC#2)
// getClubBuyController = "_-2nZ" (String#20982, DoABC#2)
// showPurchaseConfirmation = "_-2zh" (String#21447, DoABC#2)


