
package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.enum.*;

    public class EventsTabPageDecorator implements ITabPageDecorator 
    {

        private var _navigator:HabboNavigator;
        private var _SafeStr_6615:IDropMenuWindow;

        public function EventsTabPageDecorator(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function refreshCustomContent(_arg_1:IWindowContainer):void
        {
            var _local_2:String = "events_header";
            var _local_3:IWindowContainer = (_arg_1.getChildByName(_local_2) as IWindowContainer);
            if (this._SafeStr_6615 == null){
                this._SafeStr_6615 = IDropMenuWindow(_local_3.findChildByName("eventCtgFilter"));
                this.RoomEventViewCtrl();
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
            this._navigator.officialRoomEntryManager.OfficialRoomEntryManager(_arg_1);
        }
        public function navigatorOpenedWhileInTab():void
        {
            this.startSearch();
        }
        private function RoomEventViewCtrl():void
        {
            var _local_4:String;
            var _local_5:String;
            if (this._SafeStr_6615 == null){
                return;
            };
            var _local_1:Array = new Array();
            _local_1.push(this._navigator.getText("navigator.navisel.alllatestevents"));
            var _local_2:int = 100;
            var _local_3:int = 1;
            while (_local_3 < _local_2) {
                _local_4 = ("roomevent_type_" + _local_3);
                _local_5 = this._navigator.getText(_local_4);
                if ((((_local_5 == null)) || ((_local_5 == _local_4)))) break;
                _local_1.push(_local_5);
                _local_3++;
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
            var _local_1:int = (((this._SafeStr_6615 == null)) ? 0 : this._SafeStr_6615.selection);
            Logger.log(("Event filter changed: " + _local_1));
            this._navigator.mainViewCtrl.startSearch(Tabs._SafeStr_4285, Tabs._SafeStr_4297, (((_local_1 < 1)) ? "-1" : (_local_1 + "")));
        }
        public function get filterCategory():String
        {
            return (((this._SafeStr_6615) ? this._SafeStr_6615.IDropMenuWindow()[this._SafeStr_6615.selection] : null));
        }

    }
}//package com.sulake.habbo.navigator.mainview.tabpagedecorators

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// ITabPageDecorator = "_-0h3" (String#4447, DoABC#2)
// EventsTabPageDecorator = "_-11C" (String#4898, DoABC#2)
// OfficialRoomEntryManager = "_-2qK" (String#21094, DoABC#2)
// officialRoomEntryManager = "_-aX" (String#23654, DoABC#2)
// navigatorOpenedWhileInTab = "_-2IQ" (String#6410, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// refreshCustomContent = "_-1cv" (String#1724, DoABC#2)
// refreshFooter = "_-1IP" (String#1655, DoABC#2)
// _SafeStr_4285 = "_-20q" (String#19046, DoABC#2)
// tabSelected = "_-2T" (String#6625, DoABC#2)
// _SafeStr_4297 = "_-36W" (String#21748, DoABC#2)
// filterCategory = "_-1T1" (String#5414, DoABC#2)
// _SafeStr_6615 = "_-3Aj" (String#915, DoABC#2)
// onFilterSelected = "_-yH" (String#2229, DoABC#2)
// IDropMenuWindow = "_-2oo" (String#7052, DoABC#2)
// RoomEventViewCtrl = "_-0lu" (String#4546, DoABC#2)


