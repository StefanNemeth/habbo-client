
package com.sulake.habbo.room.utils
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.IVector3d;

    public class RoomCamera 
    {

        private static const _SafeStr_13155:Number = 12;

        private var _targetId:int = -1;
        private var _targetCategory:int = -2;
        private var _realTargetLoc:Vector3d = null;
        private var _SafeStr_13158:Number = 0;
        private var _SafeStr_13159:Number = 0;
        private var _SafeStr_13160:Boolean = false;
        private var _RoomCamera:Vector3d = null;
        private var _targetObjectLoc:Vector3d;
        private var _limitedLocationX:Boolean = false;
        private var _limitedLocationY:Boolean = false;
        private var _centeredLocX:Boolean = false;
        private var _centeredLocY:Boolean = false;
        private var _screenWd:int = 0;
        private var _screenHt:int = 0;
        private var _scale:int = 0;
        private var _roomWd:int = 0;
        private var _roomHt:int = 0;
        private var _geometryUpdateId:int = -1;
        private var _SafeStr_13170:int = 0;
        private var _SafeStr_13171:Boolean = false;

        public function RoomCamera()
        {
            this._targetObjectLoc = new Vector3d();
            super();
        }
        public function get location():IVector3d
        {
            return (this._RoomCamera);
        }
        public function get targetId():int
        {
            return (this._targetId);
        }
        public function get targetCategory():int
        {
            return (this._targetCategory);
        }
        public function get targetObjectLoc():IVector3d
        {
            return (this._targetObjectLoc);
        }
        public function get limitedLocationX():Boolean
        {
            return (this._limitedLocationX);
        }
        public function get limitedLocationY():Boolean
        {
            return (this._limitedLocationY);
        }
        public function get centeredLocX():Boolean
        {
            return (this._centeredLocX);
        }
        public function get centeredLocY():Boolean
        {
            return (this._centeredLocY);
        }
        public function get screenWd():int
        {
            return (this._screenWd);
        }
        public function get screenHt():int
        {
            return (this._screenHt);
        }
        public function get scale():int
        {
            return (this._scale);
        }
        public function get roomWd():int
        {
            return (this._roomWd);
        }
        public function get roomHt():int
        {
            return (this._roomHt);
        }
        public function get geometryUpdateId():int
        {
            return (this._geometryUpdateId);
        }
        public function get isMoving():Boolean
        {
            if (((!((this._realTargetLoc == null))) && (!((this._RoomCamera == null))))){
                return (true);
            };
            return (false);
        }
        public function set targetId(_arg_1:int):void
        {
            this._targetId = _arg_1;
        }
        public function set targetObjectLoc(_arg_1:IVector3d):void
        {
            this._targetObjectLoc.assign(_arg_1);
        }
        public function set targetCategory(_arg_1:int):void
        {
            this._targetCategory = _arg_1;
        }
        public function set limitedLocationX(_arg_1:Boolean):void
        {
            this._limitedLocationX = _arg_1;
        }
        public function set limitedLocationY(_arg_1:Boolean):void
        {
            this._limitedLocationY = _arg_1;
        }
        public function set centeredLocX(_arg_1:Boolean):void
        {
            this._centeredLocX = _arg_1;
        }
        public function set centeredLocY(_arg_1:Boolean):void
        {
            this._centeredLocY = _arg_1;
        }
        public function set screenWd(_arg_1:int):void
        {
            this._screenWd = _arg_1;
        }
        public function set screenHt(_arg_1:int):void
        {
            this._screenHt = _arg_1;
        }
        public function set scale(_arg_1:int):void
        {
            if (this._scale != _arg_1){
                this._scale = _arg_1;
                this._SafeStr_13171 = true;
            };
        }
        public function set roomWd(_arg_1:int):void
        {
            this._roomWd = _arg_1;
        }
        public function set roomHt(_arg_1:int):void
        {
            this._roomHt = _arg_1;
        }
        public function set geometryUpdateId(_arg_1:int):void
        {
            this._geometryUpdateId = _arg_1;
        }
        public function set target(_arg_1:IVector3d):void
        {
            var _local_2:Vector3d;
            if (this._realTargetLoc == null){
                this._realTargetLoc = new Vector3d();
            };
            if (((((!((this._realTargetLoc.x == _arg_1.x))) || (!((this._realTargetLoc.y == _arg_1.y))))) || (!((this._realTargetLoc.z == _arg_1.z))))){
                this._realTargetLoc.assign(_arg_1);
                this._SafeStr_13170 = 0;
                _local_2 = Vector3d.dif(this._realTargetLoc, this._RoomCamera);
                this._SafeStr_13158 = _local_2.length;
                this._SafeStr_13160 = true;
            };
        }
        public function dispose():void
        {
            this._realTargetLoc = null;
            this._RoomCamera = null;
        }
        public function initializeLocation(_arg_1:IVector3d):void
        {
            if (this._RoomCamera != null){
                return;
            };
            this._RoomCamera = new Vector3d();
            this._RoomCamera.assign(_arg_1);
        }
        public function resetLocation(_arg_1:IVector3d):void
        {
            if (this._RoomCamera == null){
                this._RoomCamera = new Vector3d();
            };
            this._RoomCamera.assign(_arg_1);
        }
        public function update(_arg_1:uint, _arg_2:Number):void
        {
            var _local_3:Vector3d;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            if (((!((this._realTargetLoc == null))) && (!((this._RoomCamera == null))))){
                this._SafeStr_13170++;
                if (this._SafeStr_13171){
                    this._SafeStr_13171 = false;
                    this._RoomCamera = this._realTargetLoc;
                    this._realTargetLoc = null;
                    return;
                };
                _local_3 = Vector3d.dif(this._realTargetLoc, this._RoomCamera);
                if (_local_3.length > this._SafeStr_13158){
                    this._SafeStr_13158 = _local_3.length;
                };
                if (_local_3.length <= _arg_2){
                    this._RoomCamera = this._realTargetLoc;
                    this._realTargetLoc = null;
                    this._SafeStr_13159 = 0;
                }
                else {
                    _local_4 = Math.sin(((Math.PI * _local_3.length) / this._SafeStr_13158));
                    _local_5 = (_arg_2 * 0.5);
                    _local_6 = (this._SafeStr_13158 / _SafeStr_13155);
                    _local_7 = (_local_5 + ((_local_6 - _local_5) * _local_4));
                    if (this._SafeStr_13160){
                        if (_local_7 < this._SafeStr_13159){
                            _local_7 = this._SafeStr_13159;
                            if (_local_7 > _local_3.length){
                                _local_7 = _local_3.length;
                            };
                        }
                        else {
                            this._SafeStr_13160 = false;
                        };
                    };
                    this._SafeStr_13159 = _local_7;
                    _local_3.div(_local_3.length);
                    _local_3.mul(_local_7);
                    this._RoomCamera = Vector3d.sum(this._RoomCamera, _local_3);
                };
            };
        }
        public function reset():void
        {
            this._geometryUpdateId = -1;
        }

    }
}//package com.sulake.habbo.room.utils

// _RoomCamera = "_-1Xk" (String#5512, DoABC#2)
// dif = "_-wu" (String#24566, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _SafeStr_13155 = "_-2Zc" (String#20424, DoABC#2)
// _targetId = "_-0nU" (String#15956, DoABC#2)
// _targetCategory = "_-xr" (String#24608, DoABC#2)
// _SafeStr_13158 = "_-ko" (String#24061, DoABC#2)
// _SafeStr_13159 = "_-1Xs" (String#17810, DoABC#2)
// _SafeStr_13160 = "_-1lx" (String#18373, DoABC#2)
// _targetObjectLoc = "_-2D0" (String#19523, DoABC#2)
// _limitedLocationX = "_-0Zw" (String#15439, DoABC#2)
// _limitedLocationY = "_-0l3" (String#15868, DoABC#2)
// _centeredLocX = "_-1YB" (String#17823, DoABC#2)
// _centeredLocY = "_-Xl" (String#23553, DoABC#2)
// _screenWd = "_-32U" (String#21596, DoABC#2)
// _screenHt = "_-0F7" (String#14649, DoABC#2)
// _roomWd = "_-2tw" (String#21235, DoABC#2)
// _roomHt = "_-HM" (String#22906, DoABC#2)
// _SafeStr_13170 = "_-2Mi" (String#19915, DoABC#2)
// _SafeStr_13171 = "_-23T" (String#19153, DoABC#2)
// targetId = "_-0Ji" (String#14831, DoABC#2)
// targetCategory = "_-1Hs" (String#17188, DoABC#2)
// targetObjectLoc = "_-05c" (String#14267, DoABC#2)
// limitedLocationX = "_-2WO" (String#20300, DoABC#2)
// limitedLocationY = "_-2AT" (String#19426, DoABC#2)
// centeredLocX = "_-2M" (String#19884, DoABC#2)
// centeredLocY = "_-294" (String#19369, DoABC#2)
// screenWd = "_-2dn" (String#20592, DoABC#2)
// roomWd = "_-1Cg" (String#16971, DoABC#2)
// roomHt = "_-1gg" (String#18164, DoABC#2)
// geometryUpdateId = "_-1y5" (String#18891, DoABC#2)
// initializeLocation = "_-0-v" (String#14049, DoABC#2)
// resetLocation = "_-1tW" (String#18698, DoABC#2)
// div = "_-2-I" (String#18982, DoABC#2)
// RoomCamera = "_-1FW" (String#17096, DoABC#2)
// _geometryUpdateId = "_-2yN" (String#370, DoABC#2)
// isMoving = "_-2Cl" (String#19515, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)
// _realTargetLoc = "_-0bq" (String#1509, DoABC#2)


