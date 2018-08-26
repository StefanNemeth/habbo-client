
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.IVector3d;
    import flash.display.BitmapData;

    public class PlaneMaterial 
    {

        public static const _SafeStr_12841:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _SafeStr_12897:Array;
        private var _SafeStr_12886:Boolean = false;

        public function PlaneMaterial()
        {
            this._SafeStr_12897 = [];
            super();
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCellMatrix;
            if (this._SafeStr_12897 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12897.length) {
                    _local_2 = (this._SafeStr_12897[_local_1] as PlaneMaterialCellMatrix);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_12897 = null;
            };
        }
        public function clearCache():void
        {
            var _local_1:int;
            var _local_2:PlaneMaterialCellMatrix;
            if (!this._SafeStr_12886){
                return;
            };
            if (this._SafeStr_12897 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_12897.length) {
                    _local_2 = (this._SafeStr_12897[_local_1] as PlaneMaterialCellMatrix);
                    if (_local_2 != null){
                        _local_2.clearCache();
                    };
                    _local_1++;
                };
            };
            this._SafeStr_12886 = false;
        }
        public function addMaterialCellMatrix(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Number=-1, _arg_5:Number=1, _arg_6:Number=-1, _arg_7:Number=1):PlaneMaterialCellMatrix
        {
            var _local_8:PlaneMaterialCellMatrix;
            _local_8 = new PlaneMaterialCellMatrix(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7);
            this._SafeStr_12897.push(_local_8);
            return (_local_8);
        }
        private function getMaterialCellMatrix(_arg_1:IVector3d):PlaneMaterialCellMatrix
        {
            var _local_3:PlaneMaterialCellMatrix;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:int;
            while (_local_2 < this._SafeStr_12897.length) {
                _local_3 = (this._SafeStr_12897[_local_2] as PlaneMaterialCellMatrix);
                if (_local_3 != null){
                    if ((((((((_arg_1.x >= _local_3.normalMinX)) && ((_arg_1.x <= _local_3.normalMaxX)))) && ((_arg_1.y >= _local_3.normalMinY)))) && ((_arg_1.y <= _local_3.normalMaxY)))){
                        return (_local_3);
                    };
                };
                _local_2++;
            };
            return (null);
        }
        public function render(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:int, _arg_7:Boolean):BitmapData
        {
            if (_arg_2 < 1){
                _arg_2 = 1;
            };
            if (_arg_3 < 1){
                _arg_3 = 1;
            };
            var _local_8:PlaneMaterialCellMatrix = this.getMaterialCellMatrix(_arg_4);
            if (_local_8 != null){
                this._SafeStr_12886 = true;
                return (_local_8.render(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// addMaterialCellMatrix = "_-1Tu" (String#17662, DoABC#2)
// _SafeStr_12886 = "_-1qn" (String#868, DoABC#2)
// _SafeStr_12897 = "_-2DC" (String#19533, DoABC#2)
// getMaterialCellMatrix = "_-ER" (String#22790, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// PlaneMaterial = "_-W-" (String#8321, DoABC#2)
// PlaneMaterialCellMatrix = "_-0Pa" (String#4083, DoABC#2)


