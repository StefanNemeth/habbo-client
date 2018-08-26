
package com.sulake.core.window.utils
{
    import com.sulake.core.utils.Map;
    import flash.events.IEventDispatcher;
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.events.Event;
    import flash.text.StyleSheet;

    public class TextStyleManager 
    {

        public static const _SafeStr_9115:String = "regular";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        private static var _SafeStr_9751:Map;
        private static var _SafeStr_9752:Array;
        private static var _eventDispatcher:IEventDispatcher;
        private static const {:String = "{";
        private static const }:String = "}";
        private static const /*:String = "/*";
        private static const */:String = "*/";

        {
            init();
        }
        public static function get events():IEventDispatcher
        {
            return (_eventDispatcher);
        }
        private static function init():void
        {
            var _local_1:TextStyle;
            _SafeStr_9751 = new Map();
            _SafeStr_9752 = new Array();
            _eventDispatcher = new EventDispatcher();
            _local_1 = new TextStyle();
            _local_1.name = _SafeStr_9115;
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "normal";
            _local_1.fontWeight = "normal";
            _SafeStr_9751[_local_1.name] = _local_1;
            _SafeStr_9752.push(_local_1.name);
            _local_1 = new TextStyle();
            _local_1.name = ITALIC;
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "italic";
            _local_1.fontWeight = "normal";
            _SafeStr_9751[_local_1.name] = _local_1;
            _SafeStr_9752.push(_local_1.name);
            _local_1 = new TextStyle();
            _local_1.name = BOLD;
            _local_1.color = 0;
            _local_1.fontSize = "9";
            _local_1.fontFamily = "Courier";
            _local_1.fontStyle = "normal";
            _local_1.fontWeight = "bold";
            _SafeStr_9751[_local_1.name] = _local_1;
            _SafeStr_9752.push(_local_1.name);
        }
        public static function getStyle(_arg_1:String):TextStyle
        {
            return (_SafeStr_9751[_arg_1]);
        }
        public static function TextStyleManager(_arg_1:int):TextStyle
        {
            return (_SafeStr_9751.getWithIndex(_arg_1));
        }
        public static function TextStyleManager(_arg_1:String, _arg_2:TextStyle):void
        {
            var _local_3 = (_SafeStr_9751.getKeys().indexOf(_arg_1) == -1);
            _arg_2.name = _arg_1;
            _SafeStr_9751[_arg_1] = _arg_2;
            if (_local_3){
                _SafeStr_9752.push(_arg_1);
                _eventDispatcher.dispatchEvent(new Event(Event.ADDED));
            }
            else {
                _eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
            };
        }
        public static function TextStyleManager(_arg_1:Array, _arg_2:Boolean=false):void
        {
            var _local_4:TextStyle;
            var _local_5:Array;
            if (_arg_2){
                _local_5 = [_SafeStr_9751[_SafeStr_9115], _SafeStr_9751[ITALIC], _SafeStr_9751[BOLD]];
                _SafeStr_9751.reset();
                _SafeStr_9751[_SafeStr_9115] = _local_5[0];
                _SafeStr_9751[ITALIC] = _local_5[1];
                _SafeStr_9751[BOLD] = _local_5[2];
            };
            var _local_3:int = _SafeStr_9751.length;
            for each (_local_4 in _arg_1) {
                _SafeStr_9751[_local_4.name] = _local_4;
                if (_SafeStr_9752.indexOf(_local_4.name) == -1){
                    _SafeStr_9752.push(_local_4.name);
                };
            };
            _eventDispatcher.dispatchEvent(new Event(Event.CHANGE));
            if (_SafeStr_9751.length != _local_3){
                _eventDispatcher.dispatchEvent(new Event(Event.ADDED));
            };
        }
        public static function TextStyleManager(_arg_1:String):TextStyle
        {
            var _local_3:TextStyle;
            var _local_2:TextStyle = (parseCSS(_arg_1)[0] as TextStyle);
            if (_local_2){
                _local_3 = _SafeStr_9751[_local_2.name];
                if (((_local_3) && (_local_3.equals(_local_2)))){
                    return (_local_3);
                };
            };
            return (null);
        }
        public static function TextStyleManager():Array
        {
            var _local_1:Array = new Array();
            var _local_2:int = _SafeStr_9751.length;
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_1.push(_SafeStr_9751.getWithIndex(_local_3));
                _local_3++;
            };
            return (_local_1);
        }
        public static function TextStyleManager():Array
        {
            return (_SafeStr_9751.getKeys());
        }
        public static function TextStyleManager():Array
        {
            return (_SafeStr_9752);
        }
        public static function parseCSS(_arg_1:String):Array
        {
            var _local_5:Object;
            var _local_6:TextStyle;
            var _local_7:String;
            var _local_2:StyleSheet = new StyleSheet();
            _local_2.parseCSS(_arg_1);
            var _local_3:Array = TextStyleManager(_arg_1);
            var _local_4:Array = new Array();
            for each (_local_7 in _local_3) {
                _local_5 = _local_2.getStyle(_local_7);
                _local_6 = new TextStyle();
                _local_6.name = _local_7;
                _local_6.color = ((_local_5.color) ? uint(String(_local_5.color).replace("#", "0x")) : null);
                _local_6.fontFamily = ((_local_5.fontFamily) ? _local_5.fontFamily : null);
                _local_6.fontSize = ((_local_5.fontSize) ? parseInt(String(_local_5.fontSize)) : null);
                _local_6.fontStyle = ((_local_5.fontStyle) ? _local_5.fontStyle : null);
                _local_6.fontWeight = ((_local_5.fontWeight) ? _local_5.fontWeight : null);
                _local_6.kerning = ((_local_5.kerning) ? (_local_5.kerning == "true") : null);
                _local_6.leading = ((_local_5.leading) ? parseInt(String(_local_5.leading)) : null);
                _local_6.letterSpacing = ((_local_5.letterSpacing) ? parseInt(_local_5.letterSpacing.toString()) : null);
                _local_6.textDecoration = ((_local_5.textDecoration) ? _local_5.textDecoration : null);
                _local_6.textIndent = ((_local_5.textIndent) ? parseInt(_local_5.textIndent.toString()) : null);
                _local_6.antiAliasType = ((_local_5.antiAliasType) ? _local_5.antiAliasType : null);
                _local_6.sharpness = ((_local_5.sharpness) ? parseInt(_local_5.sharpness) : null);
                _local_6.thickness = ((_local_5.thickness) ? parseInt(_local_5.thickness) : null);
                _local_4.push(_local_6);
            };
            return (_local_4);
        }
        private static function TextStyleManager(_arg_1:String):Array
        {
            var _local_5:String;
            var _local_2:Array = [];
            var _local_3:String = _arg_1;
            _local_3 = _local_3.split("\t").join("");
            _local_3 = _local_3.split("\n").join("");
            _local_3 = _local_3.split("\r").join("");
            var _local_4:Array = _local_3.split(});
            if (TextStyleManager(_arg_1, {) != TextStyleManager(_arg_1, })){
                throw (new Error((((('Mismatching amount of "' + {) + '" versus "') + }) + '", please check the CSS!')));
            };
            for each (_local_5 in _local_4) {
                while (true) {
                    if (_local_5.indexOf(/*) == 0){
                        _local_5 = _local_5.substring((_local_5.indexOf(*/) + 2), _local_5.length);
                    }
                    else {
                        break;
                    };
                };
                _local_5 = _local_5.slice(0, _local_5.indexOf({)).split(" ").join("");
                if (_local_5.length){
                    _local_2.push(_local_5);
                };
            };
            return (_local_2);
        }
        private static function TextStyleManager(_arg_1:String, _arg_2:String):int
        {
            var _local_3:int;
            var _local_4:int;
            while ((_local_4 = _arg_1.indexOf(_arg_2, _local_4)) != -1) {
                _local_4++;
                _local_3++;
            };
            return (_local_3);
        }
        public static function toString():String
        {
            var _local_3:TextStyle;
            var _local_1:Array = TextStyleManager();
            var _local_2:String = "";
            for each (_local_3 in _local_1) {
                _local_2 = (_local_2 + (_local_3.toString() + "\n\n"));
            };
            return (_local_2);
        }

    }
}//package com.sulake.core.window.utils

// TextStyle = "_-0qh" (String#16074, DoABC#2)
// TextStyleManager = "_-a7" (String#23636, DoABC#2)
// TextStyleManager = "_-11y" (String#16535, DoABC#2)
// equals = "_-1fP" (String#18113, DoABC#2)
// TextStyleManager = "_-2x4" (String#21352, DoABC#2)
// TextStyleManager = "_-17f" (String#16761, DoABC#2)
// _SafeStr_9115 = "_-1hf" (String#18196, DoABC#2)
// TextStyleManager = "_-17m" (String#16765, DoABC#2)
// _SafeStr_9751 = "_-1Yj" (String#17838, DoABC#2)
// _SafeStr_9752 = "_-2nn" (String#20991, DoABC#2)
// { = "_-0H0" (String#14718, DoABC#2)
// } = "_-08l" (String#14396, DoABC#2)
// /* = "_-uf" (String#24477, DoABC#2)
// */ = "_-1Ha" (String#17174, DoABC#2)
// TextStyleManager = "_-mq" (String#24144, DoABC#2)
// TextStyleManager = "_-26t" (String#19287, DoABC#2)
// TextStyleManager = "_-0Ul" (String#15234, DoABC#2)
// TextStyleManager = "_-ZH" (String#23608, DoABC#2)
// TextStyleManager = "_-2uQ" (String#21258, DoABC#2)


