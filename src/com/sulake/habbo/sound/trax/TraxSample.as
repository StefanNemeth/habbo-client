
package com.sulake.habbo.sound.trax
{
    import com.sulake.core.runtime.IDisposable;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;

    public class TraxSample implements IDisposable 
    {

        public static const _SafeStr_6173:String = "sample_44khz";
        public static const _SafeStr_6174:String = "sample_22khz";
        public static const _SafeStr_6175:String = "sample_11khz";
        public static const _SafeStr_6176:String = "sample_16bit";
        public static const _SafeStr_6177:String = "sample_8bit";
        public static const SAMPLE_VALUE_MULTIPLIER:Number = (1 / 0x8000);//3.0517578125E-5
        private static const _SafeStr_6178:int = 32;
        private static const _SafeStr_6179:int = 0xFF;
        private static const _SafeStr_6180:int = 0xFFFF;
        private static const _SafeStr_6181:int = 127;
        private static const _SafeStr_6182:int = 32767;

        private var _disposed:Boolean = false;
        private var _SafeStr_6183:Vector.<int> = null;
        private var _id:int;
        private var _SafeStr_6184:int = 2;
        private var _SafeStr_6185:int = 1;
        private var _SafeStr_6186:Array;
        private var _usageTimeStamp:uint;

        public function TraxSample(_arg_1:ByteArray, _arg_2:int, _arg_3:String="sample_44khz", _arg_4:String="sample_16bit")
        {
            var _local_12:Number;
            var _local_13:int;
            var _local_14:int;
            var _local_15:Number;
            var _local_16:Number;
            this._SafeStr_6186 = [];
            super();
            this._id = _arg_2;
            var _local_5 = 65536;
            switch (_arg_3){
                case _SafeStr_6174:
                    this._SafeStr_6185 = 2;
                    break;
                case _SafeStr_6175:
                    this._SafeStr_6185 = 4;
                    break;
                default:
                    this._SafeStr_6185 = 1;
            };
            switch (_arg_4){
                case _SafeStr_6177:
                    this._SafeStr_6184 = 4;
                    _local_5 = 0x0100;
                    break;
                default:
                    this._SafeStr_6184 = 2;
                    _local_5 = 65536;
            };
            var _local_6:int = (this._SafeStr_6184 * this._SafeStr_6185);
            var _local_7:int = (_arg_1.length / 8);
            _local_7 = (int((_local_7 / _local_6)) * _local_6);
            this._SafeStr_6183 = new Vector.<int>((_local_7 / _local_6), true);
            var _local_8:Number = (1 / (Number(_local_5) / 2));
            _arg_1.position = 0;
            var _local_9:int;
            var _local_10:int = (_local_7 / this._SafeStr_6185);
            var _local_11:int;
            while (_local_11 < _local_10) {
                _local_12 = _arg_1.readFloat();
                _arg_1.readFloat();
                _local_13 = 2;
                while (_local_13 <= this._SafeStr_6185) {
                    _local_15 = _arg_1.readFloat();
                    _arg_1.readFloat();
                    _local_16 = Number(_local_13);
                    _local_12 = (((_local_12 * (_local_16 - 1)) / _local_16) + (Number(_local_15) / _local_16));
                    _local_13++;
                };
                if (_local_11 >= ((_local_10 - 1) - _SafeStr_6178)){
                    _local_12 = (_local_12 * (((_local_10 - _local_11) - 1) / Number(_SafeStr_6178)));
                };
                _local_14 = ((_local_12 + 1) / _local_8);
                if (_local_14 < 0){
                    _local_14 = 0;
                }
                else {
                    if (_local_14 >= _local_5){
                        _local_14 = (_local_5 - 1);
                    };
                };
                _local_9 = (_local_9 * _local_5);
                _local_9 = (_local_9 + _local_14);
                if ((_local_11 % this._SafeStr_6184) == (this._SafeStr_6184 - 1)){
                    this._SafeStr_6183[int((_local_11 / this._SafeStr_6184))] = _local_9;
                    _local_9 = 0;
                };
                _local_11++;
            };
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get length():uint
        {
            return (((this._SafeStr_6183.length * this._SafeStr_6184) * this._SafeStr_6185));
        }
        public function get usageCount():int
        {
            return (this._SafeStr_6186.length);
        }
        public function get usageTimeStamp():int
        {
            return (this._usageTimeStamp);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (!this._disposed){
                this._SafeStr_6183 = null;
                this._SafeStr_6186 = null;
            };
        }
        public function setSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_8:int;
            var _local_9:int;
            var _local_10:int;
            if ((((_arg_1 == null)) || ((this._SafeStr_6183 == null)))){
                return (_arg_4);
            };
            var _local_5:int = (this._SafeStr_6184 * this._SafeStr_6185);
            _arg_4 = (_arg_4 / _local_5);
            if (_arg_2 < 0){
                _arg_3 = (_arg_3 + _arg_2);
                _arg_2 = 0;
            };
            if (_arg_3 > (_arg_1.length - _arg_2)){
                _arg_3 = (_arg_1.length - _arg_2);
            };
            var _local_6:int = (_arg_3 / _local_5);
            var _local_7:int;
            if (_local_6 > (this._SafeStr_6183.length - _arg_4)){
                _local_7 = ((_local_6 - (this._SafeStr_6183.length - _arg_4)) * _local_5);
                _local_6 = (this._SafeStr_6183.length - _arg_4);
                if (_local_7 > (_arg_1.length - _arg_2)){
                    _local_7 = (_arg_1.length - _arg_2);
                };
            };
            if (this._SafeStr_6185 == 1){
                if (this._SafeStr_6184 == 2){
                    while (_local_6-- > 0) {
                        _local_8 = this._SafeStr_6183[_arg_4++];
                        var _local_11 = _arg_2++;
                        _arg_1[_local_11] = (((_local_8 >> 16) & _SafeStr_6180) - _SafeStr_6182);
                        var _local_12 = _arg_2++;
                        _arg_1[_local_12] = ((_local_8 & _SafeStr_6180) - _SafeStr_6182);
                    };
                }
                else {
                    if (this._SafeStr_6184 == 4){
                        while (_local_6-- > 0) {
                            _local_8 = this._SafeStr_6183[_arg_4++];
                            _local_11 = _arg_2++;
                            _arg_1[_local_11] = ((((_local_8 >> 24) & _SafeStr_6179) - _SafeStr_6181) << 8);
                            _local_12 = _arg_2++;
                            _arg_1[_local_12] = ((((_local_8 >> 16) & _SafeStr_6179) - _SafeStr_6181) << 8);
                            var _local_13 = _arg_2++;
                            _arg_1[_local_13] = ((((_local_8 >> 8) & _SafeStr_6179) - _SafeStr_6181) << 8);
                            var _local_14 = _arg_2++;
                            _arg_1[_local_14] = (((_local_8 & _SafeStr_6179) - _SafeStr_6181) << 8);
                        };
                    };
                };
            }
            else {
                if (this._SafeStr_6185 >= 2){
                    _local_9 = 0;
                    _local_10 = 0;
                    if (this._SafeStr_6184 == 2){
                        while (_local_6-- > 0) {
                            _local_8 = this._SafeStr_6183[_arg_4++];
                            _local_10 = (((_local_8 >> 16) & _SafeStr_6180) - _SafeStr_6182);
                            _local_9 = this._SafeStr_6185;
                            while (_local_9 > 0) {
                                _local_11 = _arg_2++;
                                _arg_1[_local_11] = _local_10;
                                _local_9--;
                            };
                            _local_10 = ((_local_8 & _SafeStr_6180) - _SafeStr_6182);
                            _local_9 = this._SafeStr_6185;
                            while (_local_9 > 0) {
                                _local_11 = _arg_2++;
                                _arg_1[_local_11] = _local_10;
                                _local_9--;
                            };
                        };
                    }
                    else {
                        if (this._SafeStr_6184 == 4){
                            while (_local_6-- > 0) {
                                _local_8 = this._SafeStr_6183[_arg_4++];
                                _local_10 = ((((_local_8 >> 24) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_9 = this._SafeStr_6185;
                                while (_local_9 > 0) {
                                    _local_11 = _arg_2++;
                                    _arg_1[_local_11] = _local_10;
                                    _local_9--;
                                };
                                _local_10 = ((((_local_8 >> 16) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_9 = this._SafeStr_6185;
                                while (_local_9 > 0) {
                                    _local_11 = _arg_2++;
                                    _arg_1[_local_11] = _local_10;
                                    _local_9--;
                                };
                                _local_10 = ((((_local_8 >> 8) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_9 = this._SafeStr_6185;
                                while (_local_9 > 0) {
                                    _local_11 = _arg_2++;
                                    _arg_1[_local_11] = _local_10;
                                    _local_9--;
                                };
                                _local_10 = (((_local_8 & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_9 = this._SafeStr_6185;
                                while (_local_9 > 0) {
                                    _local_11 = _arg_2++;
                                    _arg_1[_local_11] = _local_10;
                                    _local_9--;
                                };
                            };
                        };
                    };
                };
            };
            while (_local_7-- > 0) {
                _local_11 = _arg_2++;
                _arg_1[_local_11] = 0;
            };
            return ((_arg_4 * _local_5));
        }
        public function addSample(_arg_1:Vector.<int>, _arg_2:int, _arg_3:int, _arg_4:int):int
        {
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            if ((((_arg_1 == null)) || ((this._SafeStr_6183 == null)))){
                return (_arg_4);
            };
            var _local_5:int = (this._SafeStr_6184 * this._SafeStr_6185);
            _arg_4 = (_arg_4 / _local_5);
            if (_arg_2 < 0){
                _arg_3 = (_arg_3 + _arg_2);
                _arg_2 = 0;
            };
            if (_arg_3 > (_arg_1.length - _arg_2)){
                _arg_3 = (_arg_1.length - _arg_2);
            };
            var _local_6:int = (_arg_3 / _local_5);
            if (_local_6 > (this._SafeStr_6183.length - _arg_4)){
                _local_6 = (this._SafeStr_6183.length - _arg_4);
            };
            if (this._SafeStr_6185 == 1){
                if (this._SafeStr_6184 == 2){
                    while (_local_6-- > 0) {
                        _local_7 = this._SafeStr_6183[_arg_4++];
                        var _local_10 = _arg_2++;
                        _arg_1[_local_10] = (_arg_1[_local_10] + (((_local_7 >> 16) & _SafeStr_6180) - _SafeStr_6182));
                        var _local_11 = _arg_2++;
                        _arg_1[_local_11] = (_arg_1[_local_11] + ((_local_7 & _SafeStr_6180) - _SafeStr_6182));
                    };
                }
                else {
                    if (this._SafeStr_6184 == 4){
                        while (_local_6-- > 0) {
                            _local_7 = this._SafeStr_6183[_arg_4++];
                            _local_10 = _arg_2++;
                            _arg_1[_local_10] = (_arg_1[_local_10] + ((((_local_7 >> 24) & _SafeStr_6179) - _SafeStr_6181) << 8));
                            _local_11 = _arg_2++;
                            _arg_1[_local_11] = (_arg_1[_local_11] + ((((_local_7 >> 16) & _SafeStr_6179) - _SafeStr_6181) << 8));
                            var _local_12 = _arg_2++;
                            _arg_1[_local_12] = (_arg_1[_local_12] + ((((_local_7 >> 8) & _SafeStr_6179) - _SafeStr_6181) << 8));
                            var _local_13 = _arg_2++;
                            _arg_1[_local_13] = (_arg_1[_local_13] + (((_local_7 & _SafeStr_6179) - _SafeStr_6181) << 8));
                        };
                    };
                };
            }
            else {
                if (this._SafeStr_6185 >= 2){
                    _local_8 = 0;
                    _local_9 = 0;
                    if (this._SafeStr_6184 == 2){
                        while (_local_6-- > 0) {
                            _local_7 = this._SafeStr_6183[_arg_4++];
                            _local_9 = (((_local_7 >> 16) & _SafeStr_6180) - _SafeStr_6182);
                            _local_8 = this._SafeStr_6185;
                            while (_local_8 > 0) {
                                _local_10 = _arg_2++;
                                _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                _local_8--;
                            };
                            _local_9 = ((_local_7 & _SafeStr_6180) - _SafeStr_6182);
                            _local_8 = this._SafeStr_6185;
                            while (_local_8 > 0) {
                                _local_10 = _arg_2++;
                                _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                _local_8--;
                            };
                        };
                    }
                    else {
                        if (this._SafeStr_6184 == 4){
                            while (_local_6-- > 0) {
                                _local_7 = this._SafeStr_6183[_arg_4++];
                                _local_9 = ((((_local_7 >> 24) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_8 = this._SafeStr_6185;
                                while (_local_8 > 0) {
                                    _local_10 = _arg_2++;
                                    _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                    _local_8--;
                                };
                                _local_9 = ((((_local_7 >> 16) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_8 = this._SafeStr_6185;
                                while (_local_8 > 0) {
                                    _local_10 = _arg_2++;
                                    _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                    _local_8--;
                                };
                                _local_9 = ((((_local_7 >> 8) & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_8 = this._SafeStr_6185;
                                while (_local_8 > 0) {
                                    _local_10 = _arg_2++;
                                    _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                    _local_8--;
                                };
                                _local_9 = (((_local_7 & _SafeStr_6179) - _SafeStr_6181) << 8);
                                _local_8 = this._SafeStr_6185;
                                while (_local_8 > 0) {
                                    _local_10 = _arg_2++;
                                    _arg_1[_local_10] = (_arg_1[_local_10] + _local_9);
                                    _local_8--;
                                };
                            };
                        };
                    };
                };
            };
            return ((_arg_4 * _local_5));
        }
        public function setUsageFromSong(_arg_1:int, _arg_2:uint):void
        {
            if (this._SafeStr_6186 == null){
                return;
            };
            if (this._SafeStr_6186.indexOf(_arg_1) == -1){
                this._SafeStr_6186.push(_arg_1);
            };
            this._usageTimeStamp = _arg_2;
        }
        public function isUsedFromSong(_arg_1:int):Boolean
        {
            if (this._SafeStr_6186 == null){
                return (false);
            };
            return (!((this._SafeStr_6186.indexOf(_arg_1) == -1)));
        }

    }
}//package com.sulake.habbo.sound.trax

// TraxSample = "_-285" (String#6206, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// setUsageFromSong = "_-2Qm" (String#20078, DoABC#2)
// setSample = "_-1IC" (String#17201, DoABC#2)
// addSample = "_-tt" (String#24443, DoABC#2)
// _SafeStr_6173 = "_-1W8" (String#17748, DoABC#2)
// _SafeStr_6174 = "_-17c" (String#16759, DoABC#2)
// _SafeStr_6175 = "_-3Em" (String#22067, DoABC#2)
// _SafeStr_6176 = "_-0FJ" (String#14656, DoABC#2)
// _SafeStr_6177 = "_-sc" (String#24383, DoABC#2)
// _SafeStr_6178 = "_-0Mu" (String#14950, DoABC#2)
// _SafeStr_6179 = "_-st" (String#24398, DoABC#2)
// _SafeStr_6180 = "_-1P7" (String#17473, DoABC#2)
// _SafeStr_6181 = "_-2qg" (String#21108, DoABC#2)
// _SafeStr_6182 = "_-V0" (String#23448, DoABC#2)
// _SafeStr_6183 = "_-0DG" (String#14579, DoABC#2)
// _SafeStr_6184 = "_-1Ad" (String#16885, DoABC#2)
// _SafeStr_6185 = "_-0KA" (String#14849, DoABC#2)
// _SafeStr_6186 = "_-31C" (String#21545, DoABC#2)
// _usageTimeStamp = "_-1fB" (String#18104, DoABC#2)
// usageCount = "_-1s-" (String#18631, DoABC#2)
// usageTimeStamp = "_-V9" (String#23455, DoABC#2)
// isUsedFromSong = "_-1Vj" (String#17730, DoABC#2)


