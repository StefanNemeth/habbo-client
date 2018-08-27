
package com.sulake.habbo.help.hotelmerge
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.help.tutorial.NameSuggestionListRenderer;
    import com.sulake.habbo.help.tutorial.TutorialUI;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class HotelMergeNameChangeView 
    {

        private static var _SafeStr_11422:uint = 13232628;
        private static var _SafeStr_11423:uint = 11129827;

        private var _controller:HotelMergeUI;
        private var _window:IFrameWindow;
        private var _SafeStr_11424:String;
        private var _SafeStr_11425:String;
        private var _SafeStr_11426:IWindowContainer;
        private var _SafeStr_11427:IWindowContainer;
        private var _SafeStr_11428:IWindowContainer;
        private var _SafeStr_3864:IWindowContainer;
        private var _SafeStr_11429:Boolean = false;
        private var _SafeStr_11430:NameSuggestionListRenderer;

        public function HotelMergeNameChangeView(_arg_1:HotelMergeUI):void
        {
            this._controller = _arg_1;
        }
        public function get id():String
        {
            return (TutorialUI.TUI_NAME_VIEW);
        }
        public function set checkedName(_arg_1:String):void
        {
            this._SafeStr_11424 = _arg_1;
            if (this._SafeStr_11425 == this._SafeStr_11424){
                this.showConfirmationView();
                return;
            };
            this.setNameAvailableView();
        }
        public function dispose():void
        {
            this.disposeWindow();
            if (this._SafeStr_11430 != null){
                this._SafeStr_11430.dispose();
                this._SafeStr_11430 = null;
            };
        }
        private function disposeWindow():void
        {
            this._SafeStr_11426 = null;
            this._SafeStr_11427 = null;
            this._SafeStr_11428 = null;
            this._SafeStr_3864 = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function showView(_arg_1:IWindowContainer):void
        {
            this._SafeStr_11429 = false;
            if (this._SafeStr_3864){
                this._SafeStr_3864.visible = false;
            };
            this._SafeStr_3864 = _arg_1;
            this._SafeStr_3864.visible = true;
            if (this._window){
                this._window.content.width = this._SafeStr_3864.width;
                this._window.content.height = this._SafeStr_3864.height;
            };
        }
        public function showMainView():void
        {
            if (!this._window){
                this._window = (this.createWindow("hotel_merge_name_change_xml") as IFrameWindow);
                this._window.center();
                this._window.procedure = this.windowEventHandler;
                this._SafeStr_11426 = (this._window.content.getChildAt(0) as IWindowContainer);
            };
            this._controller.localization.registerParameter("hotel_merge.name_change.current", "name", this._controller.myName);
            this._window.caption = this._controller.localization.getKey("hotel_merge.name_change.title.main");
            this.showView(this._SafeStr_11426);
        }
        private function showSelectionView():void
        {
            if (!this._SafeStr_11427){
                this._SafeStr_11427 = (this.createWindow("hotel_merge_name_selection_xml") as IWindowContainer);
                if (!this._SafeStr_11427){
                    return;
                };
                this._window.content.addChild(this._SafeStr_11427);
            };
            this._window.caption = this._controller.localization.getKey("hotel_merge.name_change.title.select");
            var _local_1:IButtonWindow = (this._window.findChildByName("select_name_button") as IButtonWindow);
            if (_local_1){
                _local_1.disable();
            };
            this.setNormalView();
            this.showView(this._SafeStr_11427);
        }
        private function showConfirmationView():void
        {
            if (!this._SafeStr_11428){
                this._SafeStr_11428 = (this.createWindow("hotel_merge_name_confirmation_xml") as IWindowContainer);
                if (!this._SafeStr_11428){
                    return;
                };
                this._window.content.addChild(this._SafeStr_11428);
            };
            this._window.caption = this._controller.localization.getKey("hotel_merge.name_change.title.confirm");
            var _local_1:ITextWindow = (this._SafeStr_11428.findChildByName("final_name") as ITextWindow);
            if (_local_1){
                _local_1.text = this._SafeStr_11424;
            };
            this.showView(this._SafeStr_11428);
        }
        private function createWindow(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = (this._controller.assets.getAssetByName(_arg_1) as XmlAsset);
            if (!_local_2){
                return (null);
            };
            return (this._controller.windowManager.buildFromXML((_local_2.content as XML)));
        }
        public function get view():IWindowContainer
        {
            return (this._window);
        }
        public function setNormalView():void
        {
            if (this._window == null){
                return;
            };
            var _local_1:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_local_1 == null){
                return;
            };
            _local_1.text = this._controller.localization.getKey("help.tutorial.name.info");
            var _local_2:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_local_2 == null){
                return;
            };
            _local_2.visible = false;
        }
        public function setNameAvailableView():void
        {
            if (this._window == null){
                return;
            };
            this.nameCheckWaitEnd(true);
            var _local_1:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_local_1 == null){
                return;
            };
            this._controller.localization.registerParameter("help.tutorial.name.available", "name", this._SafeStr_11424);
            _local_1.text = this._controller.localization.getKey("help.tutorial.name.available");
            var _local_2:ITextFieldWindow = (this._window.findChildByName("input") as ITextFieldWindow);
            if (_local_2 == null){
                return;
            };
            _local_2.text = this._SafeStr_11424;
            var _local_3:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            _local_3.visible = false;
        }
        public function setNameNotAvailableView(_arg_1:int, _arg_2:String, _arg_3:Array):void
        {
            var _local_8:IWindow;
            this.nameCheckWaitEnd(false);
            if (this._SafeStr_3864 != this._SafeStr_11427){
                this.showSelectionView();
            };
            this._SafeStr_11425 = null;
            this._SafeStr_11424 = null;
            if (this._window == null){
                return;
            };
            var _local_4:ITextWindow = (this._window.findChildByName("info_text") as ITextWindow);
            if (_local_4 == null){
                return;
            };
            switch (_arg_1){
                case ChangeUserNameResultMessageEvent._SafeStr_7101:
                    this._controller.localization.registerParameter("help.tutorial.name.taken", "name", _arg_2);
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.taken");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7100:
                    this._controller.localization.registerParameter("help.tutorial.name.invalid", "name", _arg_2);
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.invalid");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7097:
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7099:
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.long");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7098:
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.short");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7102:
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.change_not_allowed");
                    break;
                case ChangeUserNameResultMessageEvent._SafeStr_7103:
                    _local_4.text = this._controller.localization.getKey("help.tutorial.name.merge_hotel_down");
                    break;
            };
            var _local_5:IWindowContainer = (this._window.findChildByName("suggestions") as IWindowContainer);
            if (_local_5 == null){
                return;
            };
            if ((((_arg_1 == ChangeUserNameResultMessageEvent._SafeStr_7103)) || ((_arg_1 == ChangeUserNameResultMessageEvent._SafeStr_7102)))){
                _local_5.visible = false;
                return;
            };
            _local_5.visible = true;
            this._SafeStr_11430 = new NameSuggestionListRenderer(this._controller);
            var _local_6:int = this._SafeStr_11430.render(_arg_3, _local_5);
            var _local_7:int;
            while (_local_7 < _local_5.numChildren) {
                _local_8 = _local_5.getChildAt(_local_7);
                _local_8.color = _SafeStr_11422;
                _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.nameSelected);
                _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.nameOver);
                _local_8.addEventListener(WindowMouseEvent.WME_OUT, this.nameOut);
                _local_7++;
            };
        }
        private function nameSelected(_arg_1:WindowMouseEvent):void
        {
            this.nameCheckWaitEnd(true);
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (!_local_2){
                return;
            };
            var _local_3:String = _local_2.text;
            this.setNormalView();
            var _local_4:ITextFieldWindow = (this._window.findChildByName("input") as ITextFieldWindow);
            if (_local_4 == null){
                return;
            };
            _local_4.text = _local_3;
        }
        private function nameOver(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 != null){
                _local_2.color = _SafeStr_11423;
            };
        }
        private function nameOut(_arg_1:WindowMouseEvent):void
        {
            var _local_2:ITextWindow = (_arg_1.target as ITextWindow);
            if (_local_2 != null){
                _local_2.color = _SafeStr_11422;
            };
        }
        public function nameCheckWaitBegin():void
        {
            var _local_1:IWindow;
            if (((this._window) && (!(this._window.disposed)))){
                _local_1 = this._window.findChildByName("select_name_button");
                if (_local_1){
                    _local_1.disable();
                };
                _local_1 = this._window.findChildByName("check_name_button");
                if (_local_1){
                    _local_1.disable();
                };
                _local_1 = this._window.findChildByName("input");
                if (_local_1){
                    _local_1.disable();
                };
                _local_1 = this._window.findChildByName("info_text");
                if (_local_1){
                    _local_1.caption = this._controller.localization.getKey("help.tutorial.name.wait_while_checking");
                };
            };
            this._SafeStr_11429 = true;
        }
        public function nameCheckWaitEnd(_arg_1:Boolean):void
        {
            var _local_2:IWindow;
            if (((this._window) && (!(this._window.disposed)))){
                if (_arg_1){
                    _local_2 = this._window.findChildByName("select_name_button");
                    if (_local_2){
                        _local_2.enable();
                    };
                };
                _local_2 = this._window.findChildByName("check_name_button");
                if (_local_2){
                    _local_2.enable();
                };
                _local_2 = this._window.findChildByName("input");
                if (_local_2){
                    _local_2.enable();
                };
            };
            this._SafeStr_11429 = false;
        }
        private function windowEventHandler(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:IWindow;
            var _local_4:ITextFieldWindow;
            var _local_5:String;
            if (!this._SafeStr_11429){
                if (_arg_1.type == WindowEvent.WE_CHANGE){
                    if (_arg_2.name == "input"){
                        _local_3 = this._window.findChildByName("select_name_button");
                        _local_4 = (_arg_2 as ITextFieldWindow);
                        if (((_local_3) && (_local_4))){
                            if (_local_4.text.length > 2){
                                _local_3.enable();
                            }
                            else {
                                _local_3.disable();
                            };
                        };
                    };
                };
            };
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            switch (_arg_2.name){
                case "change_name_button":
                    this.showSelectionView();
                    return;
                case "keep_name_button":
                    this._SafeStr_11424 = this._controller.myName;
                    this.showConfirmationView();
                    return;
                case "check_name_button":
                    this._controller.checkName(this.getName());
                    this.nameCheckWaitBegin();
                    return;
                case "select_name_button":
                    _local_5 = this.getName();
                    if (_local_5.length < 1){
                        return;
                    };
                    if (this._SafeStr_11424 != _local_5){
                        this._SafeStr_11425 = _local_5;
                        this._controller.checkName(_local_5);
                        this.nameCheckWaitBegin();
                    }
                    else {
                        this.showConfirmationView();
                    };
                    return;
                case "cancel_selection_button":
                    this.nameCheckWaitEnd(true);
                    this.showMainView();
                    return;
                case "confirm_name_button":
                    this._controller.changeName(this._SafeStr_11424);
                    return;
                case "cancel_confirmation_button":
                    this.nameCheckWaitEnd(true);
                    this.showMainView();
                    return;
                case "header_button_close":
                    this.disposeWindow();
                    return;
            };
        }
        private function getName():String
        {
            var _local_1:ITextFieldWindow;
            if (this._window){
                _local_1 = (this._window.findChildByName("input") as ITextFieldWindow);
                if (_local_1){
                    return (_local_1.text);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.help.hotelmerge

// showMainView = "_-2pt" (String#21077, DoABC#2)
// changeName = "_-0uN" (String#4733, DoABC#2)
// checkName = "_-2Fe" (String#6356, DoABC#2)
// setNameNotAvailableView = "_-oP" (String#24210, DoABC#2)
// checkedName = "_-11W" (String#16518, DoABC#2)
// myName = "_-0Kp" (String#3971, DoABC#2)
// _SafeStr_11422 = "_-267" (String#6165, DoABC#2)
// _SafeStr_11423 = "_-1vZ" (String#5953, DoABC#2)
// _SafeStr_11424 = "_-1Gt" (String#5186, DoABC#2)
// _SafeStr_11425 = "_-110" (String#4894, DoABC#2)
// _SafeStr_11426 = "_-0yg" (String#4821, DoABC#2)
// _SafeStr_11427 = "_-1vO" (String#5949, DoABC#2)
// _SafeStr_11428 = "_-1pq" (String#5853, DoABC#2)
// _SafeStr_11429 = "_-F5" (String#7972, DoABC#2)
// _SafeStr_11430 = "_-2a4" (String#6760, DoABC#2)
// TUI_NAME_VIEW = "_-146" (String#16621, DoABC#2)
// showConfirmationView = "_-3Eb" (String#7605, DoABC#2)
// setNameAvailableView = "_-1EH" (String#17038, DoABC#2)
// disposeWindow = "_-0-u" (String#804, DoABC#2)
// showSelectionView = "_-3-t" (String#7301, DoABC#2)
// setNormalView = "_-0s-" (String#16122, DoABC#2)
// nameCheckWaitEnd = "_-1U" (String#17666, DoABC#2)
// nameSelected = "_-yj" (String#8853, DoABC#2)
// nameOver = "_-iF" (String#8560, DoABC#2)
// nameOut = "_-0JZ" (String#3944, DoABC#2)
// nameCheckWaitBegin = "_-3Ig" (String#22225, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// HotelMergeUI = "_-XE" (String#8353, DoABC#2)
// TutorialUI = "_-38o" (String#7488, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// HotelMergeNameChangeView = "_-0Ko" (String#3970, DoABC#2)
// NameSuggestionListRenderer = "_-Gn" (String#8013, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// getName = "_-D1" (String#931, DoABC#2)
// _SafeStr_3864 = "_-2-T" (String#446, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WE_CHANGE = "_-1sp" (String#18670, DoABC#2)
// windowEventHandler = "_-36j" (String#371, DoABC#2)
// _SafeStr_7097 = "_-Ni" (String#23153, DoABC#2)
// _SafeStr_7098 = "_-30B" (String#21507, DoABC#2)
// _SafeStr_7099 = "_-0Hq" (String#14750, DoABC#2)
// _SafeStr_7100 = "_-0nI" (String#15948, DoABC#2)
// _SafeStr_7101 = "_-3-P" (String#21478, DoABC#2)
// _SafeStr_7102 = "_-1Hn" (String#17183, DoABC#2)
// _SafeStr_7103 = "_-2YA" (String#20362, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)


