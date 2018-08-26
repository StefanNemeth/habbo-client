
package com.sulake.habbo.toolbar.extensions.purse.indicators
{
    import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.catalog.purse.PurseEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class ShellsIndicator extends CurrencyIndicatorBase 
    {

        private static const _SafeStr_5356:Array = ["icon_shell_0_png", "icon_shell_1_png", "icon_shell_2_png", "icon_shell_3_png"];

        private const _SafeStr_5357:uint = 4283212437;
        private const _SafeStr_5358:uint = 4282748017;

        private var _SafeStr_5359:int = 0;
        private var _catalog:IHabboCatalog;

        public function ShellsIndicator(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboCatalog, _arg_4:ICoreLocalizationManager)
        {
            super(_arg_1, _arg_2);
            this._catalog = _arg_3;
            this.bgColorLight = this._SafeStr_5357;
            this.bgColorDark = this._SafeStr_5358;
            this.textElementName = "amount";
            this.textElementShadowName = "amount_shadow";
            this.iconAnimationSequence = _SafeStr_5356.concat(_SafeStr_5356).concat(_SafeStr_5356);
            this.iconAnimationDelay = 50;
            this.amountZeroText = _arg_4.getKey("purse.shells.zero.amount.text", "Info");
            createWindow("purse_indicator_shells_xml", _SafeStr_5356[0]);
            this.setAmount(0);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(PurseEvent.RWPUE_SHELL_BALANCE, this.onShellBalance);
        }
        override protected function CurrencyIndicatorBase(_arg_1:WindowMouseEvent):void
        {
            this._catalog.openCatalogPage(CatalogPageName._SafeStr_5369, true);
        }
        private function onShellBalance(_arg_1:PurseEvent):void
        {
            this.setAmount(_arg_1.balance);
            if (this._SafeStr_5359 != 0){
                if (this._SafeStr_5359 > _arg_1.balance){
                    CurrencyIndicatorBase(CurrencyIndicatorBase.ANIM_DIRECTION_FORWARD);
                }
                else {
                    CurrencyIndicatorBase(CurrencyIndicatorBase.ANIM_DIRECTION_BACKWARD);
                };
            };
            this._SafeStr_5359 = _arg_1.balance;
        }
        private function setAmount(_arg_1:int):void
        {
            var _local_2:String = _arg_1.toString();
            if (_arg_1 == 0){
                _local_2 = this.amountZeroText;
                CurrencyIndicatorBase(true);
            }
            else {
                CurrencyIndicatorBase(false);
            };
            CurrencyIndicatorBase(_local_2);
        }

    }
}//package com.sulake.habbo.toolbar.extensions.purse.indicators

// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// PurseEvent = "_-kO" (String#24049, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// CurrencyIndicatorBase = "_-0Dt" (String#3824, DoABC#2)
// ShellsIndicator = "_-2HW" (String#6394, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// _SafeStr_5356 = "_-12s" (String#1608, DoABC#2)
// _SafeStr_5357 = "_-1Cp" (String#839, DoABC#2)
// _SafeStr_5358 = "_-1BZ" (String#837, DoABC#2)
// _SafeStr_5359 = "_-1FN" (String#17089, DoABC#2)
// bgColorLight = "_-OA" (String#23175, DoABC#2)
// bgColorDark = "_-ic" (String#23983, DoABC#2)
// textElementShadowName = "_-1dv" (String#18053, DoABC#2)
// iconAnimationDelay = "_-1Yv" (String#17847, DoABC#2)
// amountZeroText = "_-Md" (String#23110, DoABC#2)
// setAmount = "_-0Y3" (String#4267, DoABC#2)
// RWPUE_SHELL_BALANCE = "_-0Se" (String#15158, DoABC#2)
// onShellBalance = "_-F3" (String#22816, DoABC#2)
// CurrencyIndicatorBase = "_-1M3" (String#602, DoABC#2)
// _SafeStr_5369 = "_-06q" (String#14318, DoABC#2)
// CurrencyIndicatorBase = "_-L5" (String#23050, DoABC#2)
// CurrencyIndicatorBase = "_-uZ" (String#24474, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)


