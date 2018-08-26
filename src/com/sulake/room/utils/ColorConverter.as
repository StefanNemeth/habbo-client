
package com.sulake.room.utils
{
    public class ColorConverter 
    {

        public static function rgbToHSL(_arg_1:int):int
        {
            var _local_2:Number = (((_arg_1 >> 16) & 0xFF) / 0xFF);
            var _local_3:Number = (((_arg_1 >> 8) & 0xFF) / 0xFF);
            var _local_4:Number = ((_arg_1 & 0xFF) / 0xFF);
            var _local_5:Number = Math.max(_local_2, _local_3, _local_4);
            var _local_6:Number = Math.min(_local_2, _local_3, _local_4);
            var _local_7:Number = (_local_5 - _local_6);
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            var _local_10:Number = 0;
            if (_local_7 == 0){
                _local_8 = 0;
            }
            else {
                if (_local_5 == _local_2){
                    if (_local_3 > _local_4){
                        _local_8 = ((60 * (_local_3 - _local_4)) / _local_7);
                    }
                    else {
                        _local_8 = (((60 * (_local_3 - _local_4)) / _local_7) + 360);
                    };
                }
                else {
                    if (_local_5 == _local_3){
                        _local_8 = (((60 * (_local_4 - _local_2)) / _local_7) + 120);
                    }
                    else {
                        if (_local_5 == _local_4){
                            _local_8 = (((60 * (_local_2 - _local_3)) / _local_7) + 240);
                        };
                    };
                };
            };
            _local_9 = (0.5 * (_local_5 + _local_6));
            if (_local_7 == 0){
                _local_10 = 0;
            }
            else {
                if (_local_9 <= 0.5){
                    _local_10 = ((_local_7 / _local_9) * 0.5);
                }
                else {
                    _local_10 = ((_local_7 / (1 - _local_9)) * 0.5);
                };
            };
            var _local_11:int = Math.round(((_local_8 / 360) * 0xFF));
            var _local_12:int = Math.round((_local_10 * 0xFF));
            var _local_13:int = Math.round((_local_9 * 0xFF));
            return ((((_local_11 << 16) + (_local_12 << 8)) + _local_13));
        }
        public static function hslToRGB(_arg_1:int):int
        {
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_2:Number = (((_arg_1 >> 16) & 0xFF) / 0xFF);
            var _local_3:Number = (((_arg_1 >> 8) & 0xFF) / 0xFF);
            var _local_4:Number = ((_arg_1 & 0xFF) / 0xFF);
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Number = 0;
            if (_local_3 > 0){
                _local_12 = 0;
                _local_13 = 0;
                if (_local_4 < 0.5){
                    _local_12 = (_local_4 * (1 + _local_3));
                }
                else {
                    _local_12 = ((_local_4 + _local_3) - (_local_4 * _local_3));
                };
                _local_13 = ((2 * _local_4) - _local_12);
                _local_14 = (_local_2 + (1 / 3));
                _local_15 = _local_2;
                _local_16 = (_local_2 - (1 / 3));
                if (_local_14 < 0){
                    _local_14 = (_local_14 + 1);
                }
                else {
                    if (_local_14 > 1){
                        _local_14--;
                    };
                };
                if (_local_15 < 0){
                    _local_15 = (_local_15 + 1);
                }
                else {
                    if (_local_15 > 1){
                        _local_15--;
                    };
                };
                if (_local_16 < 0){
                    _local_16 = (_local_16 + 1);
                }
                else {
                    if (_local_16 > 1){
                        _local_16--;
                    };
                };
                if ((_local_14 * 6) < 1){
                    _local_5 = (_local_13 + (((_local_12 - _local_13) * 6) * _local_14));
                }
                else {
                    if ((_local_14 * 2) < 1){
                        _local_5 = _local_12;
                    }
                    else {
                        if ((_local_14 * 3) < 2){
                            _local_5 = (_local_13 + (((_local_12 - _local_13) * 6) * ((2 / 3) - _local_14)));
                        }
                        else {
                            _local_5 = _local_13;
                        };
                    };
                };
                if ((_local_15 * 6) < 1){
                    _local_6 = (_local_13 + (((_local_12 - _local_13) * 6) * _local_15));
                }
                else {
                    if ((_local_15 * 2) < 1){
                        _local_6 = _local_12;
                    }
                    else {
                        if ((_local_15 * 3) < 2){
                            _local_6 = (_local_13 + (((_local_12 - _local_13) * 6) * ((2 / 3) - _local_15)));
                        }
                        else {
                            _local_6 = _local_13;
                        };
                    };
                };
                if ((_local_16 * 6) < 1){
                    _local_7 = (_local_13 + (((_local_12 - _local_13) * 6) * _local_16));
                }
                else {
                    if ((_local_16 * 2) < 1){
                        _local_7 = _local_12;
                    }
                    else {
                        if ((_local_16 * 3) < 2){
                            _local_7 = (_local_13 + (((_local_12 - _local_13) * 6) * ((2 / 3) - _local_16)));
                        }
                        else {
                            _local_7 = _local_13;
                        };
                    };
                };
            }
            else {
                _local_5 = _local_4;
                _local_6 = _local_4;
                _local_7 = _local_4;
            };
            var _local_8:int = Math.round((_local_5 * 0xFF));
            var _local_9:int = Math.round((_local_6 * 0xFF));
            var _local_10:int = Math.round((_local_7 * 0xFF));
            return ((((_local_8 << 16) + (_local_9 << 8)) + _local_10));
        }

    }
}//package com.sulake.room.utils

// ColorConverter = "_-3Km" (String#7717, DoABC#2)
// rgbToHSL = "_-TY" (String#23388, DoABC#2)
// hslToRGB = "_-sE" (String#24369, DoABC#2)


