
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;

    public class RoomsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_6615:IDropMenuWindow;

        public function RoomsTabPageDecorator(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:String = "rooms_header";
            var _local_3:IWindowContainer = (_arg_1.getChildByName(_local_2) as IWindowContainer);
            if (this._SafeStr_6615 == null){
                this._SafeStr_6615 = IDropMenuWindow(_local_3.findChildByName("roomCtgFilter"));
                this.prepareRoomCategories();
                this._SafeStr_6615.addEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
            };
            _local_3.visible = true;
        }
        public function tabSelected():void
        {
            if (this._SafeStr_6615 != null){
                this._SafeStr_6615.removeEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
                this._SafeStr_6615.selection = 0;
                this._SafeStr_6615.addEventListener(WindowEvent.WE_SELECTED, this.onFilterSelected);
            };
        }
        public function refreshFooter(_arg_1:IWindowContainer):void
        {
            this._navigator.officialRoomEntryManager.refreshAdFooter(_arg_1);
        }
        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }
        public function prepareRoomCategories():void
        {
            var _local_3:FlatCategory;
            if (this._SafeStr_6615 == null){
                return;
            };
            var _local_1:Array = new Array();
            _local_1.push(this._navigator.getText("navigator.navisel.popularrooms"));
            _local_1.push(this._navigator.getText("navigator.navisel.highestscore"));
            var _local_2:int = 100;
            for each (_local_3 in this._navigator.data.visibleCategories) {
                _local_1.push(_local_3.nodeName);
            };
            this._SafeStr_6615.populate(_local_1);
            this._SafeStr_6615.selection = 0;
        }
        private function onFilterSelected(_arg_1:WindowEvent):void
        {
            this.startSearch();
        }
        private function startSearch():void
        {
            var _local_2:FlatCategory;
            var _local_3:int;
            var _local_1:int = (((this._SafeStr_6615 == null)) ? 0 : this._SafeStr_6615.selection);
            Logger.log(("Room filter changed: " + _local_1));
            if (_local_1 == 0){
                this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4288, Tabs._SafeStr_4303);
            }
            else {
                if (_local_1 == 1){
                    this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4288, Tabs._SafeStr_4305);
                }
                else {
                    _local_2 = this._navigator.data.visibleCategories[(_local_1 - 2)];
                    if (_local_2 == null){
                        Logger.log(((("No fc found: " + _local_1) + ", ") + this._navigator.data.visibleCategories.length));
                        return;
                    };
                    _local_3 = _local_2.nodeId;
                    Logger.log(("Searching with catId: " + _local_3));
                    this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4288, Tabs._SafeStr_4303, ("" + _local_3));
                };
            };
            if (this._SafeStr_6615){
                this._navigator.trackNavigationDataPoint(this._SafeStr_6615.enumerateSelection()[this._SafeStr_6615.selection], "category.view");
            };
        }
        public function get filterCategory():String
        {
            return (((this._SafeStr_6615) ? this._SafeStr_6615.enumerateSelection()[this._SafeStr_6615.selection] : null));
        }

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// RoomsTabPageDecorator = "_-vM" (String#8791, DoABC#2)
// refreshAdFooter = "_-2qK" (String#21094, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// officialRoomEntryManager = "_-aX" (String#23654, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// _SafeStr_4288 = "_-1Ja" (String#17261, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// _SafeStr_4303 = "_-21q" (String#19083, DoABC#2)
// _SafeStr_4305 = "_-0qO" (String#16066, DoABC#2)
// nodeName = "_-2F3" (String#19606, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)
// _SafeStr_6615 = "_-3Aj" (String#915, DoABC#2)
// prepareRoomCategories = "_-1PU" (String#17488, DoABC#2)
// onFilterSelected = "_-yH" (String#2229, DoABC#2)
// visibleCategories = "_-15s" (String#16692, DoABC#2)
// trackNavigationDataPoint = "_-17A" (String#16741, DoABC#2)
// enumerateSelection = "_-2oo" (String#7052, DoABC#2)


