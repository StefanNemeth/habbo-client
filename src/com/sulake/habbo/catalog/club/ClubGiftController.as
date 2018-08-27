
package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.outgoing.catalog.GetClubGiftInfo;
    import com.sulake.habbo.catalog.viewer.Offer;
    import com.sulake.habbo.communication.messages.outgoing.catalog.SelectClubGiftComposer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.catalog.purse.IPurse;

    public class ClubGiftController 
    {

        private var _widget:ClubGiftWidget;
        private var _daysUntilNextGift:int;
        private var _giftsAvailable:int;
        private var _offers:Array;
        private var _giftData:Map;
        private var _catalog:HabboCatalog;
        private var _SafeStr_5427:ClubGiftConfirmationDialog;

        public function ClubGiftController(_arg_1:HabboCatalog)
        {
            this._catalog = _arg_1;
        }
        public function dispose():void
        {
            this._catalog = null;
            if (this._SafeStr_5427){
                this._SafeStr_5427.dispose();
                this._SafeStr_5427 = null;
            };
        }
        public function set widget(_arg_1:ClubGiftWidget):void
        {
            this._widget = _arg_1;
            this._catalog.connection.send(new GetClubGiftInfo());
        }
        public function get daysUntilNextGift():int
        {
            return (this._daysUntilNextGift);
        }
        public function get giftsAvailable():int
        {
            return (this._giftsAvailable);
        }
        public function setInfo(_arg_1:int, _arg_2:int, _arg_3:Array, _arg_4:Map):void
        {
            this._daysUntilNextGift = _arg_1;
            this._giftsAvailable = _arg_2;
            this._offers = _arg_3;
            this._giftData = _arg_4;
            this._widget.update();
        }
        public function selectGift(_arg_1:Offer):void
        {
            this.closeConfirmation();
            this._SafeStr_5427 = new ClubGiftConfirmationDialog(this, _arg_1);
        }
        public function confirmSelection(_arg_1:String):void
        {
            if (((((!(_arg_1)) || (!(this._catalog)))) || (!(this._catalog.connection)))){
                return;
            };
            this._catalog.connection.send(new SelectClubGiftComposer(_arg_1));
            this._giftsAvailable--;
            this._widget.update();
            this.closeConfirmation();
        }
        public function closeConfirmation():void
        {
            if (this._SafeStr_5427){
                this._SafeStr_5427.dispose();
                this._SafeStr_5427 = null;
            };
        }
        public function getOffers():Array
        {
            return (this._offers);
        }
        public function getGiftData():Map
        {
            return (this._giftData);
        }
        public function get hasClub():Boolean
        {
            if (((!(this._catalog)) || (!(this._catalog.getPurse())))){
                return (false);
            };
            return ((this._catalog.getPurse().clubDays > 0));
        }
        public function get windowManager():IHabboWindowManager
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.windowManager);
        }
        public function get localization():ICoreLocalizationManager
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.localization);
        }
        public function get assets():IAssetLibrary
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.assets);
        }
        public function get roomEngine():IRoomEngine
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.roomEngine);
        }
        public function getProductData(_arg_1:String):IProductData
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.getProductData(_arg_1));
        }
        public function get purse():IPurse
        {
            if (!this._catalog){
                return (null);
            };
            return (this._catalog.getPurse());
        }
        public function get catalog():HabboCatalog
        {
            return (this._catalog);
        }

    }
}//package com.sulake.habbo.catalog.club

// IProductData = "_-0jc" (String#4494, DoABC#2)
// IPurse = "_-0GN" (String#3880, DoABC#2)
// ClubGiftController = "_-33f" (String#7378, DoABC#2)
// Offer = "_-0m2" (String#4550, DoABC#2)
// ClubGiftWidget = "_-2um" (String#7176, DoABC#2)
// ClubGiftConfirmationDialog = "_-WY" (String#8334, DoABC#2)
// GetClubGiftInfo = "_-2oS" (String#21022, DoABC#2)
// SelectClubGiftComposer = "_-0BI" (String#14497, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// _SafeStr_5427 = "_-au" (String#638, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// _daysUntilNextGift = "_-09n" (String#3755, DoABC#2)
// _giftsAvailable = "_-01z" (String#3603, DoABC#2)
// _giftData = "_-0kP" (String#4509, DoABC#2)
// daysUntilNextGift = "_-12R" (String#16556, DoABC#2)
// giftsAvailable = "_-GA" (String#22860, DoABC#2)
// setInfo = "_-2pW" (String#21058, DoABC#2)
// selectGift = "_-2IU" (String#19745, DoABC#2)
// getOffers = "_-8a" (String#22564, DoABC#2)
// getGiftData = "_-Ui" (String#23436, DoABC#2)


