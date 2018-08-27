
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListModificationMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListPlayStateMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPlayListUserActionMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.AddJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.sound.RemoveJukeboxDiskComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;

    public class PlayListEditorWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer;
        private var _connection:IConnection = null;
        private var _SafeStr_7296:IMessageEvent;
        private var _SafeStr_7297:IMessageEvent;
        private var _SafeStr_7298:IMessageEvent;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_PLAYLIST_EDITOR_WIDGET);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
            if (this._container.soundManager){
                this._container.soundManager.events.addEventListener(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(PlayListStatusEvent.RWPLEE_PLAY_LIST_FULL, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.RWPLENPE_SONG_CHANGED, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.RWPLENPE_USER_PLAY_SONG, this.processSoundManagerEvent);
                this._container.soundManager.events.addEventListener(NowPlayingEvent.RWPLENPW_USER_STOP_SONG, this.processSoundManagerEvent);
            };
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._SafeStr_7296 = new FurniListUpdateEvent(this.onFurniListUpdated);
            this._SafeStr_7297 = new FurniListRemoveEvent(this.onFurniListUpdated);
            this._SafeStr_7298 = new FurniListInsertEvent(this.onFurniListUpdated);
            this._connection = _arg_1;
            this._connection.addMessageEvent(this._SafeStr_7296);
            this._connection.addMessageEvent(this._SafeStr_7297);
            this._connection.addMessageEvent(this._SafeStr_7298);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._disposed = true;
                if (this._connection){
                    this._connection.removeMessageEvent(this._SafeStr_7296);
                    this._connection.removeMessageEvent(this._SafeStr_7297);
                    this._connection.removeMessageEvent(this._SafeStr_7298);
                };
                this._connection = null;
                this._SafeStr_7296 = null;
                if (this._container){
                    if (this._container.soundManager){
                        if (this._container.soundManager.events){
                            this._container.soundManager.events.removeEventListener(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(PlayListStatusEvent.RWPLEE_PLAY_LIST_FULL, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.RWPLENPE_SONG_CHANGED, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.RWPLENPE_USER_PLAY_SONG, this.processSoundManagerEvent);
                            this._container.soundManager.events.removeEventListener(NowPlayingEvent.RWPLENPW_USER_STOP_SONG, this.processSoundManagerEvent);
                        };
                    };
                    this._container = null;
                };
            };
        }
        public function getWidgetMessages():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR, RoomWidgetPlayListModificationMessage.RWPLAM_ADD_TO_PLAYLIST, RoomWidgetPlayListModificationMessage.RWPLAM_REMOVE_FROM_PLAYLIST, RoomWidgetPlayListPlayStateMessage.RWPLPS_TOGGLE_PLAY_PAUSE, RoomWidgetPlayListUserActionMessage.RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetFurniToWidgetMessage;
            var _local_3:IRoomObject;
            var _local_4:RoomWidgetPlayListModificationMessage;
            var _local_5:RoomWidgetPlayListModificationMessage;
            var _local_6:RoomWidgetPlayListPlayStateMessage;
            var _local_7:Boolean;
            var _local_8:RoomWidgetPlayListEditorEvent;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR:
                    _local_2 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_3 = this._container.roomEngine.getRoomObject(_local_2.roomId, _local_2.roomCategory, _local_2.id, _local_2.category);
                    if (_local_3 != null){
                        _local_7 = this._container.roomSession.isRoomOwner;
                        if (_local_7){
                            _local_8 = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_SHOW_PLAYLIST_EDITOR, _local_2.id);
                            this._container.events.dispatchEvent(_local_8);
                        };
                    };
                    break;
                case RoomWidgetPlayListModificationMessage.RWPLAM_ADD_TO_PLAYLIST:
                    _local_4 = (_arg_1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null){
                        this._connection.send(new AddJukeboxDiskComposer(_local_4.diskId, _local_4.slotNumber));
                    };
                    break;
                case RoomWidgetPlayListModificationMessage.RWPLAM_REMOVE_FROM_PLAYLIST:
                    _local_5 = (_arg_1 as RoomWidgetPlayListModificationMessage);
                    if (this._connection != null){
                        this._connection.send(new RemoveJukeboxDiskComposer(_local_5.slotNumber));
                    };
                    break;
                case RoomWidgetPlayListPlayStateMessage.RWPLPS_TOGGLE_PLAY_PAUSE:
                    _local_6 = (_arg_1 as RoomWidgetPlayListPlayStateMessage);
                    if (this._connection != null){
                        this._connection.send(new UseFurnitureMessageComposer(_local_6.furniId, _local_6.position));
                    };
                    break;
                case RoomWidgetPlayListUserActionMessage.RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED:
                    this._container.habboTracking.trackGoogle("playlistEditorPanelOpenCatalogue", "click");
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE);
            return (_local_1);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomEngineSoundMachineEvent;
            var _local_3:RoomWidgetPlayListEditorEvent;
            switch (_arg_1.type){
                case RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE:
                    _local_2 = (_arg_1 as RoomEngineSoundMachineEvent);
                    _local_3 = new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_HIDE_PLAYLIST_EDITOR, _local_2.objectId);
                    this._container.events.dispatchEvent(_local_3);
                    return;
            };
        }
        public function update():void
        {
        }
        private function onFurniListUpdated(_arg_1:IMessageEvent):void
        {
            if (this._container != null){
                if (this._container.events != null){
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_INVENTORY_UPDATED, -1));
                };
            };
        }
        private function processSoundManagerEvent(_arg_1:Event):void
        {
            var _local_2:NowPlayingEvent;
            switch (_arg_1.type){
                case SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_SONG_DISK_INVENTORY_UPDATED));
                    return;
                case PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_UPDATED));
                    return;
                case PlayListStatusEvent.RWPLEE_PLAY_LIST_FULL:
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorEvent(RoomWidgetPlayListEditorEvent.RWPLEE_PLAY_LIST_FULL));
                    return;
                case NowPlayingEvent.RWPLENPE_SONG_CHANGED:
                    _local_2 = (_arg_1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_SONG_CHANGED, _local_2.id, _local_2.position, _local_2.priority));
                    return;
                case NowPlayingEvent.RWPLENPE_USER_PLAY_SONG:
                    _local_2 = (_arg_1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPE_USER_PLAY_SONG, _local_2.id, _local_2.position, _local_2.priority));
                    return;
                case NowPlayingEvent.RWPLENPW_USER_STOP_SONG:
                    _local_2 = (_arg_1 as NowPlayingEvent);
                    this._container.events.dispatchEvent(new RoomWidgetPlayListEditorNowPlayingEvent(RoomWidgetPlayListEditorNowPlayingEvent.RWPLENPW_USER_STOP_SONG, _local_2.id, _local_2.position, _local_2.priority));
                    return;
            };
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// UseFurnitureMessageComposer = "_-0I2" (String#14759, DoABC#2)
// NowPlayingEvent = "_-1nK" (String#5803, DoABC#2)
// SongDiskInventoryReceivedEvent = "_-1w4" (String#5960, DoABC#2)
// FurniListRemoveEvent = "_-3Ij" (String#7684, DoABC#2)
// FurniListUpdateEvent = "_-0Xr" (String#4265, DoABC#2)
// FurniListInsertEvent = "_-0Ey" (String#3848, DoABC#2)
// RemoveJukeboxDiskComposer = "_-2Vs" (String#20276, DoABC#2)
// AddJukeboxDiskComposer = "_-08s" (String#14400, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// PlayListEditorWidgetHandler = "_-xv" (String#24611, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetPlayListEditorNowPlayingEvent = "_-2Fn" (String#6359, DoABC#2)
// RoomWidgetPlayListUserActionMessage = "_-07A" (String#3706, DoABC#2)
// RoomWidgetPlayListModificationMessage = "_-tW" (String#8759, DoABC#2)
// RoomWidgetPlayListEditorEvent = "_-1hD" (String#5690, DoABC#2)
// RoomWidgetPlayListPlayStateMessage = "_-3CO" (String#7559, DoABC#2)
// PlayListStatusEvent = "_-a-" (String#8420, DoABC#2)
// RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR = "_-mx" (String#24151, DoABC#2)
// RWPLUA_OPEN_CATALOGUE_BUTTON_PRESSED = "_-T0" (String#23366, DoABC#2)
// RWPLAM_ADD_TO_PLAYLIST = "_-1Ju" (String#17270, DoABC#2)
// RWPLAM_REMOVE_FROM_PLAYLIST = "_-26-" (String#19259, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// slotNumber = "_-xM" (String#24583, DoABC#2)
// RWPLPS_TOGGLE_PLAY_PAUSE = "_-0GS" (String#14699, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWE_PLAYLIST_EDITOR_WIDGET = "_-0b8" (String#15481, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// RWPLEE_SHOW_PLAYLIST_EDITOR = "_-KD" (String#23013, DoABC#2)
// RWPLEE_HIDE_PLAYLIST_EDITOR = "_-1d" (String#18013, DoABC#2)
// RWPLEE_INVENTORY_UPDATED = "_-3z" (String#22376, DoABC#2)
// RWPLEE_SONG_DISK_INVENTORY_UPDATED = "_-0Yd" (String#15385, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// RWPLEE_PLAY_LIST_FULL = "_-1li" (String#18362, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
// RWPLENPE_USER_PLAY_SONG = "_-36w" (String#21763, DoABC#2)
// RWPLENPW_USER_STOP_SONG = "_-0Kk" (String#14870, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// removeMessageEvent = "_-0vh" (String#4760, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7296 = "_-Jr" (String#23001, DoABC#2)
// _SafeStr_7297 = "_-163" (String#16699, DoABC#2)
// _SafeStr_7298 = "_-0eM" (String#15601, DoABC#2)
// processSoundManagerEvent = "_-0PZ" (String#15046, DoABC#2)
// onFurniListUpdated = "_-25t" (String#19253, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// habboTracking = "_-1ZQ" (String#5552, DoABC#2)


