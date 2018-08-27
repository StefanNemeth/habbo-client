
package com.sulake.habbo.room.object.visualization.data
{
    public class AnimationStateData 
    {

        private var _animationId:int = -1;
        private var _animationAfterTransitionId:int = 0;
        private var _animationOver:Boolean = false;
        private var _frameCounter:int = 0;
        private var _frames:Array;
        private var _SafeStr_12572:Array;
        private var _SafeStr_12573:Array;
        private var _layerCount:int = 0;

        public function AnimationStateData()
        {
            this._frames = [];
            this._SafeStr_12572 = [];
            this._SafeStr_12573 = [];
            super();
        }
        public function get animationOver():Boolean
        {
            return (this._animationOver);
        }
        public function set animationOver(_arg_1:Boolean):void
        {
            this._animationOver = _arg_1;
        }
        public function get frameCounter():int
        {
            return (this._frameCounter);
        }
        public function set frameCounter(_arg_1:int):void
        {
            this._frameCounter = _arg_1;
        }
        public function get animationId():int
        {
            return (this._animationId);
        }
        public function set animationId(_arg_1:int):void
        {
            if (_arg_1 != this._animationId){
                this._animationId = _arg_1;
                this.resetAnimationFrames(false);
            };
        }
        public function get animationAfterTransitionId():int
        {
            return (this._animationAfterTransitionId);
        }
        public function set animationAfterTransitionId(_arg_1:int):void
        {
            this._animationAfterTransitionId = _arg_1;
        }
        public function dispose():void
        {
            this.recycleFrames();
            this._frames = null;
            this._SafeStr_12572 = null;
            this._SafeStr_12573 = null;
        }
        public function setLayerCount(_arg_1:int):void
        {
            this._layerCount = _arg_1;
            this.resetAnimationFrames();
        }
        public function resetAnimationFrames(_arg_1:Boolean=true):void
        {
            var _local_3:AnimationFrame;
            if (((_arg_1) || ((this._frames == null)))){
                this.recycleFrames();
                this._frames = [];
            };
            this._SafeStr_12572 = [];
            this._SafeStr_12573 = [];
            this._animationOver = false;
            this._frameCounter = 0;
            var _local_2:int;
            while (_local_2 < this._layerCount) {
                if (((_arg_1) || ((this._frames.length <= _local_2)))){
                    this._frames[_local_2] = null;
                }
                else {
                    _local_3 = this._frames[_local_2];
                    if (_local_3 != null){
                        _local_3.recycle();
                        this._frames[_local_2] = AnimationFrame.allocate(_local_3.id, _local_3.x, _local_3.y, _local_3.repeats, 0, _local_3.isLastFrame);
                    };
                };
                this._SafeStr_12572[_local_2] = false;
                this._SafeStr_12573[_local_2] = false;
                _local_2++;
            };
        }
        private function recycleFrames():void
        {
            var _local_1:AnimationFrame;
            if (this._frames != null){
                for each (_local_1 in this._frames) {
                    if (_local_1 != null){
                        _local_1.recycle();
                    };
                };
            };
        }
        public function getFrame(_arg_1:int):AnimationFrame
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                return (this._frames[_arg_1]);
            };
            return (null);
        }
        public function setFrame(_arg_1:int, _arg_2:AnimationFrame):void
        {
            var _local_3:AnimationFrame;
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                _local_3 = this._frames[_arg_1];
                if (_local_3 != null){
                    _local_3.recycle();
                };
                this._frames[_arg_1] = _arg_2;
            };
        }
        public function getAnimationPlayed(_arg_1:int):Boolean
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                return (this._SafeStr_12573[_arg_1]);
            };
            return (true);
        }
        public function setAnimationPlayed(_arg_1:int, _arg_2:Boolean):void
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                this._SafeStr_12573[_arg_1] = _arg_2;
            };
        }
        public function getLastFramePlayed(_arg_1:int):Boolean
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                return (this._SafeStr_12572[_arg_1]);
            };
            return (true);
        }
        public function setLastFramePlayed(_arg_1:int, _arg_2:Boolean):void
        {
            if ((((_arg_1 >= 0)) && ((_arg_1 < this._layerCount)))){
                this._SafeStr_12572[_arg_1] = _arg_2;
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.data

// repeats = "_-0Lv" (String#14909, DoABC#2)
// _layerCount = "_-1NH" (String#850, DoABC#2)
// isLastFrame = "_-1oI" (String#18471, DoABC#2)
// _animationId = "_-3B7" (String#21928, DoABC#2)
// _animationAfterTransitionId = "_-1za" (String#18951, DoABC#2)
// _SafeStr_12572 = "_-1qW" (String#18563, DoABC#2)
// _SafeStr_12573 = "_-Rz" (String#23324, DoABC#2)
// frameCounter = "_-0gP" (String#15689, DoABC#2)
// resetAnimationFrames = "_-0ka" (String#15851, DoABC#2)
// recycleFrames = "_-3Do" (String#22026, DoABC#2)
// setFrame = "_-2nk" (String#20989, DoABC#2)
// getAnimationPlayed = "_-2hM" (String#20746, DoABC#2)
// setAnimationPlayed = "_-LJ" (String#23058, DoABC#2)
// getLastFramePlayed = "_-1ZL" (String#5550, DoABC#2)
// setLastFramePlayed = "_-bz" (String#23711, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationStateData = "_-0iP" (String#15768, DoABC#2)
// _animationOver = "_-0x7" (String#4793, DoABC#2)
// setLayerCount = "_-Io" (String#22960, DoABC#2)
// animationOver = "_-2-o" (String#19005, DoABC#2)
// animationAfterTransitionId = "_-0jC" (String#15800, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// _frameCounter = "_-2HG" (String#884, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)


