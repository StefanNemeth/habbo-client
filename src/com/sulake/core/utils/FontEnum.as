
package com.sulake.core.utils
{
    import flash.text.Font;
    import flash.utils.getQualifiedClassName;

    public class FontEnum 
    {

        private static const _SafeStr_9010:Map = new Map();
        private static const _SafeStr_9011:Map = new Map();
        private static var _SafeStr_9012:Boolean = false;

        {
            init();
        }
        public static function isSystemFont(_arg_1:String):Boolean
        {
            return (!((_SafeStr_9010.getValue(_arg_1) == null)));
        }
        public static function isEmbeddedFont(_arg_1:String):Boolean
        {
            return (!((_SafeStr_9011.getValue(_arg_1) == null)));
        }
        public static function get systemFonts():Map
        {
            return (_SafeStr_9010);
        }
        public static function get embeddedFonts():Map
        {
            return (_SafeStr_9011);
        }
        public static function registerFont(_arg_1:Class):Font
        {
            var _local_4:Font;
            Font.registerFont((_arg_1 as Class));
            var _local_2:String = getQualifiedClassName(_arg_1);
            var _local_3:Array = Font.enumerateFonts(false);
            var _local_5:int = _local_3.length;
            var _local_6:int = _local_5;
            while (_local_6 > 0) {
                _local_4 = _local_3[(_local_6 - 1)];
                if (getQualifiedClassName(_local_4) == _local_2) break;
                _local_6--;
            };
            _SafeStr_9011.add(_local_4.fontName, _local_4);
            return (_local_4);
        }
        private static function init():void
        {
            var _local_1:Array;
            var _local_2:Array;
            var _local_3:Font;
            if (!_SafeStr_9012){
                _local_1 = Font.enumerateFonts(true);
                _local_2 = Font.enumerateFonts(false);
                for each (_local_3 in _local_1) {
                    if (_local_2.indexOf(_local_3) == -1){
                        _SafeStr_9010.add(_local_3.fontName, _local_3);
                    };
                };
                _SafeStr_9012 = true;
            };
        }
        public static function refresh():void
        {
            var _local_2:Font;
            var _local_3:Font;
            var _local_1:Array = Font.enumerateFonts(false);
            var _local_4:int = _local_1.length;
            var _local_5:int;
            while (_local_5 < _local_4) {
                _local_2 = _local_1[_local_5];
                _local_3 = _SafeStr_9011.getValue(_local_2.fontName);
                if (((((!(_local_3)) || (!((_local_3.fontType == _local_2.fontType))))) || (!((_local_3.fontStyle == _local_2.fontStyle))))){
                    _SafeStr_9011.add(_local_2.fontName, _local_2);
                };
                _local_5++;
            };
        }

    }
}//package com.sulake.core.utils

// FontEnum = "_-15T" (String#4985, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _SafeStr_9010 = "_-31a" (String#21562, DoABC#2)
// _SafeStr_9011 = "_-Ka" (String#23026, DoABC#2)
// _SafeStr_9012 = "_-1Vs" (String#17737, DoABC#2)
// isSystemFont = "_-15" (String#16652, DoABC#2)
// isEmbeddedFont = "_-2kf" (String#20871, DoABC#2)
// systemFonts = "_-7X" (String#22524, DoABC#2)
// embeddedFonts = "_-lV" (String#24090, DoABC#2)


