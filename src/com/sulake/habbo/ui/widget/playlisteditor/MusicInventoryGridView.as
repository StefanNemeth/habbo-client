
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.ISongInfo;
    import flash.geom.ColorTransform;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class MusicInventoryGridView 
    {

        private var _musicController:IHabboMusicController;
        private var _SafeStr_6722:IItemGridWindow;
        private var _items:Map;
        private var _widget:PlayListEditorWidget;
        private var _SafeStr_6723:MusicInventoryGridItem;

        public function MusicInventoryGridView(_arg_1:PlayListEditorWidget, _arg_2:IItemGridWindow, _arg_3:IHabboMusicController)
        {
            this._items = new Map();
            super();
            this._musicController = _arg_3;
            this._SafeStr_6722 = _arg_2;
            this._widget = _arg_1;
            this._SafeStr_6723 = null;
            this._musicController.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
        }
        public function get itemCount():int
        {
            return (this._items.length);
        }
        public function destroy():void
        {
            if (this._SafeStr_6722 != null){
                this._SafeStr_6722.destroyGridItems();
                this._SafeStr_6722 = null;
            };
            if (this._musicController != null){
                if (this._musicController.events != null){
                    this._musicController.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                };
                this._musicController = null;
            };
            if (this._items){
                this._items.reset();
                this._items = null;
            };
            this._SafeStr_6723 = null;
            this._widget = null;
        }
        public function refresh():void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:ISongInfo;
            var _local_10:String;
            var _local_11:ColorTransform;
            var _local_12:MusicInventoryGridItem;
            var _local_13:MusicInventoryGridItem;
            if (this._SafeStr_6722 == null){
                return;
            };
            this._SafeStr_6722.removeGridItems();
            var _local_1:Map = this._items;
            var _local_2:Map = new Map();
            var _local_3:Array = _local_1.getKeys();
            this._items = new Map();
            var _local_4:int = this._musicController.getSongDiskInventorySize();
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_7 = this._musicController.getSongDiskInventoryDiskId(_local_5);
                _local_8 = this._musicController.getSongDiskInventorySongId(_local_5);
                _local_9 = this._musicController.getSongInfo(_local_8);
                _local_10 = null;
                _local_11 = null;
                if (_local_9 != null){
                    _local_10 = _local_9.name;
                    _local_11 = this._widget.getDiskColorTransformFromSongData(_local_9.songData);
                };
                if (_local_3.indexOf(_local_7) == -1){
                    _local_12 = new MusicInventoryGridItem(this._widget, _local_7, _local_8, _local_10, _local_11);
                }
                else {
                    _local_12 = _local_1[_local_7];
                    _local_3.splice(_local_3.indexOf(_local_7), 1);
                };
                _local_12.window.procedure = this.gridItemEventProc;
                _local_12.toPlayListButton.procedure = this.gridItemEventProc;
                this._SafeStr_6722.addGridItem(_local_12.window);
                this._items.add(_local_7, _local_12);
                _local_5++;
            };
            for each (_local_6 in _local_3) {
                _local_13 = _local_1[_local_6];
                _local_13.destroy();
                _local_1.remove(_local_6);
            };
        }
        public function setPreviewIconToPause():void
        {
            if (this._SafeStr_6723 != null){
                this._SafeStr_6723.playButtonState = MusicInventoryGridItem._SafeStr_6731;
            };
        }
        public function setPreviewIconToPlay():void
        {
            if (this._SafeStr_6723 != null){
                this._SafeStr_6723.playButtonState = MusicInventoryGridItem._SafeStr_6732;
            };
        }
        public function deselectAny():void
        {
            if (this._SafeStr_6723 != null){
                this._SafeStr_6723.deselect();
                this._SafeStr_6723 = null;
            };
        }
        private function gridItemEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_5:MusicInventoryGridItem;
            var _local_3 = (_arg_1.type == WindowMouseEvent.WME_DOUBLE_CLICK);
            if ((((_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)) || (_local_3))){
                if ((((_arg_2.name == "button_to_playlist")) || (_local_3))){
                    if (this._SafeStr_6723 != null){
                        this._SafeStr_6723.deselect();
                        this.stopPreview();
                        this._widget.sendAddToPlayListMessage(this._SafeStr_6723.diskId);
                        this._SafeStr_6723 = null;
                    };
                }
                else {
                    if (_arg_2.name == "button_play_pause"){
                        if (this._SafeStr_6723.playButtonState == MusicInventoryGridItem._SafeStr_6732){
                            this._SafeStr_6723.playButtonState = MusicInventoryGridItem._SafeStr_6736;
                            this._widget.playUserSong(this._SafeStr_6723.songId);
                        }
                        else {
                            this.stopPreview();
                        };
                    }
                    else {
                        _local_4 = this._SafeStr_6722.getGridItemIndex(_arg_1.window);
                        if (_local_4 != -1){
                            _local_5 = this._items.getWithIndex(_local_4);
                            if (_local_5 != this._SafeStr_6723){
                                if (this._SafeStr_6723 != null){
                                    this._SafeStr_6723.deselect();
                                };
                                this._SafeStr_6723 = _local_5;
                                this._SafeStr_6723.select();
                                this.stopPreview();
                            };
                            if (this._widget.mainWindowHandler != null){
                                this._widget.mainWindowHandler.playListEditorView.deselectAny();
                            };
                        };
                    };
                };
            };
        }
        private function stopPreview():void
        {
            this._widget.stopUserSong();
            this.setPreviewIconToPlay();
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:ISongInfo;
            var _local_3:String;
            var _local_4:ColorTransform;
            var _local_5:MusicInventoryGridItem;
            if (this._musicController != null){
                _local_2 = this._musicController.getSongInfo(_arg_1.id);
                if (_local_2 != null){
                    _local_3 = _local_2.name;
                    _local_4 = this._widget.getDiskColorTransformFromSongData(_local_2.songData);
                    _local_5 = this._items[_arg_1.id];
                    if (_local_5 != null){
                        _local_5.update(_arg_1.id, _local_3, _local_4);
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// MusicInventoryGridView = "_-130" (String#4934, DoABC#2)
// MusicInventoryGridItem = "_-Xw" (String#8369, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// removeGridItems = "_-1Bp" (String#5106, DoABC#2)
// addGridItem = "_-2vh" (String#7192, DoABC#2)
// WME_DOUBLE_CLICK = "_-Y3" (String#23564, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// mainWindowHandler = "_-2Er" (String#19599, DoABC#2)
// getDiskColorTransformFromSongData = "_-26W" (String#19272, DoABC#2)
// sendAddToPlayListMessage = "_-3E2" (String#22035, DoABC#2)
// playListEditorView = "_-0yt" (String#16387, DoABC#2)
// playUserSong = "_-1Vo" (String#17734, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// stopUserSong = "_-0qi" (String#16075, DoABC#2)
// _musicController = "_-3Bw" (String#458, DoABC#2)
// getSongDiskInventorySize = "_-3Lf" (String#7732, DoABC#2)
// setPreviewIconToPause = "_-ni" (String#24180, DoABC#2)
// setPreviewIconToPlay = "_-2bN" (String#20501, DoABC#2)
// _SafeStr_6722 = "_-1eO" (String#18073, DoABC#2)
// _SafeStr_6723 = "_-0NS" (String#4030, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// getSongDiskInventoryDiskId = "_-1eT" (String#5637, DoABC#2)
// getSongDiskInventorySongId = "_-23l" (String#6118, DoABC#2)
// gridItemEventProc = "com.sulake.habbo.communication.messages.incoming.inventory.achievements-" (String#24649, DoABC#2)
// toPlayListButton = "_-Ig" (String#22953, DoABC#2)
// playButtonState = "_-2KU" (String#19821, DoABC#2)
// _SafeStr_6731 = "_-2I-" (String#19729, DoABC#2)
// _SafeStr_6732 = "_-0cw" (String#15547, DoABC#2)
// deselectAny = "_-21Y" (String#19075, DoABC#2)
// deselect = "_-05I" (String#3671, DoABC#2)
// stopPreview = "_-11f" (String#16523, DoABC#2)
// _SafeStr_6736 = "_-1q4" (String#18546, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)


