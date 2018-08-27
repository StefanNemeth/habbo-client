
package com.sulake.habbo.friendlist
{
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;

    public class Util 
    {

        public static function remove(_arg_1:Array, _arg_2:Object):void
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 >= 0){
                _arg_1.splice(_local_3, 1);
            };
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
        public static function getRightmostPoint(_arg_1:IWindowContainer):int
        {
            var _local_4:IWindow;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if (_local_4.visible){
                    _local_2 = Math.max(_local_2, (_local_4.x + _local_4.width));
                };
                _local_3++;
            };
            return (_local_2);
        }
        public static function arrayToString(_arg_1:Array, _arg_2:String=", ", _arg_3:String=""):String
        {
            var _local_5:Object;
            var _local_4:String = "";
            for each (_local_5 in _arg_1) {
                if (_local_4 != ""){
                    _local_4 = (_local_4 + _arg_2);
                };
                _local_4 = (_local_4 + ((_arg_3 + _local_5) + _arg_3));
            };
            return (_local_4);
        }
        public static function print(_arg_1:String, _arg_2:IWindow):void
        {
            var _local_4:int;
            Logger.log((((((((_arg_1 + _arg_2) + " (") + _arg_2.width) + ", ") + _arg_2.height) + "), ") + _arg_2.getParamFlag(HabboWindowParam._SafeStr_6023)));
            var _local_3:IWindowContainer = (_arg_2 as IWindowContainer);
            if (_local_3 != null){
                _local_4 = 0;
                while (_local_4 < _local_3.numChildren) {
                    print((_arg_1 + "-"), _local_3.getChildAt(_local_4));
                    _local_4++;
                };
            };
        }
        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }
        public static function getLocationRelativeTo(_arg_1:IWindow, _arg_2:int, _arg_3:int):Rectangle
        {
            if (_arg_1 == null){
                return (new Rectangle(300, 200, _arg_2, _arg_3));
            };
            var _local_4:int = (_arg_1.width - _arg_2);
            var _local_5:int = (_arg_1.height - _arg_3);
            return (new Rectangle((_arg_1.x + (0.5 * _local_4)), (_arg_1.y + (0.5 * _local_5)), _arg_2, _arg_3));
        }
        public static function layoutChildrenInArea(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_7:IWindow;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            while (_local_6 < _arg_1.numChildren) {
                _local_7 = _arg_1.getChildAt(_local_6);
                if (_local_7.visible){
                    if ((((_local_4 > 0)) && (((_local_4 + _local_7.width) > _arg_2)))){
                        _local_4 = 0;
                        _local_5 = (_local_5 + _arg_3);
                    };
                    _local_7.x = _local_4;
                    _local_7.y = _local_5;
                    _local_4 = (_local_4 + _local_7.width);
                };
                _local_6++;
            };
        }

    }
}//package com.sulake.habbo.friendlist

// getRightmostPoint = "_-2iX" (String#20789, DoABC#2)
// arrayToString = "_-20L" (String#19026, DoABC#2)
// print = "_-2k6" (String#20851, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)
// getParamFlag = "_-38B" (String#7475, DoABC#2)


