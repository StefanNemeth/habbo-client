
package com.sulake.habbo.ui.widget.chatinput
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.geom.Point;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatTypingMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import flash.display.Stage;
    import flash.display.InteractiveObject;
    import flash.display.DisplayObject;
    import flash.text.TextField;

    public class RoomChatInputView 
    {

        private static const _SafeStr_6216:int = 250;
        private static const _SafeStr_6217:int = 0;
        private static const BOTTOM_MARGIN:int = 55;
        private static const _SafeStr_6218:String = "${widgets.chatinput.say}";

        private var _widget:RoomChatInputWidget;
        private var _window:IWindowContainer;
        private var _SafeStr_6219:ITextFieldWindow;
        private var _SafeStr_6220:IWindow;
        private var _button:IWindow;
        private var _SafeStr_6221:IWindow;
        private var _SafeStr_6222:IWindow;
        private var _SafeStr_6223:String;
        private var _SafeStr_6224:String;
        private var _SafeStr_6225:String;
        private var _SafeStr_6226:Boolean = false;
        private var _isTyping:Boolean = false;
        private var _SafeStr_6227:Boolean = false;
        private var _SafeStr_6228:Timer;
        private var _SafeStr_6229:Timer;
        private var _SafeStr_6230:String = "";

        public function RoomChatInputView(_arg_1:RoomChatInputWidget)
        {
            this._widget = _arg_1;
            this._SafeStr_6224 = _arg_1.localizations.getKey("widgets.chatinput.mode.whisper", ":tell");
            this._SafeStr_6223 = _arg_1.localizations.getKey("widgets.chatinput.mode.shout", ":shout");
            this._SafeStr_6225 = _arg_1.localizations.getKey("widgets.chatinput.mode.speak", ":speak");
            this._SafeStr_6228 = new Timer(1000, 1);
            this._SafeStr_6228.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);
            this._SafeStr_6229 = new Timer(10000, 1);
            this._SafeStr_6229.addEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);
            this.createWindow();
        }
        public function get window():IWindowContainer
        {
            return (this._window);
        }
        public function dispose():void
        {
            this._widget = null;
            this._SafeStr_6219 = null;
            this._SafeStr_6220 = null;
            this._button = null;
            this._SafeStr_6221 = null;
            this._SafeStr_6222 = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_6228 != null){
                this._SafeStr_6228.reset();
                this._SafeStr_6228.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTypingTimerComplete);
                this._SafeStr_6228 = null;
            };
            if (this._SafeStr_6229 != null){
                this._SafeStr_6229.reset();
                this._SafeStr_6229.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onIdleTimerComplete);
                this._SafeStr_6229 = null;
            };
        }
        private function createWindow():void
        {
            if (this._window != null){
                return;
            };
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("chatinput_window") as XmlAsset);
            if ((((_local_1 == null)) || ((_local_1.content == null)))){
                return;
            };
            this._window = (this._widget.windowManager.buildFromXML((_local_1.content as XML), 0) as IWindowContainer);
            this._window.x = ((this._window.desktop.width - this._window.width) / 2);
            this._window.y = ((this._window.desktop.height - this._window.height) - BOTTOM_MARGIN);
            this._window.tags.push("room_widget_chatinput");
            this._SafeStr_6219 = (this._window.findChildByName("chat_input") as ITextFieldWindow);
            this._SafeStr_6220 = this._window.findChildByName("input_border");
            this._button = this._window.findChildByName("send_button");
            this._SafeStr_6221 = this._window.findChildByName("send_button_text");
            this._SafeStr_6222 = this._window.findChildByName("block_text");
            this._SafeStr_6221.caption = _SafeStr_6218;
            this._SafeStr_6219.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            this._SafeStr_6219.addEventListener(WindowMouseEvent.WME_DOWN, this.windowMouseEventProcessor);
            this._SafeStr_6219.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.windowKeyEventProcessor);
            this._SafeStr_6219.addEventListener(WindowKeyboardEvent.WKE_KEY_UP, this.keyUpHandler);
            this._SafeStr_6219.addEventListener(WindowEvent.WE_CHANGE, this._SafeStr_6237);
            this._window.findChildByName("send_button").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onSend);
            this._SafeStr_6226 = true;
            this._SafeStr_6230 = "";
            this._window.addEventListener(WindowEvent.WE_PARENT_RESIZED, this.updatePosition);
            this._window.addEventListener(WindowEvent.WE_PARENT_ADDED, this.updatePosition);
        }
        private function updatePosition(_arg_1:WindowEvent=null):void
        {
            var _local_2:Point = new Point();
            this._window.getGlobalPosition(_local_2);
            var _local_3:int = (_local_2.x - this._window.x);
            var _local_4:int = (((this._window.desktop.width - this._SafeStr_6220.width) / 2) - _local_3);
            var _local_5:int = (((this._window.desktop.width - this._window.width) - _SafeStr_6216) - _local_3);
            this._window.x = Math.max(Math.min(_local_4, _local_5), _SafeStr_6217);
        }
        private function onSend(_arg_1:WindowMouseEvent):void
        {
            if (!this._SafeStr_6226){
                this.sendChatFromInputField();
            };
        }
        public function hideFloodBlocking():void
        {
            this._SafeStr_6219.visible = true;
            this._SafeStr_6222.visible = false;
            if (this._button != null){
                this._button.enable();
            };
        }
        public function showFloodBlocking():void
        {
            this._SafeStr_6219.visible = false;
            this._SafeStr_6222.visible = true;
            if (this._button != null){
                this._button.disable();
            };
        }
        public function updateBlockText(_arg_1:int):void
        {
            this._widget.localizations.registerParameter("chat.input.alert.flood", "time", _arg_1.toString());
        }
        public function displaySpecialChatMessage(_arg_1:String, _arg_2:String=""):void
        {
            if ((((this._window == null)) || ((this._SafeStr_6219 == null)))){
                return;
            };
            this._SafeStr_6219.enable();
            this._SafeStr_6219.selectable = true;
            this._SafeStr_6219.text = "";
            this.setInputFieldFocus();
            this._SafeStr_6219.text = (this._SafeStr_6219.text + (_arg_1 + " "));
            if (_arg_2.length > 0){
                this._SafeStr_6219.text = (this._SafeStr_6219.text + (_arg_2 + " "));
            };
            this._SafeStr_6219.setSelection(this._SafeStr_6219.text.length, this._SafeStr_6219.text.length);
            this._SafeStr_6230 = this._SafeStr_6219.text;
        }
        private function windowMouseEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            this.setInputFieldFocus();
        }
        private function windowKeyEventProcessor(_arg_1:WindowEvent=null, _arg_2:IWindow=null):void
        {
            var _local_3:uint;
            var _local_4:Boolean;
            var _local_5:WindowKeyboardEvent;
            var _local_6:KeyboardEvent;
            var _local_7:String;
            var _local_8:Array;
            if ((((((this._window == null)) || ((this._widget == null)))) || (this._widget.floodBlocked))){
                return;
            };
            if (this.anotherFieldHasFocus()){
                return;
            };
            this.setInputFieldFocus();
            if ((_arg_1 is WindowKeyboardEvent)){
                _local_5 = (_arg_1 as WindowKeyboardEvent);
                _local_3 = _local_5.charCode;
                _local_4 = _local_5.shiftKey;
            };
            if ((_arg_1 is KeyboardEvent)){
                _local_6 = (_arg_1 as KeyboardEvent);
                _local_3 = _local_6.charCode;
                _local_4 = _local_6.shiftKey;
            };
            if ((((_local_6 == null)) && ((_local_5 == null)))){
                return;
            };
            if (_local_3 == Keyboard.SPACE){
                this.checkSpecialKeywordForInput();
            };
            if (_local_3 == Keyboard.ENTER){
                this.sendChatFromInputField(_local_4);
                this.setButtonPressedState(true);
            };
            if (_local_3 == Keyboard.BACKSPACE){
                if (this._SafeStr_6219 != null){
                    _local_7 = this._SafeStr_6219.text;
                    _local_8 = _local_7.split(" ");
                    if ((((((_local_8[0] == this._SafeStr_6224)) && ((_local_8.length == 3)))) && ((_local_8[2] == "")))){
                        this._SafeStr_6219.text = "";
                        this._SafeStr_6230 = "";
                    };
                };
            };
        }
        private function keyUpHandler(_arg_1:WindowKeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ENTER){
                this.setButtonPressedState(false);
            };
        }
        private function setButtonPressedState(_arg_1:Boolean):void
        {
            if (this._button){
                this._button.setStateFlag(WindowState._SafeStr_6248, _arg_1);
            };
        }
        private function _SafeStr_6237(_arg_1:WindowEvent):void
        {
            var _local_2:ITextFieldWindow = (_arg_1.window as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            this._SafeStr_6229.reset();
            var _local_3 = (_local_2.text.length == 0);
            if (_local_3){
                this._isTyping = false;
                this._SafeStr_6228.start();
            }
            else {
                if (_local_2.text.length > (this._SafeStr_6230.length + 1)){
                    if (this._widget.allowPaste){
                        this._widget.setLastPasteTime();
                    }
                    else {
                        _local_2.text = "";
                    };
                };
                this._SafeStr_6230 = _local_2.text;
                if (!this._isTyping){
                    this._isTyping = true;
                    this._SafeStr_6228.reset();
                    this._SafeStr_6228.start();
                };
                this._SafeStr_6229.start();
            };
        }
        private function checkSpecialKeywordForInput():void
        {
            if ((((this._SafeStr_6219 == null)) || ((this._SafeStr_6219.text == "")))){
                return;
            };
            var _local_1:String = this._SafeStr_6219.text;
            var _local_2:String = this._widget.selectedUserName;
            if (_local_1 == this._SafeStr_6224){
                if (_local_2.length > 0){
                    this._SafeStr_6219.text = (this._SafeStr_6219.text + (" " + this._widget.selectedUserName));
                    this._SafeStr_6219.setSelection(this._SafeStr_6219.text.length, this._SafeStr_6219.text.length);
                    this._SafeStr_6230 = this._SafeStr_6219.text;
                };
            };
        }
        private function onIdleTimerComplete(_arg_1:TimerEvent):void
        {
            if (this._isTyping){
                this._SafeStr_6227 = false;
            };
            this._isTyping = false;
            this.sendTypingMessage();
        }
        private function onTypingTimerComplete(_arg_1:TimerEvent):void
        {
            if (this._isTyping){
                this._SafeStr_6227 = true;
            };
            this.sendTypingMessage();
        }
        private function sendTypingMessage():void
        {
            if (this._widget == null){
                return;
            };
            if (this._widget.floodBlocked){
                return;
            };
            var _local_1:RoomWidgetChatTypingMessage = new RoomWidgetChatTypingMessage(this._isTyping);
            this._widget.messageListener.processWidgetMessage(_local_1);
        }
        private function setInputFieldFocus():void
        {
            if (this._SafeStr_6219 == null){
                return;
            };
            if (this._SafeStr_6226){
                this._SafeStr_6219.text = "";
                this._SafeStr_6219.textColor = 0;
                this._SafeStr_6219.italic = false;
                this._SafeStr_6226 = false;
                this._SafeStr_6230 = "";
            };
            this._SafeStr_6219.focus();
        }
        private function sendChatFromInputField(_arg_1:Boolean=false):void
        {
            if ((((this._SafeStr_6219 == null)) || ((this._SafeStr_6219.text == "")))){
                return;
            };
            var _local_2:int = ((_arg_1) ? RoomWidgetChatMessage._SafeStr_3622 : RoomWidgetChatMessage._SafeStr_3620);
            var _local_3:String = this._SafeStr_6219.text;
            var _local_4:Array = _local_3.split(" ");
            var _local_5:String = "";
            var _local_6:String = "";
            switch (_local_4[0]){
                case this._SafeStr_6224:
                    _local_2 = RoomWidgetChatMessage._SafeStr_3621;
                    _local_5 = _local_4[1];
                    _local_6 = (((this._SafeStr_6224 + " ") + _local_5) + " ");
                    _local_4.shift();
                    _local_4.shift();
                    break;
                case this._SafeStr_6223:
                    _local_2 = RoomWidgetChatMessage._SafeStr_3622;
                    _local_4.shift();
                    break;
                case this._SafeStr_6225:
                    _local_2 = RoomWidgetChatMessage._SafeStr_3620;
                    _local_4.shift();
                    break;
            };
            _local_3 = _local_4.join(" ");
            if (this._widget != null){
                if (this._SafeStr_6228.running){
                    this._SafeStr_6228.reset();
                };
                if (this._SafeStr_6229.running){
                    this._SafeStr_6229.reset();
                };
                this._widget.sendChat(_local_3, _local_2, _local_5);
                this._isTyping = false;
                if (this._SafeStr_6227){
                    this.sendTypingMessage();
                };
                this._SafeStr_6227 = false;
            };
            this._SafeStr_6219.text = _local_6;
            this._SafeStr_6230 = _local_6;
        }
        private function anotherFieldHasFocus():Boolean
        {
            var _local_2:Stage;
            var _local_3:InteractiveObject;
            if (this._SafeStr_6219 != null){
                if (this._SafeStr_6219.focused){
                    return (false);
                };
            };
            var _local_1:DisplayObject = this._window.context.getDesktopWindow().getDisplayObject();
            if (_local_1 != null){
                _local_2 = _local_1.stage;
                if (_local_2 != null){
                    _local_3 = _local_2.focus;
                    if (_local_3 == null){
                        return (false);
                    };
                    if ((_local_3 is TextField)){
                        return (true);
                    };
                };
            };
            return (false);
        }

    }
}//package com.sulake.habbo.ui.widget.chatinput

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// RoomChatInputWidget = "_-1Oc" (String#5326, DoABC#2)
// RoomChatInputView = "_-1bd" (String#5592, DoABC#2)
// RoomWidgetChatTypingMessage = "_-0Yw" (String#4277, DoABC#2)
// _isTyping = "_-2z6" (String#624, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// WKE_KEY_UP = "_-0aL" (String#15451, DoABC#2)
// floodBlocked = "_-1rk" (String#18620, DoABC#2)
// allowPaste = "_-3Eg" (String#22061, DoABC#2)
// setLastPasteTime = "_-1-D" (String#16438, DoABC#2)
// sendChat = "_-yT" (String#24634, DoABC#2)
// displaySpecialChatMessage = "_-21Z" (String#19076, DoABC#2)
// hideFloodBlocking = "_-5Q" (String#22441, DoABC#2)
// updateBlockText = "_-x2" (String#24571, DoABC#2)
// selectedUserName = "_-1YQ" (String#17830, DoABC#2)
// showFloodBlocking = "_-s0" (String#24364, DoABC#2)
// _SafeStr_6216 = "_-24E" (String#19186, DoABC#2)
// _SafeStr_6217 = "_-0Ki" (String#14869, DoABC#2)
// _SafeStr_6218 = "_-2LF" (String#19858, DoABC#2)
// _SafeStr_6219 = "_-s-" (String#24363, DoABC#2)
// _SafeStr_6220 = "_-0hw" (String#15745, DoABC#2)
// _SafeStr_6221 = "_-Dp" (String#22762, DoABC#2)
// _SafeStr_6222 = "_-KJ" (String#23018, DoABC#2)
// _SafeStr_6223 = "_-5N" (String#22438, DoABC#2)
// _SafeStr_6224 = "_-Yn" (String#23591, DoABC#2)
// _SafeStr_6225 = "_-1NE" (String#17407, DoABC#2)
// _SafeStr_6226 = "_-1-v" (String#16464, DoABC#2)
// _SafeStr_6227 = "_-0cW" (String#15534, DoABC#2)
// _SafeStr_6228 = "_-7d" (String#22528, DoABC#2)
// _SafeStr_6229 = "_-170" (String#16736, DoABC#2)
// _SafeStr_6230 = "_-220" (String#19090, DoABC#2)
// onTypingTimerComplete = "_-lR" (String#24086, DoABC#2)
// onIdleTimerComplete = "_-Dv" (String#22766, DoABC#2)
// windowMouseEventProcessor = "_-0w8" (String#16278, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// windowKeyEventProcessor = "_-rC" (String#8727, DoABC#2)
// keyUpHandler = "_-1ze" (String#18954, DoABC#2)
// _SafeStr_6237 = "return" (String#46536, DoABC#2)
// onSend = "_-0qb" (String#4653, DoABC#2)
// WE_PARENT_RESIZED = "_-0GO" (String#14697, DoABC#2)
// updatePosition = "_-2oz" (String#21039, DoABC#2)
// WE_PARENT_ADDED = "_-0D7" (String#14572, DoABC#2)
// sendChatFromInputField = "_-1UT" (String#17684, DoABC#2)
// setInputFieldFocus = "_-21f" (String#19080, DoABC#2)
// anotherFieldHasFocus = "_-3-u" (String#21497, DoABC#2)
// checkSpecialKeywordForInput = "_-2M-" (String#19885, DoABC#2)
// setButtonPressedState = "_-0eD" (String#15595, DoABC#2)
// setStateFlag = "_-1jq" (String#5750, DoABC#2)
// _SafeStr_6248 = "_-3J9" (String#22246, DoABC#2)
// sendTypingMessage = "_-29Y" (String#19387, DoABC#2)


