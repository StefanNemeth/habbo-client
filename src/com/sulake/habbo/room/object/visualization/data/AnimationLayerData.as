
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationLayerData 
    {

        private var _SafeStr_12518:Array;
        private var _frameCount:int = -1;
        private var _loopCount:int = 1;
        private var _SafeStr_12519:int = 1;
        private var _isRandom:Boolean = false;

        public function AnimationLayerData(_arg_1:int, _arg_2:int, _arg_3:Boolean)
        {
            this._SafeStr_12518 = [];
            super();
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            this._loopCount = _arg_1;
            this._SafeStr_12519 = _arg_2;
            this._isRandom = _arg_3;
        }
        public function get frameCount():int
        {
            if (this._frameCount < 0){
                this.calculateLength();
            };
            return (this._frameCount);
        }
        public function dispose():void
        {
            var _local_2:AnimationFrameSequenceData;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12518.length) {
                _local_2 = (this._SafeStr_12518[_local_1] as AnimationFrameSequenceData);
                if (_local_2 != null){
                    _local_2.dispose();
                };
                _local_1++;
            };
            this._SafeStr_12518 = [];
        }
        public function addFrameSequence(_arg_1:int, _arg_2:Boolean):AnimationFrameSequenceData
        {
            var _local_3:AnimationFrameSequenceData = new AnimationFrameSequenceData(_arg_1, _arg_2);
            this._SafeStr_12518.push(_local_3);
            return (_local_3);
        }
        public function calculateLength():void
        {
            var _local_2:AnimationFrameSequenceData;
            this._frameCount = 0;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12518.length) {
                _local_2 = (this._SafeStr_12518[_local_1] as AnimationFrameSequenceData);
                if (_local_2 != null){
                    this._frameCount = (this._frameCount + _local_2.frameCount);
                };
                _local_1++;
            };
        }
        public function getFrame(_arg_1:int, _arg_2:int):AnimationFrame
        {
            var _local_6:int;
            var _local_7:int;
            if (this._frameCount < 1){
                return (null);
            };
            var _local_3:AnimationFrameSequenceData;
            _arg_2 = (_arg_2 / this._SafeStr_12519);
            var _local_4:Boolean;
            var _local_5:int;
            if (!this._isRandom){
                _local_6 = (_arg_2 / this._frameCount);
                _arg_2 = (_arg_2 % this._frameCount);
                if ((((((this._loopCount > 0)) && ((_local_6 >= this._loopCount)))) || ((((this._loopCount <= 0)) && ((this._frameCount == 1)))))){
                    _arg_2 = (this._frameCount - 1);
                    _local_4 = true;
                };
                _local_7 = 0;
                _local_5 = 0;
                while (_local_5 < this._SafeStr_12518.length) {
                    _local_3 = (this._SafeStr_12518[_local_5] as AnimationFrameSequenceData);
                    if (_local_3 != null){
                        if (_arg_2 < (_local_7 + _local_3.frameCount)) break;
                        _local_7 = (_local_7 + _local_3.frameCount);
                    };
                    _local_5++;
                };
                return (this.getFrameFromSpecificSequence(_arg_1, _local_3, _local_5, (_arg_2 - _local_7), _local_4));
            };
            _local_5 = (this._SafeStr_12518.length * Math.random());
            _local_3 = (this._SafeStr_12518[_local_5] as AnimationFrameSequenceData);
            if (_local_3.frameCount < 1){
                return (null);
            };
            _arg_2 = 0;
            return (this.getFrameFromSpecificSequence(_arg_1, _local_3, _local_5, _arg_2, false));
        }
        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):AnimationFrame
        {
            if ((((_arg_2 < 0)) || ((_arg_2 >= this._SafeStr_12518.length)))){
                return (null);
            };
            var _local_5:AnimationFrameSequenceData = (this._SafeStr_12518[_arg_2] as AnimationFrameSequenceData);
            if (_local_5 != null){
                if (_arg_3 >= _local_5.frameCount){
                    return (this.getFrame(_arg_1, _arg_4));
                };
                return (this.getFrameFromSpecificSequence(_arg_1, _local_5, _arg_2, _arg_3, false));
            };
            return (null);
        }
        private function getFrameFromSpecificSequence(_arg_1:int, _arg_2:AnimationFrameSequenceData, _arg_3:int, _arg_4:int, _arg_5:Boolean):AnimationFrame
        {
            var _local_6:int;
            var _local_7:AnimationFrameData;
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Boolean;
            var _local_15:AnimationFrame;
            if (_arg_2 != null){
                _local_6 = _arg_2.getFrameIndex(_arg_4);
                _local_7 = _arg_2.getFrame(_local_6);
                if (_local_7 == null){
                    return (null);
                };
                _local_8 = _local_7.getX(_arg_1);
                _local_9 = _local_7.getY(_arg_1);
                _local_10 = _local_7.randomX;
                _local_11 = _local_7.randomY;
                if (_local_10 != 0){
                    _local_8 = (_local_8 + (_local_10 * Math.random()));
                };
                if (_local_11 != 0){
                    _local_9 = (_local_9 + (_local_11 * Math.random()));
                };
                _local_12 = _local_7.repeats;
                if (_local_12 > 1){
                    _local_12 = _arg_2.getRepeats(_local_6);
                };
                _local_13 = (this._SafeStr_12519 * _local_12);
                if (_arg_5){
                    _local_13 = AnimationFrame._SafeStr_12524;
                };
                _local_14 = false;
                if (((!(this._isRandom)) && (!(_arg_2.isRandom)))){
                    if ((((_arg_3 == (this._SafeStr_12518.length - 1))) && ((_arg_4 == (_arg_2.frameCount - 1))))){
                        _local_14 = true;
                    };
                };
                return (AnimationFrame.allocate(_local_7.id, _local_8, _local_9, _local_12, _local_13, _local_14, _arg_3, _arg_4));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// getX = "_-bw" (String#8454, DoABC#2)
// getY = "_-2Wq" (String#6697, DoABC#2)
// _frameCount = "_-LD" (String#8106, DoABC#2)
// addFrameSequence = "_-XJ" (String#23535, DoABC#2)
// calculateLength = "_-2L8" (String#19853, DoABC#2)
// getFrameFromSequence = "_-1rq" (String#18624, DoABC#2)
// _SafeStr_12518 = "_-NV" (String#23145, DoABC#2)
// _SafeStr_12519 = "_-3B9" (String#21930, DoABC#2)
// _isRandom = "_-04W" (String#3656, DoABC#2)
// getFrameFromSpecificSequence = "_-0Bu" (String#14523, DoABC#2)
// repeats = "_-0Lv" (String#14909, DoABC#2)
// getRepeats = "_-0CB" (String#14536, DoABC#2)
// _SafeStr_12524 = "_-35J" (String#21706, DoABC#2)
// isRandom = "_-pm" (String#24264, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationFrameSequenceData = "_-34t" (String#7406, DoABC#2)
// AnimationFrameData = "_-19W" (String#5067, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// getFrameIndex = "_-38K" (String#21816, DoABC#2)
// frameCount = "_-0C7" (String#14533, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)


