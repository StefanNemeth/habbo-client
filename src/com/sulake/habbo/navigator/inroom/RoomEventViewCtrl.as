
package com.sulake.habbo.navigator.inroom
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateEventMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.EditEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CancelEventMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.navigator.*;

    public class RoomEventViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var _eventNameInput:TextFieldManager;
        private var _SafeStr_8452:TextFieldManager;
        private var _SafeStr_6906:TextFieldManager;
        private var _SafeStr_6907:TextFieldManager;
        private var _active:Boolean;
        private var _SafeStr_8453:IWindowContainer;
        private var _SafeStr_8454:ITextWindow;
        private var _SafeStr_8455:ITextWindow;
        private var _SafeStr_8456:ITextWindow;
        private var _SafeStr_8457:IButtonWindow;
        private var _SafeStr_8458:IButtonWindow;
        private var _SafeStr_8459:IButtonWindow;
        private var _SafeStr_8460:IButtonWindow;
        private var _SafeStr_8461:IDropMenuWindow;

        public function RoomEventViewCtrl(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
        }
        public function set active(_arg_1:Boolean):void
        {
            this._active = _arg_1;
        }
        public function get active():Boolean
        {
            return (this._active);
        }
        public function refresh(_arg_1:IWindowContainer):void
        {
            if (!this._active){
                return;
            };
            this.prepareWindow(_arg_1);
            this.clearErrors();
            var _local_2:RoomEventData = this._navigator.data.roomEventData;
            if (_local_2 == null){
                this.RoomEventViewCtrl();
            }
            else {
                this.RoomEventViewCtrl(_local_2);
            };
            this._window.visible = true;
        }
        private function RoomEventViewCtrl(_arg_1:RoomEventData):void
        {
            this._SafeStr_8461.visible = false;
            this._SafeStr_8453.visible = true;
            this._SafeStr_8454.text = this._navigator.getText(("roomevent_type_" + _arg_1.eventType));
            this._eventNameInput.CurrencyIndicatorBase(_arg_1.eventName);
            this._SafeStr_8452.CurrencyIndicatorBase(_arg_1.eventDescription);
            this._SafeStr_6906.CurrencyIndicatorBase(this.RoomEventViewCtrl(_arg_1, 1));
            this._SafeStr_6907.CurrencyIndicatorBase(this.RoomEventViewCtrl(_arg_1, 2));
            this._SafeStr_8457.visible = false;
            this._SafeStr_8458.visible = true;
            this._SafeStr_8460.visible = true;
            this._SafeStr_8455.visible = false;
            this._SafeStr_8456.visible = true;
        }
        private function RoomEventViewCtrl():void
        {
            this._SafeStr_8461.visible = true;
            this._SafeStr_8453.visible = false;
            this._SafeStr_8457.visible = true;
            this._SafeStr_8458.visible = false;
            this._SafeStr_8460.visible = false;
            this._SafeStr_8452.goBackToInitialState();
            this._eventNameInput.goBackToInitialState();
            this._SafeStr_6906.goBackToInitialState();
            this._SafeStr_6907.goBackToInitialState();
            this._SafeStr_8461.selection = 0;
            this._SafeStr_8455.visible = true;
            this._SafeStr_8456.visible = false;
        }
        private function getInput(_arg_1:String):ITextFieldWindow
        {
            return (ITextFieldWindow(this._window.findChildByName(_arg_1)));
        }
        private function RoomEventViewCtrl():int
        {
            var _local_1:int = this._SafeStr_8461.selection;
            return ((_local_1 + 1));
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            var _local_2:int = this.RoomEventViewCtrl();
            var _local_3:String = this._eventNameInput.getText();
            var _local_4:String = this._SafeStr_8452.getText();
            var _local_5:Array = new Array();
            this.addTag(_local_5, this._SafeStr_6906.getText());
            this.addTag(_local_5, this._SafeStr_6907.getText());
            if (!this.RoomEventViewCtrl()){
                return;
            };
            this._navigator.send(new CreateEventMessageComposer(_local_2, _local_3, _local_4, _local_5));
            this.RoomEventViewCtrl();
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            var _local_2:int = this._navigator.data.roomEventData.eventType;
            var _local_3:String = this._eventNameInput.getText();
            var _local_4:String = this._SafeStr_8452.getText();
            var _local_5:Array = new Array();
            this.addTag(_local_5, this._SafeStr_6906.getText());
            this.addTag(_local_5, this._SafeStr_6907.getText());
            if (!this.RoomEventViewCtrl()){
                return;
            };
            this._navigator.send(new EditEventMessageComposer(_local_2, _local_3, _local_4, _local_5));
            this.RoomEventViewCtrl();
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            this._navigator.send(new CancelEventMessageComposer());
            this.RoomEventViewCtrl();
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            this.RoomEventViewCtrl();
        }
        private function RoomEventViewCtrl():Boolean
        {
            this.clearErrors();
            if (!this._eventNameInput.checkMandatory(this._navigator.getText("navigator.eventsettings.nameerr"))){
                return (false);
            };
            if (!this._SafeStr_8452.checkMandatory(this._navigator.getText("navigator.eventsettings.descerr"))){
                return (false);
            };
            return (true);
        }
        private function clearErrors():void
        {
            this._eventNameInput.clearErrors();
            this._SafeStr_8452.clearErrors();
            this._SafeStr_6906.clearErrors();
            this._SafeStr_6907.clearErrors();
        }
        private function prepareWindow(_arg_1:IWindowContainer):void
        {
            if (this._window == null){
                this._window = IWindowContainer(this._navigator.getXmlWindow("iro_event_settings"));
                this._SafeStr_8453 = IWindowContainer(this.find("event_type_disabled_cont"));
                this._SafeStr_8454 = ITextWindow(this.find("event_type_disabled_text"));
                this._SafeStr_8455 = ITextWindow(this.find("create_caption"));
                this._SafeStr_8456 = ITextWindow(this.find("edit_caption"));
                this._SafeStr_8457 = IButtonWindow(this.find("create_button"));
                this._SafeStr_8458 = IButtonWindow(this.find("edit_button"));
                this._SafeStr_8459 = IButtonWindow(this.find("cancel_button"));
                this._SafeStr_8460 = IButtonWindow(this.find("end_button"));
                this._SafeStr_8461 = IDropMenuWindow(this.find("event_type"));
                this.RoomEventViewCtrl();
                this.RoomEventViewCtrl(this._SafeStr_8457, this.RoomEventViewCtrl);
                this.RoomEventViewCtrl(this._SafeStr_8458, this.RoomEventViewCtrl);
                this.RoomEventViewCtrl(this._SafeStr_8460, this.RoomEventViewCtrl);
                this.RoomEventViewCtrl(this._SafeStr_8459, this.RoomEventViewCtrl);
                this._eventNameInput = new TextFieldManager(this._navigator, this.getInput("event_name"), 25);
                this._SafeStr_8452 = new TextFieldManager(this._navigator, this.getInput("event_desc"), 100);
                this._SafeStr_6906 = new TextFieldManager(this._navigator, this.getInput("event_tag_1"), 25);
                this._SafeStr_6907 = new TextFieldManager(this._navigator, this.getInput("event_tag_2"), 25);
                _arg_1.addChild(this._window);
            };
        }
        private function RoomEventViewCtrl(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        private function find(_arg_1:String):IWindow
        {
            var _local_2:IWindow = this._window.findChildByName(_arg_1);
            if (_local_2 == null){
                throw (new Error((("Window element with name: " + _arg_1) + " cannot be found!")));
            };
            return (_local_2);
        }
        private function RoomEventViewCtrl():void
        {
            var _local_4:String;
            var _local_5:String;
            var _local_1:Array = new Array();
            var _local_2:int = 100;
            var _local_3:int = 1;
            while (_local_3 < _local_2) {
                _local_4 = ("roomevent_type_" + _local_3);
                _local_5 = this._navigator.getText(_local_4);
                if ((((_local_5 == null)) || ((_local_5 == _local_4)))) break;
                _local_1.push(_local_5);
                _local_3++;
            };
            this._SafeStr_8461.populate(_local_1);
        }
        private function RoomEventViewCtrl():void
        {
            this._active = false;
            this._navigator.roomInfoViewCtrl.reload();
        }
        private function RoomEventViewCtrl(_arg_1:RoomEventData, _arg_2:int):String
        {
            var _local_3:String = _arg_1.tags[(_arg_2 - 1)];
            return ((((_local_3 == null)) ? "" : _local_3));
        }
        private function addTag(_arg_1:Array, _arg_2:String):void
        {
            if (_arg_2 != ""){
                _arg_1.push(_arg_2);
            };
        }

    }
}//package com.sulake.habbo.navigator.inroom

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// RoomEventData = "_-07q" (String#3718, DoABC#2)
// TextFieldManager = "_-Em" (String#7966, DoABC#2)
// RoomEventViewCtrl = "_-Od" (String#8176, DoABC#2)
// CreateEventMessageComposer = "_-19X" (String#16838, DoABC#2)
// EditEventMessageComposer = "_-1sL" (String#18646, DoABC#2)
// CancelEventMessageComposer = "_-2Vz" (String#20281, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// RoomEventViewCtrl = "_-10B" (String#595, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// roomInfoViewCtrl = "_-HS" (String#22911, DoABC#2)
// reload = "_-3AK" (String#7519, DoABC#2)
// eventType = "_-2Se" (String#20142, DoABC#2)
// eventName = "_-1tL" (String#18690, DoABC#2)
// eventDescription = "_-1i8" (String#18215, DoABC#2)
// RoomEventViewCtrl = "_-0lu" (String#4546, DoABC#2)
// RoomEventViewCtrl = "_-2kt" (String#6975, DoABC#2)
// RoomEventViewCtrl = "_-0ir" (String#1534, DoABC#2)
// goBackToInitialState = "_-27b" (String#19315, DoABC#2)
// RoomEventViewCtrl = "_-36s" (String#7447, DoABC#2)
// checkMandatory = "_-2zP" (String#21436, DoABC#2)
// _SafeStr_6906 = "_-0cV" (String#4354, DoABC#2)
// _SafeStr_6907 = "_-0Og" (String#4061, DoABC#2)
// clearErrors = "_-1FQ" (String#1642, DoABC#2)
// roomEventData = "_-0tV" (String#16179, DoABC#2)
// _SafeStr_8452 = "_-1Ky" (String#17310, DoABC#2)
// _SafeStr_8453 = "_-2yP" (String#21407, DoABC#2)
// _SafeStr_8454 = "_-0LD" (String#14882, DoABC#2)
// _SafeStr_8455 = "_-2eT" (String#20623, DoABC#2)
// _SafeStr_8456 = "_-yN" (String#24630, DoABC#2)
// _SafeStr_8457 = "_-1Tl" (String#17656, DoABC#2)
// _SafeStr_8458 = "_-2Zf" (String#20426, DoABC#2)
// _SafeStr_8459 = "_-01w" (String#14126, DoABC#2)
// _SafeStr_8460 = "_-2U2" (String#20201, DoABC#2)
// _SafeStr_8461 = "_-0h8" (String#15715, DoABC#2)
// RoomEventViewCtrl = "_-2Oj" (String#19992, DoABC#2)
// RoomEventViewCtrl = "_-2az" (String#20486, DoABC#2)
// RoomEventViewCtrl = "_-28W" (String#19350, DoABC#2)
// RoomEventViewCtrl = "_-0Cb" (String#14553, DoABC#2)
// RoomEventViewCtrl = "_-1p2" (String#18503, DoABC#2)
// RoomEventViewCtrl = "_-0dc" (String#15569, DoABC#2)
// RoomEventViewCtrl = "_-3G2" (String#22118, DoABC#2)


