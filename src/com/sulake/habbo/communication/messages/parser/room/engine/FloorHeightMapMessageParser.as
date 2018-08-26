
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.room.object.RoomPlaneParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FloorHeightMapMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array;
        private var _width:int = 0;
        private var _height:int = 0;
        private var _scale:Number = 0;

        public function FloorHeightMapMessageParser()
        {
            this._heightMap = [];
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
        public function get scale():Number
        {
            return (this._scale);
        }
        public function getTileHeight(_arg_1:int, _arg_2:int):int
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= this.width)))) || ((_arg_2 < 0)))) || ((_arg_2 >= this.height)))){
                return (RoomPlaneParser._SafeStr_3802);
            };
            var _local_3:Array = (this._heightMap[_arg_2] as Array);
            return (_local_3[_arg_1]);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this._width = 0;
            this._height = 0;
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_13:String;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:String = _arg_1.readString();
            var _local_5:Array = _local_4.split("\r");
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Array;
            var _local_10:int = _local_5.length;
            var _local_11:int;
            var _local_12:String;
            _local_7 = 0;
            while (_local_7 < _local_10) {
                _local_12 = (_local_5[_local_7] as String);
                if (_local_12.length > _local_11){
                    _local_11 = _local_12.length;
                };
                _local_7++;
            };
            this._heightMap = [];
            _local_7 = 0;
            while (_local_7 < _local_10) {
                _local_9 = [];
                _local_6 = 0;
                while (_local_6 < _local_11) {
                    _local_9.push(RoomPlaneParser._SafeStr_3802);
                    _local_6++;
                };
                this._heightMap.push(_local_9);
                _local_7++;
            };
            this._width = _local_11;
            this._height = _local_10;
            _local_7 = 0;
            while (_local_7 < _local_5.length) {
                _local_9 = (this._heightMap[_local_7] as Array);
                _local_12 = (_local_5[_local_7] as String);
                if (_local_12.length > 0){
                    _local_6 = 0;
                    while (_local_6 < _local_12.length) {
                        _local_13 = _local_12.charAt(_local_6);
                        if (((!((_local_13 == "x"))) && (!((_local_13 == "X"))))){
                            _local_8 = this.FloorHeightMapMessageParser(_local_13);
                        }
                        else {
                            _local_8 = RoomPlaneParser._SafeStr_3802;
                        };
                        _local_9[_local_6] = _local_8;
                        _local_6++;
                    };
                };
                _local_7++;
            };
            if ((((this._width >= 20)) || ((this._height >= 20)))){
                this._scale = 32;
            }
            else {
                this._scale = 64;
            };
            return (true);
        }
        private function FloorHeightMapMessageParser(_arg_1:String):int
        {
            var _local_2:int = parseInt(_arg_1, 16);
            return ((_local_2 % 10));
        }

    }
}//package com.sulake.habbo.communication.messages.parser.room.engine

// IMessageDataWrapper = "_-0Mb" (String#4014, DoABC#2)
// RoomPlaneParser = "_-2Ya" (String#6737, DoABC#2)
// FloorHeightMapMessageParser = "_-9G" (String#7849, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// FloorHeightMapMessageParser = "_-355" (String#1994, DoABC#2)
// _SafeStr_3802 = "_-v4" (String#24495, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


