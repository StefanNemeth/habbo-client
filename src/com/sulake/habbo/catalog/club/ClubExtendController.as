
package com.sulake.habbo.catalog.club
{
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
    import com.sulake.habbo.communication.messages.parser.catalog.HabboClubExtendOfferMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.catalog.HabboClubExtendOfferMessageEvent;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;

    public class ClubExtendController 
    {

        private var _catalog:HabboCatalog;
        private var _SafeStr_5427:ClubExtendConfirmationDialog;
        private var _offer:ClubOfferExtendData;
        private var _disposed:Boolean = false;

        public function ClubExtendController(_arg_1:HabboCatalog)
        {
            this._catalog = _arg_1;
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this.closeConfirmation();
            this._offer = null;
            this._catalog = null;
            this._disposed = true;
        }
        public function onOffer(_arg_1:HabboClubExtendOfferMessageEvent):void
        {
            if (this._disposed){
                return;
            };
            var _local_2:HabboClubExtendOfferMessageParser = _arg_1.getParser();
            this._offer = _local_2.offer();
            this.showConfirmation();
            if (this._catalog.connection){
                if (this._offer.vip){
                    this._catalog.connection.send(new EventLogMessageComposer("Catalog", "dialog_show", "vip.membership.extension.purchase"));
                }
                else {
                    this._catalog.connection.send(new EventLogMessageComposer("Catalog", "dialog_show", "basic.membership.extension.purchase"));
                };
            };
        }
        public function closeConfirmation():void
        {
            if (this._SafeStr_5427){
                this._SafeStr_5427.dispose();
                this._SafeStr_5427 = null;
            };
        }
        public function showConfirmation():void
        {
            this.closeConfirmation();
            this._SafeStr_5427 = new ClubExtendConfirmationDialog(this, this._offer);
            this._SafeStr_5427.showConfirmation();
        }
        public function confirmSelection():void
        {
            if (((((!(this._catalog)) || (!(this._catalog.connection)))) || (!(this._offer)))){
                return;
            };
            if (this._offer.vip){
                this._catalog.purchaseVipMembershipExtension(this._offer.offerId);
            }
            else {
                this._catalog.purchaseBasicMembershipExtension(this._offer.offerId);
            };
            this.closeConfirmation();
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

    }
}//package com.sulake.habbo.catalog.club

// ClubExtendController = "_-2UZ" (String#6657, DoABC#2)
// HabboClubExtendOfferMessageEvent = "_-2CH" (String#19495, DoABC#2)
// ClubExtendConfirmationDialog = "_-0oV" (String#4603, DoABC#2)
// HabboClubExtendOfferMessageParser = "_-0BJ" (String#3785, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// _offer = "_-1jb" (String#165, DoABC#2)
// _SafeStr_5427 = "_-au" (String#638, DoABC#2)
// closeConfirmation = "_-2PG" (String#6548, DoABC#2)
// confirmSelection = "_-fK" (String#23861, DoABC#2)
// onOffer = "_-3Ge" (String#22147, DoABC#2)
// purchaseVipMembershipExtension = "_-0mj" (String#15926, DoABC#2)
// purchaseBasicMembershipExtension = "_-0JV" (String#14821, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


