
package com.sulake.habbo.navigator
{
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import flash.ui.Keyboard;

    public class TextFieldManager 
    {

        private var _navigator:HabboNavigator;
        private var _input:ITextFieldWindow;
        private var _SafeStr_11824:Boolean;
        private var _SafeStr_11217:String = "";
        private var _SafeStr_12022:int;
        private var _SafeStr_12023:Function;
        private var _text:String = "";
        private var _SafeStr_12025:IWindowContainer;
        private var _orgTextBackground:Boolean;
        private var _SafeStr_12026:uint;
        private var _orgTextColor:uint;

        public function TextFieldManager(_arg_1:HabboNavigator, _arg_2:ITextFieldWindow, _arg_3:int=1000, _arg_4:Function=null, _arg_5:String=null)
        {
            this._navigator = _arg_1;
            this._input = _arg_2;
            this._SafeStr_12022 = _arg_3;
            this._SafeStr_12023 = _arg_4;
            if (_arg_5 != null){
                this._SafeStr_11824 = true;
                this._SafeStr_11217 = _arg_5;
                this._input.text = _arg_5;
            };
            Util.setProcDirectly(this._input, this.onInputClick);
            this._input.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.checkEnterPress);
            this._input.addEventListener(WindowEvent.WE_CHANGE, this.checkMaxLen);
            this._orgTextBackground = this._input.textBackground;
            this._SafeStr_12026 = this._input.textBackgroundColor;
            this._orgTextColor = this._input.textColor;
        }
        public function dispose():void
        {
            if (this._input){
                this._input.dispose();
                this._input = null;
            };
            if (this._SafeStr_12025){
                this._SafeStr_12025.dispose();
                this._SafeStr_12025 = null;
            };
            this._navigator = null;
        }
        public function checkMandatory(_arg_1:String):Boolean
        {
            if (!this.isInputValid()){
                this.displayError(_arg_1);
                return (false);
            };
            this.restoreBackground();
            return (true);
        }
        public function restoreBackground():void
        {
            this._input.textBackground = this._orgTextBackground;
            this._input.textBackgroundColor = this._SafeStr_12026;
            this._input.textColor = this._orgTextColor;
        }
        public function displayError(_arg_1:String):void
        {
            this._input.textBackground = true;
            this._input.textBackgroundColor = 4294021019;
            this._input.textColor = 0xFF000000;
            if (this._SafeStr_12025 == null){
                this._SafeStr_12025 = IWindowContainer(this._navigator.getXmlWindow("nav_error_popup"));
                this._navigator.refreshButton(this._SafeStr_12025, "popup_arrow_down", true, null, 0);
                IWindowContainer(this._input.parent).addChild(this._SafeStr_12025);
            };
            var _local_2:ITextWindow = ITextWindow(this._SafeStr_12025.findChildByName("error_text"));
            _local_2.text = _arg_1;
            _local_2.width = (_local_2.textWidth + 5);
            this._SafeStr_12025.findChildByName("border").width = (_local_2.width + 15);
            this._SafeStr_12025.width = (_local_2.width + 15);
            var _local_3:Point = new Point();
            this._input.getLocalPosition(_local_3);
            this._SafeStr_12025.x = _local_3.x;
            this._SafeStr_12025.y = ((_local_3.y - this._SafeStr_12025.height) + 3);
            var _local_4:IWindow = this._SafeStr_12025.findChildByName("popup_arrow_down");
            _local_4.x = ((this._SafeStr_12025.width / 2) - (_local_4.width / 2));
            this._SafeStr_12025.x = (this._SafeStr_12025.x + ((this._input.width - this._SafeStr_12025.width) / 2));
            this._SafeStr_12025.visible = true;
        }
        public function goBackToInitialState():void
        {
            this.clearErrors();
            if (this._SafeStr_11217 != null){
                this._input.text = this._SafeStr_11217;
                this._SafeStr_11824 = true;
            }
            else {
                this._input.text = "";
                this._SafeStr_11824 = false;
            };
        }
        public function getText():String
        {
            if (this._SafeStr_11824){
                return (this._text);
            };
            return (this._input.text);
        }
        public function setText(_arg_1:String):void
        {
            this._SafeStr_11824 = false;
            this._input.text = _arg_1;
        }
        public function clearErrors():void
        {
            this.restoreBackground();
            if (this._SafeStr_12025 != null){
                this._SafeStr_12025.visible = false;
            };
        }
        public function get input():ITextFieldWindow
        {
            return (this._input);
        }
        private function isInputValid():Boolean
        {
            return (((!(this._SafeStr_11824)) && ((Util.trim(this.getText()).length > 2))));
        }
        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_FOCUSED){
                return;
            };
            if (!this._SafeStr_11824){
                return;
            };
            this._input.text = this._text;
            this._SafeStr_11824 = false;
            this.restoreBackground();
        }
        private function checkEnterPress(_arg_1:WindowKeyboardEvent):void
        {
            if (_arg_1.charCode == Keyboard.ENTER){
                if (this._SafeStr_12023 != null){
                    this._SafeStr_12023();
                };
            };
        }
        private function checkMaxLen(_arg_1:WindowEvent):void
        {
            var _local_2:String = this._input.text;
            if (_local_2.length > this._SafeStr_12022){
                this._input.text = _local_2.substring(0, this._SafeStr_12022);
            };
        }

    }
}//package com.sulake.habbo.navigator

// _SafeStr_11217 = "_-WX" (String#8333, DoABC#2)
// _SafeStr_11824 = "_-0s6" (String#824, DoABC#2)
// onInputClick = "_-2zA" (String#907, DoABC#2)
// trim = "_-03B" (String#14169, DoABC#2)
// _input = "_-0I9" (String#14764, DoABC#2)
// _SafeStr_12022 = "_-2Ql" (String#20077, DoABC#2)
// _SafeStr_12023 = "_-2li" (String#20907, DoABC#2)
// _text = "_-3Hd" (String#22185, DoABC#2)
// _SafeStr_12025 = "_-32X" (String#21598, DoABC#2)
// _SafeStr_12026 = "_-2xD" (String#21358, DoABC#2)
// checkEnterPress = "_-2OB" (String#19973, DoABC#2)
// checkMaxLen = "_-ng" (String#24179, DoABC#2)
// isInputValid = "_-JS" (String#22981, DoABC#2)
// restoreBackground = "_-2YW" (String#20378, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// TextFieldManager = "_-Em" (String#7966, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// setText = "_-1vu" (String#243, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// setProcDirectly = "_-24s" (String#19218, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// goBackToInitialState = "_-27b" (String#19315, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// checkMandatory = "_-2zP" (String#21436, DoABC#2)
// displayError = "_-ky" (String#24070, DoABC#2)
// clearErrors = "_-1FQ" (String#1642, DoABC#2)
// textBackground = "_-IA" (String#2081, DoABC#2)
// getLocalPosition = "_-35W" (String#7418, DoABC#2)


