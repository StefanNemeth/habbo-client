
package com.sulake.habbo.roomevents
{
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Util 
    {

        public static function setProcDirectly(_arg_1:IWindow, _arg_2:Function):void
        {
            _arg_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            _arg_1.procedure = _arg_2;
        }
        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_4:IWindow;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if (_local_4.visible){
                    _local_2 = Math.max(_local_2, (_local_4.y + _local_4.height));
                };
                _local_3++;
            };
            return (_local_2);
        }
        public static function InfostandWidget(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }
        public static function showChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = true;
                _local_2++;
            };
        }
        public static function moveChildrenToColumn(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_5:String;
            var _local_6:IWindow;
            for each (_local_5 in _arg_2) {
                _local_6 = _arg_1.getChildByName(_local_5);
                if (((((!((_local_6 == null))) && (_local_6.visible))) && ((_local_6.height > 0)))){
                    _local_6.y = _arg_3;
                    _arg_3 = (_arg_3 + (_local_6.height + _arg_4));
                };
            };
        }
        public static function moveAllChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int;
            var _local_5:IWindow;
            while (_local_4 < _arg_1.numChildren) {
                _local_5 = _arg_1.getChildAt(_local_4);
                if (((((!((_local_5 == null))) && (_local_5.visible))) && ((_local_5.height > 0)))){
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }

    }
}//package com.sulake.habbo.roomevents

// showChildren = "_-0l0" (String#4522, DoABC#2)
// moveAllChildrenToColumn = "_-07-" (String#14323, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// setProcDirectly = "_-24s" (String#19218, DoABC#2)


