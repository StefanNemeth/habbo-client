
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationFrame 
    {

        public static const _SafeStr_12524:int = -1;
        public static const _SafeStr_12557:int = -1;
        private static const _SafeStr_12558:int = 3000;
        private static const POOL:Array = [];

        private var _id:int = 0;
        private var _x:int = 0;
        private var _y:int = 0;
        private var _repeats:int = 1;
        private var _frameRepeats:int = 1;
        private var _remainingFrameRepeats:int = 1;
        private var _activeSequence:int = -1;
        private var _activeSequenceOffset:int = 0;
        private var _isLastFrame:Boolean = false;
        private var _isRecycled:Boolean = false;

        public static function allocate(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Boolean, _arg_7:int=-1, _arg_8:int=0):AnimationFrame
        {
            var _local_9:AnimationFrame = (((POOL.length > 0)) ? POOL.pop() : new (AnimationFrame)());
            _local_9._isRecycled = false;
            _local_9._id = _arg_1;
            _local_9._x = _arg_2;
            _local_9._y = _arg_3;
            _local_9._isLastFrame = _arg_6;
            if (_arg_4 < 1){
                _arg_4 = 1;
            };
            _local_9._repeats = _arg_4;
            if (_arg_5 < 0){
                _arg_5 = _SafeStr_12524;
            };
            _local_9._frameRepeats = _arg_5;
            _local_9._remainingFrameRepeats = _arg_5;
            if (_arg_7 >= 0){
                _local_9._activeSequence = _arg_7;
                _local_9._activeSequenceOffset = _arg_8;
            };
            return (_local_9);
        }

        public function get id():int
        {
            if (this._id >= 0){
                return (this._id);
            };
            return ((-(this._id) * Math.random()));
        }
        public function get x():int
        {
            return (this._x);
        }
        public function get y():int
        {
            return (this._y);
        }
        public function get repeats():int
        {
            return (this._repeats);
        }
        public function get frameRepeats():int
        {
            return (this._frameRepeats);
        }
        public function get isLastFrame():Boolean
        {
            return (this._isLastFrame);
        }
        public function get remainingFrameRepeats():int
        {
            if (this._frameRepeats < 0){
                return (_SafeStr_12524);
            };
            return (this._remainingFrameRepeats);
        }
        public function set remainingFrameRepeats(_arg_1:int):void
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if ((((this._frameRepeats > 0)) && ((_arg_1 > this._frameRepeats)))){
                _arg_1 = this._frameRepeats;
            };
            this._remainingFrameRepeats = _arg_1;
        }
        public function get activeSequence():int
        {
            return (this._activeSequence);
        }
        public function get activeSequenceOffset():int
        {
            return (this._activeSequenceOffset);
        }
        public function recycle():void
        {
            if (!this._isRecycled){
                this._isRecycled = true;
                if (POOL.length < _SafeStr_12558){
                    POOL.push(this);
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// repeats = "_-0Lv" (String#14909, DoABC#2)
// _SafeStr_12524 = "_-35J" (String#21706, DoABC#2)
// _SafeStr_12557 = "_-1Jn" (String#17267, DoABC#2)
// _SafeStr_12558 = "_-2Ss" (String#20155, DoABC#2)
// _repeats = "_-3CQ" (String#7561, DoABC#2)
// _frameRepeats = "_-1Oe" (String#5327, DoABC#2)
// _remainingFrameRepeats = "_-0UV" (String#15224, DoABC#2)
// _activeSequence = "_-2pZ" (String#21061, DoABC#2)
// _activeSequenceOffset = "_-1lI" (String#18342, DoABC#2)
// _isLastFrame = "_-2F8" (String#19611, DoABC#2)
// frameRepeats = "_-05j" (String#14271, DoABC#2)
// isLastFrame = "_-1oI" (String#18471, DoABC#2)
// remainingFrameRepeats = "_-3D8" (String#22000, DoABC#2)
// activeSequence = "_-1z1" (String#18929, DoABC#2)
// activeSequenceOffset = "_-2fA" (String#20653, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)


