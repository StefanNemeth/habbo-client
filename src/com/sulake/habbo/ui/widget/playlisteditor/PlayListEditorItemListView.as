
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.sound.ISongInfo;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class PlayListEditorItemListView 
    {

        private var _itemListWindow:IItemListWindow;
        private var _items:Array;
        private var _widget:PlayListEditorWidget;
        private var _SafeStr_6723:PlayListEditorItem;
        private var _selectedItemIndex:int = -1;
        private var _SafeStr_6743:int = -1;

        public function PlayListEditorItemListView(_arg_1:PlayListEditorWidget, _arg_2:IItemListWindow)
        {
            this._itemListWindow = _arg_2;
            this._widget = _arg_1;
            this._SafeStr_6723 = null;
        }
        public function get selectedItemIndex():int
        {
            return (this._selectedItemIndex);
        }
        public function destroy():void
        {
            if (this._itemListWindow == null){
                return;
            };
            this._itemListWindow.destroyListItems();
        }
        public function refresh(_arg_1:Array, _arg_2:int):void
        {
            var _local_3:ISongInfo;
            var _local_4:String;
            var _local_5:String;
            var _local_6:ColorTransform;
            var _local_7:PlayListEditorItem;
            if (this._itemListWindow == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            this._SafeStr_6743 = -1;
            this._items = new Array();
            this._itemListWindow.destroyListItems();
            for each (_local_3 in _arg_1) {
                _local_4 = _local_3.name;
                _local_5 = _local_3.creator;
                _local_6 = this._widget.getDiskColorTransformFromSongData(_local_3.songData);
                _local_7 = new PlayListEditorItem(this._widget, _local_4, _local_5, _local_6);
                _local_7.window.procedure = this.itemEventProc;
                _local_7.removeButton.procedure = this.itemEventProc;
                this._itemListWindow.addListItem(_local_7.window);
                this._items.push(_local_7);
            };
            this.setItemIndexPlaying(_arg_2);
        }
        public function setItemIndexPlaying(_arg_1:int):void
        {
            var _local_2:PlayListEditorItem;
            var _local_3:PlayListEditorItem;
            if (this._items == null){
                return;
            };
            if (_arg_1 < 0){
                for each (_local_3 in this._items) {
                    _local_3.setIconState(PlayListEditorItem.PLEI_ICON_STATE_NORMAL);
                };
                return;
            };
            if (_arg_1 >= this._items.length){
                return;
            };
            if ((((this._SafeStr_6743 >= 0)) && ((this._SafeStr_6743 < this._items.length)))){
                _local_2 = (this._items[this._SafeStr_6743] as PlayListEditorItem);
                _local_2.setIconState(PlayListEditorItem.PLEI_ICON_STATE_NORMAL);
            };
            _local_2 = (this._items[_arg_1] as PlayListEditorItem);
            _local_2.setIconState(PlayListEditorItem.PLEI_ICON_STATE_PLAYING);
            this._SafeStr_6743 = _arg_1;
        }
        public function deselectAny():void
        {
            if (this._SafeStr_6723 != null){
                this._SafeStr_6723.deselect();
                this._SafeStr_6723 = null;
                this._selectedItemIndex = -1;
            };
        }
        private function itemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_3 = (_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK);
            if ((((_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)) || (_local_3))){
                if ((((_arg_2.name == "button_remove_from_playlist")) || (_local_3))){
                    if (this._SafeStr_6723 != null){
                        this._SafeStr_6723.deselect();
                    };
                    if (this._selectedItemIndex > -1){
                        this._widget.sendRemoveFromPlayListMessage(this._selectedItemIndex);
                    };
                    this._SafeStr_6723 = null;
                    this._selectedItemIndex = -1;
                }
                else {
                    if (this._SafeStr_6723 != null){
                        this._SafeStr_6723.deselect();
                    };
                    _local_4 = this._itemListWindow.getListItemIndex(_arg_1.window);
                    if (_local_4 != -1){
                        this._selectedItemIndex = _local_4;
                        this._SafeStr_6723 = this._items[_local_4];
                        this._SafeStr_6723.select();
                        if (_arg_2.name == "button_remove_from_playlist"){
                            this._widget.sendRemoveFromPlayListMessage(_local_4);
                        };
                        if (this._widget.mainWindowHandler != null){
                            this._widget.mainWindowHandler.musicInventoryView.deselectAny();
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// PlayListEditorItemListView = "_-0tv" (String#4722, DoABC#2)
// PlayListEditorItem = "_-01c" (String#3594, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// destroyListItems = "_-0xF" (String#4796, DoABC#2)
// getListItemIndex = "_-6Q" (String#7792, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// mainWindowHandler = "_-2Er" (String#19599, DoABC#2)
// getDiskColorTransformFromSongData = "_-26W" (String#19272, DoABC#2)
// sendRemoveFromPlayListMessage = "_-1Aq" (String#16896, DoABC#2)
// selectedItemIndex = "_-2QA" (String#20052, DoABC#2)
// musicInventoryView = "_-Il" (String#22957, DoABC#2)
// setItemIndexPlaying = "_-BC" (String#22662, DoABC#2)
// _SafeStr_6723 = "_-0NS" (String#4030, DoABC#2)
// deselectAny = "_-21Y" (String#19075, DoABC#2)
// deselect = "_-05I" (String#3671, DoABC#2)
// _selectedItemIndex = "_-1b6" (String#17939, DoABC#2)
// _SafeStr_6743 = "_-1Zt" (String#17886, DoABC#2)
// itemEventProc = "_-2KN" (String#6453, DoABC#2)
// removeButton = "_-3Fh" (String#22105, DoABC#2)
// setIconState = "_-so" (String#24393, DoABC#2)
// PLEI_ICON_STATE_NORMAL = "_-0xa" (String#16336, DoABC#2)
// PLEI_ICON_STATE_PLAYING = "_-0K7" (String#14848, DoABC#2)


