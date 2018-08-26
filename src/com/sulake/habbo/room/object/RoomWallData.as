
package com.sulake.habbo.room.object
{
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class RoomWallData 
    {

        public static var _SafeStr_13088:Array = [];
        public static var _SafeStr_13089:Array = [];

        private var _SafeStr_13122:Array;
        private var _SafeStr_13123:Array;
        private var _SafeStr_12441:Array;
        private var _SafeStr_13124:Array;
        private var _SafeStr_13125:Array;
        private var _borders:Array;
        private var _hideWalls:Array;
        private var _manuallyLeftCut:Array;
        private var _manuallyRightCut:Array;
        private var _count:int = 0;

        {
            _SafeStr_13088.push(new Vector3d(1, 0, 0));
            _SafeStr_13088.push(new Vector3d(0, 1, 0));
            _SafeStr_13088.push(new Vector3d(-1, 0, 0));
            _SafeStr_13088.push(new Vector3d(0, -1, 0));
            _SafeStr_13089.push(new Vector3d(0, 1, 0));
            _SafeStr_13089.push(new Vector3d(-1, 0, 0));
            _SafeStr_13089.push(new Vector3d(0, -1, 0));
            _SafeStr_13089.push(new Vector3d(1, 0, 0));
        }
        public function RoomWallData()
        {
            this._SafeStr_13122 = [];
            this._SafeStr_13123 = [];
            this._SafeStr_12441 = [];
            this._SafeStr_13124 = [];
            this._SafeStr_13125 = [];
            this._borders = [];
            this._hideWalls = [];
            this._manuallyLeftCut = [];
            this._manuallyRightCut = [];
            super();
        }
        public function addWall(_arg_1:Point, _arg_2:int, _arg_3:int, _arg_4:Boolean, _arg_5:Boolean):void
        {
            this._SafeStr_13122.push(_arg_1);
            this._SafeStr_12441.push(_arg_2);
            this._SafeStr_13124.push(_arg_3);
            this._borders.push(_arg_4);
            this._SafeStr_13125.push(_arg_5);
            this._hideWalls.push(false);
            this._manuallyLeftCut.push(false);
            this._manuallyRightCut.push(false);
            this._count++;
        }
        public function get count():int
        {
            return (this._count);
        }
        public function getCorner(_arg_1:int):Point
        {
            return (this._SafeStr_13122[_arg_1]);
        }
        public function getEndPoint(_arg_1:int):Point
        {
            this.calculateWallEndPoints();
            return (this._SafeStr_13123[_arg_1]);
        }
        public function getLength(_arg_1:int):int
        {
            return (this._SafeStr_13124[_arg_1]);
        }
        public function getDirection(_arg_1:int):int
        {
            return (this._SafeStr_12441[_arg_1]);
        }
        public function getBorder(_arg_1:int):Boolean
        {
            return (this._borders[_arg_1]);
        }
        public function getHideWall(_arg_1:int):Boolean
        {
            return (this._hideWalls[_arg_1]);
        }
        public function getLeftTurn(_arg_1:int):Boolean
        {
            return (this._SafeStr_13125[_arg_1]);
        }
        public function getManuallyLeftCut(_arg_1:int):Boolean
        {
            return (this._manuallyLeftCut[_arg_1]);
        }
        public function getManuallyRightCut(_arg_1:int):Boolean
        {
            return (this._manuallyRightCut[_arg_1]);
        }
        public function setHideWall(_arg_1:int, _arg_2:Boolean):void
        {
            this._hideWalls[_arg_1] = _arg_2;
        }
        public function setLength(_arg_1:int, _arg_2:int):void
        {
            if (_arg_2 < this._SafeStr_13124[_arg_1]){
                this._SafeStr_13124[_arg_1] = _arg_2;
                this._manuallyRightCut[_arg_1] = true;
            };
        }
        public function moveCorner(_arg_1:int, _arg_2:int):void
        {
            var _local_3:IVector3d;
            if ((((_arg_2 > 0)) && ((_arg_2 < this._SafeStr_13124[_arg_1])))){
                _local_3 = _SafeStr_13088[this.getDirection(_arg_1)];
                this._SafeStr_13122[_arg_1] = this._SafeStr_13122[_arg_1].add(new Point((_arg_2 * _local_3.x), (_arg_2 * _local_3.y)));
                this._SafeStr_13124[_arg_1] = (this._SafeStr_13124[_arg_1] - _arg_2);
                this._manuallyLeftCut[_arg_1] = true;
            };
        }
        private function calculateWallEndPoints():void
        {
            var _local_1:int;
            var _local_2:Point;
            var _local_3:Point;
            var _local_4:IVector3d;
            var _local_5:int;
            if (this._SafeStr_13123.length != this.count){
                this._SafeStr_13123 = [];
                _local_1 = 0;
                while (_local_1 < this.count) {
                    _local_2 = this.getCorner(_local_1);
                    _local_3 = new Point(_local_2.x, _local_2.y);
                    _local_4 = RoomWallData._SafeStr_13088[this.getDirection(_local_1)];
                    _local_5 = this.getLength(_local_1);
                    _local_3.x = (_local_3.x + (_local_4.x * _local_5));
                    _local_3.y = (_local_3.y + (_local_4.y * _local_5));
                    this._SafeStr_13123.push(_local_3);
                    _local_1++;
                };
            };
        }

    }
}//package com.sulake.habbo.room.object

// _SafeStr_12441 = "_-0pY" (String#1556, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// addWall = "_-07C" (String#3707, DoABC#2)
// getBorder = "_-35V" (String#21713, DoABC#2)
// getLeftTurn = "_-WI" (String#23501, DoABC#2)
// setHideWall = "_-0k6" (String#15835, DoABC#2)
// getHideWall = "_-1Iz" (String#17236, DoABC#2)
// getCorner = "_-2qn" (String#21114, DoABC#2)
// getLength = "_-0Aa" (String#14472, DoABC#2)
// _SafeStr_13088 = "_-0mb" (String#15921, DoABC#2)
// _SafeStr_13089 = "_-Of" (String#23193, DoABC#2)
// setLength = "_-2ae" (String#20472, DoABC#2)
// moveCorner = "_-0lt" (String#15893, DoABC#2)
// getEndPoint = "_-1Pf" (String#17494, DoABC#2)
// getManuallyLeftCut = "_-0vQ" (String#16254, DoABC#2)
// getManuallyRightCut = "_-2mb" (String#20946, DoABC#2)
// _SafeStr_13122 = "_-0Zf" (String#15429, DoABC#2)
// _SafeStr_13123 = "_-mN" (String#24122, DoABC#2)
// _SafeStr_13124 = "_-2bZ" (String#20508, DoABC#2)
// _SafeStr_13125 = "_-1Ao" (String#16894, DoABC#2)
// _count = "_-2TO" (String#20180, DoABC#2)
// calculateWallEndPoints = "_-07g" (String#14351, DoABC#2)
// RoomWallData = "_-Bo" (String#7910, DoABC#2)


