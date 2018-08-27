
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.ITextFieldContainer;
    import com.sulake.core.localization.ILocalizable;
    import flash.utils.Dictionary;
    import _-0Oz.createPropertySetterTable;
    import flash.text.TextField;
    import com.sulake.core.window.utils.TextMargins;
    import com.sulake.core.window.utils.TextStyle;
    import com.sulake.core.window.utils.TextStyleManager;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.AntiAliasType;
    import flash.text.TextFormat;
    import com.sulake.core.utils.FontEnum;
    import com.sulake.core.utils.Map;
    import flash.text.FontStyle;
    import com.sulake.core.window.utils.PropertyDefaults;
    import com.sulake.core.window.utils.IMargins;
    import com.sulake.core.window.graphics.IGraphicContext;
    import flash.events.MouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Point;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.graphics.WindowRedrawFlag;
    import flash.display.DisplayObject;
    import flash.text.TextLineMetrics;
    import com.sulake.core.utils.XMLVariableParser;
    import com.sulake.core.window.utils.PropertyStruct;

    public class TextController extends WindowController implements ITextWindow, ITextFieldContainer, ILocalizable 
    {

        protected static const _SafeStr_9066:Dictionary = createPropertySetterTable();

        protected var _field:TextField;
        protected var _scrollH:Number;
        protected var _scrollV:Number;
        protected var _SafeStr_9069:Boolean;
        protected var _margins:TextMargins;
        protected var _autoSize:String = "none";
        protected var _SafeStr_9071:Boolean = false;
        protected var _immediateClickMode:Boolean = false;
        private var _SafeStr_9073:String = "regular";
        private var _explicitStyle:TextStyle;

        public function TextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            this._explicitStyle = new TextStyle();
            this._margins = new TextMargins(0, 0, 0, 0, this.setTextMargins);
            this._SafeStr_9069 = false;
            this._scrollH = 0;
            this._scrollV = 0;
            if (this._field == null){
                this._field = new TextField();
                if (_arg_6){
                    this._field.width = _arg_6.width;
                    this._field.height = _arg_6.height;
                };
                this._field.mouseWheelEnabled = false;
            };
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            setTextFormatting(this._field, this._SafeStr_9073, this._explicitStyle);
            TextStyleManager.events.addEventListener(Event.CHANGE, this.onTextStyleChanged);
            if (this._field.autoSize == TextFieldAutoSize.NONE){
                this._field.width = _rectangle.width;
                this._field.height = _rectangle.height;
            };
        }
        private static function setAntiAliasType(_arg_1:TextController, _arg_2:String):void
        {
            _arg_2 = (((_arg_2 == AntiAliasType.ADVANCED)) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL);
            _arg_1._explicitStyle.antiAliasType = _arg_2;
            _arg_1._field.antiAliasType = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setAlwaysShowSelection(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.alwaysShowSelection = _arg_2;
        }
        private static function setAutoSize(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._autoSize = _arg_2;
            _arg_1._field.autoSize = (((_arg_2)!=TextFieldAutoSize.NONE) ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE);
            _arg_1.refreshTextImage();
        }
        private static function setTextBackground(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1.background = _arg_2;
        }
        private static function setTextBackgroundColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1.color = _arg_2;
        }
        private static function setBold(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.bold = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.fontWeight = TextStyle.BOLD;
        }
        private static function setBorder(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.border = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setBorderColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1._field.borderColor = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setCondenseWhite(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.condenseWhite = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setDefaultTextFormat(_arg_1:TextController, _arg_2:TextFormat):void
        {
            _arg_1._field.defaultTextFormat = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setEmbedFonts(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.embedFonts = _arg_2;
        }
        private static function setFontFace(_arg_1:TextController, _arg_2:String):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.font = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1._field.embedFonts = FontEnum.isEmbeddedFont(_arg_2);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.fontFamily = _arg_2;
        }
        private static function setFontSize(_arg_1:TextController, _arg_2:uint):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.size = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.fontSize = _arg_2;
        }
        private static function setGridFitType(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._field.gridFitType = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setHtmlText(_arg_1:TextController, _arg_2:String):void
        {
            if (_arg_2 == null){
                return;
            };
            if (_arg_1._SafeStr_9071){
                _arg_1.context.removeLocalizationListener(_arg_1._caption.slice(2, _arg_1._caption.indexOf("}")), _arg_1);
                _arg_1._SafeStr_9071 = false;
            };
            _arg_1._caption = _arg_2;
            if ((((_arg_1._caption.charAt(0) == "$")) && ((_arg_1._caption.charAt(1) == "{")))){
                _arg_1.context.registerLocalizationListener(_arg_1._caption.slice(2, _arg_1._caption.indexOf("}")), _arg_1);
                _arg_1._SafeStr_9071 = true;
            }
            else {
                if (_arg_1._field != null){
                    _arg_1._field.htmlText = _arg_1._caption;
                    _arg_1.refreshTextImage();
                };
            };
        }
        private static function setItalic(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.italic = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.fontStyle = ((_arg_2) ? TextStyle.ITALIC : TextStyle.NORMAL);
        }
        private static function setKerning(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.kerning = _arg_2;
            var _local_4:TextFormat = new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading);
            _local_4.kerning = _arg_2;
            _arg_1.setTextFormat(_local_4);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.kerning = _arg_2;
        }
        private static function setTextMarginMap(_arg_1:TextController, _arg_2:Map):void
        {
            if (_arg_1._margins){
                _arg_1._margins.assign(int(_arg_2["left"]), int(_arg_2["top"]), int(_arg_2["right"]), int(_arg_2["bottom"]), _arg_1.setTextMargins);
            }
            else {
                _arg_1._margins = new TextMargins(int(_arg_2["left"]), int(_arg_2["top"]), int(_arg_2["right"]), int(_arg_2["bottom"]), _arg_1.setTextMargins);
            };
            _arg_1.refreshTextImage();
        }
        private static function setMarginLeft(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._margins) && (!((_arg_1._margins.left == _arg_2))))){
                _arg_1.margins.left = _arg_2;
            };
        }
        private static function setMarginTop(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._margins) && (!((_arg_1._margins.top == _arg_2))))){
                _arg_1.margins.top = _arg_2;
            };
        }
        private static function setMarginRight(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._margins) && (!((_arg_1._margins.right == _arg_2))))){
                _arg_1.margins.right = _arg_2;
            };
        }
        private static function setMarginBottom(_arg_1:TextController, _arg_2:int):void
        {
            if (((_arg_1._margins) && (!((_arg_1._margins.bottom == _arg_2))))){
                _arg_1.margins.bottom = _arg_2;
            };
        }
        private static function setMaxChars(_arg_1:TextController, _arg_2:int):void
        {
            _arg_1._field.maxChars = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setMouseWheelEnabled(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.mouseWheelEnabled = _arg_2;
        }
        private static function setMultiline(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.multiline = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setRestrict(_arg_1:TextController, _arg_2:String):void
        {
            _arg_1._field.restrict = _arg_2;
        }
        private static function setSharpness(_arg_1:TextController, _arg_2:Number):void
        {
            _arg_1._field.sharpness = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setSpacing(_arg_1:TextController, _arg_2:Number):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.letterSpacing = _arg_2;
            var _local_4:TextFormat = new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading);
            _local_4.letterSpacing = _arg_2;
            _arg_1.setTextFormat(_local_4);
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.letterSpacing = _arg_2;
        }
        private static function setTextColor(_arg_1:TextController, _arg_2:uint):void
        {
            _arg_1._field.textColor = _arg_2;
            _arg_1.refreshTextImage();
            _arg_1._explicitStyle.color = _arg_2;
        }
        private static function setTextStyle(_arg_1:TextController, _arg_2:TextStyle):void
        {
            if (((!(_arg_1)) || (!(_arg_2)))){
                return;
            };
            var _local_3:TextStyle = TextStyleManager.getStyle(_arg_2.name);
            if (((_local_3) && (!(_local_3.equals(_arg_2))))){
                _local_3 = TextStyleManager.findMatchingTextStyle(_arg_2.toString());
            };
            if (_local_3){
                _arg_1._SafeStr_9073 = _local_3.name;
                setTextFormatting(_arg_1._field, _arg_1._SafeStr_9073, _arg_1._explicitStyle);
                _arg_1.refreshTextImage();
            };
        }
        private static function setTextStyleString(_arg_1:TextController, _arg_2:String):void
        {
            var _local_3:TextStyle = TextStyleManager.getStyle(_arg_2);
            if (!_local_3){
                _local_3 = TextStyleManager.findMatchingTextStyle(_arg_2);
            };
            if (_local_3){
                _arg_1._SafeStr_9073 = _local_3.name;
                setTextFormatting(_arg_1._field, _arg_1._SafeStr_9073, _arg_1._explicitStyle);
                _arg_1.refreshTextImage();
            }
            else {
                _local_3 = TextStyleManager.parseCSS(_arg_2)[0];
                if (_local_3){
                    if (!TextStyleManager.getStyle(_local_3.name)){
                        TextStyleManager.setStyle(_local_3.name, _local_3);
                    };
                    setTextStyle(_arg_1, _local_3);
                };
            };
        }
        private static function setThickness(_arg_1:TextController, _arg_2:Number):void
        {
            _arg_1._field.thickness = _arg_2;
            _arg_1.refreshTextImage();
        }
        private static function setUnderline(_arg_1:TextController, _arg_2:Boolean):void
        {
            var _local_3:TextFormat = _arg_1.defaultTextFormat;
            _local_3.underline = _arg_2;
            _arg_1.setTextFormat(new TextFormat(_local_3.font, _local_3.size, _local_3.color, _local_3.bold, _local_3.italic, _local_3.underline, _local_3.url, _local_3.target, _local_3.align, _local_3.leftMargin, _local_3.rightMargin, _local_3.indent, _local_3.leading));
            _arg_1.defaultTextFormat = _local_3;
            _arg_1._explicitStyle.textDecoration = ((_arg_2) ? TextStyle._SafeStr_9113 : TextStyle.NONE);
        }
        private static function setWordWrap(_arg_1:TextController, _arg_2:Boolean):void
        {
            _arg_1._field.wordWrap = _arg_2;
            _arg_1.refreshTextImage();
        }
        protected static function setTextFormatting(_arg_1:TextField, _arg_2:String, _arg_3:TextStyle):void
        {
            var _local_4:TextStyle = TextStyleManager.getStyle(_arg_2);
            var _local_5:TextFormat = _arg_1.defaultTextFormat;
            if (!_local_4){
                _local_4 = TextStyleManager.getStyle(TextStyleManager._SafeStr_9115);
            };
            if (!_arg_3.fontFamily){
                _local_5.font = _local_4.fontFamily;
            };
            if (!_arg_3.fontSize){
                _local_5.size = _local_4.fontSize;
            };
            if (!_arg_3.color){
                _local_5.color = _local_4.color;
            };
            if (!_arg_3.fontWeight){
                _local_5.bold = (((_local_4.fontWeight == FontStyle.BOLD)) ? true : null);
            };
            if (!_arg_3.fontStyle){
                _local_5.italic = (((_local_4.fontStyle == FontStyle.ITALIC)) ? true : null);
            };
            if (!_arg_3.textDecoration){
                _local_5.underline = (((_local_4.textDecoration == TextStyle._SafeStr_9113)) ? true : null);
            };
            if (!_arg_3.textIndent){
                _local_5.indent = _local_4.textIndent;
            };
            if (!_arg_3.leading){
                _local_5.leading = _local_4.leading;
            };
            if (!_arg_3.kerning){
                _local_5.kerning = _local_4.kerning;
            };
            if (!_arg_3.letterSpacing){
                _local_5.letterSpacing = _local_4.letterSpacing;
            };
            if (!_arg_3.antiAliasType){
                _arg_1.antiAliasType = (((_local_4.antiAliasType == AntiAliasType.ADVANCED)) ? AntiAliasType.ADVANCED : AntiAliasType.NORMAL);
            };
            if (!_arg_3.sharpness){
                _arg_1.sharpness = int(_local_4.sharpness);
            };
            if (!_arg_3.thickness){
                _arg_1.thickness = int(_local_4.thickness);
            };
            if (((!(_local_4.fontWeight)) && (!(_arg_3.fontWeight)))){
                _local_5.bold = false;
            };
            if (((!(_local_4.fontStyle)) && (!(_arg_3.fontStyle)))){
                _local_5.italic = false;
            };
            if (((!(_local_4.textDecoration)) && (!(_arg_3.textDecoration)))){
                _local_5.underline = false;
            };
            if (((!(_local_4.textIndent)) && (!(_arg_3.textIndent)))){
                _local_5.indent = 0;
            };
            if (((!(_local_4.leading)) && (!(_arg_3.leading)))){
                _local_5.leading = 0;
            };
            if (((!(_local_4.kerning)) && (!(_arg_3.kerning)))){
                _local_5.kerning = false;
            };
            if (((!(_local_4.letterSpacing)) && (!(_arg_3.letterSpacing)))){
                _local_5.letterSpacing = 0;
            };
            if (((!(_local_4.antiAliasType)) && (!(_arg_3.antiAliasType)))){
                _arg_1.antiAliasType = AntiAliasType.NORMAL;
            };
            if (((!(_local_4.sharpness)) && (!(_arg_3.sharpness)))){
                _arg_1.sharpness = 0;
            };
            if (((!(_local_4.thickness)) && (!(_arg_3.thickness)))){
                _arg_1.thickness = 0;
            };
            _arg_1.setTextFormat(_local_5);
            _arg_1.embedFonts = FontEnum.isEmbeddedFont(_local_5.font);
            _arg_1.defaultTextFormat = _local_5;
        }
        protected static function createPropertySetterTable():Dictionary
        {
            var _local_1:Dictionary = new Dictionary();
            _local_1["always_show_selection"] = setAlwaysShowSelection;
            _local_1["background"] = setTextBackground;
            _local_1["background_color"] = setTextBackgroundColor;
            _local_1["bold"] = setBold;
            _local_1["border"] = setBorder;
            _local_1["border_color"] = setBorderColor;
            _local_1["condense_white"] = setCondenseWhite;
            _local_1["default_text_format"] = setDefaultTextFormat;
            _local_1["font_face"] = setFontFace;
            _local_1["font_size"] = setFontSize;
            _local_1["grid_fit_type"] = setGridFitType;
            _local_1["html_text"] = setHtmlText;
            _local_1["italic"] = setItalic;
            _local_1["kerning"] = setKerning;
            _local_1["max_chars"] = setMaxChars;
            _local_1["multiline"] = setMultiline;
            _local_1["restrict"] = setRestrict;
            _local_1["spacing"] = setSpacing;
            _local_1["sharpness"] = setSharpness;
            _local_1["thickness"] = setThickness;
            _local_1["underline"] = setUnderline;
            _local_1["word_wrap"] = setWordWrap;
            _local_1["margins"] = setTextMarginMap;
            _local_1[PropertyDefaults._SafeStr_9116] = setAntiAliasType;
            _local_1[PropertyDefaults._SafeStr_9117] = setAutoSize;
            _local_1[PropertyDefaults._SafeStr_9118] = setMouseWheelEnabled;
            _local_1[PropertyDefaults._SafeStr_9119] = setTextColor;
            _local_1[PropertyDefaults._SafeStr_9120] = setTextStyleString;
            _local_1[PropertyDefaults._SafeStr_9121] = setMarginLeft;
            _local_1[PropertyDefaults._SafeStr_9122] = setMarginTop;
            _local_1[PropertyDefaults._SafeStr_9123] = setMarginRight;
            _local_1[PropertyDefaults._SafeStr_9124] = setMarginBottom;
            return (_local_1);
        }

        public function get antiAliasType():String
        {
            return (this._field.antiAliasType);
        }
        public function get autoSize():String
        {
            return (this._autoSize);
        }
        public function get bold():Boolean
        {
            return (this._field.defaultTextFormat.bold);
        }
        public function get border():Boolean
        {
            return (this._field.border);
        }
        public function get borderColor():uint
        {
            return (this._field.borderColor);
        }
        public function get bottomScrollV():int
        {
            return (this._field.bottomScrollV);
        }
        public function get defaultTextFormat():TextFormat
        {
            return (this._field.defaultTextFormat);
        }
        public function get embedFonts():Boolean
        {
            return (this._field.embedFonts);
        }
        public function get fontFace():String
        {
            return (this._field.defaultTextFormat.font);
        }
        public function get fontSize():uint
        {
            return ((((this._field.defaultTextFormat.size == null)) ? 12 : uint(this._field.defaultTextFormat.size)));
        }
        public function get gridFitType():String
        {
            return (this._field.gridFitType);
        }
        public function get htmlText():String
        {
            return (this._field.htmlText);
        }
        public function get italic():Boolean
        {
            return (this._field.defaultTextFormat.italic);
        }
        public function get kerning():Boolean
        {
            return (this._field.defaultTextFormat.kerning);
        }
        public function get length():int
        {
            return (this._field.length);
        }
        public function get margins():IMargins
        {
            return (this._margins);
        }
        public function get maxChars():int
        {
            return (this._field.maxChars);
        }
        public function get multiline():Boolean
        {
            return (this._field.multiline);
        }
        public function get numLines():int
        {
            return (this._field.numLines);
        }
        public function get restrict():String
        {
            return (this._field.restrict);
        }
        public function get sharpness():Number
        {
            return (this._field.sharpness);
        }
        public function get spacing():Number
        {
            return (Number(this._field.defaultTextFormat.letterSpacing));
        }
        public function get text():String
        {
            return ((((this._field)!=null) ? this._field.text : ""));
        }
        public function get textColor():uint
        {
            return (this._field.textColor);
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
            return (this._field.textHeight);
        }
        public function get textWidth():Number
        {
            return (this._field.textWidth);
        }
        public function get textStyle():TextStyle
        {
            return (TextStyleManager.getStyle(this._SafeStr_9073));
        }
        public function get thickness():Number
        {
            return (this._field.thickness);
        }
        public function get underline():Boolean
        {
            return (this._field.defaultTextFormat.underline);
        }
        public function get wordWrap():Boolean
        {
            return (this._field.wordWrap);
        }
        public function get textField():TextField
        {
            return (this._field);
        }
        public function get immediateClickMode():Boolean
        {
            return (this._immediateClickMode);
        }
        public function get scrollH():Number
        {
            return (this._scrollH);
        }
        public function get scrollV():Number
        {
            return (this._scrollV);
        }
        public function get maxScrollH():int
        {
            return (this._field.maxScrollH);
        }
        public function get maxScrollV():int
        {
            return (Math.max((this._field.textHeight - height), 0));
        }
        public function set antiAliasType(_arg_1:String):void
        {
            setAntiAliasType(this, _arg_1);
        }
        public function set autoSize(_arg_1:String):void
        {
            setAutoSize(this, _arg_1);
        }
        public function set bold(_arg_1:Boolean):void
        {
            setBold(this, _arg_1);
        }
        public function set border(_arg_1:Boolean):void
        {
            setBorder(this, _arg_1);
        }
        public function set borderColor(_arg_1:uint):void
        {
            setBorderColor(this, _arg_1);
        }
        public function set defaultTextFormat(_arg_1:TextFormat):void
        {
            setDefaultTextFormat(this, _arg_1);
        }
        public function set embedFonts(_arg_1:Boolean):void
        {
            setEmbedFonts(this, _arg_1);
        }
        public function set fontFace(_arg_1:String):void
        {
            setFontFace(this, _arg_1);
        }
        public function set fontSize(_arg_1:uint):void
        {
            setFontSize(this, _arg_1);
        }
        public function set gridFitType(_arg_1:String):void
        {
            setGridFitType(this, _arg_1);
        }
        public function set htmlText(_arg_1:String):void
        {
            setHtmlText(this, _arg_1);
        }
        public function set italic(_arg_1:Boolean):void
        {
            setItalic(this, _arg_1);
        }
        public function set kerning(_arg_1:Boolean):void
        {
            setKerning(this, _arg_1);
        }
        public function set maxChars(_arg_1:int):void
        {
            setMaxChars(this, _arg_1);
        }
        public function set multiline(_arg_1:Boolean):void
        {
            setMultiline(this, _arg_1);
        }
        public function set restrict(_arg_1:String):void
        {
            setRestrict(this, _arg_1);
        }
        public function set sharpness(_arg_1:Number):void
        {
            setSharpness(this, _arg_1);
        }
        public function set spacing(_arg_1:Number):void
        {
            setSpacing(this, _arg_1);
        }
        public function set textColor(_arg_1:uint):void
        {
            setTextColor(this, _arg_1);
        }
        public function set textBackground(_arg_1:Boolean):void
        {
            setTextBackground(this, _arg_1);
        }
        public function set textBackgroundColor(_arg_1:uint):void
        {
            setTextBackgroundColor(this, _arg_1);
        }
        public function set textStyle(_arg_1:TextStyle):void
        {
            setTextStyle(this, _arg_1);
        }
        public function set thickness(_arg_1:Number):void
        {
            setThickness(this, _arg_1);
        }
        public function set underline(_arg_1:Boolean):void
        {
            setUnderline(this, _arg_1);
        }
        public function set wordWrap(_arg_1:Boolean):void
        {
            setWordWrap(this, _arg_1);
        }
        public function set scrollH(_arg_1:Number):void
        {
            this._scrollH = _arg_1;
            this._field.scrollH = (this._scrollH * Number(this._field.maxScrollH));
            this.refreshTextImage();
        }
        public function set scrollV(_arg_1:Number):void
        {
            if (_arg_1 > this._scrollV){
                this._scrollV = _arg_1;
                this._field.scrollV = Math.max(this._field.scrollV, ((_arg_1 * this._field.maxScrollV) + 1));
                this.refreshTextImage();
            }
            else {
                if (_arg_1 < this._scrollV){
                    this._scrollV = _arg_1;
                    this._field.scrollV = Math.min(this._field.scrollV, ((_arg_1 * this._field.maxScrollV) - 1));
                    this.refreshTextImage();
                };
            };
        }
        public function get visibleRegion():Rectangle
        {
            return (new Rectangle((this._scrollH * this.maxScrollH), (this._scrollV * this.maxScrollV), width, height));
        }
        public function get scrollableRegion():Rectangle
        {
            return (new Rectangle(0, 0, (this.maxScrollH + width), (this.maxScrollV + height)));
        }
        public function get scrollStepH():Number
        {
            return (10);
        }
        public function get scrollStepV():Number
        {
            return ((this._field.textHeight / this._field.numLines));
        }
        public function set scrollStepH(_arg_1:Number):void
        {
        }
        public function set scrollStepV(_arg_1:Number):void
        {
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
                if (this._field != null){
                    this._field.text = _caption;
                    this.refreshTextImage();
                };
            };
        }
        override public function set caption(_arg_1:String):void
        {
            this.text = _arg_1;
        }
        override public function set color(_arg_1:uint):void
        {
            super.color = _arg_1;
            this._field.backgroundColor = _arg_1;
        }
        override public function set background(_arg_1:Boolean):void
        {
            super.background = _arg_1;
            this._field.background = _arg_1;
        }
        public function set localization(_arg_1:String):void
        {
            if (((!((_arg_1 == null))) && (!((this._field == null))))){
                this._field.text = _arg_1;
                this.refreshTextImage();
            };
        }
        public function set immediateClickMode(_arg_1:Boolean):void
        {
            var _local_2:IGraphicContext;
            if (_arg_1 != this._immediateClickMode){
                this._immediateClickMode = _arg_1;
                _local_2 = getGraphicContext(false);
                if (_local_2){
                    if (this._immediateClickMode){
                        _local_2.mouse = true;
                        _local_2.addEventListener(MouseEvent.CLICK, this.immediateClickHandler);
                    }
                    else {
                        _local_2.mouse = false;
                        _local_2.removeEventListener(MouseEvent.CLICK, this.immediateClickHandler);
                    };
                };
            };
        }
        override public function clone():IWindow
        {
            var _local_1:TextController = (super.clone() as TextController);
            _local_1._field.backgroundColor = color;
            _local_1._field.background = background;
            _local_1._scrollH = this._scrollH;
            _local_1._scrollV = this._scrollV;
            _local_1._margins = this._margins.clone(_local_1.setTextMargins);
            _local_1._autoSize = this._autoSize;
            _local_1._SafeStr_9071 = this._SafeStr_9071;
            return (_local_1);
        }
        override public function dispose():void
        {
            this.immediateClickMode = false;
            TextStyleManager.events.removeEventListener(Event.CHANGE, this.onTextStyleChanged);
            if (this._SafeStr_9071){
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
            };
            if (this._margins != null){
                this._margins.dispose();
                this._margins = null;
            };
            this._field = null;
            super.dispose();
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            if (!this._SafeStr_9069){
                if (_arg_2.type == WindowEvent.WE_RESIZED){
                    this.refreshTextImage(true);
                };
            };
            return (super.update(_arg_1, _arg_2));
        }
        protected function immediateClickHandler(_arg_1:Event):void
        {
            var _local_6:IWindow;
            var _local_2:MouseEvent = (_arg_1 as MouseEvent);
            var _local_3:Point = new Point(_local_2.stageX, _local_2.stageY);
            var _local_4:Array = [];
            desktop.groupChildrenUnderPoint(_local_3, _local_4);
            while (_local_4.length > 0) {
                _local_6 = _local_4.pop();
                if (_local_6 == this) break;
                if (_local_6.getParamFlag(WindowParam._SafeStr_7434)){
                    return;
                };
            };
            getRelativeMousePosition(_local_3);
            var _local_5:WindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this, null, _local_3.x, _local_3.y, _local_2.stageX, _local_2.stageY, _local_2.altKey, _local_2.ctrlKey, _local_2.shiftKey, _local_2.buttonDown, _local_2.delta);
            if (_events){
                _events.dispatchEvent(_local_5);
            };
            if (!_local_5.isWindowOperationPrevented()){
                if (procedure != null){
                    procedure(_local_5, this);
                };
            };
            _arg_1.stopImmediatePropagation();
            _local_5.recycle();
        }
        protected function refreshTextImage(_arg_1:Boolean=false):void
        {
            var _local_8:WindowEvent;
            if (this._SafeStr_9069){
                return;
            };
            this._SafeStr_9069 = true;
            var _local_2:int = (this._margins.left + this._margins.right);
            var _local_3:int = (this._margins.top + this._margins.bottom);
            var _local_4:int = (_rectangle.width - _local_2);
            var _local_5:int = (_rectangle.height - _local_3);
            var _local_6:int = (Math.floor(this._field.width) + ((this._field.border) ? 1 : 0));
            var _local_7:Boolean;
            if (_local_6 != _local_4){
                if (this._autoSize == TextFieldAutoSize.LEFT){
                    setRectangle(_rectangle.x, _rectangle.y, (_local_6 + _local_2), (Math.floor(this._field.height) + _local_3));
                    _local_7 = true;
                }
                else {
                    if (this._autoSize != TextFieldAutoSize.RIGHT){
                        if (this._autoSize != TextFieldAutoSize.CENTER){
                            this._field.width = (_local_4 - ((this._field.border) ? 1 : 0));
                            this._field.height = (_local_5 - ((this._field.border) ? 1 : 0));
                        };
                    };
                };
            };
            if ((this._field.height + ((this._field.border) ? 1 : 0)) < _local_5){
                if (this._autoSize == TextFieldAutoSize.NONE){
                    this._field.height = (_local_5 - ((this._field.border) ? 1 : 0));
                }
                else {
                    height = (Math.floor(this._field.height) + _local_3);
                    _local_7 = true;
                };
            }
            else {
                if ((this._field.height + ((this._field.border) ? 1 : 0)) > _local_5){
                    if (this._autoSize != TextFieldAutoSize.NONE){
                        height = (Math.floor(this._field.height) + _local_3);
                        _local_7 = true;
                    };
                };
            };
            this._SafeStr_9069 = false;
            _context.invalidate(this, _rectangle, WindowRedrawFlag._SafeStr_9133);
            if (((((!(_local_7)) && (!(_arg_1)))) && (_events))){
                _local_8 = WindowEvent.allocate(WindowEvent.WE_RESIZED, this, null);
                _events.dispatchEvent(_local_8);
                _local_8.recycle();
            };
        }
        public function appendText(_arg_1:String):void
        {
            this._field.appendText(_arg_1);
            this.refreshTextImage();
        }
        public function getCharBoundaries(_arg_1:int):Rectangle
        {
            return (this._field.getCharBoundaries(_arg_1));
        }
        public function getCharIndexAtPoint(_arg_1:Number, _arg_2:Number):int
        {
            return (this._field.getCharIndexAtPoint(_arg_1, _arg_2));
        }
        public function getFirstCharInParagraph(_arg_1:int):int
        {
            return (this._field.getFirstCharInParagraph(_arg_1));
        }
        public function getImageReference(_arg_1:String):DisplayObject
        {
            return (this._field.getImageReference(_arg_1));
        }
        public function getLineIndexAtPoint(_arg_1:Number, _arg_2:Number):int
        {
            return (this._field.getLineIndexAtPoint(_arg_1, _arg_2));
        }
        public function getLineIndexOfChar(_arg_1:int):int
        {
            return (this._field.getLineIndexOfChar(_arg_1));
        }
        public function getLineLength(_arg_1:int):int
        {
            return (this._field.getLineLength(_arg_1));
        }
        public function getLineMetrics(_arg_1:int):TextLineMetrics
        {
            return (this._field.getLineMetrics(_arg_1));
        }
        public function getLineOffset(_arg_1:int):int
        {
            return (this._field.getLineOffset(_arg_1));
        }
        public function getLineText(_arg_1:int):String
        {
            return (this._field.getLineText(_arg_1));
        }
        public function getParagraphLength(_arg_1:int):int
        {
            return (this._field.getParagraphLength(_arg_1));
        }
        public function getTextFormat(_arg_1:int=-1, _arg_2:int=-1):TextFormat
        {
            return (this._field.getTextFormat(_arg_1, _arg_2));
        }
        public function replaceText(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            this._field.replaceText(_arg_1, _arg_2, _arg_3);
            this.refreshTextImage();
        }
        public function setTextFormat(_arg_1:TextFormat, _arg_2:int=-1, _arg_3:int=-1):void
        {
            this._field.setTextFormat(_arg_1, _arg_2, _arg_3);
            this.refreshTextImage();
        }
        public function setTextMargins(_arg_1:IMargins):void
        {
            if (_arg_1 != this._margins){
                this._margins.dispose();
                this._margins = new TextMargins(_arg_1.left, _arg_1.top, _arg_1.right, _arg_1.bottom, this.setTextMargins);
            };
            this.refreshTextImage();
        }
        private function onTextStyleChanged(_arg_1:Event):void
        {
            setTextFormatting(this._field, this._SafeStr_9073, this._explicitStyle);
            this.refreshTextImage();
        }
        protected function parseVariableSet(_arg_1:XML):void
        {
            var _local_2:String;
            var _local_3:Function;
            var _local_4:Map;
            if (_arg_1 != null){
                _local_4 = new Map();
                XMLVariableParser.parseVariableList(_arg_1.children(), _local_4);
                this._SafeStr_9069 = true;
                for (_local_2 in _local_4) {
                    _local_3 = _SafeStr_9066[_local_2];
                    if (_local_3 != null){
                        (_local_3(this, _local_4[_local_2]));
                    };
                };
                this._SafeStr_9069 = false;
            };
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:Function;
            var _local_3:PropertyStruct;
            this._SafeStr_9069 = true;
            for each (_local_3 in _arg_1) {
                _local_2 = _SafeStr_9066[_local_3.key];
                if (_local_2 != null){
                    (_local_2(this, _local_3.value));
                };
            };
            this._SafeStr_9069 = false;
            super.properties = _arg_1;
            this.refreshTextImage();
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            var _local_2:TextStyle = TextStyleManager.getStyle(this._SafeStr_9073);
            _local_1.push(new PropertyStruct("always_show_selection", this._field.alwaysShowSelection, PropertyStruct._SafeStr_8996, !((this._field.alwaysShowSelection == false))));
            _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9116, this._field.antiAliasType, PropertyStruct._SafeStr_8998, !((this._field.antiAliasType == _local_2.antiAliasType)), PropertyDefaults._SafeStr_9135));
            _local_1.push((((this._autoSize)!=PropertyDefaults._SafeStr_9136) ? new PropertyStruct(PropertyDefaults._SafeStr_9117, this._autoSize, PropertyStruct._SafeStr_8998, true, PropertyDefaults._SafeStr_9137) : PropertyDefaults._SafeStr_9138));
            _local_1.push(new PropertyStruct("border", this._field.border, PropertyStruct._SafeStr_8996, (this._field.border == true)));
            _local_1.push(new PropertyStruct("border_color", this._field.borderColor, PropertyStruct._SafeStr_8991, !((this._field.borderColor == 0))));
            _local_1.push(new PropertyStruct("condense_white", this._field.condenseWhite, PropertyStruct._SafeStr_8996, !((this._field.condenseWhite == false))));
            _local_1.push(new PropertyStruct("font_face", this.defaultTextFormat.font, PropertyStruct._SafeStr_8998, !((this.defaultTextFormat.font == _local_2.fontFamily))));
            _local_1.push(new PropertyStruct("font_size", this.defaultTextFormat.size, PropertyStruct._SafeStr_8993, !((this.defaultTextFormat.size == _local_2.fontSize))));
            _local_1.push((((this._field.gridFitType)!=PropertyDefaults._SafeStr_9139) ? new PropertyStruct(PropertyDefaults._SafeStr_9140, this._field.gridFitType, PropertyStruct._SafeStr_8998, true, PropertyDefaults._SafeStr_9141) : PropertyDefaults._SafeStr_9142));
            _local_1.push((((((_local_2.color)!=null) ? !((this._field.textColor == _local_2.color)) : !((this._field.textColor == PropertyDefaults._SafeStr_9143)))) ? new PropertyStruct(PropertyDefaults._SafeStr_9119, this._field.textColor, PropertyStruct._SafeStr_8991, true) : PropertyDefaults._SafeStr_9144));
            _local_1.push((((this._SafeStr_9073)!=TextStyleManager._SafeStr_9115) ? new PropertyStruct(PropertyDefaults._SafeStr_9120, this._SafeStr_9073, PropertyStruct._SafeStr_8998, true, PropertyDefaults._SafeStr_9145) : PropertyDefaults._SafeStr_9146));
            _local_1.push((((this._margins.left)!=PropertyDefaults._SafeStr_9147) ? new PropertyStruct(PropertyDefaults._SafeStr_9121, this._margins.left, PropertyStruct._SafeStr_8992, true) : PropertyDefaults._SafeStr_9148));
            _local_1.push((((this._margins.top)!=PropertyDefaults._SafeStr_9149) ? new PropertyStruct(PropertyDefaults._SafeStr_9122, this._margins.top, PropertyStruct._SafeStr_8992, true) : PropertyDefaults._SafeStr_8376));
            _local_1.push((((this._margins.right)!=PropertyDefaults._SafeStr_9150) ? new PropertyStruct(PropertyDefaults._SafeStr_9123, this._margins.right, PropertyStruct._SafeStr_8992, true) : PropertyDefaults._SafeStr_8377));
            _local_1.push((((this._margins.bottom)!=PropertyDefaults._SafeStr_9151) ? new PropertyStruct(PropertyDefaults._SafeStr_9124, this._margins.bottom, PropertyStruct._SafeStr_8992, true) : PropertyDefaults._SafeStr_8378));
            _local_1.push((((this._field.mouseWheelEnabled)!=PropertyDefaults._SafeStr_9152) ? new PropertyStruct(PropertyDefaults._SafeStr_9118, this._field.mouseWheelEnabled, PropertyStruct._SafeStr_8996, true) : PropertyDefaults._SafeStr_9153));
            _local_1.push(new PropertyStruct("max_chars", this._field.maxChars, PropertyStruct._SafeStr_8992, !((this._field.maxChars == 0))));
            _local_1.push(new PropertyStruct("multiline", this._field.multiline, PropertyStruct._SafeStr_8996, !((this._field.multiline == false))));
            _local_1.push(new PropertyStruct("restrict", this._field.restrict, PropertyStruct._SafeStr_8998, !((this._field.restrict == null))));
            _local_1.push(new PropertyStruct("sharpness", this._field.sharpness, PropertyStruct._SafeStr_8994, !((this._field.sharpness == 0))));
            _local_1.push(new PropertyStruct("thickness", this._field.thickness, PropertyStruct._SafeStr_8994, !((this._field.thickness == 0))));
            _local_1.push(new PropertyStruct("word_wrap", this._field.wordWrap, PropertyStruct._SafeStr_8996, !((this._field.wordWrap == false))));
            _local_1.push(new PropertyStruct("bold", !((this._field.defaultTextFormat.bold == false)), PropertyStruct._SafeStr_8996, ((!((this._field.defaultTextFormat.bold == false))) && (!((_local_2.fontWeight == FontStyle.BOLD))))));
            _local_1.push(new PropertyStruct("italic", !((this._field.defaultTextFormat.italic == false)), PropertyStruct._SafeStr_8996, ((!((this._field.defaultTextFormat.italic == false))) && (!((_local_2.fontStyle == FontStyle.ITALIC))))));
            _local_1.push(new PropertyStruct("underline", !((this._field.defaultTextFormat.underline == false)), PropertyStruct._SafeStr_8996, ((!((this._field.defaultTextFormat.underline == false))) && (!((_local_2.textDecoration == "underline"))))));
            _local_1.push(new PropertyStruct("kerning", !((this._field.defaultTextFormat.kerning == false)), PropertyStruct._SafeStr_8996, ((!((this._field.defaultTextFormat.kerning == false))) && (!(_local_2.kerning)))));
            _local_1.push(new PropertyStruct("spacing", this._field.defaultTextFormat.letterSpacing, PropertyStruct._SafeStr_8994, !((this._field.defaultTextFormat.letterSpacing == 0))));
            return (_local_1);
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// XMLVariableParser = "_-pR" (String#24252, DoABC#2)
// ILocalizable = "_-3Dn" (String#2024, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// FontEnum = "_-15T" (String#4985, DoABC#2)
// ITextFieldContainer = "_-kP" (String#8609, DoABC#2)
// TextController = "_-2vO" (String#7184, DoABC#2)
// IGraphicContext = "_-2I9" (String#1849, DoABC#2)
// IMargins = "_-1mu" (String#1757, DoABC#2)
// TextStyle = "_-0qh" (String#16074, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// TextMargins = "_-2Jl" (String#19801, DoABC#2)
// TextStyleManager = "_-a7" (String#23636, DoABC#2)
// _scrollV = "_-0Ir" (String#1449, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// fontFace = "_-hD" (String#2155, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// equals = "_-1fP" (String#18113, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _SafeStr_8376 = "_-2JG" (String#6425, DoABC#2)
// _SafeStr_8377 = "_-2RO" (String#6593, DoABC#2)
// _SafeStr_8378 = "_-v6" (String#8786, DoABC#2)
// _SafeStr_8991 = "_-23W" (String#19156, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8993 = "_-O-" (String#23167, DoABC#2)
// _SafeStr_8994 = "_-0yp" (String#16384, DoABC#2)
// _SafeStr_8996 = "_-0gH" (String#15685, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// isEmbeddedFont = "_-2kf" (String#20871, DoABC#2)
// scrollStepH = "_-1Qu" (String#5371, DoABC#2)
// scrollStepV = "_-2Ee" (String#6333, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// _SafeStr_9066 = "_-YA" (String#23569, DoABC#2)
// createPropertySetterTable = "_-30Y" (String#21524, DoABC#2)
// _scrollH = "_-wC" (String#24538, DoABC#2)
// _SafeStr_9069 = "_-0LE" (String#14883, DoABC#2)
// _margins = "_-063" (String#1402, DoABC#2)
// _SafeStr_9071 = "_-2cp" (String#6807, DoABC#2)
// _immediateClickMode = "_-1Hx" (String#17190, DoABC#2)
// _SafeStr_9073 = "_-CO" (String#7924, DoABC#2)
// setTextMargins = "_-2Ui" (String#6660, DoABC#2)
// setTextFormatting = "_-31T" (String#21558, DoABC#2)
// onTextStyleChanged = "_-2Jp" (String#1854, DoABC#2)
// _rectangle = "_-0-q" (String#3560, DoABC#2)
// setAntiAliasType = "_-1jG" (String#18255, DoABC#2)
// refreshTextImage = "_-0hP" (String#4454, DoABC#2)
// setAlwaysShowSelection = "_-04C" (String#14210, DoABC#2)
// setAutoSize = "_-1Zp" (String#17883, DoABC#2)
// setTextBackground = "_-0eS" (String#15604, DoABC#2)
// setBold = "_-1yK" (String#18901, DoABC#2)
// setBorder = "_-0o5" (String#15980, DoABC#2)
// setBorderColor = "_-2eY" (String#20627, DoABC#2)
// setCondenseWhite = "_-2gT" (String#20708, DoABC#2)
// setDefaultTextFormat = "_-0Vl" (String#15268, DoABC#2)
// setEmbedFonts = "_-0Vd" (String#15264, DoABC#2)
// setFontFace = "_-0Gf" (String#14708, DoABC#2)
// setFontSize = "_-1UU" (String#17685, DoABC#2)
// setGridFitType = "_-1M8" (String#17364, DoABC#2)
// setHtmlText = "_-33V" (String#21642, DoABC#2)
// setItalic = "_-0C6" (String#14532, DoABC#2)
// setKerning = "_-1P5" (String#17471, DoABC#2)
// setTextMarginMap = "_-sB" (String#8740, DoABC#2)
// setMarginLeft = "_-1Z8" (String#17857, DoABC#2)
// setMarginTop = "_-0jv" (String#15825, DoABC#2)
// setMarginRight = "_-229" (String#19097, DoABC#2)
// setMarginBottom = "_-Be" (String#22676, DoABC#2)
// setMaxChars = "_-2VM" (String#20255, DoABC#2)
// setMouseWheelEnabled = "_-qu" (String#24310, DoABC#2)
// setMultiline = "_-RH" (String#23295, DoABC#2)
// setRestrict = "com.sulake.habbo.communication.messages.outgoing.poll-" (String#17852, DoABC#2)
// setSharpness = "_-1a1" (String#17894, DoABC#2)
// setSpacing = "_-2fF" (String#20656, DoABC#2)
// setTextColor = "_-C-" (String#22690, DoABC#2)
// setTextStyle = "_-2f7" (String#20651, DoABC#2)
// findMatchingTextStyle = "_-2x4" (String#21352, DoABC#2)
// setTextStyleString = "_-1Xc" (String#17799, DoABC#2)
// setStyle = "_-17f" (String#16761, DoABC#2)
// setThickness = "_-2BF" (String#19453, DoABC#2)
// setUnderline = "_-2Fd" (String#19628, DoABC#2)
// _SafeStr_9113 = "_-059" (String#14249, DoABC#2)
// setWordWrap = "_-2b2" (String#20489, DoABC#2)
// _SafeStr_9115 = "_-1hf" (String#18196, DoABC#2)
// _SafeStr_9116 = "_-hP" (String#23945, DoABC#2)
// _SafeStr_9117 = "_-1OD" (String#17443, DoABC#2)
// _SafeStr_9118 = "_-2G4" (String#19646, DoABC#2)
// _SafeStr_9119 = "_-3Cl" (String#21985, DoABC#2)
// _SafeStr_9120 = "_-2Zs" (String#20434, DoABC#2)
// _SafeStr_9121 = "_-Gc" (String#22874, DoABC#2)
// _SafeStr_9122 = "_-3-3" (String#21463, DoABC#2)
// _SafeStr_9123 = "_-Vu" (String#23489, DoABC#2)
// _SafeStr_9124 = "_-tF" (String#24416, DoABC#2)
// textBackground = "_-IA" (String#2081, DoABC#2)
// mouse = "_-2qv" (String#7094, DoABC#2)
// immediateClickHandler = "_-0-p" (String#3559, DoABC#2)
// getParamFlag = "_-38B" (String#7475, DoABC#2)
// getRelativeMousePosition = "_-1wW" (String#1785, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// isWindowOperationPrevented = "_-27I" (String#19304, DoABC#2)
// setRectangle = "_-Vb" (String#23476, DoABC#2)
// _SafeStr_9133 = "_-2xy" (String#21391, DoABC#2)
// parseVariableSet = "_-288" (String#19335, DoABC#2)
// _SafeStr_9135 = "_-38p" (String#21835, DoABC#2)
// _SafeStr_9136 = "_-30W" (String#21522, DoABC#2)
// _SafeStr_9137 = "_-2CQ" (String#19501, DoABC#2)
// _SafeStr_9138 = "_-Cp" (String#22719, DoABC#2)
// _SafeStr_9139 = "_-0VX" (String#15261, DoABC#2)
// _SafeStr_9140 = "_-0Qr" (String#15096, DoABC#2)
// _SafeStr_9141 = "_-ZS" (String#23613, DoABC#2)
// _SafeStr_9142 = "_-23M" (String#19146, DoABC#2)
// _SafeStr_9143 = "_-x6" (String#24573, DoABC#2)
// _SafeStr_9144 = "_-0aD" (String#15448, DoABC#2)
// _SafeStr_9145 = "_-Ed" (String#22799, DoABC#2)
// _SafeStr_9146 = "_-09z" (String#14446, DoABC#2)
// _SafeStr_9147 = "_-iS" (String#23976, DoABC#2)
// _SafeStr_9148 = "_-299" (String#19371, DoABC#2)
// _SafeStr_9149 = "_-30" (String#21500, DoABC#2)
// _SafeStr_9150 = "_-aC" (String#23640, DoABC#2)
// _SafeStr_9151 = "_-Eb" (String#22797, DoABC#2)
// _SafeStr_9152 = "_-Eq" (String#22807, DoABC#2)
// _SafeStr_9153 = "_-0Ez" (String#14644, DoABC#2)


