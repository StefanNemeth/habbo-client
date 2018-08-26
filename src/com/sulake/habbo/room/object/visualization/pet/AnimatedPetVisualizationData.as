
package com.sulake.habbo.room.object.visualization.pet
{
    import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualizationData;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.room.object.visualization.data.SizeData;
    import com.sulake.habbo.room.object.visualization.data.AnimationSizeData;

    public class AnimatedPetVisualizationData extends AnimatedFurnitureVisualizationData 
    {

        private var _commonAssets:IAssetLibrary = null;

        public function set commonAssets(_arg_1:IAssetLibrary):void
        {
            this._commonAssets = _arg_1;
        }
        public function get commonAssets():IAssetLibrary
        {
            return (this._commonAssets);
        }
        override protected function createSizeData(_arg_1:int, _arg_2:int, _arg_3:int):SizeData
        {
            var _local_4:SizeData;
            if (_arg_1 > 1){
                _local_4 = new PetAnimationSizeData(_arg_2, _arg_3);
            }
            else {
                _local_4 = new AnimationSizeData(_arg_2, _arg_3);
            };
            return (_local_4);
        }
        override protected function processVisualizationElement(_arg_1:SizeData, _arg_2:XML):Boolean
        {
            var _local_3:PetAnimationSizeData;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return (false);
            };
            switch (String(_arg_2.name())){
                case "postures":
                    _local_3 = (_arg_1 as PetAnimationSizeData);
                    if (_local_3 != null){
                        if (!_local_3.definePostures(_arg_2)){
                            return (false);
                        };
                    };
                    break;
                case "gestures":
                    _local_3 = (_arg_1 as PetAnimationSizeData);
                    if (_local_3 != null){
                        if (!_local_3.defineGestures(_arg_2)){
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
        public function getAnimationForPosture(_arg_1:int, _arg_2:String):int
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null){
                return (_local_3.getAnimationForPosture(_arg_2));
            };
            return (PetAnimationSizeData._SafeStr_4414);
        }
        public function getAnimationForGesture(_arg_1:int, _arg_2:String):int
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null){
                return (_local_3.getAnimationForGesture(_arg_2));
            };
            return (PetAnimationSizeData._SafeStr_4414);
        }
        public function getPostureForAnimation(_arg_1:int, _arg_2:int):String
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null){
                return (_local_3.getPostureForAnimation(_arg_2));
            };
            return (null);
        }
        public function getGestureForAnimation(_arg_1:int, _arg_2:int):String
        {
            var _local_3:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_3 != null){
                return (_local_3.getGestureForAnimation(_arg_2));
            };
            return (null);
        }
        public function getPostureCount(_arg_1:int):int
        {
            var _local_2:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_2 != null){
                return (_local_2.getPostureCount());
            };
            return (0);
        }
        public function getGestureCount(_arg_1:int):int
        {
            var _local_2:PetAnimationSizeData = (getSizeData(_arg_1) as PetAnimationSizeData);
            if (_local_2 != null){
                return (_local_2.getGestureCount());
            };
            return (0);
        }

    }
}//package com.sulake.habbo.room.object.visualization.pet

// AnimatedFurnitureVisualizationData = "_-nI" (String#8663, DoABC#2)
// AnimatedPetVisualizationData = "_-1K9" (String#5246, DoABC#2)
// SizeData = "_-07b" (String#3713, DoABC#2)
// AnimationSizeData = "_-0PM" (String#4079, DoABC#2)
// PetAnimationSizeData = "_-0FZ" (String#3861, DoABC#2)
// getPostureCount = "_-2h5" (String#20731, DoABC#2)
// getPostureForAnimation = "_-13g" (String#16605, DoABC#2)
// getGestureCount = "_-1PV" (String#17489, DoABC#2)
// getGestureForAnimation = "_-1sX" (String#18655, DoABC#2)
// getAnimationForPosture = "_-1vg" (String#18783, DoABC#2)
// getAnimationForGesture = "_-R3" (String#23285, DoABC#2)
// _commonAssets = "_-4o" (String#22409, DoABC#2)
// createSizeData = "_-1G0" (String#1647, DoABC#2)
// definePostures = "_-35z" (String#21728, DoABC#2)
// defineGestures = "_-2hp" (String#20766, DoABC#2)
// getSizeData = "_-2ZC" (String#20406, DoABC#2)
// _SafeStr_4414 = "_-0MY" (String#14934, DoABC#2)


