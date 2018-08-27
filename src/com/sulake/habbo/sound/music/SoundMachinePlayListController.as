
package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.connection.IConnection;
    import flash.events.IEventDispatcher;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListSongAddedMessageEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.room.events.RoomEngineSoundMachineEvent;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import flash.events.Event;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundMachinePlayListMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.sound.PlayListEntry;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageParser;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;
    import com.sulake.habbo.communication.messages.parser.sound.PlayListSongAddedMessageParser;
    import com.sulake.habbo.sound.*;

    public class SoundMachinePlayListController implements IPlayListController 
    {

        private var _soundManager:HabboSoundManagerFlash10;
        private var _musicController:HabboMusicController;
        private var _connection:IConnection;
        private var _events:IEventDispatcher;
        private var _SafeStr_5221:IEventDispatcher;
        private var _nowPlayingSongId:int = -1;
        private var _playListEntries:Array;
        private var _isPlaying:Boolean;
        private var _disposed:Boolean = false;
        private var _SafeStr_7204:Array;

        public function SoundMachinePlayListController(_arg_1:HabboSoundManagerFlash10, _arg_2:HabboMusicController, _arg_3:IEventDispatcher, _arg_4:IEventDispatcher, _arg_5:IConnection)
        {
            var _local_6:IMessageEvent;
            this._playListEntries = new Array();
            super();
            this._soundManager = _arg_1;
            this._events = _arg_3;
            this._SafeStr_5221 = _arg_4;
            this._connection = _arg_5;
            this._musicController = _arg_2;
            this._SafeStr_7204 = [];
            this._SafeStr_7204.push(new PlayListMessageEvent(this.onPlayListMessage));
            this._SafeStr_7204.push(new PlayListSongAddedMessageEvent(this.onPlayListSongAddedMessage));
            for each (_local_6 in this._SafeStr_7204) {
                this._connection.addMessageEvent(_local_6);
            };
            this._events.addEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
            this._events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_ON, this.onSoundMachinePlayEvent);
            this._SafeStr_5221.addEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_OFF, this.onSoundMachineStopEvent);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get priority():int
        {
            return (HabboMusicPrioritiesEnum._SafeStr_6658);
        }
        public function get length():int
        {
            if (this._playListEntries == null){
                return (0);
            };
            return (this._playListEntries.length);
        }
        public function get playPosition():int
        {
            return (-1);
        }
        public function get nowPlayingSongId():int
        {
            return (this._nowPlayingSongId);
        }
        public function get isPlaying():Boolean
        {
            return (this._isPlaying);
        }
        public function set playPosition(_arg_1:int):void
        {
        }
        public function dispose():void
        {
            var _local_1:IMessageEvent;
            if (!this._disposed){
                if (this._isPlaying){
                    this.stopPlaying();
                };
                this._soundManager = null;
                if (this._connection){
                    for each (_local_1 in this._SafeStr_7204) {
                        this._connection.removeMessageEvent(_local_1);
                        _local_1.dispose();
                    };
                    this._SafeStr_7204 = null;
                    this._connection = null;
                };
                this._playListEntries = null;
                this._musicController = null;
                if (this._events){
                    this._events.removeEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
                    this._events = null;
                };
                if (this._SafeStr_5221){
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_ON, this.onSoundMachinePlayEvent);
                    this._SafeStr_5221.removeEventListener(RoomEngineSoundMachineEvent.ROSM_SOUND_MACHINE_SWITCHED_OFF, this.onSoundMachineStopEvent);
                    this._SafeStr_5221 = null;
                };
                this._disposed = true;
            };
        }
        private function onSoundMachinePlayEvent(_arg_1:Event):void
        {
            this.startPlaying();
        }
        private function onSoundMachineStopEvent(_arg_1:Event):void
        {
            this.stopPlaying();
        }
        public function startPlaying():void
        {
            if (this._isPlaying){
                return;
            };
            if ((((this._playListEntries == null)) || ((this._playListEntries.length == 0)))){
                this.requestPlayList();
                this._isPlaying = true;
                return;
            };
            this.stopPlaying();
            this._nowPlayingSongId = -1;
            this._isPlaying = true;
            this.playNextSong();
        }
        public function checkSongPlayState(_arg_1:int):void
        {
            var _local_2:SongDataEntry;
            if (this._nowPlayingSongId == _arg_1){
                this.playCurrentSongAndNotify(this._nowPlayingSongId);
                _local_2 = this.getNextEntry();
                if (_local_2 != null){
                    this._musicController.addSongInfoRequest(_local_2.id);
                };
            };
        }
        public function stopPlaying():void
        {
            this._nowPlayingSongId = -1;
            this._isPlaying = false;
            this._musicController.stop(HabboMusicPrioritiesEnum._SafeStr_6658);
        }
        public function updateVolume(_arg_1:Number):void
        {
        }
        public function addItem(_arg_1:ISongInfo, _arg_2:int=0):int
        {
            return (-1);
        }
        public function moveItem(_arg_1:int, _arg_2:int):void
        {
        }
        public function removeItem(_arg_1:int):void
        {
        }
        private function onSongFinishedPlayingEvent(_arg_1:SoundCompleteEvent):void
        {
            if (_arg_1.id == this._nowPlayingSongId){
                this.playNextSong();
            };
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:SongDataEntry;
            var _local_4:SongDataEntry;
            if ((((this._playListEntries == null)) || ((this._playListEntries.length == 0)))){
                return;
            };
            var _local_3:int;
            while (_local_3 < this._playListEntries.length) {
                _local_2 = this._playListEntries[_local_3];
                if (_local_2.id == _arg_1.id){
                    _local_4 = (this._musicController.getSongInfo(_arg_1.id) as SongDataEntry);
                    if (_local_4 != null){
                        this._playListEntries[_local_3] = _local_4;
                    };
                    return;
                };
                _local_3++;
            };
        }
        private function playNextSong():void
        {
            var _local_1:SongDataEntry = this.getNextEntry();
            if (_local_1 != null){
                this._nowPlayingSongId = _local_1.id;
                this.playCurrentSongAndNotify(this._nowPlayingSongId);
            };
        }
        private function playCurrentSongAndNotify(_arg_1:int):void
        {
            var _local_2:SongDataEntry = (this.getEntryWithId(_arg_1) as SongDataEntry);
            if (_local_2 == null){
                return;
            };
            var _local_3:Number = _local_2.startPlayHeadPos;
            _local_2.startPlayHeadPos = 0;
            if (this._musicController.playSong(_arg_1, HabboMusicPrioritiesEnum._SafeStr_6658, _local_3, 0, 0, 0)){
                Logger.log(((("Trax song started by playlist: " + _local_2.name) + " by ") + _local_2.creator));
            };
        }
        private function getNextEntry():SongDataEntry
        {
            var _local_2:SongDataEntry;
            if ((((this._playListEntries == null)) || ((this._playListEntries.length == 0)))){
                return (null);
            };
            var _local_1:int;
            var _local_3:int;
            while (_local_3 < this._playListEntries.length) {
                _local_2 = this._playListEntries[_local_3];
                if (_local_2.id == this._nowPlayingSongId){
                    _local_1 = (_local_3 + 1);
                };
                _local_3++;
            };
            if (_local_1 >= this._playListEntries.length){
                _local_1 = 0;
            };
            return (this._playListEntries[_local_1]);
        }
        public function getEntry(_arg_1:int):ISongInfo
        {
            if ((((((this._playListEntries == null)) || ((_arg_1 < 0)))) || ((_arg_1 >= this._playListEntries.length)))){
                return (null);
            };
            return (this._playListEntries[_arg_1]);
        }
        public function getEntryWithId(_arg_1:int):ISongInfo
        {
            var _local_2:SongDataEntry;
            if ((((this._playListEntries == null)) || ((this._playListEntries.length == 0)))){
                return (null);
            };
            var _local_3:int;
            while (_local_3 < this._playListEntries.length) {
                _local_2 = this._playListEntries[_local_3];
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
                _local_3++;
            };
            return (null);
        }
        public function requestPlayList():void
        {
            if (this._connection == null){
                return;
            };
            this._connection.send(new GetSoundMachinePlayListMessageComposer());
        }
        private function convertParserPlayList(_arg_1:Array):Array
        {
            var _local_3:PlayListEntry;
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1) {
                _local_2.push(new SongDataEntry(_local_3.id, _local_3.length, _local_3.name, _local_3.creator, null));
            };
            return (_local_2);
        }
        private function onPlayListMessage(_arg_1:IMessageEvent):void
        {
            var _local_6:SongDataEntry;
            var _local_8:int;
            var _local_2:PlayListMessageEvent = (_arg_1 as PlayListMessageEvent);
            var _local_3:PlayListMessageParser = (_local_2.getParser() as PlayListMessageParser);
            var _local_4:int = _local_3.synchronizationCount;
            var _local_5:Array = this.convertParserPlayList(_local_3.playList);
            if ((((_local_5 == null)) || ((_local_5.length == 0)))){
                return;
            };
            this._playListEntries = _local_5;
            var _local_7:int;
            _local_8 = 0;
            while (_local_8 < _local_5.length) {
                _local_6 = this._playListEntries[_local_8];
                _local_7 = (_local_7 + _local_6.length);
                _local_8++;
            };
            if (_local_4 < 0){
                _local_4 = 0;
            };
            _local_4 = (_local_4 % _local_7);
            _local_8 = 0;
            while (_local_8 < _local_5.length) {
                _local_6 = this._playListEntries[_local_8];
                if (_local_4 > _local_6.length){
                    _local_4 = (_local_4 - _local_6.length);
                }
                else {
                    this._nowPlayingSongId = _local_6.id;
                    _local_6.startPlayHeadPos = (Number(_local_4) / 1000);
                    break;
                };
                _local_8++;
            };
            this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED));
            if (((!((_local_6 == null))) && (this._isPlaying))){
                this.playCurrentSongAndNotify(_local_6.id);
            };
        }
        private function onPlayListSongAddedMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:PlayListSongAddedMessageEvent = (_arg_1 as PlayListSongAddedMessageEvent);
            var _local_3:PlayListSongAddedMessageParser = (_local_2.getParser() as PlayListSongAddedMessageParser);
            var _local_4:SongDataEntry = new SongDataEntry(_local_3.entry.id, _local_3.entry.length, _local_3.entry.name, _local_3.entry.creator, null);
            if (_local_4 == null){
                return;
            };
            this._playListEntries.push(_local_4);
            this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED));
            if (!this._isPlaying){
                return;
            };
            if (this._playListEntries.length == 1){
                this.playCurrentSongAndNotify(_local_4.id);
            }
            else {
                this.checkSongPlayState(_local_4.id);
            };
        }

    }
}//package com.sulake.habbo.sound.music

// HabboMusicController = "_-0hU" (String#4457, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// SoundCompleteEvent = "_-2-X" (String#6037, DoABC#2)
// PlayListEntry = "_-17H" (String#5021, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// SoundMachinePlayListController = "_-TA" (String#8270, DoABC#2)
// SongDataEntry = "_-23d" (String#6117, DoABC#2)
// GetSoundMachinePlayListMessageComposer = "_-21Q" (String#19069, DoABC#2)
// PlayListMessageEvent = "_-2L7" (String#19852, DoABC#2)
// PlayListSongAddedMessageEvent = "_-2z0" (String#21427, DoABC#2)
// PlayListStatusEvent = "_-a-" (String#8420, DoABC#2)
// PlayListMessageParser = "_-PK" (String#8191, DoABC#2)
// PlayListSongAddedMessageParser = "_-19g" (String#5070, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// getEntry = "_-ig" (String#2166, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// synchronizationCount = "_-FT" (String#22830, DoABC#2)
// playList = "_-3E3" (String#22036, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_ON = "_-0SZ" (String#15156, DoABC#2)
// ROSM_SOUND_MACHINE_SWITCHED_OFF = "_-1o2" (String#18464, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// startPlayHeadPos = "_-0Xz" (String#15354, DoABC#2)
// removeItem = "_-2gu" (String#6888, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// _SafeStr_6658 = "_-1VW" (String#17722, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// playSong = "_-0VK" (String#4210, DoABC#2)
// requestPlayList = "_-0Vy" (String#817, DoABC#2)
// _musicController = "_-3Bw" (String#458, DoABC#2)
// isPlaying = "_-2gK" (String#6876, DoABC#2)
// playPosition = "_-3Ip" (String#7686, DoABC#2)
// nowPlayingSongId = "_-2A0" (String#6248, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// _SafeStr_7204 = "_-bQ" (String#938, DoABC#2)
// removeMessageEvent = "_-0vh" (String#4760, DoABC#2)
// addSongInfoRequest = "_-1QR" (String#5359, DoABC#2)
// updateVolume = "_-31S" (String#7334, DoABC#2)
// _isPlaying = "_-21z" (String#1803, DoABC#2)
// _nowPlayingSongId = "_-2Tg" (String#6639, DoABC#2)
// stopPlaying = "_-1Tb" (String#17648, DoABC#2)
// onPlayListMessage = "_-2MH" (String#19895, DoABC#2)
// onPlayListSongAddedMessage = "_-eA" (String#23809, DoABC#2)
// onSoundMachinePlayEvent = "_-zB" (String#24658, DoABC#2)
// onSoundMachineStopEvent = "_-fg" (String#23875, DoABC#2)
// startPlaying = "_-W8" (String#23497, DoABC#2)
// playNextSong = "_-Xd" (String#23546, DoABC#2)
// checkSongPlayState = "_-SL" (String#23339, DoABC#2)
// playCurrentSongAndNotify = "_-0jd" (String#15812, DoABC#2)
// getNextEntry = "_-2LI" (String#19860, DoABC#2)
// addItem = "_-3Ev" (String#7610, DoABC#2)
// moveItem = "_-2U1" (String#20200, DoABC#2)
// getEntryWithId = "_-2o4" (String#21004, DoABC#2)
// convertParserPlayList = "_-2uw" (String#21275, DoABC#2)


