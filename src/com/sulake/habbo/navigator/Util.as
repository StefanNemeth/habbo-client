
package com.sulake.habbo.navigator
{
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import flash.geom.Point;

    public class Util 
    {

        private static var _SafeStr_12006:CutToWidth = new CutToWidth();
        private static var _SafeStr_12007:CutToHeight = new CutToHeight();

        public static function remove(_arg_1:Array, _arg_2:Object):int
        {
            var _local_3:int = _arg_1.indexOf(_arg_2);
            if (_local_3 >= 0){
                _arg_1.splice(_local_3, 1);
            };
            return (_local_3);
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
        public static function hasVisibleChildren(_arg_1:IWindowContainer):Boolean
        {
            var _local_3:IWindow;
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _local_3 = _arg_1.getChildAt(_local_2);
                if (_local_3.visible){
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }
        public static function InfostandWidget(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }
        public static function moveChildrenToRow(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
            var _local_6:String;
            var _local_7:IWindow;
            for each (_local_6 in _arg_2) {
                _local_7 = _arg_1.getChildByName(_local_6);
                if (((!((_local_7 == null))) && (_local_7.visible))){
                    _local_7.x = _arg_3;
                    _local_7.y = _arg_4;
                    _arg_3 = (_arg_3 + (_local_7.width + _arg_5));
                };
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
        public static function layoutChildrenInArea(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int, _arg_4:int=0):void
        {
            var _local_8:IWindow;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            while (_local_7 < _arg_1.numChildren) {
                _local_8 = _arg_1.getChildAt(_local_7);
                if (_local_8.visible){
                    if ((((_local_5 > 0)) && (((_local_5 + _local_8.width) > _arg_2)))){
                        _local_5 = 0;
                        _local_6 = (_local_6 + _arg_3);
                    };
                    _local_8.x = _local_5;
                    _local_8.y = _local_6;
                    _local_5 = (_local_5 + (_local_8.width + _arg_4));
                };
                _local_7++;
            };
        }
        public static function setProc(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Function):void
        {
            var _local_4:IWindow = _arg_1.findChildByName(_arg_2);
            _local_4.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            _local_4.procedure = _arg_3;
        }
        public static function setProcDirectly(_arg_1:IWindow, _arg_2:Function):void
        {
            _arg_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            _arg_1.procedure = _arg_2;
        }
        public static function setColors(_arg_1:IWindowContainer, _arg_2:uint):void
        {
            var _local_4:IWindow;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if ((_local_4 as IWindowContainer) != null){
                    setColors(IWindowContainer(_local_4), _arg_2);
                }
                else {
                    if (!(_local_4 as IRadioButtonWindow)){
                        if ((_local_4 as ITextFieldWindow)){
                            ITextFieldWindow(_local_4).textColor = _arg_2;
                            ITextFieldWindow(_local_4).borderColor = _arg_2;
                        }
                        else {
                            if ((_local_4 as ITextWindow)){
                                ITextWindow(_local_4).textColor = _arg_2;
                            }
                            else {
                                if ((_local_4 as IButtonWindow)){
                                    IButtonWindow(_local_4).style = 0;
                                };
                            };
                        };
                    };
                };
                _local_3++;
            };
        }
        public static function trim(_arg_1:String):String
        {
            if ((((_arg_1 == null)) || ((_arg_1.length < 1)))){
                return (_arg_1);
            };
            while (_arg_1.charAt(0) == " ") {
                _arg_1 = _arg_1.substring(1);
            };
            while (_arg_1.charAt((_arg_1.length - 1)) == " ") {
                _arg_1 = _arg_1.substring(0, (_arg_1.length - 1));
            };
            return (_arg_1);
        }
        public static function cutTextToWidth(_arg_1:ITextWindow, _arg_2:String, _arg_3:int):void
        {
            _arg_1.text = _arg_2;
            if (_arg_1.textWidth <= _arg_3){
                return;
            };
            _SafeStr_12006.beforeSearch(_arg_2, _arg_1, _arg_3);
            binarySearch(_SafeStr_12006, (_arg_2.length - 1));
        }
        public static function binarySearch(_arg_1:BinarySearchTest, _arg_2:int):void
        {
            var _local_5:int;
            var _local_6:Boolean;
            var _local_3:int;
            var _local_4:int;
            while (true) {
                if (_local_3 >= _arg_2){
                    _arg_1.test(_local_4);
                    return;
                };
                _local_5 = (_local_3 + Math.floor(((_arg_2 - _local_3) / 2)));
                _local_6 = _arg_1.test(_local_5);
                if (_local_6){
                    _arg_2 = (_local_5 - 1);
                }
                else {
                    _local_4 = Math.max(_local_4, _local_5);
                    _local_3 = (_local_5 + 1);
                };
            };
        }
        public static function containsMouse(_arg_1:IWindow):Boolean
        {
            var _local_2:Point = new Point();
            _arg_1.WindowController(_local_2);
            var _local_3:Boolean = (((((((_local_2.x >= 0)) && ((_local_2.y >= 0)))) && ((_local_2.x < _arg_1.width)))) && ((_local_2.y < _arg_1.height)));
            Logger.log(((((("CHECKINg: " + _local_2) + ", ") + _arg_1.rectangle) + ", ") + _local_3));
            return (_local_3);
        }

    }
}//package com.sulake.habbo.navigator

// setProc = "_-333" (String#1990, DoABC#2)
// _SafeStr_12006 = "_-Su" (String#23360, DoABC#2)
// _SafeStr_12007 = "_-3Ke" (String#22309, DoABC#2)
// trim = "_-03B" (String#14169, DoABC#2)
// beforeSearch = "_-28B" (String#19337, DoABC#2)
// binarySearch = "_-1DZ" (String#17006, DoABC#2)
// test = "_-qI" (String#8715, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// BinarySearchTest = "_-Hz" (String#8039, DoABC#2)
// CutToWidth = "_-13S" (String#4942, DoABC#2)
// CutToHeight = "_-6V" (String#7794, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// cutTextToWidth = "_-1qz" (String#18580, DoABC#2)
// containsMouse = "_-0ij" (String#15781, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// hasVisibleChildren = "_-0js" (String#15823, DoABC#2)
// setProcDirectly = "_-24s" (String#19218, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)
// setColors = "_-1Dl" (String#17014, DoABC#2)
// moveChildrenToRow = "_-0xS" (String#16331, DoABC#2)
// WindowController = "_-1wW" (String#1785, DoABC#2)


