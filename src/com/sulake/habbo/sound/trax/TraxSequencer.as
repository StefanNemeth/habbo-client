
package com.sulake.habbo.sound.trax
{
    import com.sulake.habbo.sound.IHabboSound;
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.events.IEventDispatcher;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.media.SoundTransform;
    import flash.utils.getTimer;
    import flash.events.SampleDataEvent;
    import flash.events.TimerEvent;
    import flash.utils.ByteArray;
    import com.sulake.habbo.sound.events.SoundCompleteEvent;
    import __AS3__.vec.*;

    public class TraxSequencer implements IHabboSound, IDisposable 
    {

        private static const _SafeStr_6125:Number = 44100;
        private static const _SafeStr_6126:uint = 0x2000;
        private static const _SafeStr_6127:uint = 88000;
        private static const _SafeStr_6128:uint = 88000;
        private static const _SafeStr_6129:Vector.<int> = new Vector.<int>(_SafeStr_6126, true);
        private static const INTERPOLATION_BUFFER:Vector.<int> = new Vector.<int>(_SafeStr_6126, true);

        private var _disposed:Boolean = false;
        private var _events:IEventDispatcher;
        private var _volume:Number;
        private var _SafeStr_6130:Sound;
        private var _SafeStr_4030:SoundChannel;
        private var _traxData:TraxData;
        private var _SafeStr_6132:Map;
        private var _ready:Boolean;
        private var _songId:int;
        private var _SafeStr_6134:int = 0;
        private var _position:uint;
        private var _SafeStr_6136:Array;
        private var _SafeStr_6137:Boolean;
        private var _finished:Boolean = true;
        private var _SafeStr_6139:uint;
        private var _SafeStr_6140:uint;
        private var _SafeStr_6141:Boolean;
        private var _SafeStr_6142:Boolean;
        private var _fadeInSeconds:int;
        private var _fadeOutSeconds:int;
        private var _SafeStr_6145:int;
        private var _SafeStr_6146:int;
        private var _SafeStr_6147:Timer;
        private var _SafeStr_6148:Timer;
        private var _SafeStr_6149:Boolean;
        private var _SafeStr_6150:int = 0;
        private var _SafeStr_6151:int = 0;

        public function TraxSequencer(_arg_1:int, _arg_2:TraxData, _arg_3:Map, _arg_4:IEventDispatcher)
        {
            this._SafeStr_6140 = uint(30);
            super();
            this._events = _arg_4;
            this._songId = _arg_1;
            this._volume = 1;
            this._SafeStr_6130 = new Sound();
            this._SafeStr_4030 = null;
            this._SafeStr_6132 = _arg_3;
            this._traxData = _arg_2;
            this._ready = true;
            this._position = 0;
            this._SafeStr_6136 = [];
            this._SafeStr_6137 = false;
            this._SafeStr_6139 = 0;
            this._finished = false;
            this._SafeStr_6141 = false;
            this._SafeStr_6142 = false;
            this._fadeInSeconds = 0;
            this._fadeOutSeconds = 0;
            this._SafeStr_6145 = 0;
            this._SafeStr_6146 = 0;
        }
        public function set position(_arg_1:Number):void
        {
            this._position = uint((_arg_1 * _SafeStr_6125));
        }
        public function get volume():Number
        {
            return (this._volume);
        }
        public function get position():Number
        {
            return ((this._position / _SafeStr_6125));
        }
        public function get ready():Boolean
        {
            return (this._ready);
        }
        public function set ready(_arg_1:Boolean):void
        {
            this._ready = _arg_1;
        }
        public function get finished():Boolean
        {
            return (this._finished);
        }
        public function get fadeOutSeconds():Number
        {
            return ((this._fadeOutSeconds / _SafeStr_6125));
        }
        public function set fadeOutSeconds(_arg_1:Number):void
        {
            this._fadeOutSeconds = int((_arg_1 * _SafeStr_6125));
        }
        public function get fadeInSeconds():Number
        {
            return ((this._fadeInSeconds / _SafeStr_6125));
        }
        public function set fadeInSeconds(_arg_1:Number):void
        {
            this._fadeInSeconds = int((_arg_1 * _SafeStr_6125));
        }
        public function get traxData():TraxData
        {
            return (this._traxData);
        }
        public function set volume(_arg_1:Number):void
        {
            this._volume = _arg_1;
            if (this._SafeStr_4030 != null){
                this._SafeStr_4030.soundTransform = new SoundTransform(this._volume);
            };
        }
        public function get length():Number
        {
            return ((this._SafeStr_6139 / _SafeStr_6125));
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.TraxSequencer();
                this._traxData = null;
                this._SafeStr_6132 = null;
                this._SafeStr_6136 = null;
                this._events = null;
                this._SafeStr_6130 = null;
                this._disposed = true;
            };
        }
        public function prepare():Boolean
        {
            if (!this._ready){
                Logger.log("Cannot start trax playback until samples ready!");
                return (false);
            };
            if (!this._SafeStr_6137){
                if (this._traxData != null){
                    this._SafeStr_6149 = false;
                    if (this._traxData.hasMetaData){
                        this._SafeStr_6149 = this._traxData.metaCutMode;
                    };
                    if (this._SafeStr_6149){
                        if (!this.TraxSequencer()){
                            Logger.log("Cannot start playback, prepare sequence failed!");
                            return (false);
                        };
                    }
                    else {
                        if (!this.TraxSequencer()){
                            Logger.log("Cannot start playback, prepare legacy sequence failed!");
                            return (false);
                        };
                    };
                };
            };
            return (true);
        }
        private function TraxSequencer():Boolean
        {
            var _local_3:Map;
            var _local_4:TraxChannel;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:int;
            var _local_8:int;
            var _local_9:TraxSample;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            if (this._SafeStr_6136 == null){
                return (false);
            };
            var _local_1:uint = getTimer();
            var _local_2:int;
            while (_local_2 < this._traxData.channels.length) {
                _local_3 = new Map();
                _local_4 = (this._traxData.channels[_local_2] as TraxChannel);
                _local_5 = 0;
                _local_6 = 0;
                _local_7 = 0;
                while (_local_7 < _local_4.itemCount) {
                    _local_8 = _local_4.GroupItem(_local_7).id;
                    _local_9 = (this._SafeStr_6132.getValue(_local_8) as TraxSample);
                    _local_9.TraxSample(this._songId, _local_1);
                    if (_local_9 != null){
                        _local_10 = this.TraxSequencer(_local_9.length);
                        _local_11 = (_local_4.GroupItem(_local_7).length / _local_10);
                        _local_12 = 0;
                        while (_local_12 < _local_11) {
                            if (_local_8 != 0){
                                _local_3.add(_local_5, _local_9);
                            };
                            _local_6 = (_local_6 + _local_10);
                            _local_5 = (_local_6 * _SafeStr_6128);
                            _local_12++;
                        };
                    }
                    else {
                        Logger.log("Error in prepareLegacySequence(), sample was null!");
                        return (false);
                    };
                    if (this._SafeStr_6139 < _local_5){
                        this._SafeStr_6139 = _local_5;
                    };
                    _local_7++;
                };
                this._SafeStr_6136.push(_local_3);
                _local_2++;
            };
            this._SafeStr_6137 = true;
            return (true);
        }
        private function TraxSequencer():Boolean
        {
            var _local_3:Map;
            var _local_4:TraxChannel;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:Boolean;
            var _local_8:int;
            var _local_9:int;
            var _local_10:TraxSample;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            if (this._SafeStr_6136 == null){
                return (false);
            };
            var _local_1:uint = getTimer();
            var _local_2:int;
            while (_local_2 < this._traxData.channels.length) {
                _local_3 = new Map();
                _local_4 = (this._traxData.channels[_local_2] as TraxChannel);
                _local_5 = 0;
                _local_6 = 0;
                _local_7 = false;
                _local_8 = 0;
                while (_local_8 < _local_4.itemCount) {
                    _local_9 = _local_4.GroupItem(_local_8).id;
                    _local_10 = (this._SafeStr_6132.getValue(_local_9) as TraxSample);
                    _local_10.TraxSample(this._songId, _local_1);
                    if (_local_10 != null){
                        _local_11 = _local_6;
                        _local_12 = _local_5;
                        _local_13 = this.TraxSequencer(_local_10.length);
                        _local_14 = _local_4.GroupItem(_local_8).length;
                        while (_local_11 < (_local_6 + _local_14)) {
                            if (((!((_local_9 == 0))) || (_local_7))){
                                _local_3.add(_local_12, _local_10);
                                _local_7 = false;
                            };
                            _local_11 = (_local_11 + _local_13);
                            _local_12 = (_local_11 * _SafeStr_6128);
                            if (_local_11 > (_local_6 + _local_14)){
                                _local_7 = true;
                            };
                        };
                        _local_6 = (_local_6 + _local_4.GroupItem(_local_8).length);
                        _local_5 = (_local_6 * _SafeStr_6128);
                    }
                    else {
                        Logger.log("Error in prepareSequence(), sample was null!");
                        return (false);
                    };
                    if (this._SafeStr_6139 < _local_5){
                        this._SafeStr_6139 = _local_5;
                    };
                    _local_8++;
                };
                this._SafeStr_6136.push(_local_3);
                _local_2++;
            };
            this._SafeStr_6137 = true;
            return (true);
        }
        public function play(_arg_1:Number=0):Boolean
        {
            if (!this.prepare()){
                return (false);
            };
            this.TraxSequencer();
            if (this._SafeStr_4030 != null){
                this.TraxSequencer();
            };
            if (this._fadeInSeconds > 0){
                this._SafeStr_6141 = true;
                this._SafeStr_6145 = 0;
            };
            this._SafeStr_6142 = false;
            this._SafeStr_6146 = 0;
            this._finished = false;
            this._SafeStr_6130.addEventListener(SampleDataEvent.SAMPLE_DATA, this.TraxSequencer);
            this._SafeStr_6134 = (_arg_1 * _SafeStr_6125);
            this._SafeStr_6150 = 0;
            this._SafeStr_6151 = 0;
            this._SafeStr_4030 = this._SafeStr_6130.play();
            this.volume = this._volume;
            return (true);
        }
        public function render(_arg_1:SampleDataEvent):Boolean
        {
            if (!this.prepare()){
                return (false);
            };
            while (!(this._finished)) {
                this.TraxSequencer(_arg_1);
            };
            return (true);
        }
        public function stop():Boolean
        {
            if ((((this._fadeOutSeconds > 0)) && (!(this._finished)))){
                this.TraxSequencer();
            }
            else {
                this.TraxSequencer();
            };
            return (true);
        }
        private function TraxSequencer():void
        {
            this.TraxSequencer();
            if (this._SafeStr_4030 != null){
                this._SafeStr_4030.stop();
                this._SafeStr_4030 = null;
            };
            if (this._SafeStr_6130 != null){
                this._SafeStr_6130.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.TraxSequencer);
            };
        }
        private function TraxSequencer():void
        {
            if (this._SafeStr_6147 == null){
                this._SafeStr_6142 = true;
                this._SafeStr_6146 = 0;
                this._SafeStr_6147 = new Timer((this._SafeStr_6140 + (this._fadeOutSeconds / (_SafeStr_6125 / 1000))), 1);
                this._SafeStr_6147.start();
                this._SafeStr_6147.addEventListener(TimerEvent.TIMER_COMPLETE, this.TraxSequencer);
            };
        }
        private function TraxSequencer(_arg_1:uint):int
        {
            if (this._SafeStr_6149){
                return (Math.round((_arg_1 / _SafeStr_6127)));
            };
            return (Math.ceil((_arg_1 / _SafeStr_6127)));
        }
        private function TraxSequencer():Array
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:Map;
            var _local_5:int;
            var _local_1:Array = [];
            if (this._SafeStr_6136 != null){
                _local_2 = this._SafeStr_6136.length;
                _local_3 = 0;
                while (_local_3 < _local_2) {
                    _local_4 = this._SafeStr_6136[_local_3];
                    _local_5 = 0;
                    while ((((_local_5 < _local_4.length)) && ((_local_4.getKey(_local_5) < this._position)))) {
                        _local_5++;
                    };
                    _local_1.push((_local_5 - 1));
                    _local_3++;
                };
            };
            return (_local_1);
        }
        private function TraxSequencer():void
        {
            var _local_5:Map;
            var _local_6:int;
            var _local_7:TraxSample;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            if (this._SafeStr_6136 == null){
                return;
            };
            var _local_1:Array = this.TraxSequencer();
            var _local_2:int = this._SafeStr_6136.length;
            var _local_3:TraxChannelSample;
            var _local_4:int = (_local_2 - 1);
            while (_local_4 >= 0) {
                _local_5 = this._SafeStr_6136[_local_4];
                _local_6 = _local_1[_local_4];
                _local_7 = _local_5.getWithIndex(_local_6);
                if (_local_7 == null){
                    _local_3 = null;
                }
                else {
                    _local_10 = _local_5.getKey(_local_6);
                    _local_11 = (this._position - _local_10);
                    if ((((_local_7.id == 0)) || ((_local_11 < 0)))){
                        _local_3 = null;
                    }
                    else {
                        _local_3 = new TraxChannelSample(_local_7, _local_11);
                    };
                };
                _local_8 = _SafeStr_6126;
                if ((this._SafeStr_6139 - this._position) < _local_8){
                    _local_8 = (this._SafeStr_6139 - this._position);
                };
                _local_9 = 0;
                while (_local_9 < _local_8) {
                    _local_12 = _local_8;
                    if (_local_6 < (_local_5.length - 1)){
                        _local_13 = _local_5.getKey((_local_6 + 1));
                        if ((_local_8 + this._position) >= _local_13){
                            _local_12 = (_local_13 - this._position);
                        };
                    };
                    if (_local_12 > (_local_8 - _local_9)){
                        _local_12 = (_local_8 - _local_9);
                    };
                    if (_local_4 == (_local_2 - 1)){
                        if (_local_3 != null){
                            _local_3.TraxSample(_SafeStr_6129, _local_9, _local_12);
                            _local_9 = (_local_9 + _local_12);
                        }
                        else {
                            _local_14 = 0;
                            while (_local_14 < _local_12) {
                                var _local_15 = _local_9++;
                                _SafeStr_6129[_local_15] = 0;
                                _local_14++;
                            };
                        };
                    }
                    else {
                        if (_local_3 != null){
                            _local_3.TraxSample(_SafeStr_6129, _local_9, _local_12);
                        };
                        _local_9 = (_local_9 + _local_12);
                    };
                    if (_local_9 < _local_8){
                        _local_7 = _local_5.getWithIndex(++_local_6);
                        if ((((_local_7 == null)) || ((_local_7.id == 0)))){
                            _local_3 = null;
                        }
                        else {
                            _local_3 = new TraxChannelSample(_local_7, 0);
                        };
                    };
                };
                _local_4--;
            };
        }
        private function TraxSequencer():void
        {
            var _local_1:int = (((this._SafeStr_6139 < this._SafeStr_6134)) ? this._SafeStr_6139 : (((this._SafeStr_6134 > 0)) ? this._SafeStr_6134 : this._SafeStr_6139));
            if ((((this._position > (_local_1 + (this._SafeStr_6140 * (_SafeStr_6125 / 1000))))) && (!(this._finished)))){
                this._finished = true;
                if (this._SafeStr_6148 != null){
                    this._SafeStr_6148.reset();
                    this._SafeStr_6148.removeEventListener(TimerEvent.TIMER_COMPLETE, this.TraxSequencer);
                };
                this._SafeStr_6148 = new Timer(2, 1);
                this._SafeStr_6148.start();
                this._SafeStr_6148.addEventListener(TimerEvent.TIMER_COMPLETE, this.TraxSequencer);
            }
            else {
                if ((((this._position > (_local_1 - this._fadeOutSeconds))) && (!(this._SafeStr_6142)))){
                    this._SafeStr_6141 = false;
                    this._SafeStr_6142 = true;
                    this._SafeStr_6146 = 0;
                };
            };
        }
        private function TraxSequencer(_arg_1:SampleDataEvent):void
        {
            if (_arg_1.position > this._SafeStr_6150){
                this._SafeStr_6151++;
                Logger.log("Audio buffer under run...");
                this._SafeStr_6150 = _arg_1.position;
            };
            if (this.volume > 0){
                this.TraxSequencer();
            };
            var _local_2:int = _SafeStr_6126;
            if ((this._SafeStr_6139 - this._position) < _local_2){
                _local_2 = (this._SafeStr_6139 - this._position);
                if (_local_2 < 0){
                    _local_2 = 0;
                };
            };
            if (this.volume <= 0){
                _local_2 = 0;
            };
            this.TraxSequencer(_arg_1.data, _local_2);
            this._position = (this._position + _SafeStr_6126);
            this._SafeStr_6150 = (this._SafeStr_6150 + _SafeStr_6126);
            if (this._SafeStr_4030 != null){
                this._SafeStr_6140 = (((_arg_1.position / _SafeStr_6125) * 1000) - this._SafeStr_4030.position);
            };
            this.TraxSequencer();
        }
        private function interpolate(_arg_1:int, _arg_2:Number):int
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:int;
            var _local_3:Number = 0;
            while (_local_10 < _arg_1) {
                _local_6 = Math.floor(_local_3);
                _local_7 = Math.ceil(_local_3);
                _local_4 = _SafeStr_6129[_local_6];
                _local_5 = _SafeStr_6129[_local_7];
                _local_8 = (_local_3 - _local_6);
                _local_9 = (_local_5 - _local_4);
                INTERPOLATION_BUFFER[_local_10] = (_local_4 + (_local_9 * _local_8));
                _local_3 = (_local_3 + _arg_2);
                if (_local_3 > (_SafeStr_6126 - 2)){
                    this._position = (this._position + _SafeStr_6126);
                    this.TraxSequencer();
                    _local_3 = 0;
                };
                _local_10++;
            };
            return (int(Math.round(_local_3)));
        }
        private function TraxSequencer(_arg_1:ByteArray, _arg_2:int):void
        {
            var _local_5:Number;
            var _local_6:Number;
            if (_arg_2 > 0){
                if (((!(this._SafeStr_6141)) && (!(this._SafeStr_6142)))){
                    this.TraxSequencer(_arg_1, _arg_2);
                }
                else {
                    if (this._SafeStr_6141){
                        _local_5 = (1 / this._fadeInSeconds);
                        _local_6 = (this._SafeStr_6145 / Number(this._fadeInSeconds));
                        this._SafeStr_6145 = (this._SafeStr_6145 + _SafeStr_6126);
                        if (this._SafeStr_6145 > this._fadeInSeconds){
                            this._SafeStr_6141 = false;
                        };
                    }
                    else {
                        if (this._SafeStr_6142){
                            _local_5 = (-1 / this._fadeOutSeconds);
                            _local_6 = (1 - (this._SafeStr_6146 / Number(this._fadeOutSeconds)));
                            this._SafeStr_6146 = (this._SafeStr_6146 + _SafeStr_6126);
                            if (this._SafeStr_6146 > this._fadeOutSeconds){
                                this._SafeStr_6146 = this._fadeOutSeconds;
                            };
                        };
                    };
                    this.TraxSequencer(_arg_1, _arg_2, _local_6, _local_5);
                };
            };
            var _local_3:Number = 0;
            var _local_4:int = _arg_2;
            while (_local_4 < _SafeStr_6126) {
                _arg_1.writeFloat(_local_3);
                _arg_1.writeFloat(_local_3);
                _local_4++;
            };
        }
        private function TraxSequencer(_arg_1:ByteArray, _arg_2:int):void
        {
            var _local_3:Number = 0;
            var _local_4:int;
            while (_local_4 < _arg_2) {
                _local_3 = (Number(_SafeStr_6129[_local_4]) * TraxSample.SAMPLE_VALUE_MULTIPLIER);
                _arg_1.writeFloat(_local_3);
                _arg_1.writeFloat(_local_3);
                _local_4++;
            };
        }
        private function TraxSequencer(_arg_1:ByteArray, _arg_2:int, _arg_3:Number, _arg_4:Number):void
        {
            var _local_5:Number = 0;
            var _local_6:int;
            _local_6 = 0;
            while (_local_6 < _arg_2) {
                if ((((_arg_3 < 0)) || ((_arg_3 > 1)))) break;
                _local_5 = ((Number(_SafeStr_6129[_local_6]) * TraxSample.SAMPLE_VALUE_MULTIPLIER) * _arg_3);
                _arg_3 = (_arg_3 + _arg_4);
                _arg_1.writeFloat(_local_5);
                _arg_1.writeFloat(_local_5);
                _local_6++;
            };
            if (_arg_3 < 0){
                while (_local_6 < _arg_2) {
                    _arg_1.writeFloat(0);
                    _arg_1.writeFloat(0);
                    _local_6++;
                };
            }
            else {
                if (_arg_3 > 1){
                    while (_local_6 < _arg_2) {
                        _local_5 = (Number(_SafeStr_6129[_local_6]) * TraxSample.SAMPLE_VALUE_MULTIPLIER);
                        _arg_3 = (_arg_3 + _arg_4);
                        _arg_1.writeFloat(_local_5);
                        _arg_1.writeFloat(_local_5);
                        _local_6++;
                    };
                };
            };
        }
        private function TraxSequencer(_arg_1:TimerEvent):void
        {
            if (this._finished){
                this.TraxSequencer();
            };
        }
        private function TraxSequencer(_arg_1:TimerEvent):void
        {
            this.TraxSequencer();
            this.TraxSequencer();
        }
        private function TraxSequencer():void
        {
            this.TraxSequencer();
            this._events.dispatchEvent(new SoundCompleteEvent(SoundCompleteEvent.TRAX_SONG_COMPLETE, this._songId));
        }
        private function TraxSequencer():void
        {
            if (this._SafeStr_6147 != null){
                this._SafeStr_6147.removeEventListener(TimerEvent.TIMER_COMPLETE, this.TraxSequencer);
                this._SafeStr_6147.reset();
                this._SafeStr_6147 = null;
            };
        }
        private function TraxSequencer():void
        {
            if (this._SafeStr_6148 != null){
                this._SafeStr_6148.reset();
                this._SafeStr_6148.removeEventListener(TimerEvent.TIMER_COMPLETE, this.TraxSequencer);
                this._SafeStr_6148 = null;
            };
        }

    }
}//package com.sulake.habbo.sound.trax

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// TraxData = "_-kA" (String#8604, DoABC#2)
// TraxSequencer = "_-0aW" (String#4313, DoABC#2)
// TraxSample = "_-285" (String#6206, DoABC#2)
// TraxChannel = "_-2yL" (String#7246, DoABC#2)
// SoundCompleteEvent = "_-2-X" (String#6037, DoABC#2)
// TraxChannelSample = "_-0JT" (String#3942, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _volume = "_-hi" (String#311, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// GroupItem = "_-0un" (String#16229, DoABC#2)
// _SafeStr_4030 = "_-FQ" (String#7980, DoABC#2)
// finished = "_-28w" (String#6223, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// fadeInSeconds = "_-2FB" (String#6346, DoABC#2)
// _songId = "_-0a-" (String#241, DoABC#2)
// channels = "_-2lP" (String#20897, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)
// hasMetaData = "_-1BR" (String#16916, DoABC#2)
// metaCutMode = "_-Cw" (String#22724, DoABC#2)
// _SafeStr_6125 = "_-Wp" (String#23517, DoABC#2)
// _SafeStr_6126 = "_-0TO" (String#15186, DoABC#2)
// _SafeStr_6127 = "_-0x" (String#16311, DoABC#2)
// _SafeStr_6128 = "_-26c" (String#19276, DoABC#2)
// _SafeStr_6129 = "_-Ur" (String#23440, DoABC#2)
// _SafeStr_6130 = "_-0Wg" (String#15304, DoABC#2)
// _traxData = "_-2-c" (String#18996, DoABC#2)
// _SafeStr_6132 = "_-0JG" (String#14812, DoABC#2)
// _ready = "_-2-1" (String#1794, DoABC#2)
// _SafeStr_6134 = "_-2jL" (String#20817, DoABC#2)
// _position = "_-2f5" (String#20649, DoABC#2)
// _SafeStr_6136 = "_-2wr" (String#21340, DoABC#2)
// _SafeStr_6137 = "_-0h1" (String#15711, DoABC#2)
// _finished = "_-HE" (String#22900, DoABC#2)
// _SafeStr_6139 = "_-KS" (String#23023, DoABC#2)
// _SafeStr_6140 = "_-1Yp" (String#17843, DoABC#2)
// _SafeStr_6141 = "_-2f6" (String#20650, DoABC#2)
// _SafeStr_6142 = "_-25V" (String#19238, DoABC#2)
// _fadeInSeconds = "_-0AH" (String#14459, DoABC#2)
// _fadeOutSeconds = "_-1P6" (String#17472, DoABC#2)
// _SafeStr_6145 = "_-10T" (String#16482, DoABC#2)
// _SafeStr_6146 = "_-0Nf" (String#14978, DoABC#2)
// _SafeStr_6147 = "_-37G" (String#21778, DoABC#2)
// _SafeStr_6148 = "_-06a" (String#14309, DoABC#2)
// _SafeStr_6149 = "_-1G6" (String#17118, DoABC#2)
// _SafeStr_6150 = "_-Wg" (String#23512, DoABC#2)
// _SafeStr_6151 = "_-r7" (String#24319, DoABC#2)
// traxData = "_-2S4" (String#20122, DoABC#2)
// TraxSequencer = "_-18Y" (String#16795, DoABC#2)
// TraxSequencer = "_-32e" (String#21602, DoABC#2)
// TraxSequencer = "_-3-r" (String#21495, DoABC#2)
// TraxSample = "_-2Qm" (String#20078, DoABC#2)
// TraxSequencer = "_-Uu" (String#23443, DoABC#2)
// TraxSequencer = "_-1n8" (String#18430, DoABC#2)
// TraxSequencer = "_-h9" (String#23937, DoABC#2)
// TraxSequencer = "_-1Gl" (String#17142, DoABC#2)
// TraxSequencer = "_-0TM" (String#15185, DoABC#2)
// TraxSequencer = "_-3-i" (String#21489, DoABC#2)
// TraxSequencer = "_-2wI" (String#21323, DoABC#2)
// TraxSequencer = "_-1jO" (String#18261, DoABC#2)
// TraxSequencer = "_-1qb" (String#18567, DoABC#2)
// TraxSample = "_-1IC" (String#17201, DoABC#2)
// TraxSample = "_-tt" (String#24443, DoABC#2)
// TraxSequencer = "_-1JE" (String#17245, DoABC#2)
// TraxSequencer = "_-2tJ" (String#21212, DoABC#2)
// TraxSequencer = "_-10" (String#16466, DoABC#2)
// TraxSequencer = "_-1n4" (String#18426, DoABC#2)
// TraxSequencer = "_-1Jw" (String#17271, DoABC#2)


