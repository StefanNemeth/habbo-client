
package com.sulake.habbo.messenger
{
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;

    public class Util 
    {

        public static function remove(_arg_1:Array, _arg_2:Object):void
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 >= 0){
                _arg_1.splice(_local_3, 1);
            };
        }
        public static function getFormattedNow():String
        {
            var _local_1:Date = new Date();
            return (((pad(true, "0", 2, ("" + _local_1.hours)) + ":") + pad(true, "0", 2, ("" + _local_1.minutes))));
        }
        public static function pad(_arg_1:Boolean, _arg_2:String, _arg_3:int, _arg_4:String):String
        {
            var _local_5:String = _arg_4;
            while (_local_5.length < _arg_3) {
                if (_arg_1){
                    _local_5 = (_arg_2 + _local_5);
                }
                else {
                    _local_5 = (_local_5 + _arg_2);
                };
            };
            return (_local_5);
        }
        public static function getContainer(_arg_1:IHabboWindowManager, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:Boolean):IWindowContainer
        {
            return ((_arg_1.createWindow(_arg_2, _arg_2, HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3731 | ((_arg_5) ? HabboWindowParam._SafeStr_6023 : 0)), new Rectangle(_arg_3, _arg_4, 600, 600), null) as IWindowContainer));
        }

    }
}//package com.sulake.habbo.messenger

// pad = "_-124" (String#16539, DoABC#2)
// getContainer = "_-3BA" (String#21931, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// getFormattedNow = "_-1y3" (String#18889, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)


