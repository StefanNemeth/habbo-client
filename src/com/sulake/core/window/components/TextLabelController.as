
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.localization.ILocalizable;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.TextStyleManager;
    import flash.events.Event;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.TextFormat;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.utils.TextStyle;
    import com.sulake.core.window.utils.TextFieldCache;
    import flash.text.TextField;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import com.sulake.core.utils.Map;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class TextLabelController extends WindowController implements ILabelWindow, ILocalizable 
    {

        private var _SafeStr_9251:Object = null;
        private var _SafeStr_9073:String = "regular";
        private var _text:String = "";
        private var _SafeStr_9071:Boolean = false;
        private var _margins:TextMargins;
        private var _textHeight:Number = 0;
        private var _textWidth:Number = 0;
        private var _TextLabelController:Boolean = false;

        public function TextLabelController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            TextStyleManager.events.addEventListener(Event.CHANGE, this.TextFieldCache);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get antiAliasType():String
        {
            return (this.textField.antiAliasType);
        }
        public function get autoSize():String
        {
            return (this.textField.autoSize);
        }
        public function get bold():Boolean
        {
            return (this.textField.defaultTextFormat.bold);
        }
        public function get border():Boolean
        {
            return (this.textField.border);
        }
        public function get borderColor():uint
        {
            return (this.textField.borderColor);
        }
        public function get defaultTextFormat():TextFormat
        {
            return (this.textField.defaultTextFormat);
        }
        public function get embedFonts():Boolean
        {
            return (this.textField.embedFonts);
        }
        public function get fontFace():String
        {
            return (this.textField.defaultTextFormat.font);
        }
        public function get fontSize():uint
        {
            return ((((this.textField.defaultTextFormat.size == null)) ? 12 : uint(this.textField.defaultTextFormat.size)));
        }
        public function get gridFitType():String
        {
            return (this.textField.gridFitType);
        }
        public function get italic():Boolean
        {
            return (this.textField.defaultTextFormat.italic);
        }
        public function get kerning():Boolean
        {
            return (this.textField.defaultTextFormat.kerning);
        }
        public function get length():int
        {
            return (this._text.length);
        }
        public function get margins():IMargins
        {
            if (!this._margins){
                this._margins = new TextMargins(0, 0, 0, 0, this.TextController);
            };
            return (this._margins);
        }
        public function get maxChars():int
        {
            return (this.textField.maxChars);
        }
        public function get sharpness():Number
        {
            return (this.textField.sharpness);
        }
        public function get spacing():Number
        {
            return (Number(this.textField.defaultTextFormat.letterSpacing));
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get textColor():uint
        {
            return (uint(this._SafeStr_9251));
        }
        public function get textBackground():Boolean
        {
            return (background);
        }
        public function get textBackgroundColor():uint
        {
            return (color);
        }
        public function get textHeight():Number
        {
            return (this._textHeight);
        }
        public function get textWidth():Number
        {
            return (this._textWidth);
        }
        public function get textStyle():TextStyle
        {
            return (TextStyleManager.getStyle(this._SafeStr_9073));
        }
        public function get thickness():Number
        {
            return (this.textField.thickness);
        }
        public function get underline():Boolean
        {
            return (this.textField.defaultTextFormat.underline);
        }
        public function get drawOffsetX():int
        {
            return (((this._margins) ? this._margins.left : 0));
        }
        public function get drawOffsetY():int
        {
            return (((this._margins) ? this._margins.top : 0));
        }
        public function get hasTextColor():Boolean
        {
            return (!((this._SafeStr_9251 == null)));
        }
        protected function get textField():TextField
        {
            var _local_1:TextField = TextFieldCache.TextFieldCache(this._SafeStr_9073);
            if (_local_1){
                _local_1.text = this._text;
                if (this._SafeStr_9251 != null){
                    _local_1.textColor = uint(this._SafeStr_9251);
                };
            };
            return (_local_1);
        }
        public function set text(_arg_1:String):void
        {
            if (_arg_1 == null){
                return;
            };
            if (this._SafeStr_9071){
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                this._SafeStr_9071 = false;
            };
            _caption = _arg_1;
            if ((((_caption.charAt(0) == "$")) && ((_caption.charAt(1) == "{")))){
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                this._SafeStr_9071 = true;
            }
            else {
                this._text = _arg_1;
                this.refresh();
            };
        }
        override public function set caption(_arg_1:String):void
        {
            this.text = _arg_1;
        }
        public function set localization(_arg_1:String):void
        {
            if (_arg_1 != null){
                this._text = _arg_1;
                this.refresh();
            };
        }
        public function set textStyle(_arg_1:TextStyle):void
        {
            if (this._SafeStr_9073 != _arg_1.name){
                this._SafeStr_9073 = _arg_1.name;
                this.refresh();
            };
        }
        public function set textColor(_arg_1:uint):void
        {
            if (_arg_1 != this._SafeStr_9251){
                this._SafeStr_9251 = _arg_1;
                this.refresh();
            };
        }
        override public function dispose():void
        {
            if (!_disposed){
                TextStyleManager.events.removeEventListener(Event.CHANGE, this.TextFieldCache);
                if (this._SafeStr_9071){
                    this._SafeStr_9071 = false;
                    context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                };
                if (this._margins){
                    this._margins.dispose();
                    this._margins = null;
                };
                super.dispose();
            };
        }
        private function refresh(_arg_1:Boolean=false):void
        {
            var _local_9:WindowEvent;
            if (this._TextLabelController){
                return;
            };
            this._TextLabelController = true;
            var _local_2:TextField = this.textField;
            if (!_local_2){
                this._TextLabelController = false;
                return;
            };
            this._textWidth = _local_2.textWidth;
            this._textHeight = _local_2.textHeight;
            var _local_3:int = ((this._margins) ? (this._margins.left + this._margins.right) : 0);
            var _local_4:int = ((this._margins) ? (this._margins.top + this._margins.bottom) : 0);
            var _local_5:int = (_rectangle.width - _local_3);
            var _local_6:int = (_rectangle.height - _local_4);
            var _local_7:int = (Math.floor(_local_2.width) + ((_local_2.border) ? 1 : 0));
            var _local_8:Boolean;
            if (_local_7 != _local_5){
                WindowController(_rectangle.x, _rectangle.y, (_local_7 + _local_3), (Math.floor(_local_2.height) + _local_4));
                _local_8 = true;
            };
            if ((_local_2.height + ((_local_2.border) ? 1 : 0)) < _local_6){
                _local_2.height = (_local_6 - ((_local_2.border) ? 1 : 0));
            }
            else {
                if ((_local_2.height + ((_local_2.border) ? 1 : 0)) > _local_6){
                    WindowController(_rectangle.x, _rectangle.y, (_local_7 + _local_3), (Math.floor(_local_2.height) + _local_4));
                    _local_8 = true;
                };
            };
            this._TextLabelController = false;
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            if (((((!(_local_8)) && (!(_arg_1)))) && (_events))){
                _local_9 = WindowEvent.allocate(WindowEvent.WE_RESIZED, this, null);
                _events.dispatchEvent(_local_9);
                _local_9.recycle();
            };
        }
        private function TextController(_arg_1:IMargins):void
        {
            if (((_arg_1) && (!((_arg_1 == this._margins))))){
                if (this._margins){
                    this._margins.assign(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, this.TextController);
                }
                else {
                    this._margins = new TextMargins(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, this.TextController);
                };
            };
            this.refresh();
        }
        private function TextFieldCache(_arg_1:Event):void
        {
            this.refresh();
        }
        private function TextController(_arg_1:Map):void
        {
            if (this._margins){
                this._margins.assign(int(_arg_1["left"]), int(_arg_1["top"]), int(_arg_1["right"]), int(_arg_1["bottom"]), this.TextController);
            }
            else {
                this._margins = new TextMargins(int(_arg_1["left"]), int(_arg_1["top"]), int(_arg_1["right"]), int(_arg_1["bottom"]), this.TextController);
            };
            this.refresh();
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            var _local_2:TextStyle = TextStyleManager.getStyle(this._SafeStr_9073);
            _local_1.push((((this._SafeStr_9073)!=TextStyleManager._SafeStr_9115) ? new PropertyStruct(PropertyDefaults._SafeStr_9120, this._SafeStr_9073, PropertyStruct._SafeStr_8998, true, PropertyDefaults._SafeStr_9145) : PropertyDefaults._SafeStr_9146));
            _local_1.push((((((_local_2.color)!=null) ? !((this._SafeStr_9251 == _local_2.color)) : ((!((this._SafeStr_9251 == null))) && (!((this._SafeStr_9251 == PropertyDefaults._SafeStr_9143)))))) ? new PropertyStruct(PropertyDefaults._SafeStr_9119, this._SafeStr_9251, PropertyStruct._SafeStr_8991, true) : PropertyDefaults._SafeStr_9144));
            if (this._margins){
                if (this._margins.left != PropertyDefaults._SafeStr_9147){
                    _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9121, this._margins.left, PropertyStruct._SafeStr_8992, true));
                }
                else {
                    _local_1.push(PropertyDefaults._SafeStr_9148);
                };
                if (this._margins.top != PropertyDefaults._SafeStr_9149){
                    _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9122, this._margins.top, PropertyStruct._SafeStr_8992, true));
                }
                else {
                    _local_1.push(PropertyDefaults._SafeStr_8376);
                };
                if (this._margins.right != PropertyDefaults._SafeStr_9150){
                    _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9123, this._margins.right, PropertyStruct._SafeStr_8992, true));
                }
                else {
                    _local_1.push(PropertyDefaults._SafeStr_8377);
                };
                if (this._margins.bottom != PropertyDefaults._SafeStr_9151){
                    _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9124, this._margins.bottom, PropertyStruct._SafeStr_8992, true));
                }
                else {
                    _local_1.push(PropertyDefaults._SafeStr_8378);
                };
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9148);
                _local_1.push(PropertyDefaults._SafeStr_8376);
                _local_1.push(PropertyDefaults._SafeStr_8377);
                _local_1.push(PropertyDefaults._SafeStr_8378);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9120:
                        this.textStyle = TextStyleManager.getStyle((_local_2.value as String));
                        break;
                    case PropertyDefaults._SafeStr_9119:
                        this._SafeStr_9251 = (_local_2.value as uint);
                        break;
                    case PropertyDefaults._SafeStr_9121:
                        if (((this._margins) || (_local_2.valid))){
                            this.margins.left = (_local_2.value as int);
                        };
                        break;
                    case PropertyDefaults._SafeStr_9122:
                        if (((this._margins) || (_local_2.valid))){
                            this.margins.top = (_local_2.value as int);
                        };
                        break;
                    case PropertyDefaults._SafeStr_9123:
                        if (((this._margins) || (_local_2.valid))){
                            this.margins.right = (_local_2.value as int);
                        };
                        break;
                    case PropertyDefaults._SafeStr_9124:
                        if (((this._margins) || (_local_2.valid))){
                            this.margins.bottom = (_local_2.value as int);
                        };
                        break;
                    case "margins":
                        this.TextController((_local_2.value as Map));
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IMargins = "_-1mu" (String#1757, DoABC#2)
// TextStyle = "_-0qh" (String#16074, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// TextMargins = "_-2Jl" (String#19801, DoABC#2)
// TextStyleManager = "_-a7" (String#23636, DoABC#2)
// TextLabelController = "_-2Hc" (String#6396, DoABC#2)
// TextFieldCache = "_-2LJ" (String#6466, DoABC#2)
// drawOffsetX = "_-20-" (String#19010, DoABC#2)
// drawOffsetY = "_-2NC" (String#19931, DoABC#2)
// hasTextColor = "_-2gE" (String#20699, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// fontFace = "_-hD" (String#2155, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _SafeStr_8376 = "_-2JG" (String#6425, DoABC#2)
// _SafeStr_8377 = "_-2RO" (String#6593, DoABC#2)
// _SafeStr_8378 = "_-v6" (String#8786, DoABC#2)
// _SafeStr_8991 = "_-23W" (String#19156, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// _margins = "_-063" (String#1402, DoABC#2)
// _SafeStr_9071 = "_-2cp" (String#6807, DoABC#2)
// _SafeStr_9073 = "_-CO" (String#7924, DoABC#2)
// TextController = "_-2Ui" (String#6660, DoABC#2)
// TextFieldCache = "_-2Jp" (String#1854, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// TextController = "_-sB" (String#8740, DoABC#2)
// _SafeStr_9115 = "_-1hf" (String#18196, DoABC#2)
// _SafeStr_9119 = "_-3Cl" (String#21985, DoABC#2)
// _SafeStr_9120 = "_-2Zs" (String#20434, DoABC#2)
// _SafeStr_9121 = "_-Gc" (String#22874, DoABC#2)
// _SafeStr_9122 = "_-3-3" (String#21463, DoABC#2)
// _SafeStr_9123 = "_-Vu" (String#23489, DoABC#2)
// _SafeStr_9124 = "_-tF" (String#24416, DoABC#2)
// textBackground = "_-IA" (String#2081, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// WindowController = "_-Vb" (String#23476, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// _SafeStr_9143 = "_-x6" (String#24573, DoABC#2)
// _SafeStr_9144 = "_-0aD" (String#15448, DoABC#2)
// _SafeStr_9145 = "_-Ed" (String#22799, DoABC#2)
// _SafeStr_9146 = "_-09z" (String#14446, DoABC#2)
// _SafeStr_9147 = "_-iS" (String#23976, DoABC#2)
// _SafeStr_9148 = "_-299" (String#19371, DoABC#2)
// _SafeStr_9149 = "_-30" (String#21500, DoABC#2)
// _SafeStr_9150 = "_-aC" (String#23640, DoABC#2)
// _SafeStr_9151 = "_-Eb" (String#22797, DoABC#2)
// _SafeStr_9251 = "_-0AV" (String#14467, DoABC#2)
// _textHeight = "_-2xj" (String#21384, DoABC#2)
// _textWidth = "_-1Dq" (String#17018, DoABC#2)
// _TextLabelController = "_-178" (String#16739, DoABC#2)
// TextFieldCache = "_-08N" (String#14379, DoABC#2)
// valid = "_-H2" (String#22891, DoABC#2)


