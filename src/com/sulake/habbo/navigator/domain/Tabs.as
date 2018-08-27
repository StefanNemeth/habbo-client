
package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.EventsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.MainViewCtrl;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.OfficialTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.MyRoomsTabPageDecorator;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.SearchTabPageDecorator;

    public class Tabs 
    {

        public static const _SafeStr_4285:int = 1;
        public static const _SafeStr_4288:int = 2;
        public static const _SafeStr_4286:int = 3;
        public static const _SafeStr_4287:int = 4;
        public static const _SafeStr_4151:int = 5;
        public static const _SafeStr_4303:int = 1;
        public static const _SafeStr_4305:int = 2;
        public static const _SafeStr_4299:int = 3;
        public static const _SafeStr_4304:int = 4;
        public static const _SafeStr_4301:int = 5;
        public static const _SafeStr_4298:int = 6;
        public static const _SafeStr_4300:int = 7;
        public static const _SafeStr_4306:int = 8;
        public static const _SafeStr_4152:int = 9;
        public static const _SafeStr_8656:int = 10;
        public static const _SafeStr_4302:int = 11;
        public static const _SafeStr_4297:int = 12;

        private var _tabs:Array;
        private var _navigator:HabboNavigator;

        public function Tabs(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
            this._tabs = new Array();
            this._tabs.push(new Tab(this._navigator, _SafeStr_4285, _SafeStr_4297, new EventsTabPageDecorator(this._navigator), MainViewCtrl._SafeStr_4223));
            this._tabs.push(new Tab(this._navigator, _SafeStr_4288, _SafeStr_4303, new RoomsTabPageDecorator(this._navigator), MainViewCtrl._SafeStr_4223));
            this._tabs.push(new Tab(this._navigator, _SafeStr_4287, _SafeStr_4302, new OfficialTabPageDecorator(this._navigator), MainViewCtrl._SafeStr_4226));
            this._tabs.push(new Tab(this._navigator, _SafeStr_4286, _SafeStr_4301, new MyRoomsTabPageDecorator(this._navigator), MainViewCtrl._SafeStr_4223));
            this._tabs.push(new Tab(this._navigator, _SafeStr_4151, _SafeStr_4306, new SearchTabPageDecorator(this._navigator), MainViewCtrl._SafeStr_4224));
            this.setSelectedTab(_SafeStr_4285);
        }
        public function onFrontPage():Boolean
        {
            return ((this.getSelected().id == _SafeStr_4287));
        }
        public function get tabs():Array
        {
            return (this._tabs);
        }
        public function setSelectedTab(_arg_1:int):void
        {
            this.clearSelected();
            this.getTab(_arg_1).selected = true;
        }
        public function getSelected():Tab
        {
            var _local_1:Tab;
            for each (_local_1 in this._tabs) {
                if (_local_1.selected){
                    return (_local_1);
                };
            };
            return (null);
        }
        private function clearSelected():void
        {
            var _local_1:Tab;
            for each (_local_1 in this._tabs) {
                _local_1.selected = false;
            };
        }
        public function getTab(_arg_1:int):Tab
        {
            var _local_2:Tab;
            for each (_local_2 in this._tabs) {
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.navigator.domain

// Tabs = "_-1b9" (String#5579, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// RoomsTabPageDecorator = "_-vM" (String#8791, DoABC#2)
// MyRoomsTabPageDecorator = "_-0rE" (String#4667, DoABC#2)
// OfficialTabPageDecorator = "_-1jj" (String#5748, DoABC#2)
// EventsTabPageDecorator = "_-11C" (String#4898, DoABC#2)
// SearchTabPageDecorator = "_-11G" (String#4901, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// _SafeStr_4152 = "_-2NE" (String#19932, DoABC#2)
// _SafeStr_4223 = "_-2Wh" (String#20312, DoABC#2)
// _SafeStr_4224 = "_-2gj" (String#20718, DoABC#2)
// _SafeStr_4226 = "_-1kG" (String#18300, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// getTab = "_-0mC" (String#15903, DoABC#2)
// _SafeStr_4285 = "_-20q" (String#19046, DoABC#2)
// _SafeStr_4286 = "_-3k" (String#22364, DoABC#2)
// _SafeStr_4287 = "_-2Xo" (String#20350, DoABC#2)
// _SafeStr_4288 = "_-1Ja" (String#17261, DoABC#2)
// _SafeStr_4297 = "_-36W" (String#21748, DoABC#2)
// _SafeStr_4298 = "_-0Jm" (String#14833, DoABC#2)
// _SafeStr_4299 = "_-2ob" (String#21028, DoABC#2)
// _SafeStr_4300 = "_-0Q4" (String#15063, DoABC#2)
// _SafeStr_4301 = "_-1o0" (String#18463, DoABC#2)
// _SafeStr_4302 = "_-1xH" (String#18859, DoABC#2)
// _SafeStr_4303 = "_-21q" (String#19083, DoABC#2)
// _SafeStr_4304 = "_-0CH" (String#14541, DoABC#2)
// _SafeStr_4305 = "_-0qO" (String#16066, DoABC#2)
// _SafeStr_4306 = "_-1Y7" (String#17819, DoABC#2)
// _SafeStr_8656 = "_-sO" (String#24376, DoABC#2)
// _tabs = "_-0QO" (String#585, DoABC#2)
// onFrontPage = "_-1cm" (String#18001, DoABC#2)
// clearSelected = "_-0C5" (String#14531, DoABC#2)


