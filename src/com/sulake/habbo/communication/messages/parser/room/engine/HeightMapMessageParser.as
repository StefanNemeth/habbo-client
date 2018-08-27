
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HeightMapMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array;
        private var _SafeStr_3778:Array;
        private var _SafeStr_3779:Array;
        private var _width:int = 0;
        private var _height:int = 0;

        public function HeightMapMessageParser()
        {
            this._heightMap = [];
            this._SafeStr_3778 = [];
            this._SafeStr_3779 = [];
            super();
        }
        public function get roomId():int
        {
            return (this._roomId);
        }
        public function get roomCategory():int
        {
            return (this._roomCategory);
        }
        public function get width():int
        {
            return (this._width);
        }
        public function get height():int
        {
            return (this._height);
        }
        public function getTileHeight(_arg_1:int, _arg_2:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this.width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this.height)))){
                return (-1);
            };
            var _local_3:Array = (this._heightMap[_arg_2] as Array);
            return (Number(_local_3[_arg_1]));
        }
        public function getTileBlocking(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this.width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this.height)))){
                return (true);
            };
            var _local_3:Array = (this._SafeStr_3778[_arg_2] as Array);
            return (Boolean(_local_3[_arg_1]));
        }
        public function isRoomTile(_arg_1:int, _arg_2:int):Boolean
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this.width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this.height)))){
                return (false);
            };
            var _local_3:Array = (this._SafeStr_3779[_arg_2] as Array);
            return (Boolean(_local_3[_arg_1]));
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this._SafeStr_3778 = [];
            this._SafeStr_3779 = [];
            this._width = 0;
            this._height = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_16:String;
            var _local_17:String;
            var _local_18:Number;
            var _local_19:Boolean;
            var _local_20:Boolean;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:String = _arg_1.readString();
            var _local_5:Array = _local_4.split("\r");
            var _local_6:int;
            var _local_7:int;
            var _local_8:Array = [];
            var _local_9:Array;
            var _local_10:Array = [];
            var _local_11:Array;
            var _local_12:Array = [];
            var _local_13:Array;
            var _local_14:Array;
            var _local_15:int;
            this._width = 0;
            this._height = 0;
            _local_7 = 0;
            while (_local_7 < _local_5.length) {
                _local_16 = (_local_5[_local_7] as String);
                if (_local_16.length > 0){
                    if (_local_16.length > this._width){
                        this._width = _local_16.length;
                    };
                    _local_9 = [];
                    _local_8[_local_7] = _local_9;
                    _local_11 = [];
                    _local_10[_local_7] = _local_11;
                    _local_13 = [];
                    _local_12[_local_7] = _local_13;
                    _local_6 = 0;
                    while (_local_6 < _local_16.length) {
                        _local_17 = _local_16.charAt(_local_6);
                        if (((!((_local_17 == "x"))) && (!((_local_17 == "X"))))){
                            _local_15 = this.getHeightValue(_local_17);
                            _local_9.push(_local_15);
                            if (this.getBlocking(_local_17)){
                                _local_11.push(true);
                            }
                            else {
                                _local_11.push(false);
                            };
                            _local_13.push(true);
                        }
                        else {
                            _local_9.push(-1);
                            _local_11.push(true);
                            _local_13.push(false);
                        };
                        _local_6++;
                    };
                };
                _local_7++;
            };
            _local_7 = 0;
            while (_local_7 < _local_8.length) {
                _local_9 = (_local_8[_local_7] as Array);
                while (_local_9.length < this._width) {
                    _local_9.push(-1);
                };
                _local_7++;
            };
            this._heightMap = [];
            _local_7 = 0;
            while (_local_7 < _local_8.length) {
                _local_14 = [];
                this._heightMap.push(_local_14);
                _local_9 = (_local_8[_local_7] as Array);
                _local_6 = 0;
                while (_local_6 < this._width) {
                    _local_18 = Number(_local_9[_local_6]);
                    _local_14.push(_local_18);
                    _local_6++;
                };
                _local_7++;
            };
            _local_7 = 0;
            while (_local_7 < _local_10.length) {
                _local_11 = (_local_10[_local_7] as Array);
                while (_local_11.length < this._width) {
                    _local_11.push(true);
                };
                _local_7++;
            };
            this._SafeStr_3778 = [];
            _local_7 = 0;
            while (_local_7 < _local_10.length) {
                _local_14 = [];
                this._SafeStr_3778.push(_local_14);
                _local_11 = (_local_10[_local_7] as Array);
                _local_6 = 0;
                while (_local_6 < this._width) {
                    _local_19 = Boolean(_local_11[_local_6]);
                    _local_14.push(_local_19);
                    _local_6++;
                };
                _local_7++;
            };
            _local_7 = 0;
            while (_local_7 < _local_12.length) {
                _local_13 = (_local_12[_local_7] as Array);
                while (_local_13.length < this._width) {
                    _local_13.push(false);
                };
                _local_7++;
            };
            this._SafeStr_3779 = [];
            _local_7 = 0;
            while (_local_7 < _local_12.length) {
                _local_14 = [];
                this._SafeStr_3779.push(_local_14);
                _local_13 = (_local_12[_local_7] as Array);
                _local_6 = 0;
                while (_local_6 < this._width) {
                    _local_20 = Boolean(_local_13[_local_6]);
                    _local_14.push(_local_20);
                    _local_6++;
                };
                _local_7++;
            };
            this._height = this._heightMap.length;
            return (true);
        }
        private function getHeightValue(_arg_1:String):int
        {
            var _local_2:int = parseInt(_arg_1, 16);
            return ((_local_2 % 10));
        }
        private function getBlocking(_arg_1:String):Boolean
        {
            var _local_2:int = parseInt(_arg_1, 16);
            return ((_local_2 >= 10));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// HeightMapMessageParser = "_-2Bb" (String#6278, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _SafeStr_3778 = "_-07P" (String#3710, DoABC#2)
// _SafeStr_3779 = "_-1wl" (String#18834, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// getTileBlocking = "_-2o1" (String#21002, DoABC#2)
// isRoomTile = "_-3Dl" (String#22024, DoABC#2)
// getHeightValue = "_-355" (String#1994, DoABC#2)
// getBlocking = "_-0M1" (String#4001, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


