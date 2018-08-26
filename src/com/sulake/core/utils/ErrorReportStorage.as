
package com.sulake.core.utils
{
    public class ErrorReportStorage 
    {

        private static var _SafeStr_9051:Map = new Map();
        private static var _SafeStr_9052:Map = new Map();

        public static function getDebugData():String
        {
            var _local_1:String = "";
            var _local_2:int;
            while (_local_2 < _SafeStr_9052.length) {
                if (_local_2 == 0){
                    _local_1 = _SafeStr_9052.getWithIndex(_local_2);
                }
                else {
                    _local_1 = ((_local_1 + " ** ") + _SafeStr_9052.getWithIndex(_local_2));
                };
                _local_2++;
            };
            if (_local_1.length > 400){
                _local_1 = _local_1.substr((_local_1.length - 400));
            };
            return (_local_1);
        }
        public static function addDebugData(_arg_1:String, _arg_2:String):void
        {
            _SafeStr_9052.remove(_arg_1);
            _SafeStr_9052.add(_arg_1, _arg_2);
        }
        public static function setParameter(_arg_1:String, _arg_2:String):void
        {
            _SafeStr_9051[_arg_1] = _arg_2;
        }
        public static function getParameter(_arg_1:String):String
        {
            return (_SafeStr_9051[_arg_1]);
        }
        public static function getParameterNames():Array
        {
            return (_SafeStr_9051.getKeys());
        }

    }
}//package com.sulake.core.utils

// addDebugData = "_-04r" (String#14235, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// setParameter = "_-33Y" (String#21643, DoABC#2)
// _SafeStr_9051 = "_-1HQ" (String#17166, DoABC#2)
// _SafeStr_9052 = "_-1RN" (String#17560, DoABC#2)
// getDebugData = "_-1wO" (String#18816, DoABC#2)
// getParameter = "_-0Ty" (String#15204, DoABC#2)
// getParameterNames = "_-HY" (String#22915, DoABC#2)


