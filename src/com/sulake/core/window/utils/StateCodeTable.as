
package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.WindowState;
    import flash.utils.Dictionary;

    public class StateCodeTable 
    {

        public static function fillTables(_arg_1:Dictionary, _arg_2:Dictionary=null):void
        {
            var _local_3:String;
            _arg_1["default"] = WindowState._SafeStr_4075;
            _arg_1["active"] = WindowState._SafeStr_4586;
            _arg_1["focused"] = WindowState._SafeStr_9170;
            _arg_1["hovering"] = WindowState._SafeStr_5004;
            _arg_1["selected"] = WindowState._SafeStr_9258;
            _arg_1["pressed"] = WindowState._SafeStr_6248;
            _arg_1["disabled"] = WindowState._SafeStr_9399;
            _arg_1["locked"] = WindowState._SafeStr_9479;
            if (_arg_2 != null){
                for (_local_3 in _arg_1) {
                    _arg_2[_arg_1[_local_3]] = _local_3;
                };
            };
        }

    }
}//package com.sulake.core.window.utils

// WindowState = "_-1Kt" (String#5262, DoABC#2)
// StateCodeTable = "_-fd" (String#23872, DoABC#2)
// _SafeStr_4075 = "_-0DX" (String#14589, DoABC#2)
// _SafeStr_4586 = "_-22X" (String#19111, DoABC#2)
// _SafeStr_5004 = "_-0Yv" (String#15399, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// _SafeStr_9170 = "_-2FR" (String#19621, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)
// _SafeStr_9399 = "_-1WJ" (String#17754, DoABC#2)
// _SafeStr_9479 = "_-H4" (String#22893, DoABC#2)
// fillTables = "_-15n" (String#16687, DoABC#2)


