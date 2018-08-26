
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationFrame;

    public class AnimatedFurnitureVisualizationData extends FurnitureVisualizationData 
    {

        override protected function createSizeData(_arg_1:int, _arg_2:int, _arg_3:int):SizeData
        {
            var _local_4:SizeData;
            return (new AnimationSizeData(_arg_2, _arg_3));
        }
        override protected function processVisualizationElement(_arg_1:SizeData, _arg_2:XML):Boolean
        {
            var _local_3:AnimationSizeData;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            switch (String(_arg_2.name())){
                case "animations":
                    _local_3 = (_arg_1 as AnimationSizeData);
                    if (_local_3 != null){
                        if (!_local_3.defineAnimations(_arg_2)){
                            return (false);
                        };
                    };
                    break;
                default:
                    if (!super.processVisualizationElement(_arg_1, _arg_2)){
                        return (false);
                    };
            };
            return (true);
        }
        public function hasAnimation(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_3 != null){
                return (_local_3.hasAnimation(_arg_2));
            };
            return (false);
        }
        public function getAnimationCount(_arg_1:int):int
        {
            var _local_2:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_2 != null){
                return (_local_2.getAnimationCount());
            };
            return (0);
        }
        public function getAnimationId(_arg_1:int, _arg_2:int):int
        {
            var _local_3:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_3 != null){
                return (_local_3.getAnimationId(_arg_2));
            };
            return (0);
        }
        public function isImmediateChange(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            var _local_4:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_4 != null){
                return (_local_4.isImmediateChange(_arg_2, _arg_3));
            };
            return (false);
        }
        public function getStartFrame(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_4 != null){
                return (_local_4.getStartFrame(_arg_2, _arg_3));
            };
            return (0);
        }
        public function getFrame(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):AnimationFrame
        {
            var _local_6:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_6 != null){
                return (_local_6.getFrame(_arg_2, _arg_3, _arg_4, _arg_5));
            };
            return (null);
        }
        public function getFrameFromSequence(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):AnimationFrame
        {
            var _local_8:AnimationSizeData = (getSizeData(_arg_1) as AnimationSizeData);
            if (_local_8 != null){
                return (_local_8.getFrameFromSequence(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// isImmediateChange = "_-1rn" (String#18623, DoABC#2)
// getStartFrame = "_-3L-" (String#22323, DoABC#2)
// getFrameFromSequence = "_-1rq" (String#18624, DoABC#2)
// defineAnimations = "_-SX" (String#23347, DoABC#2)
// hasAnimation = "_-3Au" (String#21915, DoABC#2)
// getAnimationCount = "_-2J6" (String#19771, DoABC#2)
// FurnitureVisualizationData = "_-0d0" (String#4371, DoABC#2)
// AnimatedFurnitureVisualizationData = "_-nI" (String#8663, DoABC#2)
// SizeData = "_-07b" (String#3713, DoABC#2)
// AnimationFrame = "_-to" (String#8764, DoABC#2)
// AnimationSizeData = "_-0PM" (String#4079, DoABC#2)
// getAnimationId = "_-1nQ" (String#1759, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// createSizeData = "_-1G0" (String#1647, DoABC#2)
// getSizeData = "_-2ZC" (String#20406, DoABC#2)


