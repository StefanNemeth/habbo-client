
package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.trax.TraxSequencer;
    import flash.utils.ByteArray;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDRoomEngine;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.habbo.sound.events.TraxSongLoadEvent;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IAsset;
    import flash.media.Sound;
    import com.sulake.habbo.sound.object.HabboSound;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.sulake.habbo.sound.trax.TraxData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.SoundSettingsEvent;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetSoundSettingsComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.sound.music.HabboMusicController;
    import com.sulake.habbo.communication.messages.outgoing.sound.SetSoundSettingsComposer;
    import com.sulake.habbo.communication.messages.parser.sound.SoundSettingsParser;
    import com.sulake.habbo.sound.trax.TraxSample;
    import flash.utils.getTimer;

    public class HabboSoundManagerFlash10 extends Component implements IHabboSoundManager, IUpdateReceiver 
    {

        private static const _SafeStr_13699:int = 60;
        private static const _SafeStr_13700:int = 25165823;
        private static const _SafeStr_13701:int = 0xFFFFFF;

        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _roomEngine:IRoomEngine;
        private var _notifications:IHabboNotifications;
        private var _volume:Number = 1;
        private var _SafeStr_13702:Map;
        private var _SafeStr_13703:Array;
        private var _SafeStr_13704:Map;
        private var _SafeStr_13705:Map;
        private var _SafeStr_13706:int = -1;
        private var _SafeStr_13707:TraxSequencer;
        private var _musicController:IHabboMusicController;
        private var _SafeStr_13708:Map;
        private var _SafeStr_13709:ByteArray;
        private var _SafeStr_13710:Boolean = false;

        public function HabboSoundManagerFlash10(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null, _arg_4:Boolean=true)
        {
            this._SafeStr_13702 = new Map();
            this._SafeStr_13703 = [];
            this._SafeStr_13704 = new Map();
            this._SafeStr_13705 = new Map();
            this._SafeStr_13708 = new Map();
            this._SafeStr_13709 = new ByteArray();
            super(_arg_1, _arg_2, _arg_3);
            if (_arg_4){
                queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationInit);
                queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
                queueInterface(new IIDRoomEngine(), this.onRoomEngineReady);
                queueInterface(new IIDHabboNotifications(), this.onNotificationsReady);
            };
            events.addEventListener(TraxSongLoadEvent.TSLE_TRAX_LOAD_COMPLETE, this.onTraxLoadComplete);
            registerUpdateReceiver(this, 1);
            Logger.log("Sound manager 10 init");
        }
        public function get musicController():IHabboMusicController
        {
            return (this._musicController);
        }
        public function get volume():Number
        {
            return (this._volume);
        }
        public function set volume(_arg_1:Number):void
        {
            this.updateVolumeSetting(_arg_1);
            this.storeVolumeSetting();
        }
        public function set previewVolume(_arg_1:Number):void
        {
            this.updateVolumeSetting(_arg_1);
        }
        override public function dispose():void
        {
            this._connection = null;
            if (this._musicController){
                this._musicController.dispose();
                this._musicController = null;
            };
            if (this._SafeStr_13704){
                this._SafeStr_13704.dispose();
                this._SafeStr_13704 = null;
            };
            if (this._SafeStr_13705){
                this._SafeStr_13705.dispose();
                this._SafeStr_13705 = null;
            };
            if (this._SafeStr_13702){
                this._SafeStr_13702.dispose();
                this._SafeStr_13702 = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._roomEngine){
                this._roomEngine.release(new IIDRoomEngine());
                this._roomEngine = null;
            };
            if (this._notifications){
                this._notifications.release(new IIDHabboNotifications());
                this._notifications = null;
            };
            super.dispose();
        }
        public function playSound(_arg_1:String):void
        {
            var _local_3:String;
            var _local_4:IAsset;
            var _local_5:Sound;
            var _local_2:HabboSound = this._SafeStr_13705.getValue(_arg_1);
            if (_local_2 == null){
                _local_3 = "";
                switch (_arg_1){
                    case HabboSoundTypesEnum._SafeStr_11957:
                        _local_3 = "sound_call_for_help";
                        break;
                    case HabboSoundTypesEnum._SafeStr_13696:
                        _local_3 = "sound_guide_received_invitation";
                        break;
                    case HabboSoundTypesEnum._SafeStr_11740:
                        _local_3 = "sound_console_new_message";
                        break;
                    case HabboSoundTypesEnum._SafeStr_11737:
                        _local_3 = "sound_console_message_sent";
                        break;
                    case HabboSoundTypesEnum._SafeStr_10667:
                        _local_3 = "sound_catalogue_pixels";
                        break;
                    case HabboSoundTypesEnum._SafeStr_10666:
                        _local_3 = "sound_catalogue_cash";
                        break;
                    case HabboSoundTypesEnum._SafeStr_13697:
                        _local_3 = "sound_respect_received";
                        break;
                    default:
                        Logger.log(("HabboSoundManagerFlash10: Unknown sound request: " + _arg_1));
                };
                _local_4 = assets.getAssetByName(_local_3);
                _local_5 = (_local_4.content as Sound);
                if (_local_5 == null){
                    return;
                };
                _local_2 = new HabboSound(_local_5);
                this._SafeStr_13705.add(_arg_1, _local_2);
            };
            _local_2.volume = this._volume;
            _local_2.play();
        }
        private function loadSample(_arg_1:int):void
        {
            if (this._configuration == null){
                return;
            };
            var _local_2:String = this._configuration.getKey("flash.dynamic.download.url", "furniture/");
            _local_2 = (_local_2 + this._configuration.getKey("flash.dynamic.download.samples.template", "mp3/sound_machine_sample_%typeid%.mp3"));
            _local_2 = _local_2.replace(/%typeid%/, _arg_1.toString());
            var _local_3:URLRequest = new URLRequest(_local_2);
            var _local_4:Sound = new Sound();
            _local_4.addEventListener(Event.COMPLETE, this.onSampleLoadComplete);
            _local_4.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler);
            _local_4.load(_local_3);
            this._SafeStr_13702.add(_local_4, _arg_1);
        }
        public function loadTraxSong(_arg_1:int, _arg_2:String):IHabboSound
        {
            if (this._SafeStr_13707 != null){
                return (this.addTraxSongForDownload(_arg_1, _arg_2));
            };
            var _local_3:TraxSequencer = this.createTraxInstance(_arg_1, _arg_2);
            if (!_local_3.ready){
                this._SafeStr_13707 = _local_3;
                this._SafeStr_13706 = _arg_1;
            };
            return ((_local_3 as IHabboSound));
        }
        private function addTraxSongForDownload(_arg_1:int, _arg_2:String):IHabboSound
        {
            var _local_3:TraxSequencer = this.createTraxInstance(_arg_1, _arg_2, false);
            if (!_local_3.ready){
                this._SafeStr_13708.add(_arg_1, _local_3);
            };
            return (_local_3);
        }
        private function createTraxInstance(_arg_1:int, _arg_2:String, _arg_3:Boolean=true):TraxSequencer
        {
            var _local_4:TraxData = new TraxData(_arg_2);
            var _local_5:TraxSequencer = new TraxSequencer(_arg_1, _local_4, this._SafeStr_13704, events);
            _local_5.volume = this._volume;
            this.validateSampleAvailability(_local_5, _arg_3);
            return (_local_5);
        }
        private function validateSampleAvailability(_arg_1:TraxSequencer, _arg_2:Boolean):void
        {
            var _local_3:TraxData = _arg_1.traxData;
            var _local_4:Array = _local_3.getSampleIds();
            var _local_5:Boolean;
            var _local_6:int;
            while (_local_6 < _local_4.length) {
                if (this._SafeStr_13704.getValue(int(_local_4[_local_6])) == null){
                    if (_arg_2){
                        this.loadSample(int(_local_4[_local_6]));
                    };
                    _local_5 = true;
                };
                _local_6++;
            };
            if (_local_5){
                _arg_1.ready = false;
            }
            else {
                _arg_1.ready = true;
            };
        }
        public function notifyPlayedSong(_arg_1:String, _arg_2:String):void
        {
            if (this._notifications == null){
                return;
            };
            this._notifications.addSongPlayingNotification(_arg_1, _arg_2);
        }
        private function onHabboConfigurationInit(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 != null){
                this._configuration = (_arg_2 as IHabboConfigurationManager);
                if (this._configuration.getBoolean("trax.player.sample.memory.purge.enabled", false)){
                    this._SafeStr_13710 = true;
                };
            };
        }
        protected function setHabboConfiguration(_arg_1:IHabboConfigurationManager):void
        {
            this._configuration = _arg_1;
        }
        private function onCommunicationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 != null){
                this._communication = IHabboCommunicationManager(_arg_2);
                this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            };
        }
        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = this._communication.getHabboMainConnection(this.onConnectionReady);
            if (_local_2 != null){
                _local_2.addMessageEvent(new SoundSettingsEvent(this.onSoundSettingsEvent));
                _local_2.send(new GetSoundSettingsComposer());
                this.onConnectionReady(_local_2);
                this.initMusicController();
            };
        }
        private function onRoomEngineReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 == null){
                return;
            };
            this._roomEngine = IRoomEngine(_arg_2);
            this.initMusicController();
        }
        private function onNotificationsReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (_arg_2 == null){
                return;
            };
            this._notifications = IHabboNotifications(_arg_2);
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
            };
            this.initMusicController();
        }
        private function initMusicController():void
        {
            if ((((((((this._configuration == null)) || ((this._connection == null)))) || ((this._roomEngine == null)))) || (!((this._musicController == null))))){
                return;
            };
            this._musicController = new HabboMusicController(this, events, this._roomEngine.events, this._connection);
        }
        protected function setMusicController(_arg_1:IHabboMusicController):void
        {
            this._musicController = _arg_1;
        }
        private function onSampleLoadComplete(_arg_1:Event):void
        {
            var _local_2:Sound = (_arg_1.target as Sound);
            this._SafeStr_13703.push(_local_2);
        }
        private function onTraxLoadComplete(_arg_1:Event):void
        {
            var _local_2:TraxSongLoadEvent = (_arg_1 as TraxSongLoadEvent);
            if (_local_2 == null){
                return;
            };
            if (this._musicController == null){
                return;
            };
            this._musicController.onSongLoaded(_local_2.id);
        }
        private function ioErrorHandler(_arg_1:Event):void
        {
            events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.TSLE_TRAX_LOAD_FAILED, this._SafeStr_13706));
            this._SafeStr_13706 = -1;
            this._SafeStr_13707 = null;
        }
        private function storeVolumeSetting():void
        {
            if (this._connection != null){
                this._connection.send(new SetSoundSettingsComposer(int((this._volume * 100))));
            };
        }
        private function updateVolumeSetting(_arg_1:Number):void
        {
            this._volume = _arg_1;
            this._musicController.updateVolume(this._volume);
        }
        private function onSoundSettingsEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:SoundSettingsEvent = (_arg_1 as SoundSettingsEvent);
            var _local_3:SoundSettingsParser = (_local_2.getParser() as SoundSettingsParser);
            if ((((_local_3.volume == 1)) || ((_local_3.volume == 0)))){
                this.updateVolumeSetting((_local_3.volume * 1));
            }
            else {
                this.updateVolumeSetting((_local_3.volume / 100));
            };
        }
        private function processLoadedSample(_arg_1:Sound):void
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_4:TraxSample;
            if (this._SafeStr_13702.getValue(_arg_1) != null){
                _local_2 = this._SafeStr_13702.remove(_arg_1);
                if (this._SafeStr_13704.getValue(_local_2) == null){
                    this._SafeStr_13709.clear();
                    _local_3 = _arg_1.length;
                    _arg_1.extract(this._SafeStr_13709, int((_local_3 * 44.1)));
                    _local_4 = new TraxSample(this._SafeStr_13709, _local_2, TraxSample._SafeStr_6173, TraxSample._SafeStr_6176);
                    this._SafeStr_13704.add(_local_2, _local_4);
                };
            };
        }
        private function processLoadedSamples():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:Sound;
            var _local_4:int;
            if (this._SafeStr_13703.length > 0){
                _local_1 = getTimer();
                _local_2 = _local_1;
                while (((((_local_2 - _local_1) < _SafeStr_13699)) && ((this._SafeStr_13703.length > 0)))) {
                    _local_3 = this._SafeStr_13703.splice(0, 1)[0];
                    this.processLoadedSample(_local_3);
                    _local_2 = getTimer();
                };
                if ((((this._SafeStr_13702.length == 0)) && (!((this._SafeStr_13706 == -1))))){
                    this._SafeStr_13707.ready = true;
                    _local_4 = this._SafeStr_13706;
                    this._SafeStr_13706 = -1;
                    this._SafeStr_13707 = null;
                    events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.TSLE_TRAX_LOAD_COMPLETE, _local_4));
                    if (this._SafeStr_13710){
                        this.processSampleMemoryUsage();
                    };
                };
            };
        }
        private function loadNextSong():void
        {
            var _local_1:int;
            var _local_2:TraxSequencer;
            if ((((this._SafeStr_13707 == null)) && ((this._SafeStr_13708.length > 0)))){
                _local_1 = this._SafeStr_13708.getKey(0);
                _local_2 = this._SafeStr_13708.remove(_local_1);
                if (((!((_local_2 == null))) && (!(_local_2.disposed)))){
                    this.validateSampleAvailability(_local_2, true);
                    if (_local_2.ready){
                        events.dispatchEvent(new TraxSongLoadEvent(TraxSongLoadEvent.TSLE_TRAX_LOAD_COMPLETE, _local_1));
                    }
                    else {
                        this._SafeStr_13707 = _local_2;
                        this._SafeStr_13706 = _local_1;
                    };
                };
            };
        }
        public function update(_arg_1:uint):void
        {
            this.processLoadedSamples();
            this.loadNextSong();
        }
        private function logSampleUsage():void
        {
        }
        private function processSampleMemoryUsage():void
        {
            var _local_5:int;
            var _local_6:TraxSample;
            var _local_7:Array;
            var _local_8:uint;
            var _local_9:int;
            var _local_10:TraxSample;
            var _local_11:int;
            var _local_12:TraxSample;
            var _local_1:uint;
            var _local_2:Array = [];
            var _local_3:Array = this._musicController.samplesIdsInUse;
            var _local_4:int;
            while (_local_4 < this._SafeStr_13704.length) {
                _local_5 = this._SafeStr_13704.getKey(_local_4);
                _local_6 = this._SafeStr_13704.getWithIndex(_local_4);
                if (((!((_local_6.usageCount == 0))) && ((_local_3.indexOf(_local_5) == -1)))){
                    _local_2.push(_local_6);
                };
                _local_1 = (_local_1 + _local_6.length);
                _local_4++;
            };
            if (_local_1 > _SafeStr_13700){
                _local_7 = [];
                Logger.log("Sample memory limit reached, clearing the oldest and least frequently used samples");
                _local_2.sort(this.orderUsageAndTimeStamp);
                _local_8 = 0;
                _local_9 = 0;
                while ((((_local_8 < (_local_1 - _SafeStr_13701))) && ((_local_9 < _local_2.length)))) {
                    _local_10 = _local_2[_local_9++];
                    _local_8 = (_local_8 + _local_10.length);
                    _local_7.push(_local_10.id);
                };
                _local_2 = null;
                if (_local_7.length > 0){
                    for each (_local_11 in _local_7) {
                        Logger.log(("Purging sample : " + _local_11));
                        _local_12 = (this._SafeStr_13704.getValue(_local_11) as TraxSample);
                        _local_12.dispose();
                        this._SafeStr_13704.remove(_local_11);
                    };
                    this._musicController.samplesUnloaded(_local_7);
                };
            };
        }
        private function orderUsageAndTimeStamp(_arg_1:TraxSample, _arg_2:TraxSample):int
        {
            if (_arg_1.usageCount < _arg_2.usageCount){
                return (-1);
            };
            if (_arg_1.usageCount > _arg_2.usageCount){
                return (1);
            };
            if (_arg_1.usageTimeStamp < _arg_2.usageTimeStamp){
                return (-1);
            };
            if (_arg_1.usageTimeStamp > _arg_2.usageTimeStamp){
                return (1);
            };
            return (0);
        }

    }
}//package com.sulake.habbo.sound

// IID = "_-3KV" (String#7712, DoABC#2)
// _SafeStr_10666 = "_-218" (String#19056, DoABC#2)
// _SafeStr_10667 = "_-1Ze" (String#17876, DoABC#2)
// onHabboConfigurationInit = "_-1NP" (String#851, DoABC#2)
// onAuthenticationOK = "_-20A" (String#612, DoABC#2)
// ioErrorHandler = "_-1tF" (String#5906, DoABC#2)
// _notifications = "_-ef" (String#940, DoABC#2)
// onNotificationsReady = "_-AF" (String#2065, DoABC#2)
// _SafeStr_11737 = "_-0u3" (String#16205, DoABC#2)
// _SafeStr_11740 = "_-WS" (String#23509, DoABC#2)
// _SafeStr_11957 = "_-0BV" (String#14505, DoABC#2)
// addSongPlayingNotification = "_-fE" (String#8499, DoABC#2)
// HabboSoundTypesEnum = "_-0vP" (String#16253, DoABC#2)
// TSLE_TRAX_LOAD_COMPLETE = "_-0Fd" (String#14669, DoABC#2)
// TSLE_TRAX_LOAD_FAILED = "_-0hO" (String#15724, DoABC#2)
// _SafeStr_13696 = "_-EI" (String#22783, DoABC#2)
// _SafeStr_13697 = "_-Aa" (String#22638, DoABC#2)
// _SafeStr_13699 = "_-kq" (String#24063, DoABC#2)
// _SafeStr_13700 = "_-1Fb" (String#17098, DoABC#2)
// _SafeStr_13701 = "_-2bV" (String#20504, DoABC#2)
// _SafeStr_13702 = "_-0ks" (String#15859, DoABC#2)
// _SafeStr_13703 = "_-34Z" (String#21680, DoABC#2)
// _SafeStr_13704 = "_-26g" (String#19279, DoABC#2)
// _SafeStr_13705 = "_-2E2" (String#19570, DoABC#2)
// _SafeStr_13706 = "_-10k" (String#16489, DoABC#2)
// _SafeStr_13707 = "_-27L" (String#19306, DoABC#2)
// _SafeStr_13708 = "_-1J7" (String#17241, DoABC#2)
// _SafeStr_13709 = "_-2WB" (String#20290, DoABC#2)
// _SafeStr_13710 = "_-30L" (String#21515, DoABC#2)
// onTraxLoadComplete = "_-1sM" (String#18647, DoABC#2)
// updateVolumeSetting = "_-0Xn" (String#15348, DoABC#2)
// storeVolumeSetting = "_-14X" (String#16636, DoABC#2)
// loadSample = "_-F7" (String#22819, DoABC#2)
// onSampleLoadComplete = "_-1E0" (String#17027, DoABC#2)
// addTraxSongForDownload = "_-1y6" (String#18892, DoABC#2)
// createTraxInstance = "_-12E" (String#16546, DoABC#2)
// validateSampleAvailability = "_-0V6" (String#15246, DoABC#2)
// setHabboConfiguration = "_-2ws" (String#21341, DoABC#2)
// onSoundSettingsEvent = "_-3IE" (String#22211, DoABC#2)
// initMusicController = "_-1KQ" (String#17291, DoABC#2)
// setMusicController = "_-1m4" (String#18382, DoABC#2)
// processLoadedSample = "_-UV" (String#23429, DoABC#2)
// processLoadedSamples = "_-0fp" (String#15664, DoABC#2)
// processSampleMemoryUsage = "_-0vt" (String#16269, DoABC#2)
// loadNextSong = "_-0-4" (String#14014, DoABC#2)
// logSampleUsage = "_-0uG" (String#16213, DoABC#2)
// orderUsageAndTimeStamp = "_-0Co" (String#14562, DoABC#2)
// IHabboSound = "_-tK" (String#8755, DoABC#2)
// TraxData = "_-kA" (String#8604, DoABC#2)
// SetSoundSettingsComposer = "_-0Vr" (String#15272, DoABC#2)
// TraxSequencer = "_-0aW" (String#4313, DoABC#2)
// GetSoundSettingsComposer = "_-2mn" (String#20953, DoABC#2)
// TraxSample = "_-285" (String#6206, DoABC#2)
// SoundSettingsEvent = "_-0Zh" (String#15431, DoABC#2)
// HabboMusicController = "_-0hU" (String#4457, DoABC#2)
// HabboSound = "_-1YJ" (String#5525, DoABC#2)
// SoundSettingsParser = "_-WA" (String#8325, DoABC#2)
// TraxSongLoadEvent = "_-2VX" (String#6673, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// getSampleIds = "_-1c-" (String#17971, DoABC#2)
// traxData = "_-2S4" (String#20122, DoABC#2)
// _SafeStr_6173 = "_-1W8" (String#17748, DoABC#2)
// _SafeStr_6176 = "_-0FJ" (String#14656, DoABC#2)
// usageCount = "_-1s-" (String#18631, DoABC#2)
// usageTimeStamp = "_-V9" (String#23455, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// _musicController = "_-3Bw" (String#458, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// previewVolume = "_-1fh" (String#5660, DoABC#2)
// loadTraxSong = "_-1OI" (String#5318, DoABC#2)
// updateVolume = "_-31S" (String#7334, DoABC#2)
// onSongLoaded = "_-1iX" (String#5723, DoABC#2)
// samplesUnloaded = "_-1dU" (String#5623, DoABC#2)
// samplesIdsInUse = "_-0Sc" (String#4152, DoABC#2)
// notifyPlayedSong = "_-3FC" (String#22085, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onCommunicationManagerReady = "_-3A0" (String#914, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


