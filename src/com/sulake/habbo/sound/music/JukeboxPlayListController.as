
package com.sulake.habbo.sound.music
{
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.IHabboMusicController;
    import flash.events.IEventDispatcher;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.sound.HabboSoundManagerFlash10;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.NowPlayingMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxSongDisksMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.JukeboxPlayListFullMessageEvent;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.sound.HabboMusicPrioritiesEnum;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetJukeboxPlayListMessageComposer;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageParser;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.communication.messages.parser.sound.JukeboxSongDisksMessageParser;
    import com.sulake.habbo.sound.events.PlayListStatusEvent;

    public class JukeboxPlayListController implements IPlayListController 
    {

        private var _disposed:Boolean = false;
        private var _isPlaying:Boolean = false;
        private var _entries:Array;
        private var _musicController:IHabboMusicController;
        private var _events:IEventDispatcher;
        private var _connection:IConnection;
        private var _soundManager:HabboSoundManagerFlash10;
        private var _nowPlayingSongId:int = -1;
        private var _SafeStr_7748:Array;
        private var _SafeStr_7204:Array;
        private var _playPosition:int = -1;

        public function JukeboxPlayListController(_arg_1:HabboSoundManagerFlash10, _arg_2:HabboMusicController, _arg_3:IEventDispatcher, _arg_4:IConnection)
        {
            var _local_5:IMessageEvent;
            this._entries = new Array();
            this._SafeStr_7748 = new Array();
            super();
            this._soundManager = _arg_1;
            this._musicController = _arg_2;
            this._events = _arg_3;
            this._connection = _arg_4;
            this._SafeStr_7204 = [];
            this._SafeStr_7204.push(new NowPlayingMessageEvent(this.onNowPlayingMessage));
            this._SafeStr_7204.push(new JukeboxSongDisksMessageEvent(this.onJukeboxSongDisksMessage));
            this._SafeStr_7204.push(new JukeboxPlayListFullMessageEvent(this.onJukeboxPlayListFullMessage));
            for each (_local_5 in this._SafeStr_7204) {
                this._connection.addMessageEvent(_local_5);
            };
            this._events.addEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
            this._musicController.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
        }
        public function get priority():int
        {
            return (HabboMusicPrioritiesEnum._SafeStr_6658);
        }
        public function get nowPlayingSongId():int
        {
            return (this._nowPlayingSongId);
        }
        public function get playPosition():int
        {
            return (this._playPosition);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get isPlaying():Boolean
        {
            return (this._isPlaying);
        }
        public function get length():int
        {
            if (this._entries == null){
                return (0);
            };
            return (this._entries.length);
        }
        public function dispose():void
        {
            var _local_1:IMessageEvent;
            if (!this._disposed){
                this.stopPlaying();
                if (this._musicController.events){
                    this._musicController.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                };
                this._musicController = null;
                this._soundManager = null;
                if (this._connection){
                    for each (_local_1 in this._SafeStr_7204) {
                        this._connection.removeMessageEvent(_local_1);
                        _local_1.dispose();
                    };
                    this._SafeStr_7204 = null;
                    this._connection = null;
                };
                if (this._events){
                    this._events.removeEventListener(SoundCompleteEvent.TRAX_SONG_COMPLETE, this.onSongFinishedPlayingEvent);
                    this._events = null;
                };
                this._disposed = true;
            };
        }
        public function stopPlaying():void
        {
            this._musicController.stop(this.priority);
            this._nowPlayingSongId = -1;
            this._playPosition = -1;
            this._isPlaying = false;
        }
        public function requestPlayList():void
        {
            if (this._connection == null){
                return;
            };
            this._connection.send(new GetJukeboxPlayListMessageComposer());
        }
        public function getEntry(_arg_1:int):ISongInfo
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this._entries.length)))){
                return (null);
            };
            return (this._entries[_arg_1]);
        }
        protected function onSongFinishedPlayingEvent(_arg_1:SoundCompleteEvent):void
        {
        }
        private function onNowPlayingMessage(_arg_1:IMessageEvent):void
        {
            var _local_2:NowPlayingMessageEvent = (_arg_1 as NowPlayingMessageEvent);
            var _local_3:NowPlayingMessageParser = (_local_2.getParser() as NowPlayingMessageParser);
            Logger.log(((((("Received Now Playing message with: " + _local_3.currentSongId) + ", ") + _local_3.nextSongId) + ", ") + _local_3.syncCount));
            this._isPlaying = !((_local_3.currentSongId == -1));
            if (_local_3.currentSongId >= 0){
                this._musicController.playSong(_local_3.currentSongId, HabboMusicPrioritiesEnum._SafeStr_6658, (_local_3.syncCount / 1000), 0, 1, 1);
                this._nowPlayingSongId = _local_3.currentSongId;
            }
            else {
                this.stopPlaying();
            };
            if (_local_3.nextSongId >= 0){
                this._musicController.addSongInfoRequest(_local_3.nextSongId);
            };
            this._playPosition = _local_3.currentPosition;
            this._soundManager.events.dispatchEvent(new NowPlayingEvent(NowPlayingEvent.RWPLENPE_SONG_CHANGED, HabboMusicPrioritiesEnum._SafeStr_6658, _local_3.currentSongId, _local_3.currentPosition));
        }
        private function onJukeboxSongDisksMessage(_arg_1:IMessageEvent):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:SongDataEntry;
            var _local_2:JukeboxSongDisksMessageEvent = (_arg_1 as JukeboxSongDisksMessageEvent);
            var _local_3:JukeboxSongDisksMessageParser = (_local_2.getParser() as JukeboxSongDisksMessageParser);
            Logger.log(("Received Jukebox song disks (=playlist) message, length of playlist: " + _local_3.songDisks.length));
            this._entries = new Array();
            var _local_4:int;
            while (_local_4 < _local_3.songDisks.length) {
                _local_5 = _local_3.songDisks.getWithIndex(_local_4);
                _local_6 = _local_3.songDisks.getKey(_local_4);
                _local_7 = (this._musicController.getSongInfo(_local_5) as SongDataEntry);
                if (_local_7 == null){
                    _local_7 = new SongDataEntry(_local_5, -1, null, null, null);
                    if (this._SafeStr_7748.indexOf(_local_5) < 0){
                        this._SafeStr_7748.push(_local_5);
                        this._musicController.requestSongInfoWithoutSamples(_local_5);
                    };
                };
                _local_7.diskId = _local_6;
                this._entries.push(_local_7);
                _local_4++;
            };
            if (this._SafeStr_7748.length == 0){
                this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED));
            };
        }
        private function onJukeboxPlayListFullMessage(_arg_1:IMessageEvent):void
        {
            Logger.log("Received jukebox playlist full message.");
            this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.RWPLEE_PLAY_LIST_FULL));
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_4:ISongInfo;
            var _local_5:int;
            var _local_6:SongDataEntry;
            var _local_2:int;
            while (_local_2 < this.length) {
                _local_4 = this._entries[_local_2];
                if (_local_4.id == _arg_1.id){
                    _local_5 = _local_4.diskId;
                    _local_6 = (this._musicController.getSongInfo(_arg_1.id) as SongDataEntry);
                    if (_local_6 != null){
                        _local_6.diskId = _local_5;
                        this._entries[_local_2] = _local_6;
                    };
                    break;
                };
                _local_2++;
            };
            var _local_3:int = this._SafeStr_7748.indexOf(_arg_1.id);
            if (_local_3 >= 0){
                this._SafeStr_7748.splice(_local_3, 1);
            };
            if (this._SafeStr_7748.length == 0){
                this._events.dispatchEvent(new PlayListStatusEvent(PlayListStatusEvent.RWPLEE_PLAY_LIST_UPDATED));
            };
        }

    }
}//package com.sulake.habbo.sound.music

// HabboMusicController = "_-0hU" (String#4457, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// SoundCompleteEvent = "_-2-X" (String#6037, DoABC#2)
// JukeboxPlayListController = "_-2ld" (String#6996, DoABC#2)
// NowPlayingEvent = "_-1nK" (String#5803, DoABC#2)
// HabboMusicPrioritiesEnum = "_-2lY" (String#6994, DoABC#2)
// SongDataEntry = "_-23d" (String#6117, DoABC#2)
// JukeboxSongDisksMessageEvent = "_-0c1" (String#15514, DoABC#2)
// NowPlayingMessageEvent = "_-0NW" (String#14973, DoABC#2)
// JukeboxPlayListFullMessageEvent = "_-0kw" (String#15863, DoABC#2)
// GetJukeboxPlayListMessageComposer = "_-1-Q" (String#16444, DoABC#2)
// JukeboxSongDisksMessageParser = "_-23t" (String#6119, DoABC#2)
// PlayListStatusEvent = "_-a-" (String#8420, DoABC#2)
// NowPlayingMessageParser = "_-2On" (String#6536, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// getEntry = "_-ig" (String#2166, DoABC#2)
// songDisks = "_-87" (String#22546, DoABC#2)
// currentSongId = "_-A6" (String#22622, DoABC#2)
// currentPosition = "_-2Ed" (String#19591, DoABC#2)
// nextSongId = "_-Gd" (String#22875, DoABC#2)
// syncCount = "_-2kq" (String#20879, DoABC#2)
// _entries = "_-1mm" (String#5795, DoABC#2)
// RWPLEE_PLAY_LIST_UPDATED = "_-0WY" (String#15300, DoABC#2)
// RWPLEE_PLAY_LIST_FULL = "_-1li" (String#18362, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
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
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)
// _isPlaying = "_-21z" (String#1803, DoABC#2)
// _nowPlayingSongId = "_-2Tg" (String#6639, DoABC#2)
// _SafeStr_7748 = "_-36c" (String#21751, DoABC#2)
// _playPosition = "_-2Ub" (String#20221, DoABC#2)
// onNowPlayingMessage = "_-4P" (String#22393, DoABC#2)
// onJukeboxSongDisksMessage = "_-1IF" (String#17203, DoABC#2)
// stopPlaying = "_-1Tb" (String#17648, DoABC#2)


