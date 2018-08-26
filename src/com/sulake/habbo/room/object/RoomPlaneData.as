
package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomPlaneData 
    {

        public static const _SafeStr_13115:int = 0;
        public static const _SafeStr_5829:int = 1;
        public static const _SafeStr_5832:int = 2;
        public static const _SafeStr_5831:int = 3;
        public static const _SafeStr_12947:int = 4;

        private var _type:int = 0;
        private var _loc:Vector3d = null;
        private var _leftSide:Vector3d = null;
        private var _rightSide:Vector3d = null;
        private var _normal:Vector3d = null;
        private var _normalDirection:Vector3d = null;
        private var _SafeStr_12971:Array;
        private var _SafeStr_12837:Array;

        public function RoomPlaneData(_arg_1:int, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Array)
        {
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:int;
            var _local_12:IVector3d;
            var _local_13:Vector3d;
            this._SafeStr_12971 = [];
            this._SafeStr_12837 = [];
            super();
            this._loc = new Vector3d();
            this._loc.assign(_arg_2);
            this._leftSide = new Vector3d();
            this._leftSide.assign(_arg_3);
            this._rightSide = new Vector3d();
            this._rightSide.assign(_arg_4);
            this._type = _arg_1;
            if (((!((_arg_3 == null))) && (!((_arg_4 == null))))){
                this._normal = Vector3d.crossProduct(_arg_3, _arg_4);
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = 0;
                _local_9 = 0;
                _local_10 = 0;
                if (((!((this.normal.x == 0))) || (!((this.normal.y == 0))))){
                    _local_9 = this.normal.x;
                    _local_10 = this.normal.y;
                    _local_6 = (360 + ((Math.atan2(_local_10, _local_9) / Math.PI) * 180));
                    if (_local_6 >= 360){
                        _local_6 = (_local_6 - 360);
                    };
                    _local_9 = Math.sqrt(((this.normal.x * this.normal.x) + (this.normal.y * this.normal.y)));
                    _local_10 = this.normal.z;
                    _local_7 = (360 + ((Math.atan2(_local_10, _local_9) / Math.PI) * 180));
                    if (_local_7 >= 360){
                        _local_7 = (_local_7 - 360);
                    };
                }
                else {
                    if (this.normal.z < 0){
                        _local_7 = 90;
                    }
                    else {
                        _local_7 = 270;
                    };
                };
                this._normalDirection = new Vector3d(_local_6, _local_7, _local_8);
            };
            if (((!((_arg_5 == null))) && ((_arg_5.length > 0)))){
                _local_11 = 0;
                while (_local_11 < _arg_5.length) {
                    _local_12 = _arg_5[_local_11];
                    if (((!((_local_12 == null))) && ((_local_12.length > 0)))){
                        _local_13 = new Vector3d();
                        _local_13.assign(_local_12);
                        _local_13.mul((1 / _local_13.length));
                        this._SafeStr_12971.push(_local_13);
                    };
                    _local_11++;
                };
            };
        }
        public function get type():int
        {
            return (this._type);
        }
        public function get loc():IVector3d
        {
            return (this._loc);
        }
        public function get leftSide():IVector3d
        {
            return (this._leftSide);
        }
        public function get rightSide():IVector3d
        {
            return (this._rightSide);
        }
        public function get normal():IVector3d
        {
            return (this._normal);
        }
        public function get normalDirection():IVector3d
        {
            return (this._normalDirection);
        }
        public function get secondaryNormalCount():int
        {
            return (this._SafeStr_12971.length);
        }
        public function get maskCount():int
        {
            return (this._SafeStr_12837.length);
        }
        public function RoomPlaneData(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.secondaryNormalCount)))){
                return (null);
            };
            var _local_2:Vector3d = new Vector3d();
            _local_2.assign((this._SafeStr_12971[_arg_1] as IVector3d));
            return (_local_2);
        }
        public function RoomPlaneBitmapMaskParser(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            var _local_5:RoomPlaneMaskData = new RoomPlaneMaskData(_arg_1, _arg_2, _arg_3, _arg_4);
            this._SafeStr_12837.push(_local_5);
        }
        private function RoomPlaneData(_arg_1:int):RoomPlaneMaskData
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.maskCount)))){
                return (null);
            };
            return (this._SafeStr_12837[_arg_1]);
        }
        public function RoomPlaneData(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = this.RoomPlaneData(_arg_1);
            if (_local_2 != null){
                return (_local_2.leftSideLoc);
            };
            return (-1);
        }
        public function RoomPlaneData(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = this.RoomPlaneData(_arg_1);
            if (_local_2 != null){
                return (_local_2.rightSideLoc);
            };
            return (-1);
        }
        public function RoomPlaneData(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = this.RoomPlaneData(_arg_1);
            if (_local_2 != null){
                return (_local_2.leftSideLength);
            };
            return (-1);
        }
        public function RoomPlaneData(_arg_1:int):Number
        {
            var _local_2:RoomPlaneMaskData = this.RoomPlaneData(_arg_1);
            if (_local_2 != null){
                return (_local_2.rightSideLength);
            };
            return (-1);
        }

    }
}//package com.sulake.habbo.room.object

// crossProduct = "_-0hD" (String#15719, DoABC#2)
// _leftSide = "_-2Fc" (String#1844, DoABC#2)
// _rightSide = "_-0yh" (String#1588, DoABC#2)
// leftSide = "_-3Gi" (String#22151, DoABC#2)
// rightSide = "_-kB" (String#24043, DoABC#2)
// _SafeStr_12837 = "_-014" (String#1385, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// _SafeStr_12947 = "_-0wA" (String#16279, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// maskCount = "_-3BF" (String#21934, DoABC#2)
// _SafeStr_12971 = "_-1Kc" (String#5254, DoABC#2)
// rightSideLoc = "_-0jZ" (String#15810, DoABC#2)
// leftSideLoc = "_-38V" (String#21822, DoABC#2)
// rightSideLength = "_-3HX" (String#22181, DoABC#2)
// leftSideLength = "_-bH" (String#23681, DoABC#2)
// normalDirection = "_-35R" (String#21711, DoABC#2)
// secondaryNormalCount = "_-2fe" (String#20677, DoABC#2)
// RoomPlaneData = "_-48" (String#22384, DoABC#2)
// _SafeStr_13115 = "_-0iW" (String#15773, DoABC#2)
// RoomPlaneData = "_-1xr" (String#18882, DoABC#2)
// RoomPlaneData = "_-1Oa" (String#17452, DoABC#2)
// RoomPlaneData = "_-3GI" (String#22133, DoABC#2)
// RoomPlaneData = "_-2Wn" (String#20316, DoABC#2)
// _normalDirection = "_-2AU" (String#19427, DoABC#2)
// RoomPlaneData = "_-1Co" (String#16975, DoABC#2)
// RoomPlaneData = "_-1iF" (String#5716, DoABC#2)
// RoomPlaneMaskData = "_-0zA" (String#4830, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// RoomPlaneBitmapMaskParser = "_-0SM" (String#15149, DoABC#2)
// _SafeStr_5829 = "_-dd" (String#23787, DoABC#2)
// _SafeStr_5831 = "_-1Gc" (String#17138, DoABC#2)
// _SafeStr_5832 = "_-0IL" (String#14772, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)


