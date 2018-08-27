
package com.sulake.habbo.room.object
{
    import com.sulake.core.utils.Map;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.utils.XMLValidator;

    public class RoomPlaneParser 
    {

        private static const RORPVUM_FLOOR_THICKNESS:Number = 0.25;
        private static const RORPPUM_WALL_THICKNESS:Number = 0.25;
        public static const _SafeStr_3802:int = -110;
        public static const _SafeStr_13058:int = -100;

        private var _SafeStr_13059:Array;
        private var _SafeStr_13060:Array;
        private var _width:int = 0;
        private var _height:int = 0;
        private var _minX:int = 0;
        private var _maxX:int = 0;
        private var _minY:int = 0;
        private var _maxY:int = 0;
        private var _SafeStr_12729:Array;
        private var _wallHeight:Number = 0;
        private var _wallThicknessMultiplier:Number = 1;
        private var _floorThicknessMultiplier:Number = 1;
        private var _floorHeight:Number = 0;
        private var _SafeStr_13066:Map = null;
        private var _SafeStr_13067:Array;

        public function RoomPlaneParser()
        {
            this._SafeStr_13059 = [];
            this._SafeStr_13060 = [];
            this._SafeStr_12729 = [];
            this._SafeStr_13067 = [];
            super();
            this._wallHeight = 3.6;
            this._wallThicknessMultiplier = 1;
            this._floorThicknessMultiplier = 1;
            this._SafeStr_13066 = new Map();
        }
        private static function getFloorHeight(_arg_1:Array):Number
        {
            var _local_8:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int = _arg_1.length;
            var _local_6:int;
            if (_local_5 == 0){
                return (0);
            };
            var _local_7:Number = 0;
            _local_3 = 0;
            while (_local_3 < _local_5) {
                _local_4 = (_arg_1[_local_3] as Array);
                _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    _local_8 = Number(_local_4[_local_2]);
                    if (_local_8 > _local_7){
                        _local_7 = _local_8;
                    };
                    _local_2++;
                };
                _local_3++;
            };
            return (_local_7);
        }
        private static function findEntranceTile(_arg_1:Array):Point
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int = _arg_1.length;
            if (_local_5 == 0){
                return (null);
            };
            var _local_6:Array = [];
            _local_3 = 0;
            while (_local_3 < _local_5) {
                _local_4 = (_arg_1[_local_3] as Array);
                if ((((_local_4 == null)) || ((_local_4.length == 0)))){
                    return (null);
                };
                _local_2 = 0;
                while (_local_2 < _local_4.length) {
                    if (Number(_local_4[_local_2]) >= 0){
                        _local_6.push(_local_2);
                        break;
                    };
                    _local_2++;
                };
                if (_local_6.length < (_local_3 + 1)){
                    _local_6.push((_local_4.length + 1));
                };
                _local_3++;
            };
            _local_3 = 1;
            while (_local_3 < (_local_6.length - 1)) {
                if ((((int(_local_6[_local_3]) <= (int(_local_6[(_local_3 - 1)]) - 1))) && ((int(_local_6[_local_3]) <= (int(_local_6[(_local_3 + 1)]) - 1))))){
                    return (new Point(int(_local_6[_local_3]), _local_3));
                };
                _local_3++;
            };
            return (null);
        }

        public function get minX():int
        {
            return (this._minX);
        }
        public function get maxX():int
        {
            return (this._maxX);
        }
        public function get minY():int
        {
            return (this._minY);
        }
        public function get maxY():int
        {
            return (this._maxY);
        }
        public function get tileMapWidth():int
        {
            return (this._width);
        }
        public function get tileMapHeight():int
        {
            return (this._height);
        }
        public function get planeCount():int
        {
            return (this._SafeStr_12729.length);
        }
        public function get floorHeight():Number
        {
            return (this._floorHeight);
        }
        public function get wallHeight():Number
        {
            return (this._wallHeight);
        }
        public function set wallHeight(_arg_1:Number):void
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            this._wallHeight = _arg_1;
        }
        public function get wallThicknessMultiplier():Number
        {
            return (this._wallThicknessMultiplier);
        }
        public function set wallThicknessMultiplier(_arg_1:Number):void
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            this._wallThicknessMultiplier = _arg_1;
        }
        public function get floorThicknessMultiplier():Number
        {
            return (this._floorThicknessMultiplier);
        }
        public function set floorThicknessMultiplier(_arg_1:Number):void
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            this._floorThicknessMultiplier = _arg_1;
        }
        public function dispose():void
        {
            this._SafeStr_12729 = null;
            this._SafeStr_13059 = null;
            this._SafeStr_13060 = null;
            this._SafeStr_13067 = null;
            if (this._SafeStr_13066 != null){
                this._SafeStr_13066.dispose();
                this._SafeStr_13066 = null;
            };
        }
        public function reset():void
        {
            this._SafeStr_12729 = [];
            this._SafeStr_13059 = [];
            this._SafeStr_13060 = [];
            this._SafeStr_13059 = [];
            this._SafeStr_13060 = [];
            this._width = 0;
            this._height = 0;
            this._minX = 0;
            this._maxX = 0;
            this._minY = 0;
            this._maxY = 0;
            this._floorHeight = 0;
            this._SafeStr_13067 = [];
        }
        public function initializeTileMap(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:int;
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_2 < 0){
                _arg_2 = 0;
            };
            this._SafeStr_13059 = [];
            this._SafeStr_13060 = [];
            this._SafeStr_13067 = [];
            var _local_3:int;
            while (_local_3 < _arg_2) {
                _local_4 = [];
                _local_5 = [];
                _local_6 = [];
                _local_7 = 0;
                while (_local_7 < _arg_1) {
                    _local_4[_local_7] = _SafeStr_3802;
                    _local_5[_local_7] = _SafeStr_3802;
                    _local_6[_local_7] = false;
                    _local_7++;
                };
                this._SafeStr_13059.push(_local_4);
                this._SafeStr_13060.push(_local_5);
                this._SafeStr_13067.push(_local_6);
                _local_3++;
            };
            this._width = _arg_1;
            this._height = _arg_2;
            this._minX = this._width;
            this._maxX = -1;
            this._minY = this._height;
            this._maxY = -1;
            return (true);
        }
        public function setTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number):Boolean
        {
            var _local_4:Array;
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:int;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._width)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._height)))){
                _local_4 = (this._SafeStr_13059[_arg_2] as Array);
                _local_4[_arg_1] = _arg_3;
                if (_arg_3 >= 0){
                    if (_arg_1 < this._minX){
                        this._minX = _arg_1;
                    };
                    if (_arg_1 > this._maxX){
                        this._maxX = _arg_1;
                    };
                    if (_arg_2 < this._minY){
                        this._minY = _arg_2;
                    };
                    if (_arg_2 > this._maxY){
                        this._maxY = _arg_2;
                    };
                }
                else {
                    if ((((_arg_1 == this._minX)) || ((_arg_1 == this._maxX)))){
                        _local_5 = false;
                        _local_6 = this._minY;
                        while (_local_6 < this._maxY) {
                            if (this.getTileHeightInternal(_arg_1, _local_6) >= 0){
                                _local_5 = true;
                                break;
                            };
                            _local_6++;
                        };
                        if (!_local_5){
                            if (_arg_1 == this._minX){
                                this._minX++;
                            };
                            if (_arg_1 == this._maxX){
                                this._maxX--;
                            };
                        };
                    };
                    if ((((_arg_2 == this._minY)) || ((_arg_2 == this._maxY)))){
                        _local_7 = false;
                        _local_8 = this._minX;
                        while (_local_8 < this._maxX) {
                            if (this.getTileHeight(_local_8, _arg_2) >= 0){
                                _local_7 = true;
                                break;
                            };
                            _local_8++;
                        };
                        if (!_local_7){
                            if (_arg_2 == this._minY){
                                this._minY++;
                            };
                            if (_arg_2 == this._maxY){
                                this._maxY--;
                            };
                        };
                    };
                };
                return (true);
            };
            return (false);
        }
        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._height)))){
                return (_SafeStr_3802);
            };
            var _local_3:Array = (this._SafeStr_13059[_arg_2] as Array);
            return (Math.abs((_local_3[_arg_1] as Number)));
        }
        private function getTileHeightOriginal(_arg_1:int, _arg_2:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._height)))){
                return (_SafeStr_3802);
            };
            if (this._SafeStr_13067[_arg_2][_arg_1]){
                return (_SafeStr_13058);
            };
            var _local_3:Array = (this._SafeStr_13060[_arg_2] as Array);
            return ((_local_3[_arg_1] as Number));
        }
        private function getTileHeightInternal(_arg_1:int, _arg_2:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._height)))){
                return (_SafeStr_3802);
            };
            var _local_3:Array = (this._SafeStr_13059[_arg_2] as Array);
            return ((_local_3[_arg_1] as Number));
        }
        public function initializeFromTileData(_arg_1:Boolean=false):Boolean
        {
            var _local_2:int;
            var _local_3:int;
            _local_3 = 0;
            while (_local_3 < this._height) {
                _local_2 = 0;
                while (_local_2 < this._width) {
                    this._SafeStr_13060[_local_3][_local_2] = this._SafeStr_13059[_local_3][_local_2];
                    _local_2++;
                };
                _local_3++;
            };
            var _local_4:Point = findEntranceTile(this._SafeStr_13059);
            _local_3 = 0;
            while (_local_3 < this._height) {
                _local_2 = 0;
                while (_local_2 < this._width) {
                    if (this._SafeStr_13067[_local_3][_local_2]){
                        this.setTileHeight(_local_2, _local_3, _SafeStr_13058);
                    };
                    _local_2++;
                };
                _local_3++;
            };
            return (this.initialize(_local_4, _arg_1));
        }
        private function initialize(_arg_1:Point, _arg_2:Boolean):Boolean
        {
            var _local_7:Array;
            var _local_8:int;
            var _local_3:int;
            if (_arg_1 != null){
                _local_3 = this.getTileHeight(_arg_1.x, _arg_1.y);
                this.setTileHeight(_arg_1.x, _arg_1.y, _SafeStr_3802);
            };
            this._floorHeight = getFloorHeight(this._SafeStr_13059);
            if (!_arg_2){
                this.createWallPlanes();
            };
            var _local_4:Array;
            var _local_5:Array = [];
            var _local_6:int;
            while (_local_6 < this._SafeStr_13059.length) {
                _local_4 = this._SafeStr_13059[_local_6];
                _local_7 = [];
                _local_8 = 0;
                while (_local_8 < _local_4.length) {
                    _local_7.push(_local_4[_local_8]);
                    _local_8++;
                };
                _local_5.push(_local_7);
                _local_6++;
            };
            do  {
            } while (this.extractFloorPlane(_local_5, true));
            if (_arg_1 != null){
                this.setTileHeight(_arg_1.x, _arg_1.y, _local_3);
                _local_4 = _local_5[_arg_1.y];
                _local_4[_arg_1.x] = _local_3;
                this.extractFloorPlane(_local_5, false);
            };
            return (true);
        }
        private function generateWallData(_arg_1:Point, _arg_2:Boolean):RoomWallData
        {
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_11:Point;
            var _local_12:int;
            var _local_3:RoomWallData = new RoomWallData();
            var _local_4:Array = [this.extractTopWall, this.extractRightWall, this.extractBottomWall, this.extractLeftWall];
            var _local_5:int;
            var _local_6:Point = new Point(_arg_1.x, _arg_1.y);
            var _local_7:int;
            while (_local_7++ < 1000) {
                _local_8 = false;
                _local_9 = false;
                _local_10 = _local_5;
                if ((((((((_local_6.x < this.minX)) || ((_local_6.x > this.maxX)))) || ((_local_6.y < this.minY)))) || ((_local_6.y > this.maxY)))){
                    _local_8 = true;
                };
                _local_11 = _local_4[_local_5](_local_6, _arg_2);
                if (_local_11 == null){
                    return (null);
                };
                _local_12 = (Math.abs((_local_11.x - _local_6.x)) + Math.abs((_local_11.y - _local_6.y)));
                if ((((_local_6.x == _local_11.x)) || ((_local_6.y == _local_11.y)))){
                    _local_5 = (((_local_5 - 1) + _local_4.length) % _local_4.length);
                    _local_12 = (_local_12 + 1);
                    _local_9 = true;
                }
                else {
                    _local_5 = ((_local_5 + 1) % _local_4.length);
                    _local_12--;
                };
                _local_3.addWall(_local_6, _local_10, _local_12, _local_8, _local_9);
                if ((((((_local_11.x == _arg_1.x)) && ((_local_11.y == _arg_1.y)))) && (((!((_local_11.x == _local_6.x))) || (!((_local_11.y == _local_6.y))))))) break;
                _local_6 = _local_11;
            };
            if (_local_3.count == 0){
                return (null);
            };
            return (_local_3);
        }
        private function hidePeninsulaWallChains(_arg_1:RoomWallData):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:int;
            var _local_2:int;
            var _local_3:int = _arg_1.count;
            while (_local_2 < _local_3) {
                _local_4 = _local_2;
                _local_5 = _local_2;
                _local_6 = 0;
                _local_7 = false;
                while (((!(_arg_1.getBorder(_local_2))) && ((_local_2 < _local_3)))) {
                    if (_arg_1.getLeftTurn(_local_2)){
                        _local_6++;
                    }
                    else {
                        if (_local_6 > 0){
                            _local_6--;
                        };
                    };
                    if (_local_6 > 1){
                        _local_7 = true;
                    };
                    _local_5 = _local_2;
                    _local_2++;
                };
                if (_local_7){
                    _local_8 = _local_4;
                    while (_local_8 <= _local_5) {
                        _arg_1.setHideWall(_local_8, true);
                        _local_8++;
                    };
                };
                _local_2++;
            };
        }
        private function updateWallsNextToHoles(_arg_1:RoomWallData):void
        {
            var _local_4:Point;
            var _local_5:int;
            var _local_6:int;
            var _local_7:IVector3d;
            var _local_8:IVector3d;
            var _local_9:int;
            var _local_10:int;
            var _local_2:int = _arg_1.count;
            var _local_3:int;
            while (_local_3 < _local_2) {
                if (!_arg_1.getHideWall(_local_3)){
                    _local_4 = _arg_1.getCorner(_local_3);
                    _local_5 = _arg_1.getDirection(_local_3);
                    _local_6 = _arg_1.getLength(_local_3);
                    _local_7 = RoomWallData._SafeStr_13088[_local_5];
                    _local_8 = RoomWallData._SafeStr_13089[_local_5];
                    _local_9 = 0;
                    _local_10 = 0;
                    while (_local_10 < _local_6) {
                        if (this.getTileHeightInternal(((_local_4.x + (_local_10 * _local_7.x)) - _local_8.x), ((_local_4.y + (_local_10 * _local_7.y)) - _local_8.y)) == _SafeStr_13058){
                            if ((((_local_10 > 0)) && ((_local_9 == 0)))){
                                _arg_1.setLength(_local_3, _local_10);
                                break;
                            };
                            _local_9++;
                        }
                        else {
                            if (_local_9 > 0){
                                _arg_1.moveCorner(_local_3, _local_9);
                                break;
                            };
                        };
                        _local_10++;
                    };
                    if (_local_9 == _local_6){
                        _arg_1.setHideWall(_local_3, true);
                    };
                };
                _local_3++;
            };
        }
        private function resolveOriginalWallIndex(_arg_1:Point, _arg_2:Point, _arg_3:RoomWallData):int
        {
            var _local_10:Point;
            var _local_11:Point;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            var _local_15:int;
            var _local_4:int = Math.min(_arg_1.y, _arg_2.y);
            var _local_5:int = Math.max(_arg_1.y, _arg_2.y);
            var _local_6:int = Math.min(_arg_1.x, _arg_2.x);
            var _local_7:int = Math.max(_arg_1.x, _arg_2.x);
            var _local_8:int = _arg_3.count;
            var _local_9:int;
            while (_local_9 < _local_8) {
                _local_10 = _arg_3.getCorner(_local_9);
                _local_11 = _arg_3.getEndPoint(_local_9);
                if (_arg_1.x == _arg_2.x){
                    if ((((_local_10.x == _arg_1.x)) && ((_local_11.x == _arg_1.x)))){
                        _local_12 = Math.min(_local_10.y, _local_11.y);
                        _local_13 = Math.max(_local_10.y, _local_11.y);
                        if ((((_local_12 <= _local_4)) && ((_local_5 <= _local_13)))){
                            return (_local_9);
                        };
                    };
                }
                else {
                    if (_arg_1.y == _arg_2.y){
                        if ((((_local_10.y == _arg_1.y)) && ((_local_11.y == _arg_1.y)))){
                            _local_14 = Math.min(_local_10.x, _local_11.x);
                            _local_15 = Math.max(_local_10.x, _local_11.x);
                            if ((((_local_14 <= _local_6)) && ((_local_7 <= _local_15)))){
                                return (_local_9);
                            };
                        };
                    };
                };
                _local_9++;
            };
            return (-1);
        }
        private function hideOriginallyHiddenWalls(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            var _local_5:Point;
            var _local_6:Point;
            var _local_7:IVector3d;
            var _local_8:int;
            var _local_9:int;
            var _local_3:int = _arg_1.count;
            var _local_4:int;
            while (_local_4 < _local_3) {
                if (!_arg_1.getHideWall(_local_4)){
                    _local_5 = _arg_1.getCorner(_local_4);
                    _local_6 = new Point(_local_5.x, _local_5.y);
                    _local_7 = RoomWallData._SafeStr_13088[_arg_1.getDirection(_local_4)];
                    _local_8 = _arg_1.getLength(_local_4);
                    _local_6.x = (_local_6.x + (_local_7.x * _local_8));
                    _local_6.y = (_local_6.y + (_local_7.y * _local_8));
                    _local_9 = this.resolveOriginalWallIndex(_local_5, _local_6, _arg_2);
                    if (_local_9 >= 0){
                        if (_arg_2.getHideWall(_local_9)){
                            _arg_1.setHideWall(_local_4, true);
                        };
                    };
                };
                _local_4++;
            };
        }
        private function checkWallHiding(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            this.hidePeninsulaWallChains(_arg_2);
            this.updateWallsNextToHoles(_arg_1);
            this.hideOriginallyHiddenWalls(_arg_1, _arg_2);
        }
        private function addWalls(_arg_1:RoomWallData, _arg_2:RoomWallData):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_8:Point;
            var _local_9:int;
            var _local_10:int;
            var _local_11:IVector3d;
            var _local_12:IVector3d;
            var _local_13:Number;
            var _local_14:int;
            var _local_15:Number;
            var _local_16:Vector3d;
            var _local_17:Number;
            var _local_18:Vector3d;
            var _local_19:Vector3d;
            var _local_20:int;
            var _local_21:Vector3d;
            var _local_22:Boolean;
            var _local_23:Boolean;
            var _local_24:Boolean;
            var _local_25:Boolean;
            var _local_26:Boolean;
            var _local_27:Number;
            var _local_3:int = _arg_1.count;
            var _local_4:int = _arg_2.count;
            var _local_7:int;
            while (_local_7 < _local_3) {
                if (!_arg_1.getHideWall(_local_7)){
                    _local_8 = _arg_1.getCorner(_local_7);
                    _local_9 = _arg_1.getDirection(_local_7);
                    _local_10 = _arg_1.getLength(_local_7);
                    _local_11 = RoomWallData._SafeStr_13088[_local_9];
                    _local_12 = RoomWallData._SafeStr_13089[_local_9];
                    _local_13 = -1;
                    _local_14 = 0;
                    while (_local_14 < _local_10) {
                        _local_27 = this.getTileHeightInternal(((_local_8.x + (_local_14 * _local_11.x)) + _local_12.x), ((_local_8.y + (_local_14 * _local_11.y)) + _local_12.y));
                        if ((((_local_27 >= 0)) && ((((_local_27 < _local_13)) || ((_local_13 < 0)))))){
                            _local_13 = _local_27;
                        };
                        _local_14++;
                    };
                    _local_15 = _local_13;
                    _local_16 = new Vector3d(_local_8.x, _local_8.y, _local_15);
                    _local_16 = Vector3d.sum(_local_16, Vector3d.product(_local_12, 0.5));
                    _local_16 = Vector3d.sum(_local_16, Vector3d.product(_local_11, -0.5));
                    _local_17 = ((this.wallHeight + this.floorHeight) - _local_13);
                    _local_18 = Vector3d.product(_local_11, -(_local_10));
                    _local_19 = new Vector3d(0, 0, _local_17);
                    _local_16 = Vector3d.dif(_local_16, _local_18);
                    _local_20 = this.resolveOriginalWallIndex(_local_8, _arg_1.getEndPoint(_local_7), _arg_2);
                    if (_local_20 >= 0){
                        _local_5 = _arg_2.getDirection(((_local_20 + 1) % _local_4));
                        _local_6 = _arg_2.getDirection((((_local_20 - 1) + _local_4) % _local_4));
                    }
                    else {
                        _local_5 = _arg_1.getDirection(((_local_7 + 1) % _local_3));
                        _local_6 = _arg_1.getDirection((((_local_7 - 1) + _local_3) % _local_3));
                    };
                    _local_21 = null;
                    if ((((_local_5 - _local_9) + 4) % 4) == 3){
                        _local_21 = RoomWallData._SafeStr_13089[_local_5];
                    }
                    else {
                        if ((((_local_9 - _local_6) + 4) % 4) == 3){
                            _local_21 = RoomWallData._SafeStr_13089[_local_6];
                        };
                    };
                    _local_22 = _arg_1.getLeftTurn(_local_7);
                    _local_23 = _arg_1.getLeftTurn((((_local_7 - 1) + _local_3) % _local_3));
                    _local_24 = _arg_1.getHideWall(((_local_7 + 1) % _local_3));
                    _local_25 = _arg_1.getManuallyLeftCut(_local_7);
                    _local_26 = _arg_1.getManuallyRightCut(_local_7);
                    this.addWall(_local_16, _local_18, _local_19, _local_21, ((!(_local_23)) || (_local_25)), ((!(_local_22)) || (_local_26)), !(_local_24));
                };
                _local_7++;
            };
        }
        private function createWallPlanes():Boolean
        {
            var _local_13:int;
            var _local_14:int;
            var _local_1:Array = this._SafeStr_13059;
            if (_local_1 == null){
                return (false);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int = _local_1.length;
            var _local_6:int;
            if (_local_5 == 0){
                return (false);
            };
            _local_2 = 0;
            while (_local_2 < _local_5) {
                _local_4 = (_local_1[_local_2] as Array);
                if ((((_local_4 == null)) || ((_local_4.length == 0)))){
                    return (false);
                };
                if (_local_6 > 0){
                    _local_6 = Math.min(_local_6, _local_4.length);
                }
                else {
                    _local_6 = _local_4.length;
                };
                _local_2++;
            };
            var _local_7:Number = getFloorHeight(_local_1);
            var _local_8:int = this.minX;
            var _local_9:int = this.minY;
            _local_9 = this.minY;
            while (_local_9 <= this.maxY) {
                if (this.getTileHeightInternal(_local_8, _local_9) > _SafeStr_13058){
                    _local_9--;
                    break;
                };
                _local_9++;
            };
            if (_local_9 > this.maxY){
                return (false);
            };
            var _local_10:Point = new Point(_local_8, _local_9);
            var _local_11:RoomWallData = this.generateWallData(_local_10, true);
            var _local_12:RoomWallData = this.generateWallData(_local_10, false);
            if (_local_11 != null){
                _local_13 = _local_11.count;
                _local_14 = _local_12.count;
                this.checkWallHiding(_local_11, _local_12);
                this.addWalls(_local_11, _local_12);
            };
            _local_3 = 0;
            while (_local_3 < this.tileMapHeight) {
                _local_2 = 0;
                while (_local_2 < this.tileMapWidth) {
                    if (this.getTileHeightInternal(_local_2, _local_3) < 0){
                        this.setTileHeight(_local_2, _local_3, -((_local_7 + this.wallHeight)));
                    };
                    _local_2++;
                };
                _local_3++;
            };
            return (true);
        }
        private function extractTopWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = _SafeStr_13058;
            if (!_arg_2){
                _local_4 = _SafeStr_3802;
            };
            while (_local_3 < 1000) {
                if (this.getTileHeightInternal((_arg_1.x + _local_3), _arg_1.y) > _local_4){
                    return (new Point(((_arg_1.x + _local_3) - 1), _arg_1.y));
                };
                if (this.getTileHeightInternal((_arg_1.x + _local_3), (_arg_1.y + 1)) <= _local_4){
                    return (new Point((_arg_1.x + _local_3), (_arg_1.y + 1)));
                };
                _local_3++;
            };
            return (null);
        }
        private function extractRightWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = _SafeStr_13058;
            if (!_arg_2){
                _local_4 = _SafeStr_3802;
            };
            while (_local_3 < 1000) {
                if (this.getTileHeightInternal(_arg_1.x, (_arg_1.y + _local_3)) > _local_4){
                    return (new Point(_arg_1.x, (_arg_1.y + (_local_3 - 1))));
                };
                if (this.getTileHeightInternal((_arg_1.x - 1), (_arg_1.y + _local_3)) <= _local_4){
                    return (new Point((_arg_1.x - 1), (_arg_1.y + _local_3)));
                };
                _local_3++;
            };
            return (null);
        }
        private function extractBottomWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = _SafeStr_13058;
            if (!_arg_2){
                _local_4 = _SafeStr_3802;
            };
            while (_local_3 < 1000) {
                if (this.getTileHeightInternal((_arg_1.x - _local_3), _arg_1.y) > _local_4){
                    return (new Point((_arg_1.x - (_local_3 - 1)), _arg_1.y));
                };
                if (this.getTileHeightInternal((_arg_1.x - _local_3), (_arg_1.y - 1)) <= _local_4){
                    return (new Point((_arg_1.x - _local_3), (_arg_1.y - 1)));
                };
                _local_3++;
            };
            return (null);
        }
        private function extractLeftWall(_arg_1:Point, _arg_2:Boolean):Point
        {
            if (_arg_1 == null){
                return (null);
            };
            var _local_3:int = 1;
            var _local_4:int = _SafeStr_13058;
            if (!_arg_2){
                _local_4 = _SafeStr_3802;
            };
            while (_local_3 < 1000) {
                if (this.getTileHeightInternal(_arg_1.x, (_arg_1.y - _local_3)) > _local_4){
                    return (new Point(_arg_1.x, (_arg_1.y - (_local_3 - 1))));
                };
                if (this.getTileHeightInternal((_arg_1.x + 1), (_arg_1.y - _local_3)) <= _local_4){
                    return (new Point((_arg_1.x + 1), (_arg_1.y - _local_3)));
                };
                _local_3++;
            };
            return (null);
        }
        private function addWall(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean):void
        {
            var _local_12:Vector3d;
            this.addPlane(RoomPlaneData._SafeStr_5832, _arg_1, _arg_2, _arg_3, [_arg_4]);
            this.addPlane(RoomPlaneData._SafeStr_5831, _arg_1, _arg_2, _arg_3, [_arg_4]);
            var _local_8:Number = (RORPPUM_WALL_THICKNESS * this._wallThicknessMultiplier);
            var _local_9:Number = (RORPVUM_FLOOR_THICKNESS * this._floorThicknessMultiplier);
            var _local_10:Vector3d = Vector3d.crossProduct(_arg_2, _arg_3);
            var _local_11:Vector3d = Vector3d.product(_local_10, ((1 / _local_10.length) * -(_local_8)));
            this.addPlane(RoomPlaneData._SafeStr_5832, Vector3d.sum(_arg_1, _arg_3), _arg_2, _local_11, [_local_10, _arg_4]);
            if (_arg_5){
                this.addPlane(RoomPlaneData._SafeStr_5832, Vector3d.sum(Vector3d.sum(_arg_1, _arg_2), _arg_3), Vector3d.product(_arg_3, (-((_arg_3.length + _local_9)) / _arg_3.length)), _local_11, [_local_10, _arg_4]);
            };
            if (_arg_6){
                this.addPlane(RoomPlaneData._SafeStr_5832, Vector3d.sum(_arg_1, Vector3d.product(_arg_3, (-(_local_9) / _arg_3.length))), Vector3d.product(_arg_3, ((_arg_3.length + _local_9) / _arg_3.length)), _local_11, [_local_10, _arg_4]);
                if (_arg_7){
                    _local_12 = Vector3d.product(_arg_2, (_local_8 / _arg_2.length));
                    this.addPlane(RoomPlaneData._SafeStr_5832, Vector3d.sum(Vector3d.sum(_arg_1, _arg_3), Vector3d.product(_local_12, -1)), _local_12, _local_11, [_local_10, _arg_2, _arg_4]);
                };
            };
        }
        private function findFloorRectangle(_arg_1:Array, _arg_2:int, _arg_3:int):RoomFloorRectangle
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:Array;
            var _local_8:int;
            var _local_9:int = _arg_2;
            var _local_10:int;
            var _local_11:int;
            var _local_12:Number = -1;
            var _local_13:Number = 0;
            _local_5 = 0;
            while (_local_5 < _arg_3) {
                _local_6 = (_arg_1[_local_5] as Array);
                _local_7 = (_arg_1[_local_10] as Array);
                if (_local_12 >= 0){
                    if ((((_local_8 > 0)) && (!((Number(_local_6[(_local_8 - 1)]) == Number(_local_7[(_local_8 - 1)])))))){
                        _local_11 = _local_5;
                        break;
                    };
                    if ((((_local_9 < _arg_2)) && (!((_local_6[_local_9] == Number(_local_7[_local_9])))))){
                        _local_11 = _local_5;
                        break;
                    };
                };
                _local_4 = _local_8;
                while (_local_4 < _local_9) {
                    _local_13 = Number(_local_6[_local_4]);
                    if (_local_13 >= 0){
                        if (_local_12 < 0){
                            _local_10 = _local_5;
                            _local_8 = _local_4;
                            _local_12 = _local_13;
                        }
                        else {
                            if (_local_13 != _local_12){
                                if (_local_5 > _local_10){
                                    _local_11 = _local_5;
                                    _local_5 = _arg_3;
                                    break;
                                };
                                _local_9 = _local_4;
                            };
                        };
                    }
                    else {
                        if (_local_12 >= 0){
                            if (_local_5 == _local_10){
                                _local_9 = _local_4;
                            }
                            else {
                                if (_local_4 < _local_9){
                                    _local_11 = _local_5;
                                    _local_5 = _arg_3;
                                    break;
                                };
                            };
                        };
                    };
                    _local_11 = (_local_5 + 1);
                    _local_4++;
                };
                _local_5++;
            };
            if (_local_12 < 0){
                return (null);
            };
            if ((_local_9 - _local_8) < 1){
                return (null);
            };
            if ((_local_11 - _local_10) < 1){
                return (null);
            };
            if (_local_10 > 0){
                _local_7 = _arg_1[(_local_10 - 1)];
            }
            else {
                _local_7 = null;
            };
            _local_6 = _arg_1[_local_11];
            _local_4 = (_local_8 + 1);
            while (_local_4 < _local_9) {
                if (((((!((_local_6 == null))) && (!(((_local_6[_local_4] >= -1) == (_local_6[_local_8] >= -1)))))) || (((!((_local_7 == null))) && (!(((_local_7[_local_4] >= -1) == (_local_7[_local_8] >= -1)))))))){
                    _local_9 = _local_4;
                    break;
                };
                _local_4++;
            };
            _local_7 = _arg_1[_local_10];
            _local_4 = (_local_10 + 1);
            while (_local_4 < _local_11) {
                _local_6 = _arg_1[_local_4];
                if ((((((_local_8 > 0)) && (!(((_local_6[(_local_8 - 1)] >= -1) == (_local_7[(_local_8 - 1)] >= -1)))))) || ((((_local_9 < _arg_2)) && (!(((_local_6[_local_9] >= -1) == (_local_7[_local_9] >= -1)))))))){
                    _local_11 = _local_4;
                    break;
                };
                _local_4++;
            };
            return (new RoomFloorRectangle(_local_8, _local_10, _local_9, _local_11, _local_12));
        }
        private function getHeightMapWidth(_arg_1:Array):int
        {
            var _local_2:int = _arg_1.length;
            if (_local_2 == 0){
                return (0);
            };
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:int;
            while (_local_6 < _local_2) {
                _local_3 = (_arg_1[_local_6] as Array);
                _local_4 = (this._SafeStr_13059[_local_6] as Array);
                if ((((_local_3 == null)) || ((_local_3.length == 0)))){
                    return (0);
                };
                if ((((_local_4 == null)) || ((_local_4.length == 0)))){
                    return (0);
                };
                if (_local_3.length != _local_4.length){
                    return (0);
                };
                if (_local_5 > 0){
                    if (_local_3.length < _local_5){
                        _local_5 = _local_3.length;
                    };
                }
                else {
                    _local_5 = _local_3.length;
                };
                _local_6++;
            };
            return (_local_5);
        }
        private function getHorizontalStairInfo(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Number):RoomStairData
        {
            var _local_15:int;
            var _local_8:int = 1;
            var _local_9:Boolean;
            var _local_10:Boolean;
            var _local_11:Boolean;
            if (_arg_4 < 0){
                _local_8 = 0;
            };
            if (_arg_4 > (_arg_6 - 1)){
                _local_8 = 0;
            };
            var _local_12:int = _arg_1;
            while (_local_12 < _arg_2) {
                if (_local_8){
                    _local_15 = Math.abs((this.getTileHeightInternal(_local_12, _arg_4) - this.getTileHeightInternal(_local_12, _arg_3)));
                    if (_local_15 != 1){
                        _local_8 = 0;
                    }
                    else {
                        _local_8 = (this.getTileHeightInternal(_local_12, _arg_4) - this.getTileHeightInternal(_local_12, _arg_3));
                    };
                };
                if (((!(_local_9)) && ((this.getTileHeightInternal(_local_12, _arg_4) < _arg_7)))){
                    _local_9 = true;
                };
                _local_12++;
            };
            var _local_13:int = (_arg_1 - 1);
            var _local_14:int = (_arg_2 + 1);
            _local_12 = (_arg_1 - 1);
            while (_local_12 >= _local_13) {
                _local_15 = Math.abs((this.getTileHeightOriginal(_local_12, _arg_4) - this.getTileHeightOriginal(_local_12, _arg_3)));
                if (_local_15 == 1){
                    _local_10 = true;
                };
                _local_12--;
            };
            _local_12 = _arg_2;
            while (_local_12 < _local_14) {
                _local_15 = Math.abs((this.getTileHeightOriginal(_local_12, _arg_4) - this.getTileHeightOriginal(_local_12, _arg_3)));
                if (_local_15 == 1){
                    _local_11 = true;
                };
                _local_12++;
            };
            return (new RoomStairData(_local_8, _local_10, _local_11, _local_9));
        }
        private function getVerticalStairInfo(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:Number):RoomStairData
        {
            var _local_15:int;
            var _local_8:int = 1;
            var _local_9:Boolean;
            var _local_10:Boolean;
            var _local_11:Boolean;
            if (_arg_4 < 0){
                _local_8 = 0;
            };
            if (_arg_4 > (_arg_5 - 2)){
                _local_8 = 0;
            };
            var _local_12:int = _arg_1;
            while (_local_12 < _arg_2) {
                if (_local_8){
                    _local_15 = Math.abs((this.getTileHeightInternal(_arg_4, _local_12) - this.getTileHeightInternal(_arg_3, _local_12)));
                    if (_local_15 != 1){
                        _local_8 = 0;
                    }
                    else {
                        _local_8 = (this.getTileHeightInternal(_arg_4, _local_12) - this.getTileHeightInternal(_arg_3, _local_12));
                    };
                };
                if (((!(_local_9)) && ((this.getTileHeightInternal(_arg_4, _local_12) < _arg_7)))){
                    _local_9 = true;
                };
                _local_12++;
            };
            var _local_13:int = (_arg_1 - 1);
            var _local_14:int = (_arg_2 + 1);
            _local_12 = (_arg_1 - 1);
            while (_local_12 >= _local_13) {
                _local_15 = Math.abs((this.getTileHeightOriginal(_arg_4, _local_12) - this.getTileHeightOriginal(_arg_3, _local_12)));
                if (_local_15 == 1){
                    _local_10 = true;
                };
                _local_12--;
            };
            _local_12 = _arg_2;
            while (_local_12 < _local_14) {
                _local_15 = Math.abs((this.getTileHeightOriginal(_arg_4, _local_12) - this.getTileHeightOriginal(_arg_3, _local_12)));
                if (_local_15 == 1){
                    _local_11 = true;
                };
                _local_12++;
            };
            return (new RoomStairData(_local_8, _local_10, _local_11, _local_9));
        }
        private function extractFloorPlane(_arg_1:Array, _arg_2:Boolean):Boolean
        {
            var _local_18:Boolean;
            var _local_19:Boolean;
            var _local_20:Boolean;
            var _local_21:Boolean;
            if ((((((_arg_1 == null)) || ((this._SafeStr_13059 == null)))) || ((_arg_1 == this._SafeStr_13059)))){
                return (false);
            };
            var _local_3:int;
            var _local_4:int;
            var _local_5:Array;
            if (_arg_1.length > this._SafeStr_13059.length){
                return (false);
            };
            var _local_6:int = _arg_1.length;
            if (_local_6 == 0){
                return (false);
            };
            var _local_7:int = this.getHeightMapWidth(_arg_1);
            if (_local_7 == 0){
                return (false);
            };
            var _local_8:RoomFloorRectangle = this.findFloorRectangle(_arg_1, _local_7, _local_6);
            if (_local_8 == null){
                return (false);
            };
            var _local_9:Number = (_local_8.right - _local_8.left);
            var _local_10:Number = (_local_8.bottom - _local_8.top);
            var _local_11:Number = _local_8.altitude;
            var _local_12:Number = (_local_8.left - 0.5);
            var _local_13:Number = (_local_8.top - 0.5);
            var _local_14:RoomStairData = this.getHorizontalStairInfo(_local_8.left, _local_8.right, _local_8.top, (_local_8.top - 1), _local_7, _local_6, _local_11);
            var _local_15:RoomStairData = this.getHorizontalStairInfo(_local_8.left, _local_8.right, (_local_8.bottom - 1), _local_8.bottom, _local_7, _local_6, _local_11);
            var _local_16:RoomStairData = this.getVerticalStairInfo(_local_8.top, _local_8.bottom, _local_8.left, (_local_8.left - 1), _local_7, _local_6, _local_11);
            var _local_17:RoomStairData = this.getVerticalStairInfo(_local_8.top, _local_8.bottom, (_local_8.right - 1), _local_8.right, _local_7, _local_6, _local_11);
            if (_local_14.stairHeight){
                if (_local_14.stairHeight > 0){
                    _local_18 = false;
                    _local_19 = true;
                }
                else {
                    _local_18 = true;
                    _local_19 = false;
                };
                this.addFloor(new Vector3d((_local_12 + _local_9), (_local_13 + 0.34), (_local_11 + ((_local_14.stairHeight / 4) * 2))), new Vector3d(-(_local_9), 0, 0), new Vector3d(0, -0.34, 0), ((_local_17.border) || (!(_local_14.neighbourStairMax))), ((_local_16.border) || (!(_local_14.neighbourStairMin))), _local_19, _local_18, 0, 0, 0, 0, false, true);
                this.addFloor(new Vector3d((_local_12 + _local_9), (_local_13 + 0.67), (_local_11 + (_local_14.stairHeight / 4))), new Vector3d(-(_local_9), 0, 0), new Vector3d(0, -0.33, 0), ((_local_17.border) || (!(_local_14.neighbourStairMax))), ((_local_16.border) || (!(_local_14.neighbourStairMin))), _local_19, _local_18, 0, 0, 0, 0, false, true);
            };
            if (_local_15.stairHeight){
                if (_local_15.stairHeight < 0){
                    _local_18 = false;
                    _local_19 = true;
                }
                else {
                    _local_18 = true;
                    _local_19 = false;
                };
                this.addFloor(new Vector3d((_local_12 + _local_9), (_local_13 + _local_10), (_local_11 + (_local_15.stairHeight / 4))), new Vector3d(-(_local_9), 0, 0), new Vector3d(0, -0.33, 0), ((_local_17.border) || (!(_local_15.neighbourStairMax))), ((_local_16.border) || (!(_local_15.neighbourStairMin))), _local_19, _local_18, 0, 0, 0, 0, false, true);
            };
            if (_local_16.stairHeight){
                if (_local_16.stairHeight > 0){
                    _local_20 = false;
                    _local_21 = true;
                }
                else {
                    _local_20 = true;
                    _local_21 = false;
                };
                this.addFloor(new Vector3d((_local_12 + 0.34), (_local_13 + _local_10), (_local_11 + ((_local_16.stairHeight / 4) * 2))), new Vector3d(-0.34, 0, 0), new Vector3d(0, -(_local_10), 0), _local_21, _local_20, ((_local_15.border) || (!(_local_16.neighbourStairMax))), ((_local_14.border) || (!(_local_16.neighbourStairMin))), 0, 0, 0, 0, true, false);
                this.addFloor(new Vector3d((_local_12 + 0.67), (_local_13 + _local_10), (_local_11 + (_local_16.stairHeight / 4))), new Vector3d(-0.33, 0, 0), new Vector3d(0, -(_local_10), 0), _local_21, _local_20, ((_local_15.border) || (!(_local_16.neighbourStairMax))), ((_local_14.border) || (!(_local_16.neighbourStairMin))), 0, 0, 0, 0, true, false);
            };
            if (_local_17.stairHeight){
                if (_local_17.stairHeight < 0){
                    _local_20 = false;
                    _local_21 = true;
                }
                else {
                    _local_20 = true;
                    _local_21 = false;
                };
                this.addFloor(new Vector3d((_local_12 + _local_9), (_local_13 + _local_10), (_local_11 + (_local_17.stairHeight / 4))), new Vector3d(-0.33, 0, 0), new Vector3d(0, -(_local_10), 0), _local_21, _local_20, ((_local_15.border) || (!(_local_17.neighbourStairMax))), ((_local_14.border) || (!(_local_17.neighbourStairMin))), 0, 0, 0, 0, true, false);
            };
            _local_4 = _local_8.top;
            while (_local_4 < _local_8.bottom) {
                _local_5 = _arg_1[_local_4];
                _local_3 = _local_8.left;
                while (_local_3 < _local_8.right) {
                    _local_5[_local_3] = -1;
                    _local_3++;
                };
                _local_4++;
            };
            var _local_22:Number = 0;
            var _local_23:Number = 0;
            var _local_24:Number = 0;
            var _local_25:Number = 0;
            if (((_local_16.stairHeight) || (_local_16.neighbourStair))){
                _local_23 = 0.65;
            };
            if (((_local_17.stairHeight) || (_local_17.neighbourStair))){
                _local_22 = 0.3;
            };
            if (((_local_14.stairHeight) || (_local_14.neighbourStair))){
                _local_25 = 0.65;
            };
            if (((_local_15.stairHeight) || (_local_15.neighbourStair))){
                _local_24 = 0.3;
            };
            this.addFloor(new Vector3d((_local_12 + _local_9), (_local_13 + _local_10), _local_11), new Vector3d(-(_local_9), 0, 0), new Vector3d(0, -(_local_10), 0), ((_local_17.border) && (_arg_2)), ((_local_16.border) && (_arg_2)), ((_local_15.border) && (_arg_2)), ((_local_14.border) && (_arg_2)), _local_22, _local_23, _local_24, _local_25, false, false);
            return (true);
        }
        private function addFloor(_arg_1:IVector3d, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:Number, _arg_12:Boolean, _arg_13:Boolean):void
        {
            var _local_18:Number;
            var _local_19:Number;
            var _local_20:Number;
            var _local_14:RoomPlaneData = this.addPlane(RoomPlaneData._SafeStr_5829, _arg_1, _arg_2, _arg_3);
            var _local_15:IVector3d = _arg_1;
            var _local_16:RoomPlaneData;
            var _local_17:RoomPlaneData;
            if (_local_14){
                _local_18 = (RORPVUM_FLOOR_THICKNESS * this._floorThicknessMultiplier);
                _local_19 = _local_18;
                if (this._floorThicknessMultiplier > 1){
                    _local_19 = RORPVUM_FLOOR_THICKNESS;
                };
                if (_arg_8 > 0){
                    _local_14.addMask(0, 0, (_arg_8 - 0.02), _arg_3.length);
                };
                if (_arg_9 > 0){
                    _local_14.addMask((_arg_2.length - _arg_9), 0, _arg_9, _arg_3.length);
                };
                if (_arg_10 > 0){
                    _local_14.addMask(0, 0, _arg_2.length, (_arg_10 - 0.02));
                };
                if (_arg_11 > 0){
                    _local_14.addMask(0, (_arg_3.length - _arg_11), _arg_2.length, _arg_11);
                };
                if (_arg_6){
                    if ((((_arg_10 > 0)) || (_arg_13))){
                        _local_15 = Vector3d.sum(_arg_1, Vector3d.product(_arg_3, (_arg_10 / _arg_3.length)));
                        _local_20 = _local_19;
                    }
                    else {
                        _local_15 = _arg_1;
                        _local_20 = _local_18;
                    };
                    _local_16 = this.addPlane(RoomPlaneData._SafeStr_5829, _local_15, new Vector3d(0, 0, -(_local_20)), _arg_2);
                    if (_local_16 != null){
                        if (_arg_8 > 0){
                            _local_16.addMask(0, 0, _local_18, _arg_8);
                        };
                        if (_arg_9 > 0){
                            _local_16.addMask(0, (_arg_2.length - _arg_9), _local_18, _arg_9);
                        };
                    };
                };
                if (_arg_7){
                    if ((((_arg_11 > 0)) || (_arg_13))){
                        _local_15 = Vector3d.sum(_arg_1, Vector3d.sum(_arg_2, Vector3d.product(_arg_3, (1 - (_arg_11 / _arg_3.length)))));
                        _local_20 = _local_19;
                    }
                    else {
                        _local_15 = Vector3d.sum(_arg_1, Vector3d.sum(_arg_2, _arg_3));
                        _local_20 = _local_18;
                    };
                    _local_16 = this.addPlane(RoomPlaneData._SafeStr_5829, _local_15, new Vector3d(0, 0, -(_local_20)), Vector3d.product(_arg_2, -1));
                    if (_local_16 != null){
                        if (_arg_9 > 0){
                            _local_16.addMask(0, 0, _local_18, _arg_9);
                        };
                        if (_arg_8 > 0){
                            _local_16.addMask(0, (_arg_2.length - _arg_8), _local_18, _arg_8);
                        };
                    };
                };
                if (_arg_4){
                    if ((((_arg_8 > 0)) || (_arg_12))){
                        _local_15 = Vector3d.sum(_arg_1, Vector3d.sum(_arg_3, Vector3d.product(_arg_2, (_arg_8 / _arg_2.length))));
                        _local_20 = _local_19;
                    }
                    else {
                        _local_15 = Vector3d.sum(_arg_1, _arg_3);
                        _local_20 = _local_18;
                    };
                    _local_17 = this.addPlane(RoomPlaneData._SafeStr_5829, _local_15, new Vector3d(0, 0, -(_local_20)), Vector3d.product(_arg_3, -1));
                    if (_local_17 != null){
                        if (_arg_11 > 0){
                            _local_17.addMask(0, 0, _local_18, _arg_11);
                        };
                        if (_arg_10 > 0){
                            _local_17.addMask(0, (_arg_3.length - _arg_10), _local_18, _arg_10);
                        };
                    };
                };
                if (_arg_5){
                    if ((((_arg_9 > 0)) || (_arg_12))){
                        _local_15 = Vector3d.sum(_arg_1, Vector3d.product(_arg_2, (1 - (_arg_9 / _arg_2.length))));
                        _local_20 = _local_19;
                    }
                    else {
                        _local_15 = Vector3d.sum(_arg_1, _arg_2);
                        _local_20 = _local_18;
                    };
                    _local_17 = this.addPlane(RoomPlaneData._SafeStr_5829, _local_15, new Vector3d(0, 0, -(_local_20)), _arg_3);
                    if (_local_17 != null){
                        if (_arg_10 > 0){
                            _local_17.addMask(0, 0, _local_18, _arg_10);
                        };
                        if (_arg_11 > 0){
                            _local_17.addMask(0, (_arg_3.length - _arg_11), _local_18, _arg_11);
                        };
                    };
                };
            };
        }
        public function initializeFromXML(_arg_1:XML):Boolean
        {
            var _local_7:XML;
            var _local_8:XMLList;
            var _local_9:int;
            var _local_10:XML;
            var _local_11:Number;
            var _local_12:XML;
            var _local_13:XMLList;
            var _local_14:int;
            var _local_15:XML;
            if (_arg_1 == null){
                return (false);
            };
            this.reset();
            this.resetFloorHoles();
            if (!XMLValidator.checkRequiredAttributes(_arg_1.tileMap[0], ["width", "height", "wallHeight"])){
                return (false);
            };
            var _local_2:int = parseInt(_arg_1.tileMap.@width);
            var _local_3:int = parseInt(_arg_1.tileMap.@height);
            var _local_4:Number = parseFloat(_arg_1.tileMap.@wallHeight);
            this.initializeTileMap(_local_2, _local_3);
            var _local_5:XMLList = _arg_1.tileMap.tileRow;
            var _local_6:int;
            while (_local_6 < _local_5.length()) {
                _local_7 = _local_5[_local_6];
                _local_8 = _local_7.tile;
                _local_9 = 0;
                while (_local_9 < _local_8.length()) {
                    _local_10 = _local_8[_local_9];
                    _local_11 = parseFloat(_local_10.@height);
                    this.setTileHeight(_local_9, _local_6, _local_11);
                    _local_9++;
                };
                _local_6++;
            };
            if (_arg_1.holeMap.length() > 0){
                _local_12 = _arg_1.holeMap[0];
                _local_13 = _local_12.hole;
                _local_14 = 0;
                while (_local_14 < _local_13.length()) {
                    _local_15 = _local_13[_local_14];
                    if (XMLValidator.checkRequiredAttributes(_local_15, ["id", "x", "y", "width", "height"])){
                        this.addFloorHole(_local_15.@id, _local_15.@x, _local_15.@y, _local_15.@width, _local_15.@height);
                    };
                    _local_14++;
                };
                this.initializeHoleMap();
            };
            this.wallHeight = _local_4;
            this.initializeFromTileData();
            return (true);
        }
        private function addPlane(_arg_1:int, _arg_2:IVector3d, _arg_3:IVector3d, _arg_4:IVector3d, _arg_5:Array=null):RoomPlaneData
        {
            if ((((_arg_3.length == 0)) || ((_arg_4.length == 0)))){
                return (null);
            };
            var _local_6:RoomPlaneData = new RoomPlaneData(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
            this._SafeStr_12729.push(_local_6);
            return (_local_6);
        }
        public function getXML():XML
        {
            var _local_7:XML;
            var _local_8:Array;
            var _local_9:int;
            var _local_10:Number;
            var _local_11:XML;
            var _local_12:RoomFloorHole;
            var _local_13:int;
            var _local_14:XML;
            var _local_1:XML = new (XML)((((((('<tileMap width="' + this._width) + '" height="') + this._height) + '" wallHeight="') + this._wallHeight) + '"/>'));
            var _local_2:int;
            while (_local_2 < this._height) {
                _local_7 = <tileRow/>
                ;
                _local_8 = this._SafeStr_13060[_local_2];
                _local_9 = 0;
                while (_local_9 < this._width) {
                    _local_10 = _local_8[_local_9];
                    _local_11 = new (XML)((('<tile height="' + _local_10) + '"/>'));
                    _local_7.appendChild(_local_11);
                    _local_9++;
                };
                _local_1.appendChild(_local_7);
                _local_2++;
            };
            var _local_3:XML = <holeMap/>
            ;
            var _local_4:int;
            while (_local_4 < this._SafeStr_13066.length) {
                _local_12 = this._SafeStr_13066.getWithIndex(_local_4);
                if (_local_12 != null){
                    _local_13 = this._SafeStr_13066.getKey(_local_4);
                    _local_14 = new (XML)((((((((((('<hole id="' + _local_13) + '" x="') + _local_12.x) + '" y="') + _local_12.y) + '" width="') + _local_12.width) + '" height="') + _local_12.height) + '"/>'));
                    _local_3.appendChild(_local_14);
                };
                _local_4++;
            };
            var _local_5:XML = <roomData/>
            ;
            _local_5.appendChild(_local_1);
            _local_5.appendChild(_local_3);
            var _local_6:XML = new (XML)((((((((('<dimensions minX="' + this.minX) + '" maxX="') + this.maxX) + '" minY="') + this.minY) + '" maxY="') + this.maxY) + '"/>'));
            _local_5.appendChild(_local_6);
            return (_local_5);
        }
        public function getPlaneLocation(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.loc);
            };
            return (null);
        }
        public function getPlaneNormal(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.normal);
            };
            return (null);
        }
        public function getPlaneLeftSide(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.leftSide);
            };
            return (null);
        }
        public function getPlaneRightSide(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.rightSide);
            };
            return (null);
        }
        public function getPlaneNormalDirection(_arg_1:int):IVector3d
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.normalDirection);
            };
            return (null);
        }
        public function getPlaneSecondaryNormals(_arg_1:int):Array
        {
            var _local_3:Array;
            var _local_4:int;
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (null);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                _local_3 = [];
                _local_4 = 0;
                while (_local_4 < _local_2.secondaryNormalCount) {
                    _local_3.push(_local_2.getSecondaryNormal(_local_4));
                    _local_4++;
                };
                return (_local_3);
            };
            return (null);
        }
        public function getPlaneType(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (RoomPlaneData._SafeStr_13115);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.type);
            };
            return (RoomPlaneData._SafeStr_13115);
        }
        public function getPlaneMaskCount(_arg_1:int):int
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (0);
            };
            var _local_2:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_2 != null){
                return (_local_2.maskCount);
            };
            return (0);
        }
        public function getPlaneMaskLeftSideLoc(_arg_1:int, _arg_2:int):Number
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (-1);
            };
            var _local_3:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_3 != null){
                return (_local_3.getMaskLeftSideLoc(_arg_2));
            };
            return (-1);
        }
        public function getPlaneMaskRightSideLoc(_arg_1:int, _arg_2:int):Number
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (-1);
            };
            var _local_3:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_3 != null){
                return (_local_3.getMaskRightSideLoc(_arg_2));
            };
            return (-1);
        }
        public function getPlaneMaskLeftSideLength(_arg_1:int, _arg_2:int):Number
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (-1);
            };
            var _local_3:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_3 != null){
                return (_local_3.getMaskLeftSideLength(_arg_2));
            };
            return (-1);
        }
        public function getPlaneMaskRightSideLength(_arg_1:int, _arg_2:int):Number
        {
            if ((((_arg_1 < 0)) || ((_arg_1 >= this.planeCount)))){
                return (-1);
            };
            var _local_3:RoomPlaneData = (this._SafeStr_12729[_arg_1] as RoomPlaneData);
            if (_local_3 != null){
                return (_local_3.getMaskRightSideLength(_arg_2));
            };
            return (-1);
        }
        public function addFloorHole(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            this.removeFloorHole(_arg_1);
            var _local_6:RoomFloorHole = new RoomFloorHole(_arg_2, _arg_3, _arg_4, _arg_5);
            this._SafeStr_13066.add(_arg_1, _local_6);
        }
        public function removeFloorHole(_arg_1:int):void
        {
            this._SafeStr_13066.remove(_arg_1);
        }
        public function resetFloorHoles():void
        {
            this._SafeStr_13066.reset();
        }
        private function initializeHoleMap():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:Array;
            var _local_5:RoomFloorHole;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            _local_2 = 0;
            while (_local_2 < this._height) {
                _local_3 = this._SafeStr_13067[_local_2];
                _local_1 = 0;
                while (_local_1 < this._width) {
                    _local_3[_local_1] = false;
                    _local_1++;
                };
                _local_2++;
            };
            var _local_4:int;
            while (_local_4 < this._SafeStr_13066.length) {
                _local_5 = this._SafeStr_13066.getWithIndex(_local_4);
                if (_local_5 != null){
                    _local_6 = _local_5.x;
                    _local_7 = ((_local_5.x + _local_5.width) - 1);
                    _local_8 = _local_5.y;
                    _local_9 = ((_local_5.y + _local_5.height) - 1);
                    _local_6 = (((_local_6 < 0)) ? 0 : _local_6);
                    _local_7 = (((_local_7 >= this._width)) ? (this._width - 1) : _local_7);
                    _local_8 = (((_local_8 < 0)) ? 0 : _local_8);
                    _local_9 = (((_local_9 >= this._height)) ? (this._height - 1) : _local_9);
                    _local_2 = _local_8;
                    while (_local_2 <= _local_9) {
                        _local_3 = this._SafeStr_13067[_local_2];
                        _local_1 = _local_6;
                        while (_local_1 <= _local_7) {
                            _local_3[_local_1] = true;
                            _local_1++;
                        };
                        _local_2++;
                    };
                };
                _local_4++;
            };
        }

    }
}//package com.sulake.habbo.room.object

// dif = "_-wu" (String#24566, DoABC#2)
// _SafeStr_12729 = "_-29o" (String#879, DoABC#2)
// crossProduct = "_-0hD" (String#15719, DoABC#2)
// leftSide = "_-3Gi" (String#22151, DoABC#2)
// rightSide = "_-kB" (String#24043, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// getPlaneSecondaryNormals = "_-2-e" (String#18998, DoABC#2)
// getPlaneMaskCount = "_-0GG" (String#14695, DoABC#2)
// getPlaneMaskLeftSideLoc = "_-22Z" (String#19113, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// getPlaneMaskRightSideLoc = "_-2qb" (String#21106, DoABC#2)
// getPlaneMaskLeftSideLength = "_-15t" (String#16693, DoABC#2)
// getPlaneMaskRightSideLength = "_-0H7" (String#14723, DoABC#2)
// maskCount = "_-3BF" (String#21934, DoABC#2)
// _SafeStr_13058 = "_-1XQ" (String#17794, DoABC#2)
// _SafeStr_13059 = "_-39U" (String#21862, DoABC#2)
// _SafeStr_13060 = "_-0P1" (String#15026, DoABC#2)
// _maxX = "_-2ZM" (String#20412, DoABC#2)
// _minY = "_-0QD" (String#15072, DoABC#2)
// _maxY = "_-314" (String#21540, DoABC#2)
// _wallHeight = "_-0dC" (String#15557, DoABC#2)
// _floorHeight = "_-1VK" (String#5462, DoABC#2)
// _SafeStr_13066 = "_-2RJ" (String#20093, DoABC#2)
// _SafeStr_13067 = "_-0Z7" (String#15408, DoABC#2)
// getFloorHeight = "_-0ia" (String#15776, DoABC#2)
// findEntranceTile = "_-0j5" (String#15796, DoABC#2)
// tileMapWidth = "_-2IK" (String#19740, DoABC#2)
// tileMapHeight = "_-1N2" (String#17402, DoABC#2)
// getTileHeightInternal = "_-1zU" (String#18946, DoABC#2)
// getTileHeightOriginal = "_-0Fs" (String#14677, DoABC#2)
// generateWallData = "_-VK" (String#23462, DoABC#2)
// extractTopWall = "_-1Cb" (String#16968, DoABC#2)
// extractRightWall = "_-1QK" (String#17525, DoABC#2)
// extractBottomWall = "_-2hZ" (String#20756, DoABC#2)
// extractLeftWall = "_-39h" (String#21871, DoABC#2)
// addWall = "_-07C" (String#3707, DoABC#2)
// hidePeninsulaWallChains = "_-01b" (String#14115, DoABC#2)
// getBorder = "_-35V" (String#21713, DoABC#2)
// getLeftTurn = "_-WI" (String#23501, DoABC#2)
// setHideWall = "_-0k6" (String#15835, DoABC#2)
// updateWallsNextToHoles = "_-2Ne" (String#19951, DoABC#2)
// getHideWall = "_-1Iz" (String#17236, DoABC#2)
// getCorner = "_-2qn" (String#21114, DoABC#2)
// getLength = "_-0Aa" (String#14472, DoABC#2)
// _SafeStr_13088 = "_-0mb" (String#15921, DoABC#2)
// _SafeStr_13089 = "_-Of" (String#23193, DoABC#2)
// setLength = "_-2ae" (String#20472, DoABC#2)
// moveCorner = "_-0lt" (String#15893, DoABC#2)
// resolveOriginalWallIndex = "_-Gp" (String#22883, DoABC#2)
// getEndPoint = "_-1Pf" (String#17494, DoABC#2)
// hideOriginallyHiddenWalls = "_-3w" (String#22373, DoABC#2)
// checkWallHiding = "_-1Hp" (String#17185, DoABC#2)
// addWalls = "_-1u3" (String#18718, DoABC#2)
// getManuallyLeftCut = "_-0vQ" (String#16254, DoABC#2)
// getManuallyRightCut = "_-2mb" (String#20946, DoABC#2)
// findFloorRectangle = "_-2yo" (String#21421, DoABC#2)
// getHeightMapWidth = "_-1hO" (String#18188, DoABC#2)
// getHorizontalStairInfo = "_-3GX" (String#22144, DoABC#2)
// getVerticalStairInfo = "_-2Kj" (String#19833, DoABC#2)
// altitude = "_-1QD" (String#17518, DoABC#2)
// stairHeight = "_-1bE" (String#17944, DoABC#2)
// addFloor = "_-2lb" (String#20903, DoABC#2)
// neighbourStairMax = "_-2p7" (String#21046, DoABC#2)
// neighbourStairMin = "_-13E" (String#16589, DoABC#2)
// neighbourStair = "_-2GD" (String#19651, DoABC#2)
// resetFloorHoles = "_-0q2" (String#16054, DoABC#2)
// initializeHoleMap = "_-0Rk" (String#15129, DoABC#2)
// getPlaneNormal = "_-2h9" (String#20734, DoABC#2)
// normalDirection = "_-35R" (String#21711, DoABC#2)
// secondaryNormalCount = "_-2fe" (String#20677, DoABC#2)
// getSecondaryNormal = "_-48" (String#22384, DoABC#2)
// _SafeStr_13115 = "_-0iW" (String#15773, DoABC#2)
// getMaskLeftSideLoc = "_-1xr" (String#18882, DoABC#2)
// getMaskRightSideLoc = "_-1Oa" (String#17452, DoABC#2)
// getMaskLeftSideLength = "_-3GI" (String#22133, DoABC#2)
// getMaskRightSideLength = "_-2Wn" (String#20316, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// RoomPlaneData = "_-1iF" (String#5716, DoABC#2)
// RoomWallData = "_-Bo" (String#7910, DoABC#2)
// RoomFloorRectangle = "_-2lN" (String#6987, DoABC#2)
// RoomFloorHole = "_-nm" (String#8673, DoABC#2)
// RoomStairData = "_-2Ev" (String#6341, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// _SafeStr_3802 = "_-v4" (String#24495, DoABC#2)
// _wallThicknessMultiplier = "_-LU" (String#2093, DoABC#2)
// _floorThicknessMultiplier = "_-3Ab" (String#2015, DoABC#2)
// wallThicknessMultiplier = "_-0wt" (String#16306, DoABC#2)
// floorThicknessMultiplier = "_-1NT" (String#17417, DoABC#2)
// addPlane = "_-0lr" (String#4544, DoABC#2)
// initializeTileMap = "_-yM" (String#24629, DoABC#2)
// initializeFromTileData = "_-34W" (String#21678, DoABC#2)
// getXML = "_-2Oe" (String#6532, DoABC#2)
// loc = "_-0fh" (String#15660, DoABC#2)
// initializeFromXML = "_-00L" (String#14068, DoABC#2)
// addMask = "_-0SM" (String#15149, DoABC#2)
// RORPVUM_FLOOR_THICKNESS = "_-2pM" (String#7067, DoABC#2)
// RORPPUM_WALL_THICKNESS = "_-GT" (String#8005, DoABC#2)
// addFloorHole = "_-u-" (String#8766, DoABC#2)
// removeFloorHole = "_-1hN" (String#5693, DoABC#2)
// planeCount = "_-2lv" (String#20913, DoABC#2)
// getPlaneLocation = "_-dB" (String#23767, DoABC#2)
// getPlaneLeftSide = "_-IZ" (String#22950, DoABC#2)
// getPlaneRightSide = "_-1a4" (String#17897, DoABC#2)
// getPlaneNormalDirection = "_-2FH" (String#19615, DoABC#2)
// getPlaneType = "_-3BR" (String#21940, DoABC#2)
// product = "_-Bd" (String#22675, DoABC#2)
// _SafeStr_5829 = "_-dd" (String#23787, DoABC#2)
// _SafeStr_5831 = "_-1Gc" (String#17138, DoABC#2)
// _SafeStr_5832 = "_-0IL" (String#14772, DoABC#2)


