
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomEntryData;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.*;

    public class OfficialRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _content:IItemListWindow;

        public function OfficialRoomListCtrl(_arg_1:HabboNavigator):void
        {
            this._navigator = _arg_1;
        }
        public function dispose():void
        {
        }
        public function set content(_arg_1:IWindowContainer):void
        {
            this._content = _arg_1;
            this._content = IItemListWindow(this._content.findChildByName("item_list_official"));
        }
        public function get content():IWindowContainer
        {
            return (this._content);
        }
        public function refresh():void
        {
            var _local_3:Boolean;
            var _local_1:Array = this.getVisibleEntries();
            this._content.autoArrangeItems = false;
            var _local_2:int;
            while (true) {
                if (_local_2 < _local_1.length){
                    this.refreshEntry(true, _local_2, _local_1[_local_2]);
                }
                else {
                    _local_3 = this.refreshEntry(false, _local_2, null);
                    if (_local_3) break;
                };
                _local_2++;
            };
            this._content.autoArrangeItems = true;
        }
        private function getVisibleEntries():Array
        {
            var _local_4:OfficialRoomEntryData;
            var _local_1:Array = this._navigator.data.officialRooms.entries;
            var _local_2:Array = new Array();
            var _local_3:int;
            for each (_local_4 in _local_1) {
                if (_local_4.folderId > 0){
                    if (_local_4.folderId == _local_3){
                        _local_2.push(_local_4);
                    };
                }
                else {
                    _local_3 = ((_local_4.open) ? _local_4.index : 0);
                    _local_2.push(_local_4);
                };
            };
            return (_local_2);
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:OfficialRoomEntryData):Boolean
        {
            var _local_4:IWindowContainer = IWindowContainer(this._content.getListItemAt(_arg_2));
            var _local_5:Boolean;
            if (_local_4 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_4 = this._navigator.officialRoomEntryManager.OfficialRoomEntryManager(_arg_2);
                this._content.addListItem(_local_4);
                _local_5 = true;
            };
            this._navigator.officialRoomEntryManager.refreshEntry(_local_4, _arg_1, _arg_2, _arg_3);
            return (false);
        }

    }
}//package com.sulake.habbo.navigator.mainview

// IViewCtrl = "_-D9" (String#7935, DoABC#2)
// OfficialRoomListCtrl = "_-0ZB" (String#4283, DoABC#2)
// OfficialRoomEntryData = "_-0vy" (String#4767, DoABC#2)
// OfficialRoomEntryManager = "_-1v" (String#18754, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// officialRooms = "_-f3" (String#23847, DoABC#2)
// entries = "_-1eU" (String#18076, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// getVisibleEntries = "_-1X2" (String#17778, DoABC#2)
// folderId = "_-1uf" (String#18744, DoABC#2)
// officialRoomEntryManager = "_-aX" (String#23654, DoABC#2)


