
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;

    public class MainWindowHandler 
    {

        private static const _SafeStr_6675:int = 6;
        private static const _SafeStr_6676:int = 9;
        private static const _SafeStr_6677:int = 5;

        private var _widget:PlayListEditorWidget;
        private var _musicController:IHabboMusicController;
        private var _mainWindow:IWindowContainer;
        private var _SafeStr_6679:IBorderWindow;
        private var _SafeStr_6680:IBorderWindow;
        private var _musicInventoryView:MusicInventoryGridView;
        private var _playListEditorView:PlayListEditorItemListView;
        private var _SafeStr_6683:MusicInventoryStatusView;
        private var _SafeStr_6684:PlayListStatusView;
        private var _SafeStr_6685:IScrollbarWindow;
        private var _SafeStr_6686:IScrollbarWindow;

        public function MainWindowHandler(_arg_1:PlayListEditorWidget, _arg_2:IHabboMusicController)
        {
            var _local_4:String;
            var _local_5:BitmapData;
            super();
            this._widget = _arg_1;
            this._musicController = _arg_2;
            var _local_3:Array = [PlayListEditorWidgetAssetsEnum._SafeStr_6687, PlayListEditorWidgetAssetsEnum._SafeStr_6688, PlayListEditorWidgetAssetsEnum._SafeStr_6689, PlayListEditorWidgetAssetsEnum._SafeStr_6690, PlayListEditorWidgetAssetsEnum._SafeStr_6691];
            for each (_local_4 in _local_3) {
                _local_5 = this._widget.getImageGalleryAssetBitmap(_local_4);
                if (_local_5 != null){
                    _local_5.dispose();
                }
                else {
                    this._widget.retrieveWidgetImage(_local_4);
                };
            };
            this.createWindow();
            this._musicInventoryView = new MusicInventoryGridView(_arg_1, this.getMusicInventoryGrid(), _arg_2);
            this._playListEditorView = new PlayListEditorItemListView(_arg_1, this.getPlayListEditorItemList());
            this._SafeStr_6683 = new MusicInventoryStatusView(_arg_1, this.getMusicInventoryStatusContainer());
            this._SafeStr_6684 = new PlayListStatusView(_arg_1, this.getPlayListStatusContainer());
            this.refreshLoadableAsset();
        }
        public function get window():IWindow
        {
            return (this._mainWindow);
        }
        public function get musicInventoryView():MusicInventoryGridView
        {
            return (this._musicInventoryView);
        }
        public function get playListEditorView():PlayListEditorItemListView
        {
            return (this._playListEditorView);
        }
        public function destroy():void
        {
            if (this._musicController){
                this._musicController.stop(HabboMusicPrioritiesEnum._SafeStr_6662);
                this._musicController = null;
            };
            if (this._musicInventoryView){
                this._musicInventoryView.destroy();
                this._musicInventoryView = null;
            };
            if (this._playListEditorView){
                this._playListEditorView.destroy();
                this._playListEditorView = null;
            };
            if (this._SafeStr_6684){
                this._SafeStr_6684.destroy();
                this._SafeStr_6684 = null;
            };
            if (this._SafeStr_6683){
                this._SafeStr_6683.destroy();
                this._SafeStr_6683 = null;
            };
            this._mainWindow.destroy();
            this._mainWindow = null;
        }
        public function hide():void
        {
            this._mainWindow.visible = false;
            if (this._widget != null){
                this._widget.stopUserSong();
            };
        }
        public function show():void
        {
            this._musicController.requestUserSongDisks();
            var _local_1:IPlayListController = this._musicController.getRoomItemPlaylist();
            if (_local_1 != null){
                _local_1.requestPlayList();
                this.selectPlayListStatusViewByFurniPlayListState();
            };
            this._mainWindow.visible = true;
        }
        public function refreshLoadableAsset(_arg_1:String=""):void
        {
            if ((((_arg_1 == "")) || ((_arg_1 == PlayListEditorWidgetAssetsEnum._SafeStr_6687)))){
                this.assignWindowBitmapByAsset(this._SafeStr_6679, "music_inventory_splash_image", PlayListEditorWidgetAssetsEnum._SafeStr_6687);
            };
            if ((((_arg_1 == "")) || ((_arg_1 == PlayListEditorWidgetAssetsEnum._SafeStr_6688)))){
                this.assignWindowBitmapByAsset(this._SafeStr_6680, "playlist_editor_splash_image", PlayListEditorWidgetAssetsEnum._SafeStr_6688);
            };
            if ((((_arg_1 == "")) || ((_arg_1 == PlayListEditorWidgetAssetsEnum._SafeStr_6689)))){
                this._SafeStr_6683.setPreviewPlayingBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum._SafeStr_6689));
            };
            if ((((_arg_1 == "")) || ((_arg_1 == PlayListEditorWidgetAssetsEnum._SafeStr_6690)))){
                this._SafeStr_6683.setGetMoreMusicBackgroundImage(this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum._SafeStr_6690));
            };
            if ((((_arg_1 == "")) || ((_arg_1 == PlayListEditorWidgetAssetsEnum._SafeStr_6691)))){
                this._SafeStr_6684.addSongsBackgroundImage = this._widget.getImageGalleryAssetBitmap(PlayListEditorWidgetAssetsEnum._SafeStr_6691);
            };
        }
        private function assignWindowBitmapByAsset(_arg_1:IWindowContainer, _arg_2:String, _arg_3:String):void
        {
            var _local_5:BitmapData;
            var _local_4:IBitmapWrapperWindow = (_arg_1.getChildByName(_arg_2) as IBitmapWrapperWindow);
            if (_local_4 != null){
                _local_5 = this._widget.getImageGalleryAssetBitmap(_arg_3);
                if (_local_5 != null){
                    _local_4.bitmap = _local_5;
                    _local_4.width = _local_5.width;
                    _local_4.height = _local_5.height;
                };
            };
        }
        private function createWindow():void
        {
            if (this._widget == null){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("playlisteditor_main_window") as XmlAsset);
            Logger.log(("Show window: " + _local_1));
            this._mainWindow = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IWindowContainer);
            if (this._mainWindow == null){
                throw (new Error("Failed to construct window from XML!"));
            };
            this._mainWindow.position = new Point(80, 0);
            var _local_2:IWindowContainer = (this._mainWindow.getChildByName("content_area") as IWindowContainer);
            if (_local_2 == null){
                throw (new Error("Window is missing 'content_area' element"));
            };
            this._SafeStr_6679 = (_local_2.getChildByName("my_music_border") as IBorderWindow);
            this._SafeStr_6680 = (_local_2.getChildByName("playlist_border") as IBorderWindow);
            if (this._SafeStr_6679 == null){
                throw (new Error("Window content area is missing 'my_music_border' window element"));
            };
            if (this._SafeStr_6680 == null){
                throw (new Error("Window content area is missing 'playlist_border' window element"));
            };
            this._SafeStr_6685 = (this._SafeStr_6679.getChildByName("music_inventory_scrollbar") as IScrollbarWindow);
            this._SafeStr_6686 = (this._SafeStr_6680.getChildByName("playlist_scrollbar") as IScrollbarWindow);
            if (this._SafeStr_6685 == null){
                throw (new Error("Window content area is missing 'music_inventory_scrollbar' window element"));
            };
            if (this._SafeStr_6686 == null){
                throw (new Error("Window content area is missing 'playlist_scrollbar' window element"));
            };
            var _local_3:IWindow = this._mainWindow.findChildByTag("close");
            if (_local_3 != null){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
        }
        private function getMusicInventoryGrid():IItemGridWindow
        {
            return ((this._SafeStr_6679.getChildByName("music_inventory_itemgrid") as IItemGridWindow));
        }
        private function getPlayListEditorItemList():IItemListWindow
        {
            return ((this._SafeStr_6680.getChildByName("playlist_editor_itemlist") as IItemListWindow));
        }
        private function getMusicInventoryStatusContainer():IWindowContainer
        {
            return ((this._SafeStr_6679.getChildByName("preview_play_container") as IWindowContainer));
        }
        private function getPlayListStatusContainer():IWindowContainer
        {
            return ((this._SafeStr_6680.getChildByName("now_playing_container") as IWindowContainer));
        }
        private function selectPlayListStatusViewByFurniPlayListState():void
        {
            var _local_1:IPlayListController = this._musicController.getRoomItemPlaylist();
            if (_local_1 == null){
                return;
            };
            if (_local_1.isPlaying){
                this._SafeStr_6684.selectView(PlayListStatusView.PLSV_NOW_PLAYING);
            }
            else {
                if (_local_1.length > 0){
                    this._SafeStr_6684.selectView(PlayListStatusView.PLSV_START_PLAYBACK);
                }
                else {
                    this._SafeStr_6684.selectView(PlayListStatusView.PLSV_ADD_SONGS);
                };
            };
        }
        private function selectMusicStatusViewByMusicState():void
        {
            if (this.isPreviewPlaying()){
                this._SafeStr_6683.show();
                this._SafeStr_6683.selectView(MusicInventoryStatusView.MISV_PREVIEW_PLAYING);
            }
            else {
                if (this._musicController.getSongDiskInventorySize() <= _SafeStr_6675){
                    this._SafeStr_6683.show();
                    this._SafeStr_6683.selectView(MusicInventoryStatusView.MISV_BUY_MORE);
                }
                else {
                    this._SafeStr_6683.hide();
                };
            };
        }
        private function updatePlaylistEditorView():void
        {
            var _local_4:int;
            var _local_5:ISongInfo;
            var _local_1:IPlayListController = this._musicController.getRoomItemPlaylist();
            var _local_2:Array = [];
            var _local_3:int = -1;
            if (_local_1 != null){
                _local_4 = 0;
                while (_local_4 < _local_1.length) {
                    _local_5 = _local_1.getEntry(_local_4);
                    if (_local_5 != null){
                        _local_2.push(_local_5);
                    };
                    _local_4++;
                };
                _local_3 = _local_1.playPosition;
            };
            this._playListEditorView.refresh(_local_2, _local_3);
        }
        public function onPlayListUpdated():void
        {
            var _local_3:ISongInfo;
            this.updatePlaylistEditorView();
            this.selectPlayListStatusViewByFurniPlayListState();
            var _local_1:IPlayListController = this._musicController.getRoomItemPlaylist();
            if (_local_1 == null){
                return;
            };
            var _local_2:int = _local_1.nowPlayingSongId;
            if (_local_2 != -1){
                _local_3 = this._musicController.getSongInfo(_local_2);
                this._SafeStr_6684.nowPlayingTrackName = _local_3.name;
                this._SafeStr_6684.nowPlayingAuthorName = _local_3.creator;
            };
            this._SafeStr_6686.visible = (_local_1.length > _SafeStr_6677);
        }
        public function onSongDiskInventoryReceived():void
        {
            this._musicInventoryView.refresh();
            this.selectMusicStatusViewByMusicState();
            this._SafeStr_6685.visible = (this._musicInventoryView.itemCount > _SafeStr_6676);
        }
        public function onNowPlayingChanged(_arg_1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            var _local_2:ISongInfo;
            var _local_3:ISongInfo;
            switch (_arg_1.type){
                case RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_SONG_CHANGED:
                    this.selectPlayListStatusViewByFurniPlayListState();
                    this._playListEditorView.setItemIndexPlaying(_arg_1.position);
                    if (_arg_1.id != -1){
                        _local_3 = this._musicController.getSongInfo(_arg_1.id);
                        this._SafeStr_6684.nowPlayingTrackName = (((_local_3)!=null) ? _local_3.name : "");
                        this._SafeStr_6684.nowPlayingAuthorName = (((_local_3)!=null) ? _local_3.creator : "");
                    };
                    return;
                case RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_USER_PLAY_SONG:
                    this._musicInventoryView.setPreviewIconToPause();
                    _local_2 = this._musicController.getSongInfo(_arg_1.id);
                    this._SafeStr_6683.songName = (((_local_2)!=null) ? _local_2.name : "");
                    this._SafeStr_6683.songName = (((_local_2)!=null) ? _local_2.name : "");
                    this._SafeStr_6683.authorName = (((_local_2)!=null) ? _local_2.creator : "");
                    this.selectMusicStatusViewByMusicState();
                    return;
                case RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPW_USER_STOP_SONG:
                    this._musicInventoryView.setPreviewIconToPlay();
                    this.selectMusicStatusViewByMusicState();
                    return;
            };
        }
        private function onClose(_arg_1:WindowMouseEvent):void
        {
            this.hide();
        }
        private function isPreviewPlaying():Boolean
        {
            return (!((this._musicController.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum._SafeStr_6662) == -1)));
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// RoomWidgetPlayListEditorNowPlayingEvent = "_-2Fn" (String#6359, DoABC#2)
// MainWindowHandler = "_-2SI" (String#6615, DoABC#2)
// MusicInventoryGridView = "_-130" (String#4934, DoABC#2)
// PlayListStatusView = "_-1Nn" (String#5307, DoABC#2)
// PlayListEditorItemListView = "_-0tv" (String#4722, DoABC#2)
// PlayListEditorWidgetAssetsEnum = "_-0jk" (String#4497, DoABC#2)
// _mainWindow = "_-1P" (String#361, DoABC#2)
// getEntry = "_-ig" (String#2166, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
// RWPLENPE_USER_PLAY_SONG = "_-36w" (String#21763, DoABC#2)
// RWPLENPW_USER_STOP_SONG = "_-0Kk" (String#14870, DoABC#2)
// getRoomItemPlaylist = "_-2Su" (String#6624, DoABC#2)
// playListEditorView = "_-0yt" (String#16387, DoABC#2)
// getSongIdPlayingAtPriority = "_-u5" (String#8768, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// _SafeStr_6662 = "_-jj" (String#24024, DoABC#2)
// stopUserSong = "_-0qi" (String#16075, DoABC#2)
// getImageGalleryAssetBitmap = "_-0PQ" (String#15039, DoABC#2)
// retrieveWidgetImage = "_-2qW" (String#21104, DoABC#2)
// requestUserSongDisks = "_-1qp" (String#5871, DoABC#2)
// requestPlayList = "_-0Vy" (String#817, DoABC#2)
// refreshLoadableAsset = "_-1AG" (String#16870, DoABC#2)
// onSongDiskInventoryReceived = "_-2sW" (String#21180, DoABC#2)
// onPlayListUpdated = "_-eS" (String#23820, DoABC#2)
// onNowPlayingChanged = "_-17C" (String#5020, DoABC#2)
// _SafeStr_6675 = "_-0s4" (String#16126, DoABC#2)
// _SafeStr_6676 = "_-01R" (String#14108, DoABC#2)
// _SafeStr_6677 = "_-2Gr" (String#19676, DoABC#2)
// _musicController = "_-3Bw" (String#458, DoABC#2)
// _SafeStr_6679 = "_-0-W" (String#14032, DoABC#2)
// _SafeStr_6680 = "_-0eb" (String#15609, DoABC#2)
// _musicInventoryView = "_-1pM" (String#18517, DoABC#2)
// _playListEditorView = "_-0aJ" (String#15450, DoABC#2)
// _SafeStr_6683 = "_-0dr" (String#15579, DoABC#2)
// _SafeStr_6684 = "_-08-" (String#14366, DoABC#2)
// _SafeStr_6685 = "_-cF" (String#23725, DoABC#2)
// _SafeStr_6686 = "_-3FJ" (String#22089, DoABC#2)
// _SafeStr_6687 = "_-2uP" (String#21257, DoABC#2)
// _SafeStr_6688 = "_-OY" (String#23189, DoABC#2)
// _SafeStr_6689 = "_-1Bz" (String#16940, DoABC#2)
// _SafeStr_6690 = "_-1DW" (String#17003, DoABC#2)
// _SafeStr_6691 = "_-153" (String#16656, DoABC#2)
// getMusicInventoryGrid = "_-1st" (String#18672, DoABC#2)
// getPlayListEditorItemList = "_-1cO" (String#17986, DoABC#2)
// getMusicInventoryStatusContainer = "_-31Y" (String#21561, DoABC#2)
// getPlayListStatusContainer = "_-6d" (String#22486, DoABC#2)
// musicInventoryView = "_-Il" (String#22957, DoABC#2)
// selectPlayListStatusViewByFurniPlayListState = "_-r8" (String#24320, DoABC#2)
// assignWindowBitmapByAsset = "_-2WG" (String#20294, DoABC#2)
// setPreviewPlayingBackgroundImage = "_-2kT" (String#20863, DoABC#2)
// setGetMoreMusicBackgroundImage = "_-2ww" (String#21345, DoABC#2)
// addSongsBackgroundImage = "_-2Md" (String#19913, DoABC#2)
// isPlaying = "_-2gK" (String#6876, DoABC#2)
// selectView = "_-1-8" (String#1597, DoABC#2)
// PLSV_NOW_PLAYING = "_-2v5" (String#21282, DoABC#2)
// PLSV_START_PLAYBACK = "_-6p" (String#22492, DoABC#2)
// PLSV_ADD_SONGS = "_-0kO" (String#15845, DoABC#2)
// selectMusicStatusViewByMusicState = "_-1Yc" (String#17835, DoABC#2)
// isPreviewPlaying = "_-1ia" (String#18231, DoABC#2)
// MISV_PREVIEW_PLAYING = "_-1fR" (String#18115, DoABC#2)
// getSongDiskInventorySize = "_-3Lf" (String#7732, DoABC#2)
// MISV_BUY_MORE = "_-1sd" (String#18660, DoABC#2)
// updatePlaylistEditorView = "_-2vQ" (String#21294, DoABC#2)
// playPosition = "_-3Ip" (String#7686, DoABC#2)
// nowPlayingSongId = "_-2A0" (String#6248, DoABC#2)
// nowPlayingTrackName = "_-2VF" (String#6669, DoABC#2)
// nowPlayingAuthorName = "_-2zC" (String#7269, DoABC#2)
// setItemIndexPlaying = "_-BC" (String#22662, DoABC#2)
// setPreviewIconToPause = "_-ni" (String#24180, DoABC#2)
// songName = "_-uT" (String#24469, DoABC#2)
// authorName = "_-1Y5" (String#5522, DoABC#2)
// setPreviewIconToPlay = "_-2bN" (String#20501, DoABC#2)


