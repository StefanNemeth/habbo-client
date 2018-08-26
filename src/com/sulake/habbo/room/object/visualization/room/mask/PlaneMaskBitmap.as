
package com.sulake.habbo.room.object.visualization.room.mask
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;

    public class PlaneMaskBitmap 
    {

        public static const _SafeStr_12841:Number = -1;
        public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;

        private var _asset:IGraphicAsset = null;
        private var _normalMinX:Number = -1;
        private var _normalMaxX:Number = 1;
        private var _normalMinY:Number = -1;
        private var _normalMaxY:Number = 1;

        public function PlaneMaskBitmap(_arg_1:IGraphicAsset, _arg_2:Number=-1, _arg_3:Number=1, _arg_4:Number=-1, _arg_5:Number=1)
        {
            this._normalMinX = _arg_2;
            this._normalMaxX = _arg_3;
            this._normalMinY = _arg_4;
            this._normalMaxY = _arg_5;
            this._asset = _arg_1;
        }
        public function get asset():IGraphicAsset
        {
            return (this._asset);
        }
        public function get normalMinX():Number
        {
            return (this._normalMinX);
        }
        public function get normalMaxX():Number
        {
            return (this._normalMaxX);
        }
        public function get normalMinY():Number
        {
            return (this._normalMinY);
        }
        public function get normalMaxY():Number
        {
            return (this._normalMaxY);
        }
        public function dispose():void
        {
            this._asset = null;
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.mask

// _SafeStr_12841 = "_-TR" (String#23383, DoABC#2)
// _normalMinX = "_-pN" (String#2200, DoABC#2)
// _normalMinY = "_-0m-" (String#1544, DoABC#2)
// _normalMaxY = "_-2Ow" (String#1872, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// PlaneMaskBitmap = "_-0PP" (String#4080, DoABC#2)
// _asset = "_-1S7" (String#442, DoABC#2)


