
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.PropertyDefaults;
    import flash.text.StyleSheet;
    import flash.text.TextFieldType;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.net.URLRequest;
    import flash.external.ExternalInterface;
    import flash.net.navigateToURL;
    import com.sulake.core.window.enum.LinkTarget;
    import flash.events.TextEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowLinkEvent;
    import flash.events.Event;
    import com.sulake.core.window.utils.PropertyStruct;

    public class HTMLTextController extends TextFieldController implements IHTMLTextWindow 
    {

        private static var _SafeStr_9183:String = PropertyDefaults.HTML_LINK_TARGET_VALUE;

        private var _linkTarget:String;
        private var _htmlStyleSheetString:String = null;
        private var _SafeStr_9186:StyleSheet = null;

        public function HTMLTextController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            this._linkTarget = PropertyDefaults.HTML_LINK_TARGET_VALUE;
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
            this.immediateClickMode = true;
            _field.type = TextFieldType.DYNAMIC;
            _field.mouseEnabled = true;
            _field.selectable = false;
        }
        public static function set defaultLinkTarget(_arg_1:String):void
        {
            _SafeStr_9183 = _arg_1;
        }
        public static function get defaultLinkTarget():String
        {
            return (_SafeStr_9183);
        }
        private static function HTMLTextController(_arg_1:HTMLTextController, _arg_2:String):void
        {
            var _local_3:StyleSheet;
            if (_arg_1 == null){
                return;
            };
            if (_arg_1._htmlStyleSheetString == _arg_2){
                return;
            };
            _arg_1._htmlStyleSheetString = _arg_2;
            _arg_1._SafeStr_9186 = null;
            if (_arg_1._htmlStyleSheetString != null){
                _local_3 = new StyleSheet();
                _local_3.parseCSS(_arg_1._htmlStyleSheetString);
                _arg_1._SafeStr_9186 = _local_3;
            };
        }
        private static function HTMLTextController(_arg_1:String):String
        {
            var _local_2:RegExp;
            _local_2 = /<a[^>]+(http:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            _arg_1 = _arg_1.replace(_local_2, "<a href='event:$1'>$2</a>");
            _local_2 = /<a[^>]+(https:\/\/[^"']+)['"][^>]*>(.*)<\/a>/gi;
            return (_arg_1.replace(_local_2, "<a href='event:$1'>$2</a>"));
        }
        private static function HTMLTextController(_arg_1:String, _arg_2:String):void
        {
            var _local_4:String;
            var _local_5:*;
            if (_arg_2 == null){
                _arg_2 = _SafeStr_9183;
            };
            var _local_3:URLRequest = new URLRequest(_arg_1);
            if (!ExternalInterface.available){
                navigateToURL(_local_3, _arg_2);
            }
            else {
                _local_4 = String(ExternalInterface.call("function() { return navigator.userAgent; }")).toLowerCase();
                if ((((((((_local_4.indexOf("safari") > -1)) || ((_local_4.indexOf("chrome") > -1)))) || ((_local_4.indexOf("firefox") > -1)))) || ((((_local_4.indexOf("msie") > -1)) && ((uint(_local_4.substr((_local_4.indexOf("msie") + 5), 3)) >= 7)))))){
                    _local_5 = ExternalInterface.call((((("function() {var win = window.open('" + _local_3.url) + "', '") + _arg_2) + "'); if (win) { win.focus();} return true; }"));
                    if (_local_5){
                        Logger.log(("Opened web page url = " + _arg_1));
                    };
                }
                else {
                    navigateToURL(_local_3, _arg_2);
                };
            };
        }

        public function set linkTarget(_arg_1:String):void
        {
            if (PropertyDefaults._SafeStr_9190.indexOf(_arg_1) > -1){
                this._linkTarget = _arg_1;
            };
        }
        public function get linkTarget():String
        {
            return ((((this._linkTarget == LinkTarget._SafeStr_3729)) ? defaultLinkTarget : this._linkTarget));
        }
        public function get htmlStyleSheetString():String
        {
            return (this._htmlStyleSheetString);
        }
        public function set htmlStyleSheetString(_arg_1:String):void
        {
            HTMLTextController(this, _arg_1);
        }
        override public function set immediateClickMode(_arg_1:Boolean):void
        {
            if (_arg_1 != _immediateClickMode){
                super.immediateClickMode = _arg_1;
                if (_immediateClickMode){
                    _field.addEventListener(TextEvent.LINK, this.TextController);
                }
                else {
                    _field.removeEventListener(TextEvent.LINK, this.TextController);
                };
            };
        }
        override public function set text(_arg_1:String):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_SafeStr_9071){
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _SafeStr_9071 = false;
            };
            _caption = _arg_1;
            if ((((_caption.charAt(0) == "$")) && ((_caption.charAt(1) == "{")))){
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _SafeStr_9071 = true;
            }
            else {
                if (_field != null){
                    _field.htmlText = HTMLTextController(_caption);
                    TextController();
                };
            };
        }
        override public function set localization(_arg_1:String):void
        {
            if (((!((_arg_1 == null))) && (!((_field == null))))){
                _field.htmlText = HTMLTextController(_arg_1);
                TextController();
            };
        }
        override public function set htmlText(_arg_1:String):void
        {
            if (_arg_1 == null){
                return;
            };
            if (_SafeStr_9071){
                context.removeLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _SafeStr_9071 = false;
            };
            _caption = _arg_1;
            if ((((_caption.charAt(0) == "$")) && ((_caption.charAt(1) == "{")))){
                context.registerLocalizationListener(_caption.slice(2, _caption.indexOf("}")), this);
                _SafeStr_9071 = true;
            }
            else {
                if (_field != null){
                    _field.htmlText = HTMLTextController(_caption);
                    _field.styleSheet = this._SafeStr_9186;
                    TextController();
                };
            };
        }
        override protected function TextController(_arg_1:Event):void
        {
            var _local_2:WindowEvent;
            if ((_arg_1 is TextEvent)){
                _local_2 = WindowLinkEvent.allocate(TextEvent(_arg_1).text, this, null);
                if (_events){
                    _events.dispatchEvent(_local_2);
                };
                if (!_local_2.isWindowOperationPrevented()){
                    if (procedure != null){
                        procedure(_local_2, this);
                    };
                };
                if (((!(_local_2.isWindowOperationPrevented())) && (!((this.linkTarget == LinkTarget._SafeStr_9192))))){
                    HTMLTextController(TextEvent(_arg_1).text, this.linkTarget);
                };
                _arg_1.stopImmediatePropagation();
                _local_2.recycle();
            }
            else {
                super.TextController(_arg_1);
            };
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._linkTarget != PropertyDefaults.HTML_LINK_TARGET_VALUE){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9193, this._linkTarget, PropertyStruct._SafeStr_8998, true, PropertyDefaults._SafeStr_9190));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9194);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                if (_local_2.key == PropertyDefaults._SafeStr_9193){
                    this._linkTarget = (_local_2.value as String);
                    break;
                };
                if (_local_2.key == "html_stylesheet"){
                    this.htmlStyleSheetString = (_local_2.value as String);
                    break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// IHTMLTextWindow = "_-RR" (String#8235, DoABC#2)
// TextFieldController = "_-2rC" (String#7105, DoABC#2)
// HTMLTextController = "_-0F9" (String#3855, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// LinkTarget = "_-1HG" (String#1650, DoABC#2)
// WindowLinkEvent = "_-1tZ" (String#5912, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)
// _caption = "_-p" (String#8690, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// _SafeStr_9071 = "_-2cp" (String#6807, DoABC#2)
// _immediateClickMode = "_-1Hx" (String#17190, DoABC#2)
// TextController = "_-0hP" (String#4454, DoABC#2)
// TextController = "_-0-p" (String#3559, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// isWindowOperationPrevented = "_-27I" (String#19304, DoABC#2)
// _SafeStr_9183 = "_-1Zu" (String#17887, DoABC#2)
// _linkTarget = "_-8x" (String#7841, DoABC#2)
// _htmlStyleSheetString = "_-2er" (String#20639, DoABC#2)
// _SafeStr_9186 = "_-2-Q" (String#18988, DoABC#2)
// defaultLinkTarget = "_-354" (String#21699, DoABC#2)
// HTMLTextController = "_-0mK" (String#15909, DoABC#2)
// HTMLTextController = "_-1tX" (String#18699, DoABC#2)
// _SafeStr_9190 = "_-2wA" (String#21317, DoABC#2)
// htmlStyleSheetString = "_-3Bo" (String#21954, DoABC#2)
// _SafeStr_9192 = "_-0WO" (String#15294, DoABC#2)
// _SafeStr_9193 = "_-23w" (String#19174, DoABC#2)
// _SafeStr_9194 = "_-2g1" (String#20694, DoABC#2)


