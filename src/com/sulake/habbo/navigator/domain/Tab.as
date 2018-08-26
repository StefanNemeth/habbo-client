
package com.sulake.habbo.navigator.domain
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.ITabButtonWindow;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;

    public class Tab 
    {

        private var _navigator:HabboNavigator;
        private var _id:int;
        private var _defaultSearchType:int;
        private var _button:ITabButtonWindow;
        private var _tabPageDecorator:ITabPageDecorator;
        private var _selected:Boolean;
        private var _searchMsg:int;

        public function Tab(_arg_1:HabboNavigator, _arg_2:int, _arg_3:int, _arg_4:ITabPageDecorator, _arg_5:int=1)
        {
            this._navigator = _arg_1;
            this._id = _arg_2;
            this._defaultSearchType = _arg_3;
            this._tabPageDecorator = _arg_4;
            this._searchMsg = _arg_5;
        }
        public function sendSearchRequest():void
        {
            this._navigator.mainViewCtrl.startSearch(this._id, this._defaultSearchType, "-1", this._searchMsg);
        }
        public function set selected(_arg_1:Boolean):void
        {
            this._selected = _arg_1;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get defaultSearchType():int
        {
            return (this._defaultSearchType);
        }
        public function get selected():Boolean
        {
            return (this._selected);
        }
        public function get tabPageDecorator():ITabPageDecorator
        {
            return (this._tabPageDecorator);
        }
        public function get searchMsg():int
        {
            return (this._searchMsg);
        }
        public function get button():ITabButtonWindow
        {
            return (this._button);
        }
        public function set button(_arg_1:ITabButtonWindow):void
        {
            this._button = _arg_1;
        }

    }
}//package com.sulake.habbo.navigator.domain

// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// Tab = "_-Cd" (String#930, DoABC#2)
// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// tabPageDecorator = "_-09G" (String#14418, DoABC#2)
// sendSearchRequest = "_-27J" (String#19305, DoABC#2)
// _tabPageDecorator = "_-1fZ" (String#18120, DoABC#2)
// _searchMsg = "_-2mg" (String#20947, DoABC#2)
// defaultSearchType = "_-1D2" (String#16984, DoABC#2)
// searchMsg = "_-1-B" (String#16436, DoABC#2)


