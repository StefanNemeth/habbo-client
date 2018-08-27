
package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IPlayListController;
    import flash.utils.Timer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.TraxSongInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.UserSongDisksInventoryMessageEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import flash.events.TimerEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.IHabboSound;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetUserSongDisksMessageComposer;
    import com.sulake.habbo.sound.trax.TraxSequencer;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSongInfoMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
    import com.sulake.habbo.communication.messages.parser.sound.TraxSongInfoMessageParser;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.events.SongDiskInventoryReceivedEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.parser.sound.UserSongDisksInventoryMessageParser;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetNowPlayingMessageComposer;
    import com.sulake.habbo.sound.*;

    public class HabboMusicController implements IHabboMusicController, IDisposable 
    {

        public static const _SafeStr_7697:int = -1;
        private static const _SafeStr_7698:int = HabboMusicPrioritiesEnum._SafeStr_6658;//0

        private var _soundManager:HabboSoundManagerFlash10;
        private var _connection:IConnection;
        private var _events:IEventDispatcher;
        private var _SafeStr_5221:IEventDispatcher;
        private var _SafeStr_7699:Map;
        private var _SafeStr_7700:Map;
        private var _SafeStr_7701:Array;
        private var _SafeStr_7702:IPlayListController = null;
        private var _disposed:Boolean = false;
        private var _SafeStr_7703:Array;
        private var _SafeStr_7704:Array;
        private var _priorityPlaying:int = -1;
        private var _SafeStr_7705:int = -1;
        private var _SafeStr_7706:int = -1;
        private var _SafeStr_7707:Timer;
        private var _SafeStr_5522:Map;
        private var _SafeStr_7708:Array;
        private var _SafeStr_7204:Array;
        private var _SafeStr_7709:int = -1;
        private var _SafeStr_7710:int = -1;

        public function HabboMusicController(_arg_1:HabboSoundManagerFlash10, _arg_2:IEventDispatcher, _arg_3:IEventDispatcher, _arg_4:IConnection)
        {
            var _local_5:IMessageEvent;
            var _local_6:int;
            this._SafeStr_7699 = new Map();
            this._SafeStr_7700 = new Map();
            this._SafeStr_7701 = new Array();
            this._SafeStr_7703 = [];
            this._SafeStr_7704 = [];
            this._SafeStr_5522 = new Map();
            this._SafeStr_7708 = new Array();
            this._SafeStr_7204 = [];
            super();
            this._soundManager = _arg_1;
            this._events = _arg_2;
            this._SafeStr_5221 = _arg_3;
            this._connection = _arg_4;
            this._SafeStr_7204.push(new TraxSongInfoMessageEvent(this.onSongInfoMessage));
            this._SafeStr_7204.push(new UserSongDisksInventoryMessageEvent(this.onSongDiskInventoryMessage));
            for each (_local_5 in this._SafeStr_7204) {
                this._connection.addMessageEvent(_local_5);
            };
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_INIT, this.onJukeboxInit);
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE, this.onJukeboxDispose);
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_INIT, this.onSoundMachineInit);
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_DISPOSE, this.onSoundMachineDispose);
            this._SafeStr_7707 = new Timer(1000);
            this._SafeStr_7707.start();
            this._SafeStr_7707.addEventListener(TimerEvent.TIMER, this.sendNextSongRequestMessage);
            this._events.addEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
            _local_6 = 0;
            while (_local_6 < HabboMusicPrioritiesEnum._SafeStr_7718) {
                this._SafeStr_7703[_local_6] = null;
                this._SafeStr_7704[_local_6] = 0;
                _local_6++;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get events():IEventDispatcher
        {
            return (this._events);
        }
        protected function onSongFinishedPlayingEvent(_arg_1:SoundCompleteEvent):void
        {
            var _local_2:int;
            Logger.log((("Song " + _arg_1.id) + " finished playing"));
            if (this.getSongIdPlayingAtPriority(this._priorityPlaying) == _arg_1.id){
                if ((((this.getTopRequestPriority() == this._priorityPlaying)) && ((this.getSongRequestCountAtPriority(this._priorityPlaying) == this._SafeStr_7706)))){
                    this.resetSongStartRequest(this._priorityPlaying);
                };
                _local_2 = this._priorityPlaying;
                this.playSongWithHighestPriority();
                if (_local_2 >= HabboMusicPrioritiesEnum._SafeStr_6662){
                    this._events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.RWPLENPW_USER_STOP_SONG, _local_2, _arg_1.id, -1));
                };
            };
        }
        public function dispose():void
        {
            var _local_1:IMessageEvent;
            var _local_2:int;
            var _local_3:SongDataEntry;
            var _local_4:IHabboSound;
            if (!this._disposed){
                this._soundManager = null;
                this._SafeStr_7701 = null;
                if (this._connection){
                    for each (_local_1 in this._SafeStr_7204) {
                        this._connection.removeMessageEvent(_local_1);
                        _local_1.dispose();
                    };
                    this._SafeStr_7204 = null;
                    this._connection = null;
                };
                if (this._SafeStr_7702){
                    this._SafeStr_7702.dispose();
                    this._SafeStr_7702 = null;
                };
                if (this._SafeStr_7699){
                    _local_2 = 0;
                    while (_local_2 < this._SafeStr_7699.length) {
                        _local_3 = (this._SafeStr_7699.getWithIndex(_local_2) as SongDataEntry);
                        _local_4 = (_local_3.soundObject as IHabboSound);
                        if (_local_4 != null){
                            _local_4.stop();
                        };
                        _local_3.soundObject = null;
                        _local_2++;
                    };
                    this._SafeStr_7699.dispose();
                    this._SafeStr_7699 = null;
                };
                if (this._SafeStr_7700 != null){
                    this._SafeStr_7700.dispose();
                    this._SafeStr_7700 = null;
                };
                this._SafeStr_7707.stop();
                this._SafeStr_7707 = null;
                if (this._SafeStr_5221){
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_INIT, this.onJukeboxInit);
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_JUKEBOX_DISPOSE, this.onJukeboxDispose);
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_INIT, this.onSoundMachineInit);
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_DISPOSE, this.onSoundMachineDispose);
                };
                if (this._SafeStr_5522 != null){
                    this._SafeStr_5522.dispose();
                    this._SafeStr_5522 = null;
                };
                this._disposed = true;
            };
        }
        public function getRoomItemPlaylist(_arg_1:int=-1):IPlayListController
        {
            return (this._SafeStr_7702);
        }
        private function addSongStartRequest(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Boolean
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= HabboMusicPrioritiesEnum._SafeStr_7718)))){
                return (false);
            };
            var _local_7:SongStartRequestData = new SongStartRequestData(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            this._SafeStr_7703[_arg_1] = _local_7;
            this._SafeStr_7704[_arg_1] = (this._SafeStr_7704[_arg_1] + 1);
            return (true);
        }
        private function getSongStartRequest(_arg_1:int):SongStartRequestData
        {
            return (this._SafeStr_7703[_arg_1]);
        }
        private function getSongIdRequestedAtPriority(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= HabboMusicPrioritiesEnum._SafeStr_7718)))){
                return (-1);
            };
            if (this._SafeStr_7703[_arg_1] == null){
                return (-1);
            };
            var _local_2:SongStartRequestData = this._SafeStr_7703[_arg_1];
            return (_local_2.songId);
        }
        private function getSongRequestCountAtPriority(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= HabboMusicPrioritiesEnum._SafeStr_7718)))){
                return (-1);
            };
            return (this._SafeStr_7704[_arg_1]);
        }
        private function getTopRequestPriority():int
        {
            var _local_1:int = (this._SafeStr_7703.length - 1);
            while (_local_1 >= 0) {
                if (this._SafeStr_7703[_local_1] != null){
                    return (_local_1);
                };
                _local_1--;
            };
            return (-1);
        }
        private function resetSongStartRequest(_arg_1:int):void
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < HabboMusicPrioritiesEnum._SafeStr_7718)))){
                this._SafeStr_7703[_arg_1] = null;
            };
        }
        private function reRequestSongAtPriority(_arg_1:int):void
        {
            this._SafeStr_7704[_arg_1] = (this._SafeStr_7704[_arg_1] + 1);
        }
        private function processSongEntryForPlaying(_arg_1:int, _arg_2:Boolean=true):Boolean
        {
            var _local_3:SongDataEntry = this.getSongDataEntry(_arg_1);
            if (_local_3 == null){
                this.addSongInfoRequest(_arg_1);
                return (false);
            };
            if (_local_3.soundObject == null){
                _local_3.soundObject = this._soundManager.loadTraxSong(_local_3.id, _local_3.songData);
            };
            var _local_4:IHabboSound = _local_3.soundObject;
            if (!_local_4.ready){
                return (false);
            };
            return (true);
        }
        public function playSong(_arg_1:int, _arg_2:int, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0.5, _arg_6:Number=0.5):Boolean
        {
            Logger.log((("Requesting " + _arg_1) + " for playing"));
            if (!this.addSongStartRequest(_arg_2, _arg_1, _arg_3, _arg_4, _arg_5, _arg_6)){
                return (false);
            };
            if (!this.processSongEntryForPlaying(_arg_1)){
                return (false);
            };
            if (_arg_2 >= this._priorityPlaying){
                this.playSongObject(_arg_2, _arg_1);
            }
            else {
                Logger.log(((("Higher priority song blocked playing. Stored song " + _arg_1) + " for priority ") + _arg_2));
            };
            return (true);
        }
        private function playSongWithHighestPriority():void
        {
            var _local_3:int;
            this._priorityPlaying = -1;
            this._SafeStr_7705 = -1;
            this._SafeStr_7706 = -1;
            var _local_1:int = this.getTopRequestPriority();
            var _local_2:int = _local_1;
            while (_local_2 >= 0) {
                _local_3 = this.getSongIdRequestedAtPriority(_local_2);
                if ((((_local_3 >= 0)) && (this.playSongObject(_local_2, _local_3)))){
                    return;
                };
                _local_2--;
            };
        }
        public function stop(_arg_1:int):void
        {
            var _local_2 = (_arg_1 == this._priorityPlaying);
            var _local_3 = (this.getTopRequestPriority() == _arg_1);
            if (_local_2){
                this.resetSongStartRequest(_arg_1);
                this.stopSongAtPriority(_arg_1);
            }
            else {
                this.resetSongStartRequest(_arg_1);
                if (_local_3){
                    this.reRequestSongAtPriority(this._priorityPlaying);
                };
            };
        }
        private function stopSongAtPriority(_arg_1:int):Boolean
        {
            var _local_2:int;
            var _local_3:SongDataEntry;
            if ((((_arg_1 == this._priorityPlaying)) && ((this._priorityPlaying >= 0)))){
                _local_2 = this.getSongIdPlayingAtPriority(_arg_1);
                if (_local_2 >= 0){
                    _local_3 = this.getSongDataEntry(_local_2);
                    this.stopSongDataEntry(_local_3);
                    return (true);
                };
            };
            return (false);
        }
        private function stopSongDataEntry(_arg_1:SongDataEntry):void
        {
            var _local_2:IHabboSound;
            if (_arg_1 != null){
                Logger.log(("Stopping current song " + _arg_1.id));
                _local_2 = _arg_1.soundObject;
                if (_local_2 != null){
                    _local_2.stop();
                };
            };
        }
        private function getSongDataEntry(_arg_1:int):SongDataEntry
        {
            var _local_2:SongDataEntry;
            if (this._SafeStr_7699 != null){
                _local_2 = (this._SafeStr_7699.getValue(_arg_1) as SongDataEntry);
            };
            return (_local_2);
        }
        public function updateVolume(_arg_1:Number):void
        {
            var _local_3:int;
            var _local_4:SongDataEntry;
            var _local_2:int;
            while (_local_2 < HabboMusicPrioritiesEnum._SafeStr_7718) {
                _local_3 = this.getSongIdPlayingAtPriority(_local_2);
                if (_local_3 >= 0){
                    _local_4 = (this.getSongDataEntry(_local_3) as SongDataEntry);
                    if (((!((_local_4 == null))) && (!((_local_4.soundObject == null))))){
                        _local_4.soundObject.volume = _arg_1;
                    };
                };
                _local_2++;
            };
        }
        public function onSongLoaded(_arg_1:int):void
        {
            var _local_3:int;
            Logger.log(("Song loaded : " + _arg_1));
            var _local_2:int = this.getTopRequestPriority();
            if (_local_2 >= 0){
                _local_3 = this.getSongIdRequestedAtPriority(_local_2);
                if (_arg_1 == _local_3){
                    this.playSongObject(_local_2, _arg_1);
                };
            };
        }
        public function addSongInfoRequest(_arg_1:int):void
        {
            this.requestSong(_arg_1, true);
        }
        public function requestSongInfoWithoutSamples(_arg_1:int):void
        {
            this.requestSong(_arg_1, false);
        }
        private function requestSong(_arg_1:int, _arg_2:Boolean):void
        {
            if (this._SafeStr_7700.getValue(_arg_1) == null){
                this._SafeStr_7700.add(_arg_1, _arg_2);
                this._SafeStr_7701.push(_arg_1);
            };
        }
        public function getSongInfo(_arg_1:int):ISongInfo
        {
            var _local_2:SongDataEntry = this.getSongDataEntry(_arg_1);
            if (_local_2 == null){
                this.requestSongInfoWithoutSamples(_arg_1);
            };
            return (_local_2);
        }
        public function requestUserSongDisks():void
        {
            if (this._connection == null){
                return;
            };
            this._connection.send(new GetUserSongDisksMessageComposer());
        }
        public function getSongDiskInventorySize():int
        {
            return (this._SafeStr_5522.length);
        }
        public function getSongDiskInventoryDiskId(_arg_1:int):int
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_5522.length)))){
                return (this._SafeStr_5522.getKey(_arg_1));
            };
            return (-1);
        }
        public function getSongDiskInventorySongId(_arg_1:int):int
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._SafeStr_5522.length)))){
                return (this._SafeStr_5522.getWithIndex(_arg_1));
            };
            return (-1);
        }
        public function getSongIdPlayingAtPriority(_arg_1:int):int
        {
            if (_arg_1 != this._priorityPlaying){
                return (-1);
            };
            return (this._SafeStr_7705);
        }
        public function samplesUnloaded(_arg_1:Array):void
        {
            var _local_3:SongDataEntry;
            var _local_4:TraxSequencer;
            var _local_5:Array;
            var _local_6:int;
            var _local_2:int;
            while (_local_2 < this._SafeStr_7699.length) {
                _local_3 = (this._SafeStr_7699.getWithIndex(_local_2) as SongDataEntry);
                _local_4 = (_local_3.soundObject as TraxSequencer);
                if (((((!((_local_3.id == this._SafeStr_7705))) && (!((_local_4 == null))))) && (_local_4.ready))){
                    _local_5 = _local_4.traxData.getSampleIds();
                    _local_6 = 0;
                    while (_local_6 < _arg_1.length) {
                        if (_local_5.indexOf(_arg_1[_local_6]) != -1){
                            _local_3.soundObject = null;
                            _local_4.dispose();
                            Logger.log(((("Unloaded " + _local_3.name) + " by ") + _local_3.creator));
                        };
                        _local_6++;
                    };
                };
                _local_2++;
            };
        }
        public function get samplesIdsInUse():Array
        {
            var _local_3:SongStartRequestData;
            var _local_4:SongDataEntry;
            var _local_5:TraxSequencer;
            var _local_1:Array = [];
            var _local_2:int;
            while (_local_2 < this._SafeStr_7703.length) {
                if (this._SafeStr_7703[_local_2] != null){
                    _local_3 = this._SafeStr_7703[_local_2];
                    _local_4 = this._SafeStr_7699.getValue(_local_3.songId);
                    if (_local_4 != null){
                        _local_5 = (_local_4.soundObject as TraxSequencer);
                        if (_local_5 != null){
                            _local_1 = _local_1.concat(_local_5.traxData.getSampleIds());
                        };
                    };
                };
                _local_2++;
            };
            return (_local_1);
        }
        private function sendNextSongRequestMessage(_arg_1:TimerEvent):void
        {
            if (this._SafeStr_7701.length < 1){
                return;
            };
            if (this._connection == null){
                return;
            };
            this._connection.send(new GetSongInfoMessageComposer(this._SafeStr_7701));
            Logger.log(("Requested song info's : " + this._SafeStr_7701));
            this._SafeStr_7701 = new Array();
        }
        private function onSongInfoMessage(_arg_1:IMessageEvent):void
        {
            var _local_6:SongInfoEntry;
            var _local_7:Boolean;
            var _local_8:Boolean;
            var _local_9:IHabboSound;
            var _local_10:SongDataEntry;
            var _local_11:int;
            var _local_12:int;
            var _local_2:TraxSongInfoMessageEvent = (_arg_1 as TraxSongInfoMessageEvent);
            var _local_3:TraxSongInfoMessageParser = (_local_2.getParser() as TraxSongInfoMessageParser);
            var _local_4:Array = _local_3.songs;
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_6 = _local_4[_local_5];
                _local_7 = (this.getSongDataEntry(_local_6.id) == null);
                _local_8 = this.areSamplesRequested(_local_6.id);
                if (_local_7){
                    _local_9 = null;
                    if (_local_8){
                        _local_9 = this._soundManager.loadTraxSong(_local_6.id, _local_6.data);
                    };
                    _local_10 = new SongDataEntry(_local_6.id, _local_6.length, _local_6.name, _local_6.creator, _local_9);
                    _local_10.songData = _local_6.data;
                    this._SafeStr_7699.add(_local_6.id, _local_10);
                    _local_11 = this.getTopRequestPriority();
                    _local_12 = this.getSongIdRequestedAtPriority(_local_11);
                    if (((((!((_local_9 == null))) && (_local_9.ready))) && ((_local_6.id == _local_12)))){
                        this.playSongObject(_local_11, _local_12);
                    };
                    this._events.dispatchEvent(new SongInfoReceivedEvent(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, _local_6.id));
                    while (this._SafeStr_7708.indexOf(_local_6.id) != -1) {
                        this._SafeStr_7708.splice(this._SafeStr_7708.indexOf(_local_6.id), 1);
                        if (this._SafeStr_7708.length == 0){
                            this._events.dispatchEvent(new SongDiskInventoryReceivedEvent(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED));
                        };
                    };
                    Logger.log(("Received song info : " + _local_6.id));
                };
                _local_5++;
            };
        }
        private function playSongObject(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((((_arg_2 == -1)) || ((_arg_1 < 0)))) || ((_arg_1 >= HabboMusicPrioritiesEnum._SafeStr_7718)))){
                return (false);
            };
            var _local_3:Boolean;
            if (this.stopSongAtPriority(this._priorityPlaying)){
                _local_3 = true;
            };
            var _local_4:SongDataEntry = this.getSongDataEntry(_arg_2);
            if (_local_4 == null){
                Logger.log((("WARNING: Unable to find song entry id " + _arg_2) + " that was supposed to be loaded."));
                return (false);
            };
            var _local_5:IHabboSound = _local_4.soundObject;
            if ((((_local_5 == null)) || (!(_local_5.ready)))){
                return (false);
            };
            if (_local_3){
                Logger.log(("Waiting previous song to stop before playing song " + _arg_2));
                return (true);
            };
            _local_5.volume = this._soundManager.volume;
            var _local_6:Number = _SafeStr_7697;
            var _local_7:Number = 0;
            var _local_8:Number = 2;
            var _local_9:Number = 1;
            var _local_10:SongStartRequestData = this.getSongStartRequest(_arg_1);
            if (_local_10 != null){
                _local_6 = _local_10.startPos;
                _local_7 = _local_10.playLength;
                _local_8 = _local_10.fadeInSeconds;
                _local_9 = _local_10.fadeOutSeconds;
            };
            if (_local_6 >= (_local_4.length / 1000)){
                return (false);
            };
            if (_local_6 == _SafeStr_7697){
                _local_6 = 0;
            };
            _local_5.fadeInSeconds = _local_8;
            _local_5.fadeOutSeconds = _local_9;
            _local_5.position = _local_6;
            _local_5.play(_local_7);
            this._priorityPlaying = _arg_1;
            this._SafeStr_7706 = this.getSongRequestCountAtPriority(_arg_1);
            this._SafeStr_7705 = _arg_2;
            if (this._priorityPlaying <= _SafeStr_7698){
                this.notifySongPlaying(_local_4);
            };
            if (_arg_1 > HabboMusicPrioritiesEnum._SafeStr_6658){
                this._events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.RWPLENPE_USER_PLAY_SONG, _arg_1, _local_4.id, -1));
            };
            Logger.log(((((((((("Started playing song " + _arg_2) + " at position ") + _local_6) + " for ") + _local_7) + " seconds (length ") + (_local_4.length / 1000)) + ") with priority ") + _arg_1));
            return (true);
        }
        private function notifySongPlaying(_arg_1:SongDataEntry):void
        {
            var _local_2 = 8000;
            var _local_3:int = getTimer();
            if ((((_arg_1.length >= _local_2)) && (((!((this._SafeStr_7709 == _arg_1.id))) || ((_local_3 > (this._SafeStr_7710 + _local_2))))))){
                this._soundManager.notifyPlayedSong(_arg_1.name, _arg_1.creator);
                this._SafeStr_7709 = _arg_1.id;
                this._SafeStr_7710 = _local_3;
            };
        }
        private function areSamplesRequested(_arg_1:int):Boolean
        {
            if (this._SafeStr_7700.getValue(_arg_1) == null){
                return (false);
            };
            return (this._SafeStr_7700.getValue(_arg_1));
        }
        private function onSongDiskInventoryMessage(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_2:UserSongDisksInventoryMessageEvent = (_arg_1 as UserSongDisksInventoryMessageEvent);
            var _local_3:UserSongDisksInventoryMessageParser = (_local_2.getParser() as UserSongDisksInventoryMessageParser);
            this._SafeStr_5522.reset();
            var _local_4:int;
            while (_local_4 < _local_3.songDiskCount) {
                _local_5 = _local_3.getDiskId(_local_4);
                _local_6 = _local_3.getSongId(_local_4);
                this._SafeStr_5522.add(_local_5, _local_6);
                if (this._SafeStr_7699.getValue(_local_6) == null){
                    this._SafeStr_7708.push(_local_6);
                    this.requestSongInfoWithoutSamples(_local_6);
                };
                _local_4++;
            };
            if (this._SafeStr_7708.length == 0){
                this._events.dispatchEvent(new SongDiskInventoryReceivedEvent(SongDiskInventoryReceivedEvent.SONG_DISK_INVENTORY_RECEIVED));
            };
        }
        private function onSoundMachineInit(_arg_1:Event):void
        {
            this.disposeRoomPlaylist();
            this._SafeStr_7702 = (new SoundMachinePlayListController(this._soundManager, this, this._events, this._SafeStr_5221, this._connection) as IPlayListController);
        }
        private function onSoundMachineDispose(_arg_1:Event):void
        {
            this.disposeRoomPlaylist();
        }
        private function onJukeboxInit(_arg_1:Event):void
        {
            this.disposeRoomPlaylist();
            this._SafeStr_7702 = (new JukeboxPlayListController(this._soundManager, this, this._events, this._connection) as IPlayListController);
            this._connection.send(new GetNowPlayingMessageComposer());
        }
        private function onJukeboxDispose(_arg_1:Event):void
        {
            this.disposeRoomPlaylist();
        }
        private function disposeRoomPlaylist():void
        {
            if (this._SafeStr_7702 != null){
                this._SafeStr_7702.dispose();
                this._SafeStr_7702 = null;
            };
        }

    }
}//package com.sulake.habbo.sound.music

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// TraxSequencer = "_-0aW" (String#4313, DoABC#2)
// HabboMusicController = "_-0hU" (String#4457, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// SoundCompleteEvent = "_-2-X" (String#6037, DoABC#2)
// JukeboxPlayListController = "_-2ld" (String#6996, DoABC#2)
// UserSongDisksInventoryMessageParser = "_-BX" (String#7901, DoABC#2)
// SongInfoEntry = "_-1f6" (String#5645, DoABC#2)
// GetSongInfoMessageComposer = "_-2q3" (String#21083, DoABC#2)
// UserSongDisksInventoryMessageEvent = "_-1In" (String#17227, DoABC#2)
// GetNowPlayingMessageComposer = "_-3IV" (String#22219, DoABC#2)
// TraxSongInfoMessageParser = "_-Tc" (String#8278, DoABC#2)
// NowPlayingEvent = "_-1nK" (String#5803, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// GetUserSongDisksMessageComposer = "_-1aA" (String#17901, DoABC#2)
// SongStartRequestData = "_-1Gb" (String#5178, DoABC#2)
// TraxSongInfoMessageEvent = "_-37D" (String#21776, DoABC#2)
// SoundMachinePlayListController = "_-TA" (String#8270, DoABC#2)
// SongDataEntry = "_-23d" (String#6117, DoABC#2)
// SongDiskInventoryReceivedEvent = "_-1w4" (String#5960, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// fadeInSeconds = "_-2FB" (String#6346, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// _SafeStr_5522 = "_-2Yj" (String#6740, DoABC#2)
// songDiskCount = "_-HP" (String#22909, DoABC#2)
// getDiskId = "_-0O4" (String#14991, DoABC#2)
// getSongId = "_-3Ax" (String#21917, DoABC#2)
// songs = "_-2uJ" (String#21251, DoABC#2)
// ROSM_SOUND_MACHINE_INIT = "_-Tk" (String#23396, DoABC#2)
// ROSM_SOUND_MACHINE_DISPOSE = "_-1pK" (String#18515, DoABC#2)
// ROSM_JUKEBOX_INIT = "_-vy" (String#24527, DoABC#2)
// ROSM_JUKEBOX_DISPOSE = "_-gi" (String#23919, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// getSampleIds = "_-1c-" (String#17971, DoABC#2)
// traxData = "_-2S4" (String#20122, DoABC#2)
// RWPLENPE_USER_PLAY_SONG = "_-36w" (String#21763, DoABC#2)
// RWPLENPW_USER_STOP_SONG = "_-0Kk" (String#14870, DoABC#2)
// getRoomItemPlaylist = "_-2Su" (String#6624, DoABC#2)
// getSongIdPlayingAtPriority = "_-u5" (String#8768, DoABC#2)
// _SafeStr_6658 = "_-1VW" (String#17722, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// soundObject = "_-HA" (String#8022, DoABC#2)
// playSong = "_-0VK" (String#4210, DoABC#2)
// _SafeStr_6662 = "_-jj" (String#24024, DoABC#2)
// requestUserSongDisks = "_-1qp" (String#5871, DoABC#2)
// getSongDiskInventorySize = "_-3Lf" (String#7732, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// getSongDiskInventoryDiskId = "_-1eT" (String#5637, DoABC#2)
// getSongDiskInventorySongId = "_-23l" (String#6118, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _SafeStr_7204 = "_-bQ" (String#938, DoABC#2)
// removeMessageEvent = "_-0vh" (String#4760, DoABC#2)
// _SafeStr_7697 = "_-Rn" (String#23315, DoABC#2)
// _SafeStr_7698 = "_-q9" (String#24279, DoABC#2)
// _SafeStr_7699 = "_-0l1" (String#15866, DoABC#2)
// _SafeStr_7700 = "_-1Qt" (String#17545, DoABC#2)
// _SafeStr_7701 = "_-31t" (String#21574, DoABC#2)
// _SafeStr_7702 = "_-077" (String#14329, DoABC#2)
// _SafeStr_7703 = "_-145" (String#16620, DoABC#2)
// _SafeStr_7704 = "_-2PL" (String#20016, DoABC#2)
// _SafeStr_7705 = "_-20m" (String#19043, DoABC#2)
// _SafeStr_7706 = "_-1NF" (String#17408, DoABC#2)
// _SafeStr_7707 = "_-33O" (String#21638, DoABC#2)
// _SafeStr_7708 = "_-0-j" (String#14042, DoABC#2)
// _SafeStr_7709 = "_-0H8" (String#14724, DoABC#2)
// _SafeStr_7710 = "_-1Z9" (String#17858, DoABC#2)
// onSongInfoMessage = "_-JA" (String#22974, DoABC#2)
// onSongDiskInventoryMessage = "_-1kt" (String#18326, DoABC#2)
// onJukeboxInit = "_-1LY" (String#17336, DoABC#2)
// onJukeboxDispose = "_-xp" (String#24606, DoABC#2)
// onSoundMachineInit = "_-30v" (String#21536, DoABC#2)
// onSoundMachineDispose = "_-1lG" (String#18341, DoABC#2)
// sendNextSongRequestMessage = "_-2P2" (String#20003, DoABC#2)
// _SafeStr_7718 = "_-tQ" (String#24423, DoABC#2)
// getSongRequestCountAtPriority = "_-0Xw" (String#15352, DoABC#2)
// getTopRequestPriority = "_-0FP" (String#14661, DoABC#2)
// resetSongStartRequest = "_-1T0" (String#17626, DoABC#2)
// playSongWithHighestPriority = "_-38G" (String#21813, DoABC#2)
// addSongStartRequest = "_-2w6" (String#21313, DoABC#2)
// getSongStartRequest = "_-28u" (String#19366, DoABC#2)
// getSongIdRequestedAtPriority = "_-TG" (String#23375, DoABC#2)
// reRequestSongAtPriority = "_-37Y" (String#21788, DoABC#2)
// processSongEntryForPlaying = "_-2B-" (String#19444, DoABC#2)
// getSongDataEntry = "_-vz" (String#24528, DoABC#2)
// addSongInfoRequest = "_-1QR" (String#5359, DoABC#2)
// loadTraxSong = "_-1OI" (String#5318, DoABC#2)
// playSongObject = "_-07f" (String#14350, DoABC#2)
// stopSongAtPriority = "_-1-G" (String#16439, DoABC#2)
// stopSongDataEntry = "_-30J" (String#21513, DoABC#2)
// updateVolume = "_-31S" (String#7334, DoABC#2)
// onSongLoaded = "_-1iX" (String#5723, DoABC#2)
// requestSong = "_-1C8" (String#16949, DoABC#2)
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)
// samplesUnloaded = "_-1dU" (String#5623, DoABC#2)
// samplesIdsInUse = "_-0Sc" (String#4152, DoABC#2)
// areSamplesRequested = "_-xh" (String#24598, DoABC#2)
// startPos = "_-2Wm" (String#20315, DoABC#2)
// playLength = "_-1gr" (String#18169, DoABC#2)
// notifySongPlaying = "_-29w" (String#19402, DoABC#2)
// notifyPlayedSong = "_-3FC" (String#22085, DoABC#2)
// disposeRoomPlaylist = "_-RO" (String#23300, DoABC#2)


