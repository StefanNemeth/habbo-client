
package com.sulake.habbo.catalog.club
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.localization.ILocalization;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.catalog.purse.IPurse;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;

    public class ClubBuyConfirmationDialog 
    {

        private var _offer:ClubBuyOfferData;
        private var _controller:ClubBuyController;
        private var _view:IFrameWindow;
        private var _pageId:int;

        public function ClubBuyConfirmationDialog(_arg_1:ClubBuyController, _arg_2:ClubBuyOfferData, _arg_3:int)
        {
            this._offer = _arg_2;
            this._controller = _arg_1;
            this._pageId = _arg_3;
            this.showConfirmation();
        }
        public function dispose():void
        {
            this._controller = null;
            this._offer = null;
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function showConfirmation():void
        {
            var _local_3:ILocalization;
            if (((!(this._offer)) || (!(this._controller)))){
                return;
            };
            this._view = (this.createWindow("club_buy_confirmation") as IFrameWindow);
            if (!this._view){
                return;
            };
            this._view.procedure = this.NameChangeView;
            this._view.center();
            var _local_1:ITextWindow = (this._view.findChildByName("item_name") as ITextWindow);
            if (_local_1){
                _local_1.text = this.getProductName();
            };
            if (this._offer.vip){
                (this._view.findChildByName("icon") as IIconWindow).style = 18;
            }
            else {
                (this._view.findChildByName("icon") as IIconWindow).style = 17;
            };
            var _local_2:ICoreLocalizationManager = this._controller.localization;
            var _local_4:String = "";
            var _local_5:int = this._controller.getClubType();
            var _local_6:String = "catalog.club.buy.confirm.desc.";
            switch (_local_5){
                case HabboClubLevelEnum._SafeStr_3942:
                    _local_6 = (_local_6 + "none.");
                    break;
                case HabboClubLevelEnum._SafeStr_3943:
                    _local_6 = (_local_6 + "hc.");
                    break;
                case HabboClubLevelEnum._SafeStr_3939:
                    _local_6 = (_local_6 + "vip.");
                    break;
            };
            _local_6 = (_local_6 + ((this._offer.vip) ? "vip" : "hc"));
            _local_6 = (_local_6 + ((this._offer.upgrade) ? ".period" : ""));
            _local_3 = _local_2.getLocalization(_local_6);
            if (_local_3 != null){
                _local_4 = _local_3.value;
                _local_4 = (_local_4 + "\n\n");
            };
            var _local_7:IPurse = this._controller.getPurse();
            var _local_8:int = _local_7.clubDays;
            var _local_9:int = _local_7.clubPeriods;
            var _local_10:int = ((_local_9 * 31) + _local_8);
            var _local_11:String = ((this._offer.vip) ? "vip" : "hc");
            var _local_12:String = _local_2.getLocalization(("catalog.club." + _local_11)).value;
            var _local_13:int = (((this._offer.periods)==0) ? 1 : this._offer.periods);
            _local_2.registerParameter("catalog.club.buy.confirm.price", "price", String(this._offer.price));
            _local_2.registerParameter("catalog.club.buy.confirm.product", "days", String((_local_13 * 31)));
            _local_2.registerParameter("catalog.club.buy.confirm.product", "club", _local_12);
            _local_2.registerParameter("catalog.club.buy.confirm.amount", "day", String(this._offer.day));
            _local_2.registerParameter("catalog.club.buy.confirm.amount", "month", String(this._offer.month));
            _local_2.registerParameter("catalog.club.buy.confirm.amount", "year", String(this._offer.year));
            _local_2.registerParameter("catalog.club.buy.confirm.before", "days", String(_local_10));
            _local_2.registerParameter("catalog.club.buy.confirm.after", "days", String(this._offer.daysLeftAfterPurchase));
            if (this._offer.upgrade){
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.price").value + "\n"));
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.before").value + "\n"));
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.after").value + "\n"));
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.amount").value + "\n"));
                this._view.height = 240;
                this._view.findChildByName("description").height = 150;
            }
            else {
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.price").value + "\n"));
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.product").value + "\n"));
                _local_4 = (_local_4 + (_local_2.getLocalization("catalog.club.buy.confirm.amount").value + "\n"));
            };
            this._view.findChildByName("description").caption = _local_4;
        }
        private function getProductName():String
        {
            var _local_1:IProductData;
            if (((((this._offer) && (this._offer.productContainer))) && (this._offer.productContainer.firstProduct))){
                _local_1 = this._offer.productContainer.firstProduct.productData;
                if (_local_1){
                    return (_local_1.name);
                };
            };
            return ("");
        }
        private function NameChangeView(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((((((!(_arg_1)) || (!(_arg_2)))) || (!(this._controller)))) || (!(this._offer)))){
                return;
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "select_button":
                    this._controller.confirmSelection(this._offer, this._pageId);
                    return;
                case "header_button_close":
                case "cancel_button":
                    this._controller.ExtraToolsExtension();
                    return;
            };
        }
        private function createWindow(_arg_1:String):IWindow
        {
            if (((((!(this._controller)) || (!(this._controller.assets)))) || (!(this._controller.windowManager)))){
                return (null);
            };
            var _local_2:XmlAsset = (this._controller.assets.getAssetByName(_arg_1) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                return (null);
            };
            var _local_3:XML = (_local_2.content as XML);
            if (!_local_3){
                return (null);
            };
            return (this._controller.windowManager.buildFromXML(_local_3));
        }

    }
}//package com.sulake.habbo.catalog.club

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalization = "_-2EY" (String#1839, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// ClubBuyController = "_-2RB" (String#6584, DoABC#2)
// ClubBuyOfferData = "_-2XP" (String#6709, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// ClubBuyConfirmationDialog = "_-Hn" (String#8033, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// firstProduct = "_-KM" (String#8089, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// _pageId = "_-251" (String#366, DoABC#2)
// ExtraToolsExtension = "_-2PG" (String#6548, DoABC#2)
// upgrade = "_-2mZ" (String#20944, DoABC#2)
// periods = "_-0cr" (String#15546, DoABC#2)
// daysLeftAfterPurchase = "_-2JK" (String#19782, DoABC#2)
// getClubType = "_-1u" (String#18715, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// NameChangeView = "_-36j" (String#371, DoABC#2)
// getProductName = "_-2Y5" (String#6729, DoABC#2)


