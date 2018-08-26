
package com.sulake.room.utils
{
    import com.sulake.core.utils.Map;
    import flash.geom.Point;

    public class RoomGeometry implements IRoomGeometry 
    {

        public static const _SafeStr_14327:Number = 64;
        public static const _RoomGeometry:Number = 32;

        private var _updateId:int = 0;
        private var _x:Vector3d;
        private var _y:Vector3d;
        private var _Vector3d:Vector3d;
        private var _directionAxis:Vector3d;
        private var _location:Vector3d;
        private var _direction:Vector3d;
        private var _depth:Vector3d;
        private var _scale:Number = 1;
        private var _SafeStr_14511:Number = 1;
        private var _SafeStr_14512:Number = 1;
        private var _SafeStr_14513:Number = 1;
        private var _SafeStr_14514:Number = 1;
        private var _SafeStr_14515:Number = 1;
        private var _SafeStr_14516:Number = 1;
        private var _loc:Vector3d;
        private var _dir:Vector3d;
        private var _SafeStr_14517:Number = -500;
        private var _SafeStr_14518:Number = 500;
        private var _SafeStr_14519:Map = null;

        public function RoomGeometry(_arg_1:Number, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d=null)
        {
            this.scale = _arg_1;
            this._x = new Vector3d();
            this._y = new Vector3d();
            this._Vector3d = new Vector3d();
            this._directionAxis = new Vector3d();
            this._location = new Vector3d();
            this._direction = new Vector3d();
            this._depth = new Vector3d();
            this._SafeStr_14514 = 1;
            this._SafeStr_14515 = 1;
            this.x_scale = 1;
            this.y_scale = 1;
            this._SafeStr_14516 = (Math.sqrt((1 / 2)) / Math.sqrt((3 / 4)));
            this.z_scale = 1;
            this.location = new Vector3d(_arg_3.x, _arg_3.y, _arg_3.z);
            this.direction = new Vector3d(_arg_2.x, _arg_2.y, _arg_2.z);
            if (_arg_4 != null){
                this.RoomGeometry(_arg_4);
            }
            else {
                this.RoomGeometry(_arg_2);
            };
            this._SafeStr_14519 = new Map();
        }
        public static function getIntersectionVector(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d):IVector3d
        {
            var _local_5:Number = Vector3d.dotProduct(_arg_2, _arg_4);
            if (Math.abs(_local_5) < 1E-5){
                return (null);
            };
            var _local_6:Vector3d = Vector3d.dif(_arg_1, _arg_3);
            var _local_7:Number = (-(Vector3d.dotProduct(_arg_4, _local_6)) / _local_5);
            return (Vector3d.sum(_arg_1, Vector3d.product(_arg_2, _local_7)));
        }

        public function get updateId():int
        {
            return (this._updateId);
        }
        public function get scale():Number
        {
            return ((this._scale / Math.sqrt(0.5)));
        }
        public function get directionAxis():IVector3d
        {
            return (this._directionAxis);
        }
        public function get location():IVector3d
        {
            this._location.assign(this._loc);
            this._location.x = (this._location.x * this._SafeStr_14511);
            this._location.y = (this._location.y * this._SafeStr_14512);
            this._location.z = (this._location.z * this._SafeStr_14513);
            return (this._location);
        }
        public function get direction():IVector3d
        {
            return (this._direction);
        }
        public function set x_scale(_arg_1:Number):void
        {
            if (this._SafeStr_14511 != (_arg_1 * this._SafeStr_14514)){
                this._SafeStr_14511 = (_arg_1 * this._SafeStr_14514);
                this._updateId++;
            };
        }
        public function set y_scale(_arg_1:Number):void
        {
            if (this._SafeStr_14512 != (_arg_1 * this._SafeStr_14515)){
                this._SafeStr_14512 = (_arg_1 * this._SafeStr_14515);
                this._updateId++;
            };
        }
        public function set z_scale(_arg_1:Number):void
        {
            if (this._SafeStr_14513 != (_arg_1 * this._SafeStr_14516)){
                this._SafeStr_14513 = (_arg_1 * this._SafeStr_14516);
                this._updateId++;
            };
        }
        public function set scale(_arg_1:Number):void
        {
            if (_arg_1 <= 1){
                _arg_1 = 1;
            };
            _arg_1 = (_arg_1 * Math.sqrt(0.5));
            if (_arg_1 != this._scale){
                this._scale = _arg_1;
                this._updateId++;
            };
        }
        public function set location(_arg_1:IVector3d):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._loc == null){
                this._loc = new Vector3d();
            };
            var _local_2:Number = this._loc.x;
            var _local_3:Number = this._loc.y;
            var _local_4:Number = this._loc.z;
            this._loc.assign(_arg_1);
            this._loc.x = (this._loc.x / this._SafeStr_14511);
            this._loc.y = (this._loc.y / this._SafeStr_14512);
            this._loc.z = (this._loc.z / this._SafeStr_14513);
            if (((((!((this._loc.x == _local_2))) || (!((this._loc.y == _local_3))))) || (!((this._loc.z == _local_4))))){
                this._updateId++;
            };
        }
        public function set direction(_arg_1:IVector3d):void
        {
            var _local_21:Number;
            var _local_22:Number;
            var _local_23:Vector3d;
            var _local_24:Vector3d;
            var _local_25:Vector3d;
            if (_arg_1 == null){
                return;
            };
            if (this._dir == null){
                this._dir = new Vector3d();
            };
            var _local_2:Number = this._dir.x;
            var _local_3:Number = this._dir.y;
            var _local_4:Number = this._dir.z;
            this._dir.assign(_arg_1);
            this._direction.assign(_arg_1);
            if (((((!((this._dir.x == _local_2))) || (!((this._dir.y == _local_3))))) || (!((this._dir.z == _local_4))))){
                this._updateId++;
            };
            var _local_5:Vector3d = new Vector3d(0, 1, 0);
            var _local_6:Vector3d = new Vector3d(0, 0, 1);
            var _local_7:Vector3d = new Vector3d(1, 0, 0);
            var _local_8:Number = ((_arg_1.x / 180) * Math.PI);
            var _local_9:Number = ((_arg_1.y / 180) * Math.PI);
            var _local_10:Number = ((_arg_1.z / 180) * Math.PI);
            var _local_11:Number = Math.cos(_local_8);
            var _local_12:Number = Math.sin(_local_8);
            var _local_13:Vector3d = Vector3d.sum(Vector3d.product(_local_5, _local_11), Vector3d.product(_local_7, -(_local_12)));
            var _local_14:Vector3d = new Vector3d(_local_6.x, _local_6.y, _local_6.z);
            var _local_15:Vector3d = Vector3d.sum(Vector3d.product(_local_5, _local_12), Vector3d.product(_local_7, _local_11));
            var _local_16:Number = Math.cos(_local_9);
            var _local_17:Number = Math.sin(_local_9);
            var _local_18:Vector3d = new Vector3d(_local_13.x, _local_13.y, _local_13.z);
            var _local_19:Vector3d = Vector3d.sum(Vector3d.product(_local_14, _local_16), Vector3d.product(_local_15, _local_17));
            var _local_20:Vector3d = Vector3d.sum(Vector3d.product(_local_14, -(_local_17)), Vector3d.product(_local_15, _local_16));
            if (_local_10 != 0){
                _local_21 = Math.cos(_local_10);
                _local_22 = Math.sin(_local_10);
                _local_23 = Vector3d.sum(Vector3d.product(_local_18, _local_21), Vector3d.product(_local_19, _local_22));
                _local_24 = Vector3d.sum(Vector3d.product(_local_18, -(_local_22)), Vector3d.product(_local_19, _local_21));
                _local_25 = new Vector3d(_local_20.x, _local_20.y, _local_20.z);
                this._x.assign(_local_23);
                this._y.assign(_local_24);
                this._Vector3d.assign(_local_25);
                this._directionAxis.assign(this._Vector3d);
            }
            else {
                this._x.assign(_local_18);
                this._y.assign(_local_19);
                this._Vector3d.assign(_local_20);
                this._directionAxis.assign(this._Vector3d);
            };
        }
        public function dispose():void
        {
            this._x = null;
            this._y = null;
            this._Vector3d = null;
            this._loc = null;
            this._dir = null;
            this._directionAxis = null;
            this._location = null;
            if (this._SafeStr_14519 != null){
                this._SafeStr_14519.dispose();
                this._SafeStr_14519 = null;
            };
        }
        public function RoomGeometry(_arg_1:IVector3d, _arg_2:IVector3d):void
        {
            var _local_3:String;
            var _local_4:Vector3d;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (this._SafeStr_14519 != null){
                _local_3 = ((((int(Math.round(_arg_1.x)) + "_") + int(Math.round(_arg_1.y))) + "_") + int(Math.round(_arg_1.z)));
                this._SafeStr_14519.remove(_local_3);
                _local_4 = new Vector3d();
                _local_4.assign(_arg_2);
                this._SafeStr_14519.add(_local_3, _local_4);
                this._updateId++;
            };
        }
        private function RoomGeometry(_arg_1:IVector3d):IVector3d
        {
            var _local_2:String;
            if (this._SafeStr_14519 != null){
                _local_2 = ((((int(Math.round(_arg_1.x)) + "_") + int(Math.round(_arg_1.y))) + "_") + int(Math.round(_arg_1.z)));
                return (this._SafeStr_14519.getValue(_local_2));
            };
            return (null);
        }
        public function RoomGeometry(_arg_1:IVector3d):void
        {
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Vector3d;
            var _local_21:Vector3d;
            var _local_22:Vector3d;
            var _local_2:Vector3d = new Vector3d(0, 1, 0);
            var _local_3:Vector3d = new Vector3d(0, 0, 1);
            var _local_4:Vector3d = new Vector3d(1, 0, 0);
            var _local_5:Number = ((_arg_1.x / 180) * Math.PI);
            var _local_6:Number = ((_arg_1.y / 180) * Math.PI);
            var _local_7:Number = ((_arg_1.z / 180) * Math.PI);
            var _local_8:Number = Math.cos(_local_5);
            var _local_9:Number = Math.sin(_local_5);
            var _local_10:Vector3d = Vector3d.sum(Vector3d.product(_local_2, _local_8), Vector3d.product(_local_4, -(_local_9)));
            var _local_11:Vector3d = new Vector3d(_local_3.x, _local_3.y, _local_3.z);
            var _local_12:Vector3d = Vector3d.sum(Vector3d.product(_local_2, _local_9), Vector3d.product(_local_4, _local_8));
            var _local_13:Number = Math.cos(_local_6);
            var _local_14:Number = Math.sin(_local_6);
            var _local_15:Vector3d = new Vector3d(_local_10.x, _local_10.y, _local_10.z);
            var _local_16:Vector3d = Vector3d.sum(Vector3d.product(_local_11, _local_13), Vector3d.product(_local_12, _local_14));
            var _local_17:Vector3d = Vector3d.sum(Vector3d.product(_local_11, -(_local_14)), Vector3d.product(_local_12, _local_13));
            if (_local_7 != 0){
                _local_18 = Math.cos(_local_7);
                _local_19 = Math.sin(_local_7);
                _local_20 = Vector3d.sum(Vector3d.product(_local_15, _local_18), Vector3d.product(_local_16, _local_19));
                _local_21 = Vector3d.sum(Vector3d.product(_local_15, -(_local_19)), Vector3d.product(_local_16, _local_18));
                _local_22 = new Vector3d(_local_17.x, _local_17.y, _local_17.z);
                this._depth.assign(_local_22);
            }
            else {
                this._depth.assign(_local_17);
            };
            this._updateId++;
        }
        public function RoomGeometry(_arg_1:IVector3d, _arg_2:Number):void
        {
            if ((((_arg_1 == null)) || ((this._Vector3d == null)))){
                return;
            };
            var _local_3:Vector3d = Vector3d.product(this._Vector3d, -(_arg_2));
            var _local_4:Vector3d = new Vector3d((_arg_1.x + _local_3.x), (_arg_1.y + _local_3.y), (_arg_1.z + _local_3.z));
            this.location = _local_4;
        }
        public function RoomGeometry(_arg_1:IVector3d):IVector3d
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:Number = Vector3d.scalarProjection(_arg_1, this._x);
            var _local_3:Number = Vector3d.scalarProjection(_arg_1, this._y);
            var _local_4:Number = Vector3d.scalarProjection(_arg_1, this._Vector3d);
            return (new Vector3d(_local_2, _local_3, _local_4));
        }
        public function RoomGeometry(_arg_1:IVector3d):IVector3d
        {
            var _local_2:Vector3d = Vector3d.dif(_arg_1, this._loc);
            _local_2.x = (_local_2.x * this._SafeStr_14511);
            _local_2.y = (_local_2.y * this._SafeStr_14512);
            _local_2.z = (_local_2.z * this._SafeStr_14513);
            var _local_3:Number = Vector3d.scalarProjection(_local_2, this._depth);
            if ((((_local_3 < this._SafeStr_14517)) || ((_local_3 > this._SafeStr_14518)))){
                return (null);
            };
            var _local_4:Number = Vector3d.scalarProjection(_local_2, this._x);
            var _local_5:Number = -(Vector3d.scalarProjection(_local_2, this._y));
            _local_4 = (_local_4 * this._scale);
            _local_5 = (_local_5 * this._scale);
            var _local_6:IVector3d = this.RoomGeometry(_arg_1);
            if (_local_6 != null){
                _local_2 = Vector3d.dif(_arg_1, this._loc);
                _local_2.add(_local_6);
                _local_2.x = (_local_2.x * this._SafeStr_14511);
                _local_2.y = (_local_2.y * this._SafeStr_14512);
                _local_2.z = (_local_2.z * this._SafeStr_14513);
                _local_3 = Vector3d.scalarProjection(_local_2, this._depth);
            };
            _local_2.x = _local_4;
            _local_2.y = _local_5;
            _local_2.z = _local_3;
            return (_local_2);
        }
        public function RoomGeometry(_arg_1:IVector3d):Point
        {
            var _local_2:IVector3d = this.RoomGeometry(_arg_1);
            if (_local_2 == null){
                return (null);
            };
            return (new Point(_local_2.x, _local_2.y));
        }
        public function RoomGeometry(_arg_1:Point, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d):Point
        {
            var _local_15:Number;
            var _local_16:Number;
            var _local_5:Number = (_arg_1.x / this._scale);
            var _local_6:Number = (-(_arg_1.y) / this._scale);
            var _local_7:Vector3d = Vector3d.product(this._x, _local_5);
            _local_7.add(Vector3d.product(this._y, _local_6));
            var _local_8:Vector3d = new Vector3d((this._loc.x * this._SafeStr_14511), (this._loc.y * this._SafeStr_14512), (this._loc.z * this._SafeStr_14513));
            _local_8.add(_local_7);
            var _local_9:IVector3d = this._Vector3d;
            var _local_10:Vector3d = new Vector3d((_arg_2.x * this._SafeStr_14511), (_arg_2.y * this._SafeStr_14512), (_arg_2.z * this._SafeStr_14513));
            var _local_11:Vector3d = new Vector3d((_arg_3.x * this._SafeStr_14511), (_arg_3.y * this._SafeStr_14512), (_arg_3.z * this._SafeStr_14513));
            var _local_12:Vector3d = new Vector3d((_arg_4.x * this._SafeStr_14511), (_arg_4.y * this._SafeStr_14512), (_arg_4.z * this._SafeStr_14513));
            var _local_13:IVector3d = Vector3d.crossProduct(_local_11, _local_12);
            var _local_14:Vector3d = new Vector3d();
            _local_14.assign(RoomGeometry.getIntersectionVector(_local_8, _local_9, _local_10, _local_13));
            if (_local_14 != null){
                _local_14.sub(_local_10);
                _local_15 = ((Vector3d.scalarProjection(_local_14, _arg_3) / _local_11.length) * _arg_3.length);
                _local_16 = ((Vector3d.scalarProjection(_local_14, _arg_4) / _local_12.length) * _arg_4.length);
                return (new Point(_local_15, _local_16));
            };
            return (null);
        }
        public function RoomGeometry():void
        {
            if (this.RoomGeometry()){
                this.scale = _RoomGeometry;
            }
            else {
                this.scale = _SafeStr_14327;
            };
        }
        public function RoomGeometry():Boolean
        {
            return ((this.scale == _SafeStr_14327));
        }
        public function RoomGeometry():void
        {
            this.scale = _RoomGeometry;
        }
        public function RoomGeometry():void
        {
            this.scale = _SafeStr_14327;
        }

    }
}//package com.sulake.room.utils

// dif = "_-wu" (String#24566, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// RoomGeometry = "_-05e" (String#3679, DoABC#2)
// directionAxis = "_-3Gq" (String#7644, DoABC#2)
// RoomGeometry = "_-1QP" (String#5358, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// scalarProjection = "_-2p1" (String#21043, DoABC#2)
// z_scale = "_-2LM" (String#6468, DoABC#2)
// RoomGeometry = "_-03w" (String#3646, DoABC#2)
// _SafeStr_14327 = "_-H5" (String#22894, DoABC#2)
// RoomGeometry = "_-2Oh" (String#6534, DoABC#2)
// _RoomGeometry = "_-06M" (String#14302, DoABC#2)
// _updateId = "_-3HO" (String#22174, DoABC#2)
// _directionAxis = "_-0e7" (String#15590, DoABC#2)
// _SafeStr_14511 = "_-1Dg" (String#17011, DoABC#2)
// _SafeStr_14512 = "_-2d6" (String#20567, DoABC#2)
// _SafeStr_14513 = "_-1JI" (String#17249, DoABC#2)
// _SafeStr_14514 = "_-15g" (String#16682, DoABC#2)
// _SafeStr_14515 = "_-Lr" (String#23076, DoABC#2)
// _SafeStr_14516 = "_-2Kw" (String#19842, DoABC#2)
// _SafeStr_14517 = "_-1Zv" (String#17888, DoABC#2)
// _SafeStr_14518 = "_-Un" (String#23438, DoABC#2)
// _SafeStr_14519 = "_-Kb" (String#23027, DoABC#2)
// x_scale = "_-1qI" (String#18555, DoABC#2)
// y_scale = "_-02y" (String#14160, DoABC#2)
// RoomGeometry = "_-2Ch" (String#19512, DoABC#2)
// RoomGeometry = "_-2h8" (String#20733, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// _location = "_-245" (String#244, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// _dir = "_-1kY" (String#187, DoABC#2)
// updateId = "_-0TD" (String#1478, DoABC#2)
// RoomGeometry = "_-34h" (String#7403, DoABC#2)
// RoomGeometry = "_-9w" (String#7863, DoABC#2)
// RoomGeometry = "_-1S5" (String#5398, DoABC#2)
// RoomGeometry = "_-2Z0" (String#6746, DoABC#2)
// RoomGeometry = "_-10E" (String#4875, DoABC#2)
// _Vector3d = "_-0kf" (String#215, DoABC#2)
// _loc = "_-0OE" (String#185, DoABC#2)
// _depth = "_-XX" (String#935, DoABC#2)
// RoomGeometry = "_-eX" (String#8492, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// sub = "_-2e2" (String#20605, DoABC#2)


