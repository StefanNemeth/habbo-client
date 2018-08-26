
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.Map;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.FontStyle;
    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.utils.FontEnum;

    public class TextFieldCache implements IDisposable 
    {

        private static var _SafeStr_9769:Map = new Map();
        private static var _instance:TextFieldCache = new (TextFieldCache)();

        private var _disposed:Boolean = false;

        public function TextFieldCache()
        {
            if (_instance == null){
                TextStyleManager.events.addEventListener(Event.CHANGE, this.TextFieldCache);
            };
        }
        public static function TextFieldCache(_arg_1:TextStyle):TextField
        {
            var _local_2:TextField = _SafeStr_9769[_arg_1.name];
            if (_local_2){
                return (_local_2);
            };
            _local_2 = new TextField();
            var _local_3:TextFormat = _local_2.defaultTextFormat;
            if (!_arg_1){
                _arg_1 = TextStyleManager.getStyle(TextStyleManager._SafeStr_9115);
            };
            _local_3.font = _arg_1.fontFamily;
            _local_3.size = _arg_1.fontSize;
            _local_3.color = _arg_1.color;
            _local_3.bold = (((_arg_1.fontWeight == FontStyle.BOLD)) ? true : null);
            _local_3.italic = (((_arg_1.fontStyle == FontStyle.ITALIC)) ? true : null);
            _local_3.underline = (((_arg_1.textDecoration == TextStyle._SafeStr_9113)) ? true : null);
            _local_3.indent = _arg_1.textIndent;
            _local_3.leading = _arg_1.leading;
            _local_3.kerning = _arg_1.kerning;
            _local_3.letterSpacing = _arg_1.letterSpacing;
            _local_2.antiAliasType = (((_arg_1.antiAliasType == AntiAliasType.ADVANCED)) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL);
            _local_2.sharpness = ((_arg_1.sharpness) ? (_arg_1.sharpness as int) : 0);
            _local_2.thickness = ((_arg_1.thickness) ? (_arg_1.thickness as int) : 0);
            if (!_arg_1.fontWeight){
                _local_3.bold = false;
            };
            if (!_arg_1.fontStyle){
                _local_3.italic = false;
            };
            if (!_arg_1.textDecoration){
                _local_3.underline = false;
            };
            if (!_arg_1.textIndent){
                _local_3.indent = 0;
            };
            if (!_arg_1.leading){
                _local_3.leading = 0;
            };
            if (!_arg_1.kerning){
                _local_3.kerning = false;
            };
            if (!_arg_1.letterSpacing){
                _local_3.letterSpacing = 0;
            };
            if (!_arg_1.antiAliasType){
                _local_2.antiAliasType = AntiAliasType.NORMAL;
            };
            _local_2.autoSize = TextFieldAutoSize.LEFT;
            _local_2.setTextFormat(_local_3);
            _local_2.embedFonts = FontEnum.isEmbeddedFont(_local_3.font);
            _local_2.defaultTextFormat = _local_3;
            _SafeStr_9769[_arg_1.name] = _local_2;
            return (_local_2);
        }
        public static function TextFieldCache(_arg_1:String):TextField
        {
            var _local_2:TextStyle = TextStyleManager.getStyle(_arg_1);
            if (!_local_2){
                Logger.log((('TextFieldCache.getTextFieldByStyleName(...); No such style: "' + _arg_1) + '"!'));
                return (null);
            };
            return (TextFieldCache(_local_2));
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            TextStyleManager.events.removeEventListener(Event.CHANGE, this.TextFieldCache);
            _SafeStr_9769.reset();
            _instance = null;
            this._disposed = true;
        }
        private function TextFieldCache(_arg_1:Event):void
        {
            _SafeStr_9769.reset();
        }

    }
}//package com.sulake.core.window.utils

// FontEnum = "_-15T" (String#4985, DoABC#2)
// TextStyle = "_-0qh" (String#16074, DoABC#2)
// TextStyleManager = "_-a7" (String#23636, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// TextFieldCache = "_-2LJ" (String#6466, DoABC#2)
// TextFieldCache = "_-2pk" (String#21070, DoABC#2)
// isEmbeddedFont = "_-2kf" (String#20871, DoABC#2)
// TextFieldCache = "_-2Jp" (String#1854, DoABC#2)
// _SafeStr_9113 = "_-059" (String#14249, DoABC#2)
// _SafeStr_9115 = "_-1hf" (String#18196, DoABC#2)
// TextFieldCache = "_-08N" (String#14379, DoABC#2)
// _SafeStr_9769 = "_-2rz" (String#21156, DoABC#2)


