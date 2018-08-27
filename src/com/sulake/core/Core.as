
package com.sulake.core
{
    import com.sulake.core.runtime.ICore;
    import com.sulake.core.runtime.CoreComponentContext;
    import flash.display.DisplayObjectContainer;

    public final class Core 
    {

        public static const _SafeStr_8921:uint = 0;
        public static const _SafeStr_8923:uint = 1;
        public static const _SafeStr_8925:uint = 2;
        public static const _SafeStr_8927:uint = 4;
        public static const _SafeStr_8919:uint = 15;
        public static const CORE_SETUP_DEBUG:uint = 15;
        public static const _SafeStr_8935:int = 1;
        public static const _SafeStr_8936:int = 2;
        public static const _SafeStr_9852:int = 3;
        public static const _SafeStr_8966:int = 4;
        public static const _SafeStr_8964:int = 5;
        public static const _SafeStr_8975:int = 6;
        public static const _SafeStr_9853:int = 7;
        public static const _SafeStr_8884:int = 8;
        public static const _SafeStr_3415:int = 9;
        public static const _SafeStr_9854:int = 10;
        public static const _SafeStr_3416:int = 11;
        public static const _SafeStr_9855:int = 20;
        public static const _SafeStr_9856:int = 21;
        public static const _SafeStr_9857:int = 29;
        public static const _SafeStr_9858:int = 30;
        public static const _SafeStr_9058:int = 99;
        private static var _instance:ICore;

        public static function get version():String
        {
            return ("0.0.3");
        }
        public static function get instance():ICore
        {
            return (_instance);
        }
        public static function instantiate(_arg_1:DisplayObjectContainer, _arg_2:uint):ICore
        {
            if (_instance == null){
                _instance = new CoreComponentContext(_arg_1, _arg_2);
            };
            return (_instance);
        }
        public static function error(_arg_1:String, _arg_2:Boolean, _arg_3:int=-1, _arg_4:Error=null):void
        {
            if (_instance){
                _instance.error(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }
        public static function warning(_arg_1:String):void
        {
            if (_instance){
                _instance.warning(_arg_1);
            };
        }
        public static function debug(_arg_1:String):void
        {
            if (_instance){
                _instance.debug(_arg_1);
            };
        }
        public static function crash(_arg_1:String, _arg_2:int, _arg_3:Error=null):void
        {
            if (_instance){
                _instance.error(_arg_1, true, _arg_2, _arg_3);
            };
        }
        public static function dispose():void
        {
            if (_instance != null){
                _instance.dispose();
                _instance = null;
            };
        }

    }
}//package com.sulake.core

// CoreComponentContext = "_-2R5" (String#6581, DoABC#2)
// _SafeStr_3415 = "_-eU" (String#23821, DoABC#2)
// _SafeStr_3416 = "_-Yw" (String#23597, DoABC#2)
// ICore = "_-2kX" (String#6966, DoABC#2)
// instance = "_-1iT" (String#18226, DoABC#2)
// _SafeStr_8884 = "_-01f" (String#14117, DoABC#2)
// crash = "_-1--" (String#16429, DoABC#2)
// _SafeStr_8919 = "_-2Sm" (String#20150, DoABC#2)
// _SafeStr_8921 = "_-1te" (String#18704, DoABC#2)
// _SafeStr_8923 = "_-3J" (String#22237, DoABC#2)
// _SafeStr_8925 = "_-0uX" (String#16222, DoABC#2)
// _SafeStr_8927 = "_-1lp" (String#18368, DoABC#2)
// _SafeStr_8935 = "_-0DA" (String#14575, DoABC#2)
// _SafeStr_8936 = "_-Y9" (String#23568, DoABC#2)
// warning = "_-1MU" (String#5283, DoABC#2)
// _SafeStr_8964 = "_-3JI" (String#22255, DoABC#2)
// _SafeStr_8966 = "_-0p7" (String#16021, DoABC#2)
// _SafeStr_8975 = "_-3-U" (String#21481, DoABC#2)
// _SafeStr_9058 = "_-MM" (String#23098, DoABC#2)
// _SafeStr_9852 = "_-5s" (String#22458, DoABC#2)
// _SafeStr_9853 = "_-1CI" (String#16955, DoABC#2)
// _SafeStr_9854 = "_-1Pp" (String#17502, DoABC#2)
// _SafeStr_9855 = "_-0yb" (String#16378, DoABC#2)
// _SafeStr_9856 = "_-1xX" (String#18870, DoABC#2)
// _SafeStr_9857 = "_-0SS" (String#15152, DoABC#2)
// _SafeStr_9858 = "_-1oR" (String#18474, DoABC#2)
// instantiate = "_-Pb" (String#23231, DoABC#2)


