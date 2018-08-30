
package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneMask 
    {

        private var _SafeStr_12845:Map;
        private var _sizes:Array;
        private var _maskVisualization:PlaneMaskVisualization = null;
        private var _size:int = -1;

        public function PlaneMask()
        {
            this._sizes = [];
            super();
            this._SafeStr_12845 = new Map();
        }
        public function dispose():void
        {
            var _local_1:PlaneMaskVisualization;
            var _local_2:int;
            if (this._SafeStr_12845 != null){
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < this._SafeStr_12845.length) {
                    _local_1 = (this._SafeStr_12845.getWithIndex(_local_2) as PlaneMaskVisualization);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_12845.dispose();
                this._SafeStr_12845 = null;
            };
            this._maskVisualization = null;
            this._sizes = null;
        }
        public function createMaskVisualization(_arg_1:int):PlaneMaskVisualization
        {
            if (this._SafeStr_12845.getValue(String(_arg_1)) != null){
                return (null);
            };
            var _local_2:PlaneMaskVisualization = new PlaneMaskVisualization();
            this._SafeStr_12845.add(String(_arg_1), _local_2);
            this._sizes.push(_arg_1);
            this._sizes.sort();
            return (_local_2);
        }
        private function getSizeIndex(_arg_1:int):int
        {
            var _local_2:int;
            var _local_3:int = 1;
            while (_local_3 < this._sizes.length) {
                if (this._sizes[_local_3] > _arg_1){
                    if ((this._sizes[_local_3] - _arg_1) < (_arg_1 - this._sizes[(_local_3 - 1)])){
                        _local_2 = _local_3;
                    };
                    break;
                };
                _local_2 = _local_3;
                _local_3++;
            };
            return (_local_2);
        }
        protected function getMaskVisualization(_arg_1:int):PlaneMaskVisualization
        {
            if (_arg_1 == this._size){
                return (this._maskVisualization);
            };
            var _local_2:int = this.getSizeIndex(_arg_1);
            if (_local_2 < this._sizes.length){
                this._maskVisualization = (this._SafeStr_12845.getValue(String(this._sizes[_local_2])) as PlaneMaskVisualization);
            }
            else {
                this._maskVisualization = null;
            };
            this._size = _arg_1;
            return (this._maskVisualization);
        }
        public function getGraphicAsset(_arg_1:Number, _arg_2:IVector3d):IGraphicAsset
        {
            var _local_3:PlaneMaskVisualization = this.getMaskVisualization(_arg_1);
            if (_local_3 == null){
                return (null);
            };
            return (_local_3.getAsset(_arg_2));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.mask

// _size = "_-iJ" (String#2164, DoABC#2)
// getSizeIndex = "_-0Wx" (String#1494, DoABC#2)
// createMaskVisualization = "_-0nN" (String#15951, DoABC#2)
// getGraphicAsset = "_-2Gu" (String#19679, DoABC#2)
// _SafeStr_12845 = "_-1wR" (String#18818, DoABC#2)
// _maskVisualization = "_-2vk" (String#21304, DoABC#2)
// getMaskVisualization = "_-rW" (String#24339, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// PlaneMask = "_-1y-" (String#5993, DoABC#2)
// PlaneMaskVisualization = "_-7w" (String#7821, DoABC#2)


