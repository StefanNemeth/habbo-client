
package com.sulake.habbo.toolbar.extensions.purse.indicators
{
    import com.sulake.habbo.toolbar.extensions.purse.CurrencyIndicatorBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.localization.ICoreLocalizationManager;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.components.IIconWindow;

    public class ClubDaysIndicator extends CurrencyIndicatorBase 
    {

        private static const _SafeStr_5357:uint = 4286084205;
        private static const _SafeStr_5358:uint = 4283781966;
        private static const _SafeStr_5377:int = 13;
        private static const _SafeStr_5378:int = 14;

        private var _catalog:IHabboCatalog;
        private var _inventory:IHabboInventory;

        public function ClubDaysIndicator(_arg_1:IHabboWindowManager, _arg_2:IAssetLibrary, _arg_3:IHabboCatalog, _arg_4:IHabboInventory, _arg_5:ICoreLocalizationManager)
        {
            super(_arg_1, _arg_2);
            this._catalog = _arg_3;
            this._inventory = _arg_4;
            this.bgColorLight = _SafeStr_5357;
            this.bgColorDark = _SafeStr_5358;
            this.textElementName = "days";
            this.textElementShadowName = "days_shadow";
            this.amountZeroText = _arg_5.getKey("purse.clubdays.zero.amount.text", "Get");
            createWindow("purse_indicator_club_xml", "");
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(HabboInventoryHabboClubEvent.HIHCE_HABBO_CLUB_CHANGED, this.onClubChanged);
        }
        override protected function onContainerClick(_arg_1:WindowMouseEvent):void
        {
            this._catalog.openCatalogPage(CatalogPageName._SafeStr_5382, true);
        }
        private function onClubChanged(_arg_1:HabboInventoryHabboClubEvent):void
        {
            var _local_2:int = ((this._inventory.clubPeriods * 31) + this._inventory.clubDays);
            setText(_local_2.toString());
            switch (this._inventory.clubLevel){
                case HabboClubLevelEnum._SafeStr_3942:
                    this.setClubIcon(_SafeStr_5378);
                    setText(this.amountZeroText);
                    setTextUnderline(true);
                    return;
                case HabboClubLevelEnum._SafeStr_3943:
                    this.setClubIcon(_SafeStr_5377);
                    setTextUnderline(false);
                    return;
                case HabboClubLevelEnum._SafeStr_3939:
                    this.setClubIcon(_SafeStr_5378);
                    setTextUnderline(false);
                    return;
            };
        }
        private function setClubIcon(_arg_1:int):void
        {
            var _local_2:IIconWindow = (this.view.findChildByName("club_icon") as IIconWindow);
            if (_local_2){
                _local_2.style = _arg_1;
                _local_2.invalidate();
            };
        }

    }
}//package com.sulake.habbo.toolbar.extensions.purse.indicators

// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// HabboInventoryHabboClubEvent = "_-0Pe" (String#15048, DoABC#2)
// CurrencyIndicatorBase = "_-0Dt" (String#3824, DoABC#2)
// ClubDaysIndicator = "_-Vj" (String#8315, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// _SafeStr_5357 = "_-1Cp" (String#839, DoABC#2)
// _SafeStr_5358 = "_-1BZ" (String#837, DoABC#2)
// bgColorLight = "_-OA" (String#23175, DoABC#2)
// bgColorDark = "_-ic" (String#23983, DoABC#2)
// textElementShadowName = "_-1dv" (String#18053, DoABC#2)
// amountZeroText = "_-Md" (String#23110, DoABC#2)
// onContainerClick = "_-1M3" (String#602, DoABC#2)
// setTextUnderline = "_-uZ" (String#24474, DoABC#2)
// setText = "_-1vu" (String#243, DoABC#2)
// _SafeStr_5377 = "_-0wg" (String#1581, DoABC#2)
// _SafeStr_5378 = "_-374" (String#2003, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// HIHCE_HABBO_CLUB_CHANGED = "_-36p" (String#21757, DoABC#2)
// onClubChanged = "_-0NQ" (String#1461, DoABC#2)
// _SafeStr_5382 = "_-lc" (String#24094, DoABC#2)
// setClubIcon = "_-1YR" (String#1707, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)


