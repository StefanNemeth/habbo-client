
package com.sulake.habbo.catalog.purchase
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.IPurchasableOffer;
    import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
    import com.sulake.core.localization.ILocalization;

    public class BalanceAndCost implements IDisposable 
    {

        private var _balance:String;
        private var _cost:String;
        private var _disposed:Boolean = false;

        public function BalanceAndCost(_arg_1:HabboCatalog, _arg_2:ICoreLocalizationManager, _arg_3:IPurchasableOffer)
        {
            if ((((_arg_3.priceInCredits > 0)) && ((_arg_3.priceInActivityPoints > 0)))){
                this.setWithKey(_arg_1, _arg_2, _arg_3, ("catalog.purchase.confirmation.dialog.price.credits_and_activitypoints." + _arg_3.activityPointType));
            }
            else {
                if (_arg_3.priceInCredits > 0){
                    this.setWithKey(_arg_1, _arg_2, _arg_3, "catalog.purchase.confirmation.dialog.price.credits");
                }
                else {
                    if (_arg_3.priceInActivityPoints > 0){
                        this.setWithKey(_arg_1, _arg_2, _arg_3, ("catalog.purchase.confirmation.dialog.price.activitypoints." + _arg_3.activityPointType));
                    }
                    else {
                        this.setWithKey(_arg_1, _arg_2, _arg_3, "catalog.purchase.confirmation.dialog.price.nothing");
                    };
                };
            };
        }
        public function dispose():void
        {
            if (this.disposed){
                return;
            };
            this._disposed = true;
            this._balance = null;
            this._cost = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function setWithKey(_arg_1:HabboCatalog, _arg_2:ICoreLocalizationManager, _arg_3:IPurchasableOffer, _arg_4:String):void
        {
            var _local_5:String = _arg_1.getPurse().credits.toString();
            var _local_6:String = (((_arg_3.activityPointType == ActivityPointTypeEnum.PIXEL)) ? "pixels" : "activitypoints");
            var _local_7:ILocalization = _arg_2.getLocalization(_arg_4);
            if (_local_7){
                _arg_2.registerParameter(_arg_4, "credits", _arg_3.priceInCredits.toString());
                _arg_2.registerParameter(_arg_4, _local_6, _arg_3.priceInActivityPoints.toString());
                this._cost = _local_7.value;
                _arg_2.registerParameter(_arg_4, "credits", _local_5);
                _arg_2.registerParameter(_arg_4, _local_6, _arg_1.getPurse().getActivityPointsForType(_arg_3.activityPointType).toString());
                this._balance = _local_7.value;
            }
            else {
                Logger.log(("[CATALOG] Add pricing-model-localization for activity-point-type: " + _arg_4));
            };
        }
        public function get balance():String
        {
            return (this._balance);
        }
        public function get cost():String
        {
            return (this._cost);
        }

    }
}//package com.sulake.habbo.catalog.purchase

// ILocalization = "_-2EY" (String#1839, DoABC#2)
// ActivityPointTypeEnum = "_-11n" (String#16529, DoABC#2)
// IPurchasableOffer = "_-2RV" (String#6596, DoABC#2)
// BalanceAndCost = "_-sU" (String#8747, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// priceInCredits = "_-0Is" (String#3931, DoABC#2)
// priceInActivityPoints = "_-0HW" (String#3908, DoABC#2)
// activityPointType = "_-1gh" (String#5677, DoABC#2)
// _balance = "_-8R" (String#927, DoABC#2)
// _cost = "_-3LL" (String#22341, DoABC#2)
// getActivityPointsForType = "_-1c9" (String#5603, DoABC#2)


