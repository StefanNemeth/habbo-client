
package com.sulake.habbo.ui.widget.playlisteditor
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
    import flash.events.IEventDispatcher;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.habbo.catalog.enum.CatalogPageName;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PlayListEditorWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_6625:int = 130;
        private static const _SafeStr_6626:int = 100;
        private static const _SafeStr_6627:int = 130;
        private static const _SafeStr_6628:int = 100;
        private static const _SafeStr_6629:int = 130;
        private static const _SafeStr_6630:int = 100;

        private var _catalog:IHabboCatalog;
        private var _configuration:IHabboConfigurationManager;
        private var _soundManager:IHabboSoundManager;
        private var _InventoryMainView:MainWindowHandler;
        private var _furniId:int;

        public function PlayListEditorWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IHabboSoundManager, _arg_4:IAssetLibrary, _arg_5:IHabboLocalizationManager, _arg_6:IHabboConfigurationManager, _arg_7:IHabboCatalog)
        {
            super(_arg_1, _arg_2, _arg_4, _arg_5);
            this._soundManager = _arg_3;
            this._configuration = _arg_6;
            this._catalog = _arg_7;
            this._InventoryMainView = null;
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._InventoryMainView){
                    this._InventoryMainView.destroy();
                    this._InventoryMainView = null;
                };
                this._soundManager = null;
                super.dispose();
            };
        }
        override public function get mainWindow():IWindow
        {
            if (this._InventoryMainView == null){
                return (null);
            };
            return (this._InventoryMainView.window);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_SHOW_PLAYLIST_EDITOR, this.onShowPlayListEditorEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_HIDE_PLAYLIST_EDITOR, this.onHidePlayListEditorEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_INVENTORY_UPDATED, this.onInventoryUpdatedEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_SONG_DISK_INVENTORY_UPDATED, this.onSongDiskInventoryUpdatedEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_UPDATED, this.onPlayListUpdatedEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_FULL, this.onPlayListFullEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_SONG_CHANGED, this.onNowPlayingChangedEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_USER_PLAY_SONG, this.onNowPlayingChangedEvent);
            _arg_1.addEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPW_USER_STOP_SONG, this.onNowPlayingChangedEvent);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_SHOW_PLAYLIST_EDITOR, this.onShowPlayListEditorEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_HIDE_PLAYLIST_EDITOR, this.onHidePlayListEditorEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_INVENTORY_UPDATED, this.onInventoryUpdatedEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_SONG_DISK_INVENTORY_UPDATED, this.onSongDiskInventoryUpdatedEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_UPDATED, this.onPlayListUpdatedEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_FULL, this.onPlayListFullEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_SONG_CHANGED, this.onNowPlayingChangedEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_USER_PLAY_SONG, this.onNowPlayingChangedEvent);
            _arg_1.removeEventListener(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPW_USER_STOP_SONG, this.onNowPlayingChangedEvent);
        }
        public function get mainWindowHandler():MainWindowHandler
        {
            return (this._InventoryMainView);
        }
        public function getDiskColorTransformFromSongData(_arg_1:String):ColorTransform
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:int;
            while (_local_5 < _arg_1.length) {
                switch ((_local_5 % 3)){
                    case 0:
                        _local_2 = (_local_2 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                        break;
                    case 1:
                        _local_3 = (_local_3 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                        break;
                    case 2:
                        _local_4 = (_local_4 + ((_arg_1.charCodeAt(_local_5) * 37) as int));
                        break;
                };
                _local_5++;
            };
            _local_2 = ((_local_2 % _SafeStr_6626) + _SafeStr_6625);
            _local_3 = ((_local_3 % _SafeStr_6628) + _SafeStr_6627);
            _local_4 = ((_local_4 % _SafeStr_6630) + _SafeStr_6629);
            return (new ColorTransform((_local_2 / 0xFF), (_local_3 / 0xFF), (_local_4 / 0xFF)));
        }
        public function sendAddToPlayListMessage(_arg_1:int):void
        {
            var _local_3:int;
            var _local_4:RoomWidgetPlayListModificationMessage;
            var _local_2:IPlayListController = this._soundManager.musicController.getRoomItemPlaylist();
            if (_local_2 != null){
                _local_3 = _local_2.length;
                _local_4 = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.RWPLAM_ADD_TO_PLAYLIST, _local_3, _arg_1);
                if (messageListener != null){
                    messageListener.processWidgetMessage(_local_4);
                };
            };
        }
        public function sendRemoveFromPlayListMessage(_arg_1:int):void
        {
            var _local_2:RoomWidgetPlayListModificationMessage = new RoomWidgetPlayListModificationMessage(RoomWidgetPlayListModificationMessage.RWPLAM_REMOVE_FROM_PLAYLIST, _arg_1);
            if (messageListener != null){
                messageListener.processWidgetMessage(_local_2);
            };
        }
        public function sendTogglePlayPauseStateMessage():void
        {
            var _local_1:int;
            if (((!((this._InventoryMainView == null))) && (!((this._InventoryMainView.playListEditorView == null))))){
                _local_1 = (((this._InventoryMainView.playListEditorView.selectedItemIndex)!=-1) ? this._InventoryMainView.playListEditorView.selectedItemIndex : 0);
            };
            var _local_2:RoomWidgetPlayListPlayStateMessage = new RoomWidgetPlayListPlayStateMessage(RoomWidgetPlayListPlayStateMessage.RWPLPS_TOGGLE_PLAY_PAUSE, this._furniId, _local_1);
            if (messageListener != null){
                messageListener.processWidgetMessage(_local_2);
            };
        }
        public function playUserSong(_arg_1:int):void
        {
            var _local_3:ISongInfo;
            var _local_2:int = this._soundManager.musicController.getSongIdPlayingAtPriority(HabboMusicPrioritiesEnum._SafeStr_6658);
            if (_local_2 != -1){
                _local_3 = this._soundManager.musicController.getSongInfo(_local_2);
                if (_local_3.soundObject != null){
                    _local_3.soundObject.fadeOutSeconds = 0;
                };
            };
            this._soundManager.musicController.playSong(_arg_1, HabboMusicPrioritiesEnum._SafeStr_6662, 0, 0, 0, 0);
        }
        public function stopUserSong():void
        {
            this._soundManager.musicController.stop(HabboMusicPrioritiesEnum._SafeStr_6662);
        }
        public function getImageGalleryAssetBitmap(_arg_1:String):BitmapData
        {
            var _local_3:BitmapData;
            var _local_2:BitmapDataAsset = (this.assets.getAssetByName(_arg_1) as BitmapDataAsset);
            if (_local_2 == null){
                return (null);
            };
            _local_3 = (_local_2.content as BitmapData);
            return (_local_3.clone());
        }
        public function retrieveWidgetImage(_arg_1:String):void
        {
            var _local_2:String = this._configuration.getKey("image.library.playlist.url");
            var _local_3 = ((_local_2 + _arg_1) + ".gif");
            Logger.log(("[PlayListEditorWidget]  : " + _local_3));
            var _local_4:URLRequest = new URLRequest(_local_3);
            var _local_5:AssetLoaderStruct = this.assets.loadAssetFromFile(_arg_1, _local_4, "image/gif");
            _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onWidgetImageReady);
        }
        public function openSongDiskShopCataloguePage():void
        {
            var _local_1:RoomWidgetPlayListUserActionMessage = new RoomWidgetPlayListUserActionMessage(RoomWidgetPlayListUserActionMessage.RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED);
            if (messageListener != null){
                messageListener.processWidgetMessage(_local_1);
            };
            this._catalog.openCatalogPage(CatalogPageName._SafeStr_6008, true);
        }
        public function alertPlayListFull():void
        {
            this.windowManager.alert(("$" + "{playlist.editor.alert.playlist.full.title}"), ("$" + "{playlist.editor.alert.playlist.full}"), 0, this.alertHandler);
        }
        private function alertHandler(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function onShowPlayListEditorEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            var _local_2:IPlayListController;
            this._furniId = _arg_1.furniId;
            if (!this._InventoryMainView){
                this._InventoryMainView = new MainWindowHandler(this, this._soundManager.musicController);
                this._InventoryMainView.window.visible = false;
            };
            if (!this._InventoryMainView.window.visible){
                this._InventoryMainView.show();
                this._soundManager.musicController.requestUserSongDisks();
                _local_2 = this._soundManager.musicController.getRoomItemPlaylist();
                if (_local_2 != null){
                    _local_2.IPlayListController();
                };
            };
        }
        private function onHidePlayListEditorEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (this._InventoryMainView != null){
                if (this._InventoryMainView.window.visible){
                    this._InventoryMainView.hide();
                };
            };
        }
        private function onInventoryUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (!this._InventoryMainView){
                return;
            };
            if (this._InventoryMainView.window.visible){
                this._soundManager.musicController.requestUserSongDisks();
            };
        }
        private function onWidgetImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                _local_2 = (_arg_1.target as AssetLoaderStruct);
                if (_local_2 != null){
                    if (this._InventoryMainView != null){
                        this._InventoryMainView.refreshLoadableAsset(_local_2.assetName);
                    };
                };
            };
        }
        private function onSongDiskInventoryUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (this._InventoryMainView){
                this._InventoryMainView.onSongDiskInventoryReceived();
            };
        }
        private function onPlayListUpdatedEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            if (this._InventoryMainView){
                this._InventoryMainView.onPlayListUpdated();
            };
        }
        private function onPlayListFullEvent(_arg_1:RoomWidgetPlayListEditorEvent):void
        {
            this.alertPlayListFull();
        }
        private function onNowPlayingChangedEvent(_arg_1:RoomWidgetPlayListEditorNowPlayingEvent):void
        {
            if (this._InventoryMainView){
                this._InventoryMainView.InfoStandWidgetHandler(_arg_1);
            };
        }

    }
}//package com.sulake.habbo.ui.widget.playlisteditor

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// CatalogPageName = "_-mv" (String#24149, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// PlayListEditorWidget = "_-1O-" (String#5310, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// RoomWidgetPlayListEditorNowPlayingEvent = "_-2Fn" (String#6359, DoABC#2)
// MainWindowHandler = "_-2SI" (String#6615, DoABC#2)
// RoomWidgetPlayListUserActionMessage = "_-07A" (String#3706, DoABC#2)
// RoomWidgetPlayListModificationMessage = "_-tW" (String#8759, DoABC#2)
// RoomWidgetPlayListEditorEvent = "_-1hD" (String#5690, DoABC#2)
// RoomWidgetPlayListPlayStateMessage = "_-3CO" (String#7559, DoABC#2)
// RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED = "_-T0" (String#23366, DoABC#2)
// RWPLAM_ADD_TO_PLAYLIST = "_-1Ju" (String#17270, DoABC#2)
// RWPLAM_REMOVE_FROM_PLAYLIST = "_-26-" (String#19259, DoABC#2)
// RWPLPS_TOGGLE_PLAY_PAUSE = "_-0GS" (String#14699, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// _InventoryMainView = "_-1P" (String#361, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// alertHandler = "_-2cB" (String#6798, DoABC#2)
// _SafeStr_6008 = "_-0P0" (String#15025, DoABC#2)
// _SafeStr_6625 = "_-1qG" (String#18554, DoABC#2)
// _SafeStr_6626 = "_-2bH" (String#20499, DoABC#2)
// _SafeStr_6627 = "_-1Mq" (String#17394, DoABC#2)
// _SafeStr_6628 = "_-346" (String#21663, DoABC#2)
// _SafeStr_6629 = "_-2-Y" (String#18993, DoABC#2)
// _SafeStr_6630 = "_-2XA" (String#20330, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// RWPLEE_SHOW_PLAYLIST_EDITOR = "_-KD" (String#23013, DoABC#2)
// RWPLEE_HIDE_PLAYLIST_EDITOR = "_-1d" (String#18013, DoABC#2)
// onHidePlayListEditorEvent = "_-2h0" (String#20728, DoABC#2)
// RWPLEE_INVENTORY_UPDATED = "_-3z" (String#22376, DoABC#2)
// onInventoryUpdatedEvent = "_-HK" (String#22904, DoABC#2)
// RWPLEE_SONG_DISK_INVENTORY_UPDATED = "_-0Yd" (String#15385, DoABC#2)
// onSongDiskInventoryUpdatedEvent = "_-ey" (String#23843, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// onPlayListUpdatedEvent = "_-2no" (String#20992, DoABC#2)
// RWPLEE_PLAY_LIST_FULL = "_-1li" (String#18362, DoABC#2)
// onPlayListFullEvent = "_-3-j" (String#21490, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
// onNowPlayingChangedEvent = "_-1T5" (String#17628, DoABC#2)
// RWPLENPE_USER_PLAY_SONG = "_-36w" (String#21763, DoABC#2)
// RWPLENPW_USER_STOP_SONG = "_-0Kk" (String#14870, DoABC#2)
// mainWindowHandler = "_-2Er" (String#19599, DoABC#2)
// getDiskColorTransformFromSongData = "_-26W" (String#19272, DoABC#2)
// sendAddToPlayListMessage = "_-3E2" (String#22035, DoABC#2)
// getRoomItemPlaylist = "_-2Su" (String#6624, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// sendRemoveFromPlayListMessage = "_-1Aq" (String#16896, DoABC#2)
// sendTogglePlayPauseStateMessage = "_-0Z4" (String#15406, DoABC#2)
// playListEditorView = "_-0yt" (String#16387, DoABC#2)
// selectedItemIndex = "_-2QA" (String#20052, DoABC#2)
// playUserSong = "_-1Vo" (String#17734, DoABC#2)
// getSongIdPlayingAtPriority = "_-u5" (String#8768, DoABC#2)
// _SafeStr_6658 = "_-1VW" (String#17722, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// soundObject = "_-HA" (String#8022, DoABC#2)
// playSong = "_-0VK" (String#4210, DoABC#2)
// _SafeStr_6662 = "_-jj" (String#24024, DoABC#2)
// stopUserSong = "_-0qi" (String#16075, DoABC#2)
// getImageGalleryAssetBitmap = "_-0PQ" (String#15039, DoABC#2)
// retrieveWidgetImage = "_-2qW" (String#21104, DoABC#2)
// onWidgetImageReady = "_-2EE" (String#19576, DoABC#2)
// openSongDiskShopCataloguePage = "_-0v8" (String#16242, DoABC#2)
// alertPlayListFull = "_-sG" (String#24371, DoABC#2)
// requestUserSongDisks = "_-1qp" (String#5871, DoABC#2)
// IPlayListController = "_-0Vy" (String#817, DoABC#2)
// refreshLoadableAsset = "_-1AG" (String#16870, DoABC#2)
// onSongDiskInventoryReceived = "_-2sW" (String#21180, DoABC#2)
// onPlayListUpdated = "_-eS" (String#23820, DoABC#2)
// InfoStandWidgetHandler = "_-17C" (String#5020, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


