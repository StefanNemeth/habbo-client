
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.navigator.domain.Tabs;

    public class TextSearchInputs 
    {

        private var _navigator:HabboNavigator;
        private var _searchStr:TextFieldManager;

        public function TextSearchInputs(_arg_1:HabboNavigator, _arg_2:IWindowContainer)
        {
            this._navigator = _arg_1;
            var _local_3:ITextFieldWindow = ITextFieldWindow(_arg_2.findChildByName("search_str"));
            this._searchStr = new TextFieldManager(this._navigator, _local_3, 35, this.searchRooms, this._navigator.getText("navigator.search.info"));
            Util.setProc(_arg_2, "search_but", this.onSearchButtonClick);
        }
        public function dispose():void
        {
            if (this._searchStr){
                this._searchStr.dispose();
                this._searchStr = null;
            };
            this._navigator = null;
        }
        private function onSearchButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.searchRooms();
        }
        private function searchRooms():void
        {
            var _local_1:String = this._searchStr.getText();
            if (_local_1 == ""){
                return;
            };
            this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4151, Tabs._SafeStr_4306, _local_1);
            this._navigator.trackNavigationDataPoint("Search", "search", _local_1);
        }
        public function get searchStr():TextFieldManager
        {
            return (this._searchStr);
        }

    }
}//package com.sulake.habbo.navigator

// _searchStr = "_-2FL" (String#6350, DoABC#2)
// onSearchButtonClick = "_-0Hj" (String#3912, DoABC#2)
// setProc = "_-333" (String#1990, DoABC#2)
// searchRooms = "_-3BB" (String#21932, DoABC#2)
// searchStr = "_-2Th" (String#20188, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// TextSearchInputs = "_-22k" (String#6101, DoABC#2)
// TextFieldManager = "_-Em" (String#7966, DoABC#2)
// _SafeStr_4151 = "_-5z" (String#22464, DoABC#2)
// _SafeStr_4306 = "_-1Y7" (String#17819, DoABC#2)
// trackNavigationDataPoint = "_-17A" (String#16741, DoABC#2)


