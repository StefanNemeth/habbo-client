
package com.hurlant.math
{
    import flash.utils.ByteArray;
    import com.hurlant.util.Hex;
    import com.hurlant.crypto.prng.Random;
    import com.hurlant.util.Memory;

    public class BigInteger 
    {

        public static const _SafeStr_8675:int = 30;
        public static const _SafeStr_8682:int = (1 << _SafeStr_8675);
        public static const _SafeStr_8680:int = (_SafeStr_8682 - 1);
        public static const _SafeStr_8693:int = 52;
        public static const _SafeStr_8694:Number = Math.pow(2, _SafeStr_8693);
        public static const F1:int = (_SafeStr_8693 - _SafeStr_8675);//22
        public static const F2:int = ((2 * _SafeStr_8675) - _SafeStr_8693);//8
        public static const 0:BigInteger = nbv(0);
        public static const _SafeStr_8688:BigInteger = nbv(1);
        public static const _SafeStr_8696:Array = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 0x0101, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509];
        public static const _SafeStr_8697:int = ((1 << 26) / _SafeStr_8696[(_SafeStr_8696.length - 1)]);

        public var t:int;
        bi_internal var s:int;
        bi_internal var a:Array;

        public function BigInteger(_arg_1:*=null, _arg_2:int=0)
        {
            var _local_3:ByteArray;
            var _local_4:int;
            super();
            this.a = new Array();
            if ((_arg_1 is String)){
                _arg_1 = Hex.toArray(_arg_1);
                _arg_2 = 0;
            };
            if ((_arg_1 is ByteArray)){
                _local_3 = (_arg_1 as ByteArray);
                _local_4 = ((_arg_2) || ((_local_3.length - _local_3.position)));
                this.fromArray(_local_3, _local_4);
            };
        }
        public static function nbv(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new (BigInteger)();
            _local_2.fromInt(_arg_1);
            return (_local_2);
        }

        public function dispose():void
        {
            var _local_1:Random = new Random();
            var _local_2:uint;
            while (_local_2 < this.a.length) {
                this.a[_local_2] = _local_1.nextByte();
                delete this.a[_local_2];
                _local_2++;
            };
            this.a = null;
            this.t = 0;
            this.s = 0;
            Memory.gc();
        }
        public function toString(_arg_1:Number=16):String
        {
            var _local_2:int;
            if (this.s < 0){
                return (("-" + this.negate().toString(_arg_1)));
            };
            switch (_arg_1){
                case 2:
                    _local_2 = 1;
                    break;
                case 4:
                    _local_2 = 2;
                    break;
                case 8:
                    _local_2 = 3;
                    break;
                case 16:
                    _local_2 = 4;
                    break;
                case 32:
                    _local_2 = 5;
                    break;
                default:
                    _local_2 = 4;
            };
            var _local_3:int = ((1 << _local_2) - 1);
            var _local_4:int;
            var _local_5:Boolean;
            var _local_6:String = "";
            var _local_7:int = this.t;
            var _local_8:int = (_SafeStr_8675 - ((_local_7 * _SafeStr_8675) % _local_2));
            if (_local_7-- > 0){
                if ((((_local_8 < _SafeStr_8675)) && (((_local_4 = (this.a[_local_7] >> _local_8)) > 0)))){
                    _local_5 = true;
                    _local_6 = _local_4.toString(36);
                };
                while (_local_7 >= 0) {
                    if (_local_8 < _local_2){
                        _local_4 = ((this.a[_local_7] & ((1 << _local_8) - 1)) << (_local_2 - _local_8));
                        var _temp_1 = _local_4;
                        _local_8 = (_local_8 + (_SafeStr_8675 - _local_2));
                        _local_4 = (_temp_1 | (this.a[--_local_7] >> _local_8));
                    }
                    else {
                        _local_8 = (_local_8 - _local_2);
                        _local_4 = ((this.a[_local_7] >> _local_8) & _local_3);
                        if (_local_8 <= 0){
                            _local_8 = (_local_8 + _SafeStr_8675);
                            _local_7--;
                        };
                    };
                    if (_local_4 > 0){
                        _local_5 = true;
                    };
                    if (_local_5){
                        _local_6 = (_local_6 + _local_4.toString(36));
                    };
                };
            };
            return (((_local_5) ? _local_6 : "0"));
        }
        public function toArray(_arg_1:ByteArray):uint
        {
            var _local_2:int = 8;
            var _local_3:int = ((1 << 8) - 1);
            var _local_4:int;
            var _local_5:int = this.t;
            var _local_6:int = (_SafeStr_8675 - ((_local_5 * _SafeStr_8675) % _local_2));
            var _local_7:Boolean;
            var _local_8:int;
            if (_local_5-- > 0){
                if ((((_local_6 < _SafeStr_8675)) && (((_local_4 = (this.a[_local_5] >> _local_6)) > 0)))){
                    _local_7 = true;
                    _arg_1.writeByte(_local_4);
                    _local_8++;
                };
                while (_local_5 >= 0) {
                    if (_local_6 < _local_2){
                        _local_4 = ((this.a[_local_5] & ((1 << _local_6) - 1)) << (_local_2 - _local_6));
                        var _temp_1 = _local_4;
                        _local_6 = (_local_6 + (_SafeStr_8675 - _local_2));
                        _local_4 = (_temp_1 | (this.a[--_local_5] >> _local_6));
                    }
                    else {
                        _local_6 = (_local_6 - _local_2);
                        _local_4 = ((this.a[_local_5] >> _local_6) & _local_3);
                        if (_local_6 <= 0){
                            _local_6 = (_local_6 + _SafeStr_8675);
                            _local_5--;
                        };
                    };
                    if (_local_4 > 0){
                        _local_7 = true;
                    };
                    if (_local_7){
                        _arg_1.writeByte(_local_4);
                        _local_8++;
                    };
                };
            };
            return (_local_8);
        }
        public function valueOf():Number
        {
            var _local_1:Number = 1;
            var _local_2:Number = 0;
            var _local_3:uint;
            while (_local_3 < this.t) {
                _local_2 = (_local_2 + (this.a[_local_3] * _local_1));
                _local_1 = (_local_1 * _SafeStr_8682);
                _local_3++;
            };
            return (_local_2);
        }
        public function negate():BigInteger
        {
            var _local_1:BigInteger = this.nbi();
            0.subTo(this, _local_1);
            return (_local_1);
        }
        public function abs():BigInteger
        {
            return ((((this.s)<0) ? this.negate() : this));
        }
        public function compareTo(_arg_1:BigInteger):int
        {
            var _local_2:int = (this.s - _arg_1.s);
            if (_local_2 != 0){
                return (_local_2);
            };
            var _local_3:int = this.t;
            _local_2 = (_local_3 - _arg_1.t);
            if (_local_2 != 0){
                return (_local_2);
            };
            while (--_local_3 >= 0) {
                _local_2 = (this.a[_local_3] - _arg_1.a[_local_3]);
                if (_local_2 != 0){
                    return (_local_2);
                };
            };
            return (0);
        }
        bi_internal function nbits(_arg_1:int):int
        {
            var _local_3:int;
            var _local_2:int = 1;
            _local_3 = (_arg_1 >>> 16);
            if (_local_3 != 0){
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 16);
            };
            _local_3 = (_arg_1 >> 8);
            if (_local_3 != 0){
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 8);
            };
            _local_3 = (_arg_1 >> 4);
            if (_local_3 != 0){
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 4);
            };
            _local_3 = (_arg_1 >> 2);
            if (_local_3 != 0){
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 2);
            };
            _local_3 = (_arg_1 >> 1);
            if (_local_3 != 0){
                _arg_1 = _local_3;
                _local_2 = (_local_2 + 1);
            };
            return (_local_2);
        }
        public function bitLength():int
        {
            if (this.t <= 0){
                return (0);
            };
            return (((_SafeStr_8675 * (this.t - 1)) + this.nbits((this.a[(this.t - 1)] ^ (this.s & _SafeStr_8680)))));
        }
        public function mod(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = this.nbi();
            this.abs().divRemTo(_arg_1, null, _local_2);
            if ((((this.s < 0)) && ((_local_2.compareTo(0) > 0)))){
                _arg_1.subTo(_local_2, _local_2);
            };
            return (_local_2);
        }
        public function modPowInt(_arg_1:int, _arg_2:BigInteger):BigInteger
        {
            var _local_3:IReduction;
            if ((((_arg_1 < 0x0100)) || (_arg_2.isEven()))){
                _local_3 = new ClassicReduction(_arg_2);
            }
            else {
                _local_3 = new MontgomeryReduction(_arg_2);
            };
            return (this.exp(_arg_1, _local_3));
        }
        bi_internal function copyTo(_arg_1:BigInteger):void
        {
            var _local_2:int = (this.t - 1);
            while (_local_2 >= 0) {
                _arg_1.a[_local_2] = this.a[_local_2];
                _local_2--;
            };
            _arg_1.t = this.t;
            _arg_1.s = this.s;
        }
        bi_internal function fromInt(_arg_1:int):void
        {
            this.t = 1;
            this.s = (((_arg_1)<0) ? -1 : 0);
            if (_arg_1 > 0){
                this.a[0] = _arg_1;
            }
            else {
                if (_arg_1 < -1){
                    this.a[0] = (_arg_1 + _SafeStr_8682);
                }
                else {
                    this.t = 0;
                };
            };
        }
        bi_internal function fromArray(_arg_1:ByteArray, _arg_2:int):void
        {
            var _local_7:int;
            var _local_3:int = _arg_1.position;
            var _local_4:int = (_local_3 + _arg_2);
            var _local_5:int;
            var _local_6:int = 8;
            this.t = 0;
            this.s = 0;
            while (--_local_4 >= _local_3) {
                _local_7 = (((_local_4 < _arg_1.length)) ? _arg_1[_local_4] : 0);
                if (_local_5 == 0){
                    var _local_8 = this.t++;
                    this.a[_local_8] = _local_7;
                }
                else {
                    if ((_local_5 + _local_6) > _SafeStr_8675){
                        this.a[(this.t - 1)] = (this.a[(this.t - 1)] | ((_local_7 & ((1 << (_SafeStr_8675 - _local_5)) - 1)) << _local_5));
                        _local_8 = this.t++;
                        this.a[_local_8] = (_local_7 >> (_SafeStr_8675 - _local_5));
                    }
                    else {
                        this.a[(this.t - 1)] = (this.a[(this.t - 1)] | (_local_7 << _local_5));
                    };
                };
                _local_5 = (_local_5 + _local_6);
                if (_local_5 >= _SafeStr_8675){
                    _local_5 = (_local_5 - _SafeStr_8675);
                };
            };
            this.clamp();
            _arg_1.position = Math.min((_local_3 + _arg_2), _arg_1.length);
        }
        bi_internal function clamp():void
        {
            var _local_1 = (this.s & _SafeStr_8680);
            while ((((this.t > 0)) && ((this.a[(this.t - 1)] == _local_1)))) {
                this.t--;
            };
        }
        bi_internal function dlShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_3:int;
            _local_3 = (this.t - 1);
            while (_local_3 >= 0) {
                _arg_2.a[(_local_3 + _arg_1)] = this.a[_local_3];
                _local_3--;
            };
            _local_3 = (_arg_1 - 1);
            while (_local_3 >= 0) {
                _arg_2.a[_local_3] = 0;
                _local_3--;
            };
            _arg_2.t = (this.t + _arg_1);
            _arg_2.s = this.s;
        }
        bi_internal function drShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_3:int;
            _local_3 = _arg_1;
            while (_local_3 < this.t) {
                _arg_2.a[(_local_3 - _arg_1)] = this.a[_local_3];
                _local_3++;
            };
            _arg_2.t = Math.max((this.t - _arg_1), 0);
            _arg_2.s = this.s;
        }
        bi_internal function lShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_8:int;
            var _local_3:int = (_arg_1 % _SafeStr_8675);
            var _local_4:int = (_SafeStr_8675 - _local_3);
            var _local_5:int = ((1 << _local_4) - 1);
            var _local_6:int = (_arg_1 / _SafeStr_8675);
            var _local_7 = ((this.s << _local_3) & _SafeStr_8680);
            _local_8 = (this.t - 1);
            while (_local_8 >= 0) {
                _arg_2.a[((_local_8 + _local_6) + 1)] = ((this.a[_local_8] >> _local_4) | _local_7);
                _local_7 = ((this.a[_local_8] & _local_5) << _local_3);
                _local_8--;
            };
            _local_8 = (_local_6 - 1);
            while (_local_8 >= 0) {
                _arg_2.a[_local_8] = 0;
                _local_8--;
            };
            _arg_2.a[_local_6] = _local_7;
            _arg_2.t = ((this.t + _local_6) + 1);
            _arg_2.s = this.s;
            _arg_2.clamp();
        }
        bi_internal function rShiftTo(_arg_1:int, _arg_2:BigInteger):void
        {
            var _local_7:int;
            _arg_2.s = this.s;
            var _local_3:int = (_arg_1 / _SafeStr_8675);
            if (_local_3 >= this.t){
                _arg_2.t = 0;
                return;
            };
            var _local_4:int = (_arg_1 % _SafeStr_8675);
            var _local_5:int = (_SafeStr_8675 - _local_4);
            var _local_6:int = ((1 << _local_4) - 1);
            _arg_2.a[0] = (this.a[_local_3] >> _local_4);
            _local_7 = (_local_3 + 1);
            while (_local_7 < this.t) {
                _arg_2.a[((_local_7 - _local_3) - 1)] = (_arg_2.a[((_local_7 - _local_3) - 1)] | ((this.a[_local_7] & _local_6) << _local_5));
                _arg_2.a[(_local_7 - _local_3)] = (this.a[_local_7] >> _local_4);
                _local_7++;
            };
            if (_local_4 > 0){
                _arg_2.a[((this.t - _local_3) - 1)] = (_arg_2.a[((this.t - _local_3) - 1)] | ((this.s & _local_6) << _local_5));
            };
            _arg_2.t = (this.t - _local_3);
            _arg_2.clamp();
        }
        bi_internal function subTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = Math.min(_arg_1.t, this.t);
            while (_local_3 < _local_5) {
                _local_4 = (_local_4 + (this.a[_local_3] - _arg_1.a[_local_3]));
                var _local_6 = _local_3++;
                _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                _local_4 = (_local_4 >> _SafeStr_8675);
            };
            if (_arg_1.t < this.t){
                _local_4 = (_local_4 - _arg_1.s);
                while (_local_3 < this.t) {
                    _local_4 = (_local_4 + this.a[_local_3]);
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                    _local_4 = (_local_4 >> _SafeStr_8675);
                };
                _local_4 = (_local_4 + this.s);
            }
            else {
                _local_4 = (_local_4 + this.s);
                while (_local_3 < _arg_1.t) {
                    _local_4 = (_local_4 - _arg_1.a[_local_3]);
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                    _local_4 = (_local_4 >> _SafeStr_8675);
                };
                _local_4 = (_local_4 - _arg_1.s);
            };
            _arg_2.s = (((_local_4)<0) ? -1 : 0);
            if (_local_4 < -1){
                _local_6 = _local_3++;
                _arg_2.a[_local_6] = (_SafeStr_8682 + _local_4);
            }
            else {
                if (_local_4 > 0){
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = _local_4;
                };
            };
            _arg_2.t = _local_3;
            _arg_2.clamp();
        }
        bi_internal function am(_arg_1:int, _arg_2:int, _arg_3:BigInteger, _arg_4:int, _arg_5:int, _arg_6:int):int
        {
            var _local_9:int;
            var _local_10:int;
            var _local_11:int;
            var _local_7 = (_arg_2 & 32767);
            var _local_8 = (_arg_2 >> 15);
            while (--_arg_6 >= 0) {
                _local_9 = (this.a[_arg_1] & 32767);
                _local_10 = (this.a[_arg_1++] >> 15);
                _local_11 = ((_local_8 * _local_9) + (_local_10 * _local_7));
                _local_9 = ((((_local_7 * _local_9) + ((_local_11 & 32767) << 15)) + _arg_3.a[_arg_4]) + (_arg_5 & 1073741823));
                _arg_5 = ((((_local_9 >>> 30) + (_local_11 >>> 15)) + (_local_8 * _local_10)) + (_arg_5 >>> 30));
                var _local_12 = _arg_4++;
                _arg_3.a[_local_12] = (_local_9 & 1073741823);
            };
            return (_arg_5);
        }
        bi_internal function multiplyTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_3:BigInteger = this.abs();
            var _local_4:BigInteger = _arg_1.abs();
            var _local_5:int = _local_3.t;
            _arg_2.t = (_local_5 + _local_4.t);
            while (--_local_5 >= 0) {
                _arg_2.a[_local_5] = 0;
            };
            _local_5 = 0;
            while (_local_5 < _local_4.t) {
                _arg_2.a[(_local_5 + _local_3.t)] = _local_3.am(0, _local_4.a[_local_5], _arg_2, _local_5, 0, _local_3.t);
                _local_5++;
            };
            _arg_2.s = 0;
            _arg_2.clamp();
            if (this.s != _arg_1.s){
                0.subTo(_arg_2, _arg_2);
            };
        }
        bi_internal function squareTo(_arg_1:BigInteger):void
        {
            var _local_4:int;
            var _local_2:BigInteger = this.abs();
            var _local_3:int = (_arg_1.t = (2 * _local_2.t));
            while (--_local_3 >= 0) {
                _arg_1.a[_local_3] = 0;
            };
            _local_3 = 0;
            while (_local_3 < (_local_2.t - 1)) {
                _local_4 = _local_2.am(_local_3, _local_2.a[_local_3], _arg_1, (2 * _local_3), 0, 1);
                if ((_arg_1.a[(_local_3 + _local_2.t)] = (_arg_1.a[(_local_3 + _local_2.t)] + _local_2.am((_local_3 + 1), (2 * _local_2.a[_local_3]), _arg_1, ((2 * _local_3) + 1), _local_4, ((_local_2.t - _local_3) - 1)))) >= _SafeStr_8682){
                    _arg_1.a[(_local_3 + _local_2.t)] = (_arg_1.a[(_local_3 + _local_2.t)] - _SafeStr_8682);
                    _arg_1.a[((_local_3 + _local_2.t) + 1)] = 1;
                };
                _local_3++;
            };
            if (_arg_1.t > 0){
                _arg_1.a[(_arg_1.t - 1)] = (_arg_1.a[(_arg_1.t - 1)] + _local_2.am(_local_3, _local_2.a[_local_3], _arg_1, (2 * _local_3), 0, 1));
            };
            _arg_1.s = 0;
            _arg_1.clamp();
        }
        bi_internal function divRemTo(m:BigInteger, q:BigInteger=null, r:BigInteger=null):void
        {
            var qd:int;
            var pm:BigInteger = m.abs();
            if (pm.t <= 0){
                return;
            };
            var pt:BigInteger = this.abs();
            if (pt.t < pm.t){
                if (q != null){
                    q.fromInt(0);
                };
                if (r != null){
                    this.copyTo(r);
                };
                return;
            };
            if (r == null){
                r = this.nbi();
            };
            var y:BigInteger = this.nbi();
            var ts:int = this.s;
            var ms:int = m.s;
            var nsh:int = (_SafeStr_8675 - this.nbits(pm.a[(pm.t - 1)]));
            if (nsh > 0){
                pm.lShiftTo(nsh, y);
                pt.lShiftTo(nsh, r);
            }
            else {
                pm.copyTo(y);
                pt.copyTo(r);
            };
            var ys:int = y.t;
            var y0:int = y.a[(ys - 1)];
            if (y0 == 0){
                return;
            };
            var yt:Number = ((y0 * (1 << F1)) + (((ys)>1) ? (y.a[(ys - 2)] >> F2) : 0));
            var d1:Number = (_SafeStr_8694 / yt);
            var d2:Number = ((1 << F1) / yt);
            var e:Number = (1 << F2);
            var i:int = r.t;
            var j:int = (i - ys);
            var t:BigInteger = (((q)==null) ? this.nbi() : q);
            y.dlShiftTo(j, t);
            if (r.compareTo(t) >= 0){
                var _local_5 = r.t++;
                r.a[_local_5] = 1;
                r.subTo(t, r);
            };
            _SafeStr_8688.dlShiftTo(ys, t);
            t.subTo(y, y);
            while (y.t < ys) {
                y.(y.t++, 0); //not popped
            };
            while (--j >= 0) {
                qd = (((r.a[--i])==y0) ? _SafeStr_8680 : ((Number(r.a[i]) * d1) + ((Number(r.a[(i - 1)]) + e) * d2)));
                if ((r.a[i] = (r.a[i] + y.am(0, qd, r, j, 0, ys))) < qd){
                    y.dlShiftTo(j, t);
                    r.subTo(t, r);
                    while ((qd = (qd - 1)), r.a[i] < qd) {
                        r.subTo(t, r);
                    };
                };
            };
            if (q != null){
                r.drShiftTo(ys, q);
                if (ts != ms){
                    0.subTo(q, q);
                };
            };
            r.t = ys;
            r.clamp();
            if (nsh > 0){
                r.rShiftTo(nsh, r);
            };
            if (ts < 0){
                0.subTo(r, r);
            };
        }
        bi_internal function invDigit():int
        {
            if (this.t < 1){
                return (0);
            };
            var _local_1:int = this.a[0];
            if ((_local_1 & 1) == 0){
                return (0);
            };
            var _local_2 = (_local_1 & 3);
            _local_2 = ((_local_2 * (2 - ((_local_1 & 15) * _local_2))) & 15);
            _local_2 = ((_local_2 * (2 - ((_local_1 & 0xFF) * _local_2))) & 0xFF);
            _local_2 = ((_local_2 * (2 - (((_local_1 & 0xFFFF) * _local_2) & 0xFFFF))) & 0xFFFF);
            _local_2 = ((_local_2 * (2 - ((_local_1 * _local_2) % _SafeStr_8682))) % _SafeStr_8682);
            return ((((_local_2)>0) ? (_SafeStr_8682 - _local_2) : -(_local_2)));
        }
        bi_internal function isEven():Boolean
        {
            return (((((this.t)>0) ? (this.a[0] & 1) : this.s) == 0));
        }
        bi_internal function exp(_arg_1:int, _arg_2:IReduction):BigInteger
        {
            var _local_7:BigInteger;
            if ((((_arg_1 > 0xFFFFFFFF)) || ((_arg_1 < 1)))){
                return (_SafeStr_8688);
            };
            var _local_3:BigInteger = this.nbi();
            var _local_4:BigInteger = this.nbi();
            var _local_5:BigInteger = _arg_2.convert(this);
            var _local_6:int = (this.nbits(_arg_1) - 1);
            _local_5.copyTo(_local_3);
            while (--_local_6 >= 0) {
                _arg_2.sqrTo(_local_3, _local_4);
                if ((_arg_1 & (1 << _local_6)) > 0){
                    _arg_2.mulTo(_local_4, _local_5, _local_3);
                }
                else {
                    _local_7 = _local_3;
                    _local_3 = _local_4;
                    _local_4 = _local_7;
                };
            };
            return (_arg_2.revert(_local_3));
        }
        bi_internal function intAt(_arg_1:String, _arg_2:int):int
        {
            return (parseInt(_arg_1.charAt(_arg_2), 36));
        }
        protected function nbi()
        {
            return (new BigInteger());
        }
        public function clone():BigInteger
        {
            var _local_1:BigInteger = new BigInteger();
            this.copyTo(_local_1);
            return (_local_1);
        }
        public function intValue():int
        {
            if (this.s < 0){
                if (this.t == 1){
                    return ((this.a[0] - _SafeStr_8682));
                };
                if (this.t == 0){
                    return (-1);
                };
            }
            else {
                if (this.t == 1){
                    return (this.a[0]);
                };
                if (this.t == 0){
                    return (0);
                };
            };
            return ((((this.a[1] & ((1 << (32 - _SafeStr_8675)) - 1)) << _SafeStr_8675) | this.a[0]));
        }
        public function byteValue():int
        {
            return ((((this.t)==0) ? this.s : ((this.a[0] << 24) >> 24)));
        }
        public function shortValue():int
        {
            return ((((this.t)==0) ? this.s : ((this.a[0] << 16) >> 16)));
        }
        protected function chunkSize(_arg_1:Number):int
        {
            return (Math.floor(((Math.LN2 * _SafeStr_8675) / Math.log(_arg_1))));
        }
        public function sigNum():int
        {
            if (this.s < 0){
                return (-1);
            };
            if ((((this.t <= 0)) || ((((this.t == 1)) && ((this.a[0] <= 0)))))){
                return (0);
            };
            return (1);
        }
        public function toRadix(_arg_1:uint=10):String
        {
            if ((((((this.sigNum() == 0)) || ((_arg_1 < 2)))) || ((_arg_1 > 32)))){
                return ("0");
            };
            var _local_2:int = this.chunkSize(_arg_1);
            var _local_3:Number = Math.pow(_arg_1, _local_2);
            var _local_4:BigInteger = nbv(_local_3);
            var _local_5:BigInteger = this.nbi();
            var _local_6:BigInteger = this.nbi();
            var _local_7:String = "";
            this.divRemTo(_local_4, _local_5, _local_6);
            while (_local_5.sigNum() > 0) {
                _local_7 = ((_local_3 + _local_6.intValue()).toString(_arg_1).substr(1) + _local_7);
                _local_5.divRemTo(_local_4, _local_5, _local_6);
            };
            return ((_local_6.intValue().toString(_arg_1) + _local_7));
        }
        public function fromRadix(_arg_1:String, _arg_2:int=10):void
        {
            var _local_9:int;
            this.fromInt(0);
            var _local_3:int = this.chunkSize(_arg_2);
            var _local_4:Number = Math.pow(_arg_2, _local_3);
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            while (_local_8 < _arg_1.length) {
                _local_9 = this.intAt(_arg_1, _local_8);
                if (_local_9 < 0){
                    if ((((_arg_1.charAt(_local_8) == "-")) && ((this.sigNum() == 0)))){
                        _local_5 = true;
                    };
                }
                else {
                    _local_7 = ((_arg_2 * _local_7) + _local_9);
                    if (++_local_6 >= _local_3){
                        this.dMultiply(_local_4);
                        this.dAddOffset(_local_7, 0);
                        _local_6 = 0;
                        _local_7 = 0;
                    };
                };
                _local_8++;
            };
            if (_local_6 > 0){
                this.dMultiply(Math.pow(_arg_2, _local_6));
                this.dAddOffset(_local_7, 0);
            };
            if (_local_5){
                BigInteger.0.subTo(this, this);
            };
        }
        public function toByteArray():ByteArray
        {
            var _local_4:int;
            var _local_1:int = this.t;
            var _local_2:ByteArray = new ByteArray();
            _local_2[0] = this.s;
            var _local_3:int = (_SafeStr_8675 - ((_local_1 * _SafeStr_8675) % 8));
            var _local_5:int;
            if (_local_1-- > 0){
                if ((((_local_3 < _SafeStr_8675)) && (!(((_local_4 = (this.a[_local_1] >> _local_3)) == ((this.s & _SafeStr_8680) >> _local_3)))))){
                    var _local_6 = _local_5++;
                    _local_2[_local_6] = (_local_4 | (this.s << (_SafeStr_8675 - _local_3)));
                };
                while (_local_1 >= 0) {
                    if (_local_3 < 8){
                        _local_4 = ((this.a[_local_1] & ((1 << _local_3) - 1)) << (8 - _local_3));
                        var _temp_1 = _local_4;
                        _local_3 = (_local_3 + (_SafeStr_8675 - 8));
                        _local_4 = (_temp_1 | (this.a[--_local_1] >> _local_3));
                    }
                    else {
                        _local_3 = (_local_3 - 8);
                        _local_4 = ((this.a[_local_1] >> _local_3) & 0xFF);
                        if (_local_3 <= 0){
                            _local_3 = (_local_3 + _SafeStr_8675);
                            _local_1--;
                        };
                    };
                    if ((_local_4 & 128) != 0){
                        _local_4 = (_local_4 | -256);
                    };
                    if ((((_local_5 == 0)) && (!(((this.s & 128) == (_local_4 & 128)))))){
                        _local_5++;
                    };
                    if ((((_local_5 > 0)) || (!((_local_4 == this.s))))){
                        _local_6 = _local_5++;
                        _local_2[_local_6] = _local_4;
                    };
                };
            };
            return (_local_2);
        }
        public function equals(_arg_1:BigInteger):Boolean
        {
            return ((this.compareTo(_arg_1) == 0));
        }
        public function min(_arg_1:BigInteger):BigInteger
        {
            return ((((this.compareTo(_arg_1))<0) ? this : _arg_1));
        }
        public function max(_arg_1:BigInteger):BigInteger
        {
            return ((((this.compareTo(_arg_1))>0) ? this : _arg_1));
        }
        protected function bitwiseTo(_arg_1:BigInteger, _arg_2:Function, _arg_3:BigInteger):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int = Math.min(_arg_1.t, this.t);
            _local_4 = 0;
            while (_local_4 < _local_6) {
                _arg_3.a[_local_4] = _arg_2(this.a[_local_4], _arg_1.a[_local_4]);
                _local_4++;
            };
            if (_arg_1.t < this.t){
                _local_5 = (_arg_1.s & _SafeStr_8680);
                _local_4 = _local_6;
                while (_local_4 < this.t) {
                    _arg_3.a[_local_4] = _arg_2(this.a[_local_4], _local_5);
                    _local_4++;
                };
                _arg_3.t = this.t;
            }
            else {
                _local_5 = (this.s & _SafeStr_8680);
                _local_4 = _local_6;
                while (_local_4 < _arg_1.t) {
                    _arg_3.a[_local_4] = _arg_2(_local_5, _arg_1.a[_local_4]);
                    _local_4++;
                };
                _arg_3.t = _arg_1.t;
            };
            _arg_3.s = _arg_2(this.s, _arg_1.s);
            _arg_3.clamp();
        }
        private function op_and(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 & _arg_2));
        }
        public function and(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.bitwiseTo(_arg_1, this.op_and, _local_2);
            return (_local_2);
        }
        private function op_or(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 | _arg_2));
        }
        public function or(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.bitwiseTo(_arg_1, this.op_or, _local_2);
            return (_local_2);
        }
        private function op_xor(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 ^ _arg_2));
        }
        public function xor(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.bitwiseTo(_arg_1, this.op_xor, _local_2);
            return (_local_2);
        }
        private function op_andnot(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_1 & ~(_arg_2)));
        }
        public function andNot(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.bitwiseTo(_arg_1, this.op_andnot, _local_2);
            return (_local_2);
        }
        public function not():BigInteger
        {
            var _local_1:BigInteger = new BigInteger();
            var _local_2:int;
            while (_local_2 < this.t) {
                _local_1[_local_2] = (_SafeStr_8680 & ~(this.a[_local_2]));
                _local_2++;
            };
            _local_1.t = this.t;
            _local_1.s = ~(this.s);
            return (_local_1);
        }
        public function shiftLeft(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            if (_arg_1 < 0){
                this.rShiftTo(-(_arg_1), _local_2);
            }
            else {
                this.lShiftTo(_arg_1, _local_2);
            };
            return (_local_2);
        }
        public function shiftRight(_arg_1:int):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            if (_arg_1 < 0){
                this.lShiftTo(-(_arg_1), _local_2);
            }
            else {
                this.rShiftTo(_arg_1, _local_2);
            };
            return (_local_2);
        }
        private function lbit(_arg_1:int):int
        {
            if (_arg_1 == 0){
                return (-1);
            };
            var _local_2:int;
            if ((_arg_1 & 0xFFFF) == 0){
                _arg_1 = (_arg_1 >> 16);
                _local_2 = (_local_2 + 16);
            };
            if ((_arg_1 & 0xFF) == 0){
                _arg_1 = (_arg_1 >> 8);
                _local_2 = (_local_2 + 8);
            };
            if ((_arg_1 & 15) == 0){
                _arg_1 = (_arg_1 >> 4);
                _local_2 = (_local_2 + 4);
            };
            if ((_arg_1 & 3) == 0){
                _arg_1 = (_arg_1 >> 2);
                _local_2 = (_local_2 + 2);
            };
            if ((_arg_1 & 1) == 0){
                _local_2++;
            };
            return (_local_2);
        }
        public function getLowestSetBit():int
        {
            var _local_1:int;
            while (_local_1 < this.t) {
                if (this.a[_local_1] != 0){
                    return (((_local_1 * _SafeStr_8675) + this.lbit(this.a[_local_1])));
                };
                _local_1++;
            };
            if (this.s < 0){
                return ((this.t * _SafeStr_8675));
            };
            return (-1);
        }
        private function cbit(_arg_1:int):int
        {
            var _local_2:uint;
            while (_arg_1 != 0) {
                _arg_1 = (_arg_1 & (_arg_1 - 1));
                _local_2++;
            };
            return (_local_2);
        }
        public function bitCount():int
        {
            var _local_1:int;
            var _local_2 = (this.s & _SafeStr_8680);
            var _local_3:int;
            while (_local_3 < this.t) {
                _local_1 = (_local_1 + this.cbit((this.a[_local_3] ^ _local_2)));
                _local_3++;
            };
            return (_local_1);
        }
        public function testBit(_arg_1:int):Boolean
        {
            var _local_2:int = Math.floor((_arg_1 / _SafeStr_8675));
            if (_local_2 >= this.t){
                return (!((this.s == 0)));
            };
            return (!(((this.a[_local_2] & (1 << (_arg_1 % _SafeStr_8675))) == 0)));
        }
        protected function changeBit(_arg_1:int, _arg_2:Function):BigInteger
        {
            var _local_3:BigInteger = BigInteger._SafeStr_8688.shiftLeft(_arg_1);
            this.bitwiseTo(_local_3, _arg_2, _local_3);
            return (_local_3);
        }
        public function setBit(_arg_1:int):BigInteger
        {
            return (this.changeBit(_arg_1, this.op_or));
        }
        public function clearBit(_arg_1:int):BigInteger
        {
            return (this.changeBit(_arg_1, this.op_andnot));
        }
        public function flipBit(_arg_1:int):BigInteger
        {
            return (this.changeBit(_arg_1, this.op_xor));
        }
        protected function addTo(_arg_1:BigInteger, _arg_2:BigInteger):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = Math.min(_arg_1.t, this.t);
            while (_local_3 < _local_5) {
                _local_4 = (_local_4 + (this.a[_local_3] + _arg_1.a[_local_3]));
                var _local_6 = _local_3++;
                _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                _local_4 = (_local_4 >> _SafeStr_8675);
            };
            if (_arg_1.t < this.t){
                _local_4 = (_local_4 + _arg_1.s);
                while (_local_3 < this.t) {
                    _local_4 = (_local_4 + this.a[_local_3]);
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                    _local_4 = (_local_4 >> _SafeStr_8675);
                };
                _local_4 = (_local_4 + this.s);
            }
            else {
                _local_4 = (_local_4 + this.s);
                while (_local_3 < _arg_1.t) {
                    _local_4 = (_local_4 + _arg_1.a[_local_3]);
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = (_local_4 & _SafeStr_8680);
                    _local_4 = (_local_4 >> _SafeStr_8675);
                };
                _local_4 = (_local_4 + _arg_1.s);
            };
            _arg_2.s = (((_local_4)<0) ? -1 : 0);
            if (_local_4 > 0){
                _local_6 = _local_3++;
                _arg_2.a[_local_6] = _local_4;
            }
            else {
                if (_local_4 < -1){
                    _local_6 = _local_3++;
                    _arg_2.a[_local_6] = (_SafeStr_8682 + _local_4);
                };
            };
            _arg_2.t = _local_3;
            _arg_2.clamp();
        }
        public function add(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.addTo(_arg_1, _local_2);
            return (_local_2);
        }
        public function subtract(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.subTo(_arg_1, _local_2);
            return (_local_2);
        }
        public function multiply(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.multiplyTo(_arg_1, _local_2);
            return (_local_2);
        }
        public function divide(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.divRemTo(_arg_1, _local_2, null);
            return (_local_2);
        }
        public function remainder(_arg_1:BigInteger):BigInteger
        {
            var _local_2:BigInteger = new BigInteger();
            this.divRemTo(_arg_1, null, _local_2);
            return (_local_2);
        }
        public function divideAndRemainder(_arg_1:BigInteger):Array
        {
            var _local_2:BigInteger = new BigInteger();
            var _local_3:BigInteger = new BigInteger();
            this.divRemTo(_arg_1, _local_2, _local_3);
            return ([_local_2, _local_3]);
        }
        bi_internal function dMultiply(_arg_1:int):void
        {
            this.a[this.t] = this.am(0, (_arg_1 - 1), this, 0, 0, this.t);
            this.t++;
            this.clamp();
        }
        bi_internal function dAddOffset(_arg_1:int, _arg_2:int):void
        {
            while (this.t <= _arg_2) {
                var _local_3 = this.t++;
                this.a[_local_3] = 0;
            };
            this.a[_arg_2] = (this.a[_arg_2] + _arg_1);
            while (this.a[_arg_2] >= _SafeStr_8682) {
                this.a[_arg_2] = (this.a[_arg_2] - _SafeStr_8682);
                if (++_arg_2 >= this.t){
                    _local_3 = this.t++;
                    this.a[_local_3] = 0;
                };
                _local_3 = this.a;
                var _local_4 = _arg_2;
                var _local_5 = (_local_3[_local_4] + 1);
                _local_3[_local_4] = _local_5;
            };
        }
        public function pow(_arg_1:int):BigInteger
        {
            return (this.exp(_arg_1, new NullReduction()));
        }
        bi_internal function multiplyLowerTo(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger):void
        {
            var _local_5:int;
            var _local_4:int = Math.min((this.t + _arg_1.t), _arg_2);
            _arg_3.s = 0;
            _arg_3.t = _local_4;
            while (_local_4 > 0) {
                var _local_6 = --_local_4;
                _arg_3.a[_local_6] = 0;
            };
            _local_5 = (_arg_3.t - this.t);
            while (_local_4 < _local_5) {
                _arg_3.a[(_local_4 + this.t)] = this.am(0, _arg_1.a[_local_4], _arg_3, _local_4, 0, this.t);
                _local_4++;
            };
            _local_5 = Math.min(_arg_1.t, _arg_2);
            while (_local_4 < _local_5) {
                this.am(0, _arg_1.a[_local_4], _arg_3, _local_4, 0, (_arg_2 - _local_4));
                _local_4++;
            };
            _arg_3.clamp();
        }
        bi_internal function multiplyUpperTo(_arg_1:BigInteger, _arg_2:int, _arg_3:BigInteger):void
        {
            _arg_2--;
            var _local_4:int = (_arg_3.t = ((this.t + _arg_1.t) - _arg_2));
            _arg_3.s = 0;
            while (--_local_4 >= 0) {
                _arg_3.a[_local_4] = 0;
            };
            _local_4 = Math.max((_arg_2 - this.t), 0);
            while (_local_4 < _arg_1.t) {
                _arg_3.a[((this.t + _local_4) - _arg_2)] = this.am((_arg_2 - _local_4), _arg_1.a[_local_4], _arg_3, 0, 0, ((this.t + _local_4) - _arg_2));
                _local_4++;
            };
            _arg_3.clamp();
            _arg_3.drShiftTo(1, _arg_3);
        }
        public function modPow(_arg_1:BigInteger, _arg_2:BigInteger):BigInteger
        {
            var _local_4:int;
            var _local_6:IReduction;
            var _local_12:int;
            var _local_15:BigInteger;
            var _local_16:BigInteger;
            var _local_3:int = _arg_1.bitLength();
            var _local_5:BigInteger = nbv(1);
            if (_local_3 <= 0){
                return (_local_5);
            };
            if (_local_3 < 18){
                _local_4 = 1;
            }
            else {
                if (_local_3 < 48){
                    _local_4 = 3;
                }
                else {
                    if (_local_3 < 144){
                        _local_4 = 4;
                    }
                    else {
                        if (_local_3 < 0x0300){
                            _local_4 = 5;
                        }
                        else {
                            _local_4 = 6;
                        };
                    };
                };
            };
            if (_local_3 < 8){
                _local_6 = new ClassicReduction(_arg_2);
            }
            else {
                if (_arg_2.isEven()){
                    _local_6 = new BarrettReduction(_arg_2);
                }
                else {
                    _local_6 = new MontgomeryReduction(_arg_2);
                };
            };
            var _local_7:Array = [];
            var _local_8:int = 3;
            var _local_9:int = (_local_4 - 1);
            var _local_10:int = ((1 << _local_4) - 1);
            _local_7[1] = _local_6.convert(this);
            if (_local_4 > 1){
                _local_16 = new BigInteger();
                _local_6.sqrTo(_local_7[1], _local_16);
                while (_local_8 <= _local_10) {
                    _local_7[_local_8] = new BigInteger();
                    _local_6.mulTo(_local_16, _local_7[(_local_8 - 2)], _local_7[_local_8]);
                    _local_8 = (_local_8 + 2);
                };
            };
            var _local_11:int = (_arg_1.t - 1);
            var _local_13:Boolean = true;
            var _local_14:BigInteger = new BigInteger();
            _local_3 = (this.nbits(_arg_1.a[_local_11]) - 1);
            while (_local_11 >= 0) {
                if (_local_3 >= _local_9){
                    _local_12 = ((_arg_1.a[_local_11] >> (_local_3 - _local_9)) & _local_10);
                }
                else {
                    _local_12 = ((_arg_1.a[_local_11] & ((1 << (_local_3 + 1)) - 1)) << (_local_9 - _local_3));
                    if (_local_11 > 0){
                        _local_12 = (_local_12 | (_arg_1.a[(_local_11 - 1)] >> ((_SafeStr_8675 + _local_3) - _local_9)));
                    };
                };
                _local_8 = _local_4;
                while ((_local_12 & 1) == 0) {
                    _local_12 = (_local_12 >> 1);
                    _local_8--;
                };
                _local_3 = (_local_3 - _local_8);
                if (_local_3 < 0){
                    _local_3 = (_local_3 + _SafeStr_8675);
                    _local_11--;
                };
                if (_local_13){
                    _local_7[_local_12].copyTo(_local_5);
                    _local_13 = false;
                }
                else {
                    while (_local_8 > 1) {
                        _local_6.sqrTo(_local_5, _local_14);
                        _local_6.sqrTo(_local_14, _local_5);
                        _local_8 = (_local_8 - 2);
                    };
                    if (_local_8 > 0){
                        _local_6.sqrTo(_local_5, _local_14);
                    }
                    else {
                        _local_15 = _local_5;
                        _local_5 = _local_14;
                        _local_14 = _local_15;
                    };
                    _local_6.mulTo(_local_14, _local_7[_local_12], _local_5);
                };
                while ((((_local_11 >= 0)) && (((_arg_1.a[_local_11] & (1 << _local_3)) == 0)))) {
                    _local_6.sqrTo(_local_5, _local_14);
                    _local_15 = _local_5;
                    _local_5 = _local_14;
                    _local_14 = _local_15;
                    if (--_local_3 < 0){
                        _local_3 = (_SafeStr_8675 - 1);
                        _local_11--;
                    };
                };
            };
            return (_local_6.revert(_local_5));
        }
        public function gcd(_arg_1:BigInteger):BigInteger
        {
            var _local_6:BigInteger;
            var _local_2:BigInteger = (((this.s)<0) ? this.negate() : this.clone());
            var _local_3:BigInteger = (((_arg_1.s)<0) ? _arg_1.negate() : _arg_1.clone());
            if (_local_2.compareTo(_local_3) < 0){
                _local_6 = _local_2;
                _local_2 = _local_3;
                _local_3 = _local_6;
            };
            var _local_4:int = _local_2.getLowestSetBit();
            var _local_5:int = _local_3.getLowestSetBit();
            if (_local_5 < 0){
                return (_local_2);
            };
            if (_local_4 < _local_5){
                _local_5 = _local_4;
            };
            if (_local_5 > 0){
                _local_2.rShiftTo(_local_5, _local_2);
                _local_3.rShiftTo(_local_5, _local_3);
            };
            while (_local_2.sigNum() > 0) {
                _local_4 = _local_2.getLowestSetBit();
                if (_local_4 > 0){
                    _local_2.rShiftTo(_local_4, _local_2);
                };
                _local_4 = _local_3.getLowestSetBit();
                if (_local_4 > 0){
                    _local_3.rShiftTo(_local_4, _local_3);
                };
                if (_local_2.compareTo(_local_3) >= 0){
                    _local_2.subTo(_local_3, _local_2);
                    _local_2.rShiftTo(1, _local_2);
                }
                else {
                    _local_3.subTo(_local_2, _local_3);
                    _local_3.rShiftTo(1, _local_3);
                };
            };
            if (_local_5 > 0){
                _local_3.lShiftTo(_local_5, _local_3);
            };
            return (_local_3);
        }
        protected function modInt(_arg_1:int):int
        {
            var _local_4:int;
            if (_arg_1 <= 0){
                return (0);
            };
            var _local_2:int = (_SafeStr_8682 % _arg_1);
            var _local_3:int = (((this.s)<0) ? (_arg_1 - 1) : 0);
            if (this.t > 0){
                if (_local_2 == 0){
                    _local_3 = (this.a[0] % _arg_1);
                }
                else {
                    _local_4 = (this.t - 1);
                    while (_local_4 >= 0) {
                        _local_3 = (((_local_2 * _local_3) + this.a[_local_4]) % _arg_1);
                        _local_4--;
                    };
                };
            };
            return (_local_3);
        }
        public function modInverse(_arg_1:BigInteger):BigInteger
        {
            var _local_2:Boolean = _arg_1.isEven();
            if (((((this.isEven()) && (_local_2))) || ((_arg_1.sigNum() == 0)))){
                return (BigInteger.0);
            };
            var _local_3:BigInteger = _arg_1.clone();
            var _local_4:BigInteger = this.clone();
            var _local_5:BigInteger = nbv(1);
            var _local_6:BigInteger = nbv(0);
            var _local_7:BigInteger = nbv(0);
            var _local_8:BigInteger = nbv(1);
            while (_local_3.sigNum() != 0) {
                while (_local_3.isEven()) {
                    _local_3.rShiftTo(1, _local_3);
                    if (_local_2){
                        if (((!(_local_5.isEven())) || (!(_local_6.isEven())))){
                            _local_5.addTo(this, _local_5);
                            _local_6.subTo(_arg_1, _local_6);
                        };
                        _local_5.rShiftTo(1, _local_5);
                    }
                    else {
                        if (!_local_6.isEven()){
                            _local_6.subTo(_arg_1, _local_6);
                        };
                    };
                    _local_6.rShiftTo(1, _local_6);
                };
                while (_local_4.isEven()) {
                    _local_4.rShiftTo(1, _local_4);
                    if (_local_2){
                        if (((!(_local_7.isEven())) || (!(_local_8.isEven())))){
                            _local_7.addTo(this, _local_7);
                            _local_8.subTo(_arg_1, _local_8);
                        };
                        _local_7.rShiftTo(1, _local_7);
                    }
                    else {
                        if (!_local_8.isEven()){
                            _local_8.subTo(_arg_1, _local_8);
                        };
                    };
                    _local_8.rShiftTo(1, _local_8);
                };
                if (_local_3.compareTo(_local_4) >= 0){
                    _local_3.subTo(_local_4, _local_3);
                    if (_local_2){
                        _local_5.subTo(_local_7, _local_5);
                    };
                    _local_6.subTo(_local_8, _local_6);
                }
                else {
                    _local_4.subTo(_local_3, _local_4);
                    if (_local_2){
                        _local_7.subTo(_local_5, _local_7);
                    };
                    _local_8.subTo(_local_6, _local_8);
                };
            };
            if (_local_4.compareTo(BigInteger._SafeStr_8688) != 0){
                return (BigInteger.0);
            };
            if (_local_8.compareTo(_arg_1) >= 0){
                return (_local_8.subtract(_arg_1));
            };
            if (_local_8.sigNum() < 0){
                _local_8.addTo(_arg_1, _local_8);
            }
            else {
                return (_local_8);
            };
            if (_local_8.sigNum() < 0){
                return (_local_8.add(_arg_1));
            };
            return (_local_8);
        }
        public function isProbablePrime(_arg_1:int):Boolean
        {
            var _local_2:int;
            var _local_4:int;
            var _local_5:int;
            var _local_3:BigInteger = this.abs();
            if ((((_local_3.t == 1)) && ((_local_3.a[0] <= _SafeStr_8696[(_SafeStr_8696.length - 1)])))){
                _local_2 = 0;
                while (_local_2 < _SafeStr_8696.length) {
                    if (_local_3[0] == _SafeStr_8696[_local_2]){
                        return (true);
                    };
                    _local_2++;
                };
                return (false);
            };
            if (_local_3.isEven()){
                return (false);
            };
            _local_2 = 1;
            while (_local_2 < _SafeStr_8696.length) {
                _local_4 = _SafeStr_8696[_local_2];
                _local_5 = (_local_2 + 1);
                while ((((_local_5 < _SafeStr_8696.length)) && ((_local_4 < _SafeStr_8697)))) {
                    _local_4 = (_local_4 * _SafeStr_8696[_local_5++]);
                };
                _local_4 = _local_3.modInt(_local_4);
                while (_local_2 < _local_5) {
                    if ((_local_4 % _SafeStr_8696[_local_2++]) == 0){
                        return (false);
                    };
                };
            };
            return (_local_3.millerRabin(_arg_1));
        }
        protected function millerRabin(_arg_1:int):Boolean
        {
            var _local_7:BigInteger;
            var _local_8:int;
            var _local_2:BigInteger = this.subtract(BigInteger._SafeStr_8688);
            var _local_3:int = _local_2.getLowestSetBit();
            if (_local_3 <= 0){
                return (false);
            };
            var _local_4:BigInteger = _local_2.shiftRight(_local_3);
            _arg_1 = ((_arg_1 + 1) >> 1);
            if (_arg_1 > _SafeStr_8696.length){
                _arg_1 = _SafeStr_8696.length;
            };
            var _local_5:BigInteger = new BigInteger();
            var _local_6:int;
            while (_local_6 < _arg_1) {
                _local_5.fromInt(_SafeStr_8696[_local_6]);
                _local_7 = _local_5.modPow(_local_4, this);
                if (((!((_local_7.compareTo(BigInteger._SafeStr_8688) == 0))) && (!((_local_7.compareTo(_local_2) == 0))))){
                    _local_8 = 1;
                    while ((((_local_8++ < _local_3)) && (!((_local_7.compareTo(_local_2) == 0))))) {
                        _local_7 = _local_7.modPowInt(2, this);
                        if (_local_7.compareTo(BigInteger._SafeStr_8688) == 0){
                            return (false);
                        };
                    };
                    if (_local_7.compareTo(_local_2) != 0){
                        return (false);
                    };
                };
                _local_6++;
            };
            return (true);
        }
        public function primify(_arg_1:int, _arg_2:int):void
        {
            if (!this.testBit((_arg_1 - 1))){
                this.bitwiseTo(BigInteger._SafeStr_8688.shiftLeft((_arg_1 - 1)), this.op_or, this);
            };
            if (this.isEven()){
                this.dAddOffset(1, 0);
            };
            while (!(this.isProbablePrime(_arg_2))) {
                this.dAddOffset(2, 0);
                while (this.bitLength() > _arg_1) {
                    this.subTo(BigInteger._SafeStr_8688.shiftLeft((_arg_1 - 1)), this);
                };
            };
        }

    }
}//package com.hurlant.math

// Hex = "_-01P" (String#3591, DoABC#2)
// IReduction = "_-0Nl" (String#4038, DoABC#2)
// MontgomeryReduction = "_-aj" (String#8432, DoABC#2)
// Memory = "_-2zI" (String#7273, DoABC#2)
// BarrettReduction = "_-bu" (String#8453, DoABC#2)
// Random = "_-1wQ" (String#5965, DoABC#2)
// NullReduction = "_-0p9" (String#4615, DoABC#2)
// ClassicReduction = "_-0-i" (String#3557, DoABC#2)
// toArray = "_-3BW" (String#21943, DoABC#2)
// fromArray = "_-0as" (String#4321, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// bitLength = "_-1xj" (String#18877, DoABC#2)
// nextByte = "_-17N" (String#16751, DoABC#2)
// toByteArray = "_-Iq" (String#22961, DoABC#2)
// modPowInt = "_-1ji" (String#18272, DoABC#2)
// modPow = "_-37A" (String#21775, DoABC#2)
// multiply = "_-1H4" (String#17155, DoABC#2)
// fromRadix = "_-2e9" (String#20609, DoABC#2)
// toRadix = "_-Yu" (String#23596, DoABC#2)
// equals = "_-1fP" (String#18113, DoABC#2)
// convert = "_-1Vy" (String#5472, DoABC#2)
// revert = "_-0zg" (String#4840, DoABC#2)
// mulTo = "_-1bm" (String#5595, DoABC#2)
// sqrTo = "_-3Gd" (String#7640, DoABC#2)
// invDigit = "_-1ih" (String#18234, DoABC#2)
// _SafeStr_8675 = "_-1xv" (String#18883, DoABC#2)
// dlShiftTo = "_-2sf" (String#21187, DoABC#2)
// divRemTo = "_-1lB" (String#18338, DoABC#2)
// 0 = "_-1fe" (String#5657, DoABC#2)
// subTo = "_-tY" (String#24429, DoABC#2)
// _SafeStr_8680 = "_-k7" (String#24040, DoABC#2)
// am = "_-36t" (String#21760, DoABC#2)
// _SafeStr_8682 = "_-lz" (String#24109, DoABC#2)
// clamp = "_-0g2" (String#15674, DoABC#2)
// drShiftTo = "_-1Ae" (String#16886, DoABC#2)
// squareTo = "_-0gT" (String#15691, DoABC#2)
// multiplyTo = "_-0M" (String#14913, DoABC#2)
// _SafeStr_8688 = "_-fA" (String#23853, DoABC#2)
// divide = "_-PO" (String#23221, DoABC#2)
// multiplyUpperTo = "_-ct" (String#23750, DoABC#2)
// multiplyLowerTo = "_-0Lj" (String#14902, DoABC#2)
// dAddOffset = "_-1Rp" (String#17575, DoABC#2)
// _SafeStr_8693 = "_-2YK" (String#20369, DoABC#2)
// _SafeStr_8694 = "_-1Em" (String#17059, DoABC#2)
// nbv = "_-1So" (String#17615, DoABC#2)
// _SafeStr_8696 = "_-3E7" (String#22039, DoABC#2)
// _SafeStr_8697 = "_-1fu" (String#18134, DoABC#2)
// fromInt = "_-20j" (String#19041, DoABC#2)
// negate = "_-Is" (String#22963, DoABC#2)
// nbi = "_-Vc" (String#23477, DoABC#2)
// nbits = "_-2Mo" (String#19919, DoABC#2)
// isEven = "_-3Ds" (String#22028, DoABC#2)
// exp = "_-J8" (String#22972, DoABC#2)
// lShiftTo = "_-1La" (String#17338, DoABC#2)
// rShiftTo = "_-2dp" (String#20594, DoABC#2)
// intAt = "_-NM" (String#23138, DoABC#2)
// intValue = "_-378" (String#21773, DoABC#2)
// byteValue = "_-1c7" (String#17976, DoABC#2)
// shortValue = "_-2Dx" (String#19565, DoABC#2)
// chunkSize = "_-0sp" (String#16155, DoABC#2)
// sigNum = "_-2CD" (String#19491, DoABC#2)
// dMultiply = "_-2OI" (String#19978, DoABC#2)
// bitwiseTo = "_-0cM" (String#15527, DoABC#2)
// op_and = "_-0Gt" (String#14714, DoABC#2)
// and = "_-0bA" (String#15483, DoABC#2)
// op_or = "_-0-D" (String#14020, DoABC#2)
// or = "_-1mY" (String#18403, DoABC#2)
// op_xor = "_-0bk" (String#15502, DoABC#2)
// xor = "_-1WT" (String#5480, DoABC#2)
// op_andnot = "_-2Vo" (String#20273, DoABC#2)
// andNot = "_-PS" (String#23224, DoABC#2)
// not = "_-fo" (String#23881, DoABC#2)
// shiftLeft = "_-2o-" (String#21000, DoABC#2)
// shiftRight = "_-2sl" (String#21189, DoABC#2)
// lbit = "_-19U" (String#16836, DoABC#2)
// getLowestSetBit = "_-0h0" (String#15710, DoABC#2)
// cbit = "_-06C" (String#14292, DoABC#2)
// bitCount = "_-pD" (String#24241, DoABC#2)
// testBit = "_-4f" (String#22403, DoABC#2)
// changeBit = "_-32r" (String#21613, DoABC#2)
// setBit = "_-1iJ" (String#18221, DoABC#2)
// clearBit = "_-0FI" (String#14655, DoABC#2)
// flipBit = "_-21s" (String#19085, DoABC#2)
// addTo = "_-1GQ" (String#17132, DoABC#2)
// remainder = "_-2yw" (String#21424, DoABC#2)
// divideAndRemainder = "_-CH" (String#22701, DoABC#2)
// gcd = "_-I" (String#22928, DoABC#2)
// modInt = "_-1qj" (String#18572, DoABC#2)
// modInverse = "_-2XV" (String#20342, DoABC#2)
// isProbablePrime = "_-2uT" (String#21260, DoABC#2)
// millerRabin = "_-1QN" (String#17528, DoABC#2)
// primify = "_-d6" (String#23762, DoABC#2)


