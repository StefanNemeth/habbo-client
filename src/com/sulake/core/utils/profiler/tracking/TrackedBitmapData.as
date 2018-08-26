
package com.sulake.core.utils.profiler.tracking
{
    import flash.display.BitmapData;

    public class TrackedBitmapData extends BitmapData 
    {

        public static const _SafeStr_7194:int = 0xFFFFFF;
        public static const _SafeStr_7195:int = 8191;
        public static const _SafeStr_7196:int = 8191;
        public static const _SafeStr_7197:int = 1;
        public static const _SafeStr_7198:int = 1;
        public static const _SafeStr_7199:int = 1;
        private static var _SafeStr_7200:uint = 0;
        private static var _SafeStr_7201:uint = 0;

        private var _owner:Object;
        private var _disposed:Boolean = false;

        public function TrackedBitmapData(_arg_1:*, _arg_2:int, _arg_3:int, _arg_4:Boolean=true, _arg_5:uint=0xFFFFFFFF)
        {
            if (_arg_2 > _SafeStr_7195){
                _arg_2 = _SafeStr_7195;
            }
            else {
                if (_arg_2 < _SafeStr_7198){
                    _arg_2 = _SafeStr_7198;
                };
            };
            if (_arg_3 > _SafeStr_7196){
                _arg_3 = _SafeStr_7196;
            }
            else {
                if (_arg_3 < _SafeStr_7199){
                    _arg_3 = _SafeStr_7199;
                };
            };
            super(_arg_2, _arg_3, _arg_4, _arg_5);
            _SafeStr_7200++;
            _SafeStr_7201 = (_SafeStr_7201 + ((_arg_2 * _arg_3) * 4));
            this._owner = _arg_1;
        }
        public static function get numInstances():uint
        {
            return (_SafeStr_7200);
        }
        public static function get allocatedByteCount():uint
        {
            return (_SafeStr_7201);
        }

        override public function dispose():void
        {
            if (!this._disposed){
                _SafeStr_7201 = (_SafeStr_7201 - ((width * height) * 4));
                _SafeStr_7200--;
                this._disposed = true;
                this._owner = null;
                super.dispose();
            };
        }

    }
}//package com.sulake.core.utils.profiler.tracking

// TrackedBitmapData = "_-1gF" (String#5666, DoABC#2)
// _SafeStr_7194 = "_-1k6" (String#18293, DoABC#2)
// _SafeStr_7195 = "_-sq" (String#24395, DoABC#2)
// _SafeStr_7196 = "_-tj" (String#24436, DoABC#2)
// _SafeStr_7197 = "_-1-h" (String#16454, DoABC#2)
// _SafeStr_7198 = "_-Fu" (String#22848, DoABC#2)
// _SafeStr_7199 = "_-1sZ" (String#18657, DoABC#2)
// _SafeStr_7200 = "_-0Eg" (String#14631, DoABC#2)
// _SafeStr_7201 = "_-1uO" (String#5927, DoABC#2)
// numInstances = "_-1Up" (String#17697, DoABC#2)
// allocatedByteCount = "_-2p5" (String#7060, DoABC#2)


