
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrameSequenceData 
    {

        private var _frames:Array;
        private var _SafeStr_12589:Array;
        private var _frameRepeats:Array;
        private var _isRandom:Boolean = false;
        private var _loopCount:int = 1;

        public function AnimationFrameSequenceData(_arg_1:int, _arg_2:Boolean)
        {
            this._frames = [];
            this._SafeStr_12589 = [];
            this._frameRepeats = [];
            super();
            if (_arg_1 < 1){
                _arg_1 = 1;
            };
            this._loopCount = _arg_1;
            this._isRandom = _arg_2;
        }
        public function get isRandom():Boolean
        {
            return (this._isRandom);
        }
        public function get frameCount():int
        {
            return ((this._SafeStr_12589.length * this._loopCount));
        }
        public function dispose():void
        {
            this._frames = [];
        }
        public function initialize():void
        {
            var _local_1:int = 1;
            var _local_2:int = -1;
            var _local_3:int = (this._SafeStr_12589.length - 1);
            while (_local_3 >= 0) {
                if (this._SafeStr_12589[_local_3] == _local_2){
                    _local_1++;
                }
                else {
                    _local_2 = this._SafeStr_12589[_local_3];
                    _local_1 = 1;
                };
                this._frameRepeats[_local_3] = _local_1;
                _local_3--;
            };
        }
        public function addFrame(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:DirectionalOffsetData):void
        {
            var _local_7:AnimationFrameData;
            var _local_8:int = 1;
            if (this._frames.length > 0){
                _local_7 = this._frames[(this._frames.length - 1)];
                if ((((((((((((((((_local_7.id == _arg_1)) && (!(_local_7.hasDirectionalOffsets())))) && ((_local_7.x == _arg_2)))) && ((_local_7.y == _arg_3)))) && ((_local_7.randomX == _arg_4)))) && ((_arg_4 == 0)))) && ((_local_7.randomY == _arg_5)))) && ((_arg_5 == 0)))){
                    _local_8 = (_local_8 + _local_7.repeats);
                    this._frames.pop();
                };
            };
            var _local_9:AnimationFrameData;
            if (_arg_6 == null){
                _local_9 = new AnimationFrameData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _local_8);
            }
            else {
                _local_9 = new AnimationFrameDirectionalData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _local_8);
            };
            this._frames.push(_local_9);
            this._SafeStr_12589.push((this._frames.length - 1));
            this._frameRepeats.push(1);
        }
        public function getFrame(_arg_1:int):AnimationFrameData
        {
            if ((((((this._frames.length == 0)) || ((_arg_1 < 0)))) || ((_arg_1 >= this.frameCount)))){
                return (null);
            };
            _arg_1 = this._SafeStr_12589[(_arg_1 % this._SafeStr_12589.length)];
            return ((this._frames[_arg_1] as AnimationFrameData));
        }
        public function getFrameIndex(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.frameCount)))){
                return (-1);
            };
            if (this._isRandom){
                _arg_1 = (Math.random() * this._SafeStr_12589.length);
                if (_arg_1 == this._SafeStr_12589.length){
                    _arg_1--;
                };
            };
            return (_arg_1);
        }
        public function getRepeats(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.frameCount)))){
                return (0);
            };
            return (this._frameRepeats[(_arg_1 % this._frameRepeats.length)]);
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// addFrame = "_-0Xl" (String#15346, DoABC#2)
// _isRandom = "_-04W" (String#3656, DoABC#2)
// repeats = "_-0Lv" (String#14909, DoABC#2)
// getRepeats = "_-0CB" (String#14536, DoABC#2)
// isRandom = "_-pm" (String#24264, DoABC#2)
// _frameRepeats = "_-1Oe" (String#5327, DoABC#2)
// _SafeStr_12589 = "_-lA" (String#24075, DoABC#2)
// hasDirectionalOffsets = "_-jk" (String#24025, DoABC#2)
// DirectionalOffsetData = "_-0oK" (String#4599, DoABC#2)
// AnimationFrameSequenceData = "_-34t" (String#7406, DoABC#2)
// AnimationFrameData = "_-19W" (String#5067, DoABC#2)
// AnimationFrameDirectionalData = "_-01i" (String#3596, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// getFrameIndex = "_-38K" (String#21816, DoABC#2)
// frameCount = "_-0C7" (String#14533, DoABC#2)


