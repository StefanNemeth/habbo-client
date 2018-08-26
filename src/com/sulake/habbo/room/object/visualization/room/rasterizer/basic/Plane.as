
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.core.utils.Map;
    import com.sulake.room.utils.IRoomGeometry;

    public class Plane 
    {

        private var _SafeStr_12877:Map;
        private var _sizes:Array;
        private var _SafeStr_12878:PlaneVisualization = null;
        private var _SafeStr_12605:int = -1;

        public function Plane()
        {
            this._sizes = [];
            super();
            this._SafeStr_12877 = new Map();
        }
        public function isStatic(_arg_1:int):Boolean
        {
            return (true);
        }
        public function dispose():void
        {
            var _local_1:PlaneVisualization;
            var _local_2:int;
            if (this._SafeStr_12877 != null){
                _local_1 = null;
                _local_2 = 0;
                while (_local_2 < this._SafeStr_12877.length) {
                    _local_1 = (this._SafeStr_12877.getWithIndex(_local_2) as PlaneVisualization);
                    if (_local_1 != null){
                        _local_1.dispose();
                    };
                    _local_2++;
                };
                this._SafeStr_12877.dispose();
                this._SafeStr_12877 = null;
            };
            this._SafeStr_12878 = null;
            this._sizes = null;
        }
        public function clearCache():void
        {
            var _local_2:PlaneVisualization;
            var _local_1:int;
            while (_local_1 < this._SafeStr_12877.length) {
                _local_2 = (this._SafeStr_12877.getWithIndex(_local_1) as PlaneVisualization);
                if (_local_2 != null){
                    _local_2.clearCache();
                };
                _local_1++;
            };
        }
        public function createPlaneVisualization(_arg_1:int, _arg_2:int, _arg_3:IRoomGeometry):PlaneVisualization
        {
            if (this._SafeStr_12877.getValue(String(_arg_1)) != null){
                return (null);
            };
            var _local_4:PlaneVisualization = new PlaneVisualization(_arg_1, _arg_2, _arg_3);
            this._SafeStr_12877.add(String(_arg_1), _local_4);
            this._sizes.push(_arg_1);
            this._sizes.sort();
            return (_local_4);
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
        protected function getPlaneVisualization(_arg_1:int):PlaneVisualization
        {
            if (_arg_1 == this._SafeStr_12605){
                return (this._SafeStr_12878);
            };
            var _local_2:int = this.getSizeIndex(_arg_1);
            if (_local_2 < this._sizes.length){
                this._SafeStr_12878 = (this._SafeStr_12877.getValue(String(this._sizes[_local_2])) as PlaneVisualization);
            }
            else {
                this._SafeStr_12878 = null;
            };
            this._SafeStr_12605 = _arg_1;
            return (this._SafeStr_12878);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12605 = "_-iJ" (String#2164, DoABC#2)
// getSizeIndex = "_-0Wx" (String#1494, DoABC#2)
// _SafeStr_12877 = "_-2zK" (String#21433, DoABC#2)
// _SafeStr_12878 = "_-cL" (String#23728, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// Plane = "_-0S9" (String#4141, DoABC#2)
// createPlaneVisualization = "_-8X" (String#22562, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)


