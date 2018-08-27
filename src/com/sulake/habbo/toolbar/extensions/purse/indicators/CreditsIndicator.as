
package com.sulake.habbo.toolbar.extensions.purse.indicators
{
    import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class CreditsIndicator extends CurrencyIndicatorBase 
    {

        private static const _SafeStr_5357:uint = 4291993382;
        private static const _SafeStr_5358:uint = 0xFFC08500;
        private static const _SafeStr_5356:Array = ["icon_credit_0_png", "icon_credit_1_png", "icon_credit_2_png", "icon_credit_3_png", "icon_credit_4_png", "icon_credit_5_png", "icon_credit_6_png"];

        private var _credits:int = -1;
        private var _catalog:IHabboCatalog;

        public function CreditsIndicator(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboCatalog, _arg_4:ICoreLocalizationManager)
        {
            super(_arg_1, _arg_2);
            this._catalog = _arg_3;
            this.bgColorLight = _SafeStr_5357;
            this.bgColorDark = _SafeStr_5358;
            this.textElementName = "credits";
            this.textElementShadowName = "credits_shadow";
            this.iconAnimationSequence = _SafeStr_5356;
            this.iconAnimationDelay = 50;
            this.amountZeroText = _arg_4.getKey("purse.credits.zero.amount.text", "Buy");
            createWindow("purse_indicator_credits_xml", _SafeStr_5356[0]);
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(PurseEvent.RWPUE_CREDIT_BALANCE, this.onCreditBalance);
        }
        override protected function onContainerClick(_arg_1:WindowMouseEvent):void
        {
            this._catalog.openCreditsHabblet();
        }
        private function onCreditBalance(_arg_1:PurseEvent):void
        {
            var _local_2:String = _arg_1.balance.toString();
            if (_arg_1.balance == 0){
                _local_2 = this.amountZeroText;
                setTextUnderline(true);
            }
            else {
                setTextUnderline(false);
            };
            this.setText(_local_2);
            if (this._credits != -1){
                if (this._credits > _arg_1.balance){
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
                }
                else {
                    animateIcon(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
                };
            };
            this._credits = _arg_1.balance;
        }

    }
}//package com.sulake.habbo.toolbar.extensions.purse.indicators

// PurseEvent = "_-kO" (String#24049, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// CurrencyIndicatorBase = "_-0Dt" (String#3824, DoABC#2)
// CreditsIndicator = "_-0zT" (String#4838, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// RWPUE_CREDIT_BALANCE = "_-31Q" (String#21556, DoABC#2)
// onCreditBalance = "_-2Mm" (String#886, DoABC#2)
// _SafeStr_5356 = "_-12s" (String#1608, DoABC#2)
// _SafeStr_5357 = "_-1Cp" (String#839, DoABC#2)
// _SafeStr_5358 = "_-1BZ" (String#837, DoABC#2)
// bgColorLight = "_-OA" (String#23175, DoABC#2)
// bgColorDark = "_-ic" (String#23983, DoABC#2)
// textElementShadowName = "_-1dv" (String#18053, DoABC#2)
// iconAnimationDelay = "_-1Yv" (String#17847, DoABC#2)
// amountZeroText = "_-Md" (String#23110, DoABC#2)
// onContainerClick = "_-1M3" (String#602, DoABC#2)
// animateIcon = "_-L5" (String#23050, DoABC#2)
// setTextUnderline = "_-uZ" (String#24474, DoABC#2)
// setText = "_-1vu" (String#243, DoABC#2)
// _credits = "_-e9" (String#8486, DoABC#2)
// openCreditsHabblet = "_-0D5" (String#3811, DoABC#2)


