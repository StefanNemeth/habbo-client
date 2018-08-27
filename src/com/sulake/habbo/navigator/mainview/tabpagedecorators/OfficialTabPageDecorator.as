
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;

    public class OfficialTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;

        public function OfficialTabPageDecorator(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
        }
        public function tabSelected():void
        {
        }
        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            this._navigator.officialRoomEntryManager.refreshAdFooter(_arg_1);
        }
        public function navigatorOpenedWhileInTab():void
        {
            this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4287, Tabs._SafeStr_4302, "-1", MainViewCtrl._SafeStr_4226);
        }
        public function get filterCategory():String
        {
            return (null);
        }

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// Tabs = "_-1b9" (String#5579, DoABC#2)
// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// OfficialTabPageDecorator = "_-1jj" (String#5748, DoABC#2)
// refreshAdFooter = "_-2qK" (String#21094, DoABC#2)
// officialRoomEntryManager = "_-aX" (String#23654, DoABC#2)
// _SafeStr_4226 = "_-1kG" (String#18300, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// _SafeStr_4287 = "_-2Xo" (String#20350, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// _SafeStr_4302 = "_-1xH" (String#18859, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)


