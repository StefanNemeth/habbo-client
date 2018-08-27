
package com.sulake.habbo.communication.messages.parser.room.engine
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HeightMapUpdateMessageParser implements IMessageParser 
    {

        private var _roomId:int = 0;
        private var _roomCategory:int = 0;
        private var _heightMap:Array;
        private var _SafeStr_3778:Array;

        public function HeightMapUpdateMessageParser()
        {
            this._heightMap = [];
            this._SafeStr_3778 = [];
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
        public function getTileHeight(_arg_1:int, _arg_2:int, _arg_3:Number, _arg_4:int, _arg_5:int):Number
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= _arg_4)))) || ((_arg_2 < 0)))) || ((_arg_2 >= _arg_5)))){
                return (_arg_3);
            };
            var _local_6:int = (_arg_1 + (_arg_2 * _arg_4));
            if ((((_local_6 < 0)) || ((_local_6 >= this._heightMap.length)))){
                return (_arg_3);
            };
            var _local_7:int = int(this._heightMap[_local_6]);
            if (_local_7 == 0){
                return (_arg_3);
            };
            return ((_local_7 - 1));
        }
        public function getTileBlocking(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:int, _arg_5:int):Boolean
        {
            if ((((((((_arg_1 < 0)) || ((_arg_1 >= _arg_4)))) || ((_arg_2 < 0)))) || ((_arg_2 >= _arg_5)))){
                return (_arg_3);
            };
            var _local_6:int = (_arg_1 + (_arg_2 * _arg_4));
            if ((((((_local_6 < 0)) || ((_local_6 >= this._heightMap.length)))) || ((_local_6 >= this._SafeStr_3778.length)))){
                return (_arg_3);
            };
            var _local_7:int = int(this._heightMap[_local_6]);
            if (_local_7 == 0){
                return (_arg_3);
            };
            return (this._SafeStr_3778[_local_6]);
        }
        public function flush():Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._heightMap = [];
            this._SafeStr_3778 = [];
            return (true);
        }
        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int;
            var _local_3:int;
            var _local_4:String = _arg_1.readString();
            if ((((_local_4.indexOf("x") == 0)) || ((_local_4.indexOf("X") == 0)))){
                return (this.parseNormal(_local_4));
            };
            return (this.parseCompressed(_local_4));
        }
        private function parseCompressed(_arg_1:String):Boolean
        {
            var _local_5:String;
            var _local_6:int;
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:int;
            var _local_3:int;
            this._heightMap = [];
            this._SafeStr_3778 = [];
            var _local_4:int;
            if (_arg_1.length > 0){
                _local_2 = 0;
                while (_local_2 < _arg_1.length) {
                    _local_5 = _arg_1.charAt(_local_2);
                    if (_local_5 == "!"){
                        _local_6 = (_arg_1.charCodeAt(++_local_2) - 32);
                        _local_3 = 0;
                        while (_local_3 < _local_6) {
                            this._heightMap.push(0);
                            this._SafeStr_3778.push(false);
                            _local_3++;
                        };
                    }
                    else {
                        _local_4 = (this.getHeightValue(_local_5) + 1);
                        this._heightMap.push(_local_4);
                        if (this.getBlocking(_local_5)){
                            this._SafeStr_3778.push(true);
                        }
                        else {
                            this._SafeStr_3778.push(false);
                        };
                    };
                    _local_2++;
                };
            };
            return (true);
        }
        private function parseNormal(_arg_1:String):Boolean
        {
            var _local_6:String;
            var _local_7:String;
            if (String == null){
                return (false);
            };
            var _local_2:Array = _arg_1.split("\r");
            var _local_3:int;
            var _local_4:int;
            this._heightMap = [];
            this._SafeStr_3778 = [];
            var _local_5:int;
            _local_4 = 0;
            while (_local_4 < _local_2.length) {
                _local_6 = (_local_2[_local_4] as String);
                _local_3 = 0;
                while (_local_3 < _local_6.length) {
                    _local_7 = _local_6.charAt(_local_3);
                    if (((!((_local_7 == "x"))) && (!((_local_7 == "X"))))){
                        _local_5 = (this.getHeightValue(_local_7) + 1);
                        this._heightMap.push(_local_5);
                        if (this.getBlocking(_local_7)){
                            this._SafeStr_3778.push(true);
                        }
                        else {
                            this._SafeStr_3778.push(false);
                        };
                    }
                    else {
                        this._heightMap.push(0);
                        this._SafeStr_3778.push(true);
                    };
                    _local_3++;
                };
                _local_4++;
            };
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
// HeightMapUpdateMessageParser = "_-1HT" (String#5198, DoABC#2)
// readString = "_-2y7" (String#1973, DoABC#2)
// _SafeStr_3778 = "_-07P" (String#3710, DoABC#2)
// getTileHeight = "_-0Kq" (String#14872, DoABC#2)
// getTileBlocking = "_-2o1" (String#21002, DoABC#2)
// getHeightValue = "_-355" (String#1994, DoABC#2)
// getBlocking = "_-0M1" (String#4001, DoABC#2)
// parseNormal = "_-0tY" (String#16181, DoABC#2)
// parseCompressed = "_-2TJ" (String#20176, DoABC#2)
// IMessageParser = "_-5U" (String#7770, DoABC#2)


