
package com.sulake.core.window.services
{
    import flash.display.DisplayObject;
    import com.sulake.core.window.enum.WindowParam;

    public class WindowMouseScaler extends WindowMouseOperator implements IMouseScalingService 
    {

        public function WindowMouseScaler(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }
        override public function operate(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            var _local_4:int;
            if (!_window.disposed){
                _local_3 = (((_SafeStr_8916 & WindowParam._SafeStr_7496)) ? (_arg_1 - _mouse.x) : 0);
                _local_4 = (((_SafeStr_8916 & WindowParam._SafeStr_7497)) ? (_arg_2 - _mouse.y) : 0);
                _window.scale(_local_3, _local_4);
            };
        }

    }
}//package com.sulake.core.window.services

// IMouseScalingService = "_-Mf" (String#8135, DoABC#2)
// WindowMouseOperator = "_-1Tv" (String#5430, DoABC#2)
// WindowMouseScaler = "_-CB" (String#7917, DoABC#2)
// _SafeStr_7496 = "_-1Ig" (String#17221, DoABC#2)
// _SafeStr_7497 = "_-0TU" (String#15191, DoABC#2)
// _SafeStr_8916 = "_-27n" (String#877, DoABC#2)
// operate = "_-0n2" (String#4567, DoABC#2)


