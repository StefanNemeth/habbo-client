
package com.sulake.habbo.room.utils
{
    public class TileHeightMap 
    {

        private var _heightData:Array;
        private var _SafeStr_13146:Array;
        private var _SafeStr_13147:Array;
        private var _mapWidth:int = 0;
        private var _mapHeight:int = 0;

        public function TileHeightMap(_arg_1:int, _arg_2:int)
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            var _local_7:int;
            this._heightData = [];
            this._SafeStr_13146 = [];
            this._SafeStr_13147 = [];
            super();
            var _local_3:int;
            while (_local_3 < _arg_2) {
                _local_4 = [];
                _local_5 = [];
                _local_6 = [];
                _local_7 = 0;
                while (_local_7 < _arg_1) {
                    _local_4.push(0);
                    _local_5.push(false);
                    _local_6.push(false);
                    _local_7++;
                };
                this._heightData.push(_local_4);
                this._SafeStr_13146.push(_local_5);
                this._SafeStr_13147.push(_local_6);
                _local_3++;
            };
            this._mapWidth = _arg_1;
            this._mapHeight = _arg_2;
        }
        public function get mapWidth():int
        {
            return (this._mapWidth);
        }
        public function get mapHeight():int
        {
            return (this._mapHeight);
        }
        public function dispose():void
        {
            this._heightData = [];
            this._SafeStr_13146 = [];
            this._SafeStr_13147 = [];
            this._mapWidth = 0;
            this._mapHeight = 0;
        }
        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            var _local_3:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_3 = (this._heightData[_arg_2] as Array);
                return (Number(_local_3[_arg_1]));
            };
            return (0);
        }
        public function setTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number):void
        {
            var _local_4:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_4 = (this._heightData[_arg_2] as Array);
                _local_4[_arg_1] = _arg_3;
            };
        }
        public function getTileBlocking(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_3 = (this._SafeStr_13146[_arg_2] as Array);
                return (Boolean(_local_3[_arg_1]));
            };
            return (true);
        }
        public function setTileBlocking(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_4 = (this._SafeStr_13146[_arg_2] as Array);
                _local_4[_arg_1] = _arg_3;
            };
        }
        public function isRoomTile(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_3 = (this._SafeStr_13147[_arg_2] as Array);
                return (Boolean(_local_3[_arg_1]));
            };
            return (true);
        }
        public function setIsRoomTile(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:Array;
            if ((((((((_arg_1 >= 0)) && ((_arg_1 < this._mapWidth)))) && ((_arg_2 >= 0)))) && ((_arg_2 < this._mapHeight)))){
                _local_4 = (this._SafeStr_13147[_arg_2] as Array);
                _local_4[_arg_1] = _arg_3;
                if (!_arg_3){
                    this.setTileBlocking(_arg_1, _arg_2, true);
                };
            };
        }
        public function validateLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int):Boolean
        {
            var _local_13:Boolean;
            var _local_14:Number;
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this._mapWidth)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this._mapHeight)))){
                return (false);
            };
            if (_arg_3 > this._mapWidth){
                return (false);
            };
            if (_arg_4 > this._mapHeight){
                return (false);
            };
            if (((((_arg_1 + _arg_3) > this._mapWidth)) || (((_arg_2 + _arg_4) > this._mapHeight)))){
                return (false);
            };
            if ((((_arg_5 < 0)) || ((_arg_5 >= this._mapWidth)))){
                _arg_5 = 0;
            };
            if ((((_arg_6 < 0)) || ((_arg_6 >= this._mapHeight)))){
                _arg_6 = 0;
            };
            if (_arg_7 > this._mapWidth){
                _arg_7 = this._mapWidth;
            };
            if (_arg_8 > this._mapHeight){
                _arg_8 = this._mapHeight;
            };
            if ((_arg_5 + _arg_7) >= this._mapWidth){
                _arg_7 = (this._mapWidth - _arg_5);
            };
            if ((_arg_6 + _arg_8) >= this._mapHeight){
                _arg_8 = (this._mapHeight - _arg_6);
            };
            var _local_9:int;
            var _local_10:int;
            var _local_11:Array;
            _local_10 = _arg_2;
            while (_local_10 < (_arg_2 + _arg_4)) {
                _local_11 = (this._SafeStr_13146[_local_10] as Array);
                _local_9 = _arg_1;
                while (_local_9 < (_arg_1 + _arg_3)) {
                    if ((((((((_local_9 < _arg_5)) || ((_local_9 >= (_arg_5 + _arg_7))))) || ((_local_10 < _arg_6)))) || ((_local_10 >= (_arg_6 + _arg_8))))){
                        _local_13 = Boolean(_local_11[_local_9]);
                        if (_local_13){
                            return (false);
                        };
                    };
                    _local_9++;
                };
                _local_10++;
            };
            _local_11 = (this._heightData[_arg_2] as Array);
            var _local_12:Number = Number(_local_11[_arg_1]);
            _local_10 = _arg_2;
            while (_local_10 < (_arg_2 + _arg_4)) {
                _local_11 = (this._heightData[_local_10] as Array);
                _local_9 = _arg_1;
                while (_local_9 < (_arg_1 + _arg_3)) {
                    if ((((((((_local_9 < _arg_5)) || ((_local_9 >= (_arg_5 + _arg_7))))) || ((_local_10 < _arg_6)))) || ((_local_10 >= (_arg_6 + _arg_8))))){
                        _local_14 = Number(_local_11[_local_9]);
                        if (_local_14 > _local_12){
                            return (false);
                        };
                    };
                    _local_9++;
                };
                _local_10++;
            };
            return (true);
        }

    }
}//package com.sulake.habbo.room.utils

// _SafeStr_13146 = "_-0O" (String#14988, DoABC#2)
// _SafeStr_13147 = "_-t8" (String#24411, DoABC#2)
// _mapWidth = "_-0XR" (String#15331, DoABC#2)
// _mapHeight = "_-2mU" (String#20940, DoABC#2)
// mapWidth = "_-o8" (String#24195, DoABC#2)
// mapHeight = "_-0xh" (String#16341, DoABC#2)
// setTileBlocking = "_-2eF" (String#20613, DoABC#2)
// setIsRoomTile = "_-0eo" (String#15618, DoABC#2)
// validateLocation = "_-2fO" (String#20664, DoABC#2)
// TileHeightMap = "_-0Bg" (String#3789, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// getTileBlocking = "_-2o1" (String#21002, DoABC#2)
// isRoomTile = "_-3Dl" (String#22024, DoABC#2)


