
package com.sulake.habbo.ui.widget.avatarinfo
{
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetWaveMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDanceMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class OwnAvatarMenuView extends AvatarInfoView 
    {

        private static const _SafeStr_6851:int = 0;
        private static const _SafeStr_6852:int = 1;
        private static const _SafeStr_6853:int = 2;
        private static const _SafeStr_6854:int = 8;

        private var _data:AvatarInfoData;
        private var _mode:int;
        private var _buttons:IItemListWindow;

        public function OwnAvatarMenuView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
            _SafeStr_6841 = false;
        }
        public static function setup(_arg_1:OwnAvatarMenuView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:AvatarInfoData):void
        {
            _arg_1._data = _arg_6;
            if (((((_arg_1._widget.isDancing) && (_arg_1._widget.hasClub))) && (!(_arg_1._widget.hasEffectOn)))){
                _arg_1._mode = _SafeStr_6852;
            }
            else {
                if (((_arg_6.allowNameChange) && (_arg_1._widget.useMinimizedOwnAvatarMenu))){
                    _arg_1._mode = _SafeStr_6853;
                }
                else {
                    _arg_1._mode = _SafeStr_6851;
                };
            };
            AvatarInfoView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }

        override public function dispose():void
        {
            this._buttons = null;
            this._data = null;
            super.dispose();
        }
        override protected function updateWindow():void
        {
            var _local_1:XML;
            if (((((!(_widget)) || (!(_widget.assets)))) || (!(_widget.windowManager)))){
                return;
            };
            if (_SafeStr_6827){
                activeView = getMinimizedView();
            }
            else {
                if (!_window){
                    _local_1 = (XmlAsset(_widget.assets.getAssetByName("own_avatar_menu")).content as XML);
                    _window = (_widget.windowManager.buildFromXML(_local_1, 0) as IWindowContainer);
                    if (!_window){
                        return;
                    };
                    _window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseHoverEvent);
                    _window.addEventListener(WindowMouseEvent.WME_OUT, onMouseHoverEvent);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, onMinimize);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMinimizeHover);
                    _window.findChildByName("minimize").addEventListener(WindowMouseEvent.WME_OUT, onMinimizeHover);
                };
                this._buttons = (_window.findChildByName("buttons") as IItemListWindow);
                this._buttons.procedure = this.buttonEventProc;
                _window.findChildByName("name").caption = _userName;
                _window.visible = false;
                activeView = _window;
                this.updateButtons();
            };
        }
        public function updateButtons():void
        {
            if (((((!(_window)) || (!(this._data)))) || (!(this._buttons)))){
                return;
            };
            this._buttons.autoArrangeItems = false;
            var _local_1:int = this._buttons.numListItems;
            var _local_2:int;
            while (_local_2 < _local_1) {
                this._buttons.getListItemAt(_local_2).visible = false;
                _local_2++;
            };
            switch (this._mode){
                case _SafeStr_6851:
                    this.showButton("change_name", this._data.allowNameChange);
                    this.showButton("change_looks");
                    this.showButton("dance_menu", _widget.hasClub, !(_widget.hasEffectOn));
                    this.showButton("dance", ((!(_widget.hasClub)) && (!(_widget.isDancing))), !(_widget.hasEffectOn));
                    this.showButton("dance_stop", ((!(_widget.hasClub)) && (_widget.isDancing)));
                    this.showButton("wave", true, !(_widget.hasEffectOn));
                    this.showButton("effects", true);
                    break;
                case _SafeStr_6852:
                    this.showButton("dance_stop", true, _widget.isDancing);
                    this.showButton("dance_1");
                    this.showButton("dance_2");
                    this.showButton("dance_3");
                    this.showButton("dance_4");
                    this.showButton("back");
                    break;
                case _SafeStr_6853:
                    this.showButton("change_name");
                    this.showButton("more");
                    break;
            };
            this._buttons.autoArrangeItems = true;
            this._buttons.visible = true;
        }
        private function showButton(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=true):void
        {
            if (!this._buttons){
                return;
            };
            var _local_4:IWindowContainer = (this._buttons.getListItemByName(_arg_1) as IWindowContainer);
            if (!_local_4){
                return;
            };
            _local_4.visible = _arg_2;
            var _local_5:IWindowContainer = (_local_4.getChildByName("button") as IWindowContainer);
            if (_arg_3){
                _local_5.enable();
            }
            else {
                _local_5.disable();
            };
            var _local_6:ITextWindow = (_local_5.getChildByName("label") as ITextWindow);
            _local_6.textColor = ((_arg_3) ? _SafeStr_6821 : _SafeStr_6822);
            var _local_7:IIconWindow = (_local_5.getChildByName("icon") as IIconWindow);
            if (_local_7){
                _local_7.color = ((_arg_3) ? _SafeStr_6823 : _SafeStr_6824);
                if (_local_7.tags.indexOf("arrow_left") != -1){
                    _local_7.x = (((_local_6.x + ((_local_6.width - _local_6.textWidth) / 2)) - _local_7.width) - _SafeStr_6854);
                };
                if (_local_7.tags.indexOf("arrow_right") != -1){
                    _local_7.x = ((_local_6.x + ((_local_6.width + _local_6.textWidth) / 2)) + _SafeStr_6854);
                };
            };
        }
        private function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:RoomWidgetMessage;
            var _local_5:String;
            if (disposed){
                return;
            };
            if (((!(_window)) || (_window.disposed))){
                return;
            };
            var _local_3:Boolean;
            if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                if (_arg_2.name == "button"){
                    _local_3 = true;
                    switch (_arg_2.parent.name){
                        case "change_name":
                            _local_4 = new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_START_NAME_CHANGE);
                            break;
                        case "change_looks":
                            _widget.openAvatarEditor();
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "clothes");
                            break;
                        case "wave":
                            _local_4 = new RoomWidgetWaveMessage();
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "wave");
                            break;
                        case "dance_menu":
                            _local_3 = false;
                            this.changeMode(_SafeStr_6852);
                            break;
                        case "dance":
                            _local_4 = new RoomWidgetDanceMessage(1);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "dance_stop":
                            _local_4 = new RoomWidgetDanceMessage(0);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_stop");
                            break;
                        case "dance_1":
                        case "dance_2":
                        case "dance_3":
                        case "dance_4":
                            _local_4 = new RoomWidgetDanceMessage(parseInt(_arg_2.parent.name.charAt((_arg_2.parent.name.length - 1))));
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "dance_start");
                            break;
                        case "effects":
                            _local_4 = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_EFFECTS);
                            HabboTracking.getInstance().trackEventLog("OwnAvatarMenu", "click", "effects");
                            break;
                        case "back":
                            _local_3 = false;
                            this.changeMode(_SafeStr_6851);
                            break;
                        case "more":
                            _local_3 = false;
                            _widget.useMinimizedOwnAvatarMenu = false;
                            this.changeMode(_SafeStr_6851);
                            break;
                    };
                };
                if (_local_4){
                    _widget.messageListener.processWidgetMessage(_local_4);
                };
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    if (_arg_2.name == "button"){
                        _arg_2.color = _SafeStr_6817;
                    }
                    else {
                        if (_arg_2.tags.indexOf("link") > -1){
                            if (_arg_2.tags.indexOf("actions") > -1){
                                ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = _SafeStr_6820;
                            };
                        };
                    };
                }
                else {
                    if (_arg_1.type == WindowMouseEvent.WME_OUT){
                        if (_arg_2.name == "button"){
                            _arg_2.color = _SafeStr_6816;
                        }
                        else {
                            if (_arg_2.tags.indexOf("link") > -1){
                                if (_arg_2.tags.indexOf("actions") > -1){
                                    ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = _SafeStr_6819;
                                };
                            };
                        };
                    };
                };
            };
            if (_local_3){
                _widget.removeView(this, false);
            };
        }
        private function changeMode(_arg_1:int):void
        {
            this._mode = _arg_1;
            this.updateButtons();
        }

    }
}//package com.sulake.habbo.ui.widget.avatarinfo

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// AvatarInfoView = "_-1fg" (String#5659, DoABC#2)
// OwnAvatarMenuView = "_-3Aa" (String#7525, DoABC#2)
// AvatarInfoData = "_-2Wz" (String#20322, DoABC#2)
// RoomWidgetWaveMessage = "_-OB" (String#8167, DoABC#2)
// RoomWidgetDanceMessage = "_-1CY" (String#5117, DoABC#2)
// RWRWM_EFFECTS = "_-9y" (String#22615, DoABC#2)
// RWUAM_START_NAME_CHANGE = "_-21I" (String#19065, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _mode = "_-1kk" (String#611, DoABC#2)
// updateButtons = "_-i5" (String#942, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// _SafeStr_6816 = "_-9d" (String#22605, DoABC#2)
// _SafeStr_6817 = "_-31y" (String#21577, DoABC#2)
// _SafeStr_6819 = "_-05y" (String#14281, DoABC#2)
// _SafeStr_6820 = "_-gZ" (String#23915, DoABC#2)
// _SafeStr_6821 = "_-00J" (String#14067, DoABC#2)
// _SafeStr_6822 = "_-RS" (String#23302, DoABC#2)
// _SafeStr_6823 = "_-3Ac" (String#21905, DoABC#2)
// _SafeStr_6824 = "_-3Hu" (String#22198, DoABC#2)
// _SafeStr_6827 = "_-0Pc" (String#4085, DoABC#2)
// _SafeStr_6841 = "_-Jp" (String#22999, DoABC#2)
// updateWindow = "_-2s1" (String#451, DoABC#2)
// activeView = "_-2aO" (String#20459, DoABC#2)
// onMouseHoverEvent = "_-k9" (String#24042, DoABC#2)
// getMinimizedView = "_-03T" (String#14180, DoABC#2)
// onMinimizeHover = "_-DL" (String#22744, DoABC#2)
// onMinimize = "_-1Gr" (String#17145, DoABC#2)
// _SafeStr_6851 = "_-0t4" (String#16162, DoABC#2)
// _SafeStr_6852 = "_-3Ff" (String#22103, DoABC#2)
// _SafeStr_6853 = "_-38R" (String#21821, DoABC#2)
// _SafeStr_6854 = "_-0qg" (String#4655, DoABC#2)
// buttonEventProc = "_-kN" (String#8608, DoABC#2)
// showButton = "_-P4" (String#461, DoABC#2)
// changeMode = "_-03X" (String#14183, DoABC#2)


