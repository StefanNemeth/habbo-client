
package com.sulake.habbo.ui.widget.avatarinfo
{
    import _-1s._SafeStr_6858;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.tracking.HabboTracking;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class AvatarMenuView extends AvatarInfoView 
    {

        protected static const _SafeStr_6858:uint = 1;
        protected static const _SafeStr_6859:uint = 2;
        protected static var _SafeStr_6860:uint = _SafeStr_6858;//1
        private static const _SafeStr_6861:uint = 16744755;
        private static const _SafeStr_6862:uint = 16756591;
        private static const _SafeStr_6854:int = 8;

        protected var _data:AvatarInfoData;
        protected var _mode:uint = 1;
        protected var _SafeStr_6863:Boolean;
        private var _buttons:IItemListWindow;

        public function AvatarMenuView(_arg_1:AvatarInfoWidget)
        {
            super(_arg_1);
            _SafeStr_6841 = false;
        }
        public static function setup(_arg_1:AvatarMenuView, _arg_2:int, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:AvatarInfoData):void
        {
            _arg_1._data = _arg_6;
            AvatarInfoView.setup(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, false);
        }

        override public function dispose():void
        {
            if (_window){
                _window.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, onMouseHoverEvent);
                _window.removeEventListener(WindowMouseEvent.WME_OUT, onMouseHoverEvent);
            };
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
                    _local_1 = (XmlAsset(_widget.assets.getAssetByName("avatar_menu_widget")).content as XML);
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
        protected function updateButtons():void
        {
            var _local_4:int;
            var _local_5:String;
            if (((!(_window)) || (!(this._data)))){
                return;
            };
            var _local_1:IItemListWindow = (_window.findChildByName("buttons") as IItemListWindow);
            if (!_local_1){
                return;
            };
            _local_1.procedure = this.buttonEventProc;
            _local_1.autoArrangeItems = false;
            var _local_2:int = _local_1.numListItems;
            var _local_3:int;
            while (_local_3 < _local_2) {
                _local_1.getListItemAt(_local_3).visible = false;
                _local_3++;
            };
            if (!this._SafeStr_6863){
                if (this._data.isIgnored){
                    this._mode = _SafeStr_6859;
                }
                else {
                    this._mode = _SafeStr_6860;
                };
            };
            if (this._mode == _SafeStr_6858){
                this.showButton("moderate");
                this.showButton("friend", this._data.canBeAskedAsFriend);
                _local_4 = this._data.respectLeft;
                _widget.localizations.registerParameter("infostand.button.respect", "count", _local_4.toString());
                this.showButton("respect", (_local_4 > 0));
                this.showButton("trade", this._data.canTrade);
                switch (this._data.canTradeReason){
                    case RoomWidgetUserInfoUpdateEvent._SafeStr_6864:
                        _local_5 = "${infostand.button.trade.tooltip.shutdown}";
                        break;
                    case RoomWidgetUserInfoUpdateEvent._SafeStr_6865:
                        _local_5 = "${infostand.button.trade.tooltip.tradingroom}";
                        break;
                    default:
                        _local_5 = "";
                };
                IInteractiveWindow(IWindowContainer(_local_1.getListItemByName("trade")).getChildByName("button")).toolTipCaption = _local_5;
                this.showButton("whisper");
            };
            if (this._mode == _SafeStr_6859){
                this.showButton("ignore", !(this._data.isIgnored));
                this.showButton("unignore", this._data.isIgnored);
                this.showButton("kick", ((((((this._data.amIOwner) || (this._data.amIController))) || (this._data.amIAnyRoomController))) && (this._data.canBeKicked)));
                this.showButton("ban", ((((this._data.amIOwner) || (this._data.amIAnyRoomController))) && (this._data.canBeKicked)));
                this.showButton("report", ((_widget.configuration) && (_widget.configuration.getBoolean("infostand.report.show", false))));
                this.showButton("give_rights", ((this._data.amIOwner) && (!(this._data.hasFlatControl))));
                this.showButton("remove_rights", ((this._data.amIOwner) && (this._data.hasFlatControl)));
                this.showButton("actions");
            };
            _local_1.autoArrangeItems = true;
            _local_1.visible = true;
            _SafeStr_6860 = this._mode;
            this._SafeStr_6863 = false;
        }
        private function showButton(_arg_1:String, _arg_2:Boolean=true):void
        {
            if (!this._buttons){
                return;
            };
            var _local_3:IWindowContainer = (this._buttons.getListItemByName(_arg_1) as IWindowContainer);
            if (!_local_3){
                return;
            };
            _local_3.visible = _arg_2;
            var _local_4:IWindowContainer = (_local_3.getChildByName("button") as IWindowContainer);
            var _local_5:ITextWindow = (_local_4.getChildByName("label") as ITextWindow);
            var _local_6:IIconWindow = (_local_4.getChildByName("icon") as IIconWindow);
            if (_local_6){
                if (_local_6.tags.indexOf("arrow_left") != -1){
                    _local_6.x = (((_local_5.x + ((_local_5.width - _local_5.textWidth) / 2)) - _local_6.width) - _SafeStr_6854);
                };
                if (_local_6.tags.indexOf("arrow_right") != -1){
                    _local_6.x = ((_local_5.x + ((_local_5.width + _local_5.textWidth) / 2)) + _SafeStr_6854);
                };
            };
        }
        private function buttonEventProc(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:RoomWidgetMessage;
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
                        case "whisper":
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_WHISPER_USER;
                            break;
                        case "friend":
                            _arg_2.disable();
                            this._data.canBeAskedAsFriend = false;
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_SEND_FRIEND_REQUEST;
                            break;
                        case "respect":
                            this._data.respectLeft--;
                            _local_5 = this._data.respectLeft;
                            _widget.localizations.registerParameter("infostand.button.respect", "count", _local_5.toString());
                            this.showButton("respect", (this._data.respectLeft > 0));
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_RESPECT_USER;
                            if (_local_5 > 0){
                                _local_3 = false;
                            };
                            break;
                        case "ignore":
                            _arg_2.parent.visible = false;
                            _window.findChildByName("unignore").visible = true;
                            this._data.isIgnored = true;
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_IGNORE_USER;
                            break;
                        case "unignore":
                            _arg_2.parent.visible = false;
                            _window.findChildByName("ignore").visible = true;
                            this._data.isIgnored = false;
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_UNIGNORE_USER;
                            break;
                        case "kick":
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_KICK_USER;
                            break;
                        case "ban":
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_BAN_USER;
                            break;
                        case "give_rights":
                            _arg_2.parent.visible = false;
                            _window.findChildByName("remove_rights").visible = true;
                            this._data.hasFlatControl = true;
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_GIVE_RIGHTS;
                            break;
                        case "remove_rights":
                            _arg_2.parent.visible = false;
                            _window.findChildByName("give_rights").visible = true;
                            this._data.hasFlatControl = false;
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_TAKE_RIGHTS;
                            break;
                        case "trade":
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_START_TRADING;
                            break;
                        case "report":
                            _local_4 = RoomWidgetUserActionMessage.RWUAM_REPORT;
                            break;
                        case "moderate":
                            this._mode = _SafeStr_6859;
                            this._SafeStr_6863 = true;
                            _local_3 = false;
                            break;
                        case "actions":
                            this._mode = _SafeStr_6858;
                            this._SafeStr_6863 = true;
                            _local_3 = false;
                            break;
                    };
                };
                if (_local_4 != null){
                    _local_6 = new RoomWidgetUserActionMessage(_local_4, _userId);
                    _widget.messageListener.processWidgetMessage(_local_6);
                    HabboTracking.getInstance().trackEventLog("InfoStand", "click", _local_4);
                };
                this.updateButtons();
            }
            else {
                if (_arg_1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER){
                    if (_arg_2.name == "button"){
                        _arg_2.color = (((_arg_2.tags.indexOf("moderate") > -1)) ? _SafeStr_6818 : _SafeStr_6817);
                    }
                    else {
                        if (_arg_2.tags.indexOf("link") > -1){
                            if (_arg_2.tags.indexOf("actions") > -1){
                                ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = _SafeStr_6820;
                            }
                            else {
                                if (_arg_2.tags.indexOf("moderate") > -1){
                                    ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = _SafeStr_6862;
                                };
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
                                }
                                else {
                                    if (_arg_2.tags.indexOf("moderate") > -1){
                                        ITextWindow(IWindowContainer(_arg_2).getChildAt(0)).textColor = _SafeStr_6861;
                                    };
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

    }
}//package com.sulake.habbo.ui.widget.avatarinfo

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// IInteractiveWindow = "_-0KX" (String#1454, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// AvatarInfoView = "_-1fg" (String#5659, DoABC#2)
// AvatarMenuView = "_-Oi" (String#8178, DoABC#2)
// AvatarInfoData = "_-2Wz" (String#20322, DoABC#2)
// RWUAM_WHISPER_USER = "_-0oT" (String#15994, DoABC#2)
// RWUAM_IGNORE_USER = "_-XM" (String#23537, DoABC#2)
// RWUAM_UNIGNORE_USER = "_-1-L" (String#16442, DoABC#2)
// RWUAM_KICK_USER = "_-02D" (String#14135, DoABC#2)
// RWUAM_BAN_USER = "_-0ex" (String#15625, DoABC#2)
// RWUAM_SEND_FRIEND_REQUEST = "_-2XL" (String#20336, DoABC#2)
// RWUAM_RESPECT_USER = "_-6j" (String#22488, DoABC#2)
// RWUAM_GIVE_RIGHTS = "_-1ns" (String#18455, DoABC#2)
// RWUAM_TAKE_RIGHTS = "_-20C" (String#19019, DoABC#2)
// RWUAM_START_TRADING = "_-J3" (String#22970, DoABC#2)
// RWUAM_REPORT = "_-3-T" (String#21480, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _mode = "_-1kk" (String#611, DoABC#2)
// updateButtons = "_-i5" (String#942, DoABC#2)
// amIAnyRoomController = "_-09r" (String#14441, DoABC#2)
// amIController = "_-01W" (String#14111, DoABC#2)
// amIOwner = "_-15r" (String#16691, DoABC#2)
// canBeAskedAsFriend = "_-0c9" (String#15521, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// canTrade = "_-07S" (String#14342, DoABC#2)
// canTradeReason = "_-01A" (String#14098, DoABC#2)
// hasFlatControl = "_-282" (String#19332, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// _SafeStr_6816 = "_-9d" (String#22605, DoABC#2)
// _SafeStr_6817 = "_-31y" (String#21577, DoABC#2)
// _SafeStr_6818 = "_-0YQ" (String#15376, DoABC#2)
// _SafeStr_6819 = "_-05y" (String#14281, DoABC#2)
// _SafeStr_6820 = "_-gZ" (String#23915, DoABC#2)
// _SafeStr_6827 = "_-0Pc" (String#4085, DoABC#2)
// _SafeStr_6841 = "_-Jp" (String#22999, DoABC#2)
// updateWindow = "_-2s1" (String#451, DoABC#2)
// activeView = "_-2aO" (String#20459, DoABC#2)
// onMouseHoverEvent = "_-k9" (String#24042, DoABC#2)
// getMinimizedView = "_-03T" (String#14180, DoABC#2)
// onMinimizeHover = "_-DL" (String#22744, DoABC#2)
// onMinimize = "_-1Gr" (String#17145, DoABC#2)
// _SafeStr_6854 = "_-0qg" (String#4655, DoABC#2)
// buttonEventProc = "_-kN" (String#8608, DoABC#2)
// showButton = "_-P4" (String#461, DoABC#2)
// _SafeStr_6858 = "_-Q-" (String#23250, DoABC#2)
// _SafeStr_6859 = "_-0If" (String#14787, DoABC#2)
// _SafeStr_6860 = "_-W2" (String#23494, DoABC#2)
// _SafeStr_6861 = "_-0TV" (String#15192, DoABC#2)
// _SafeStr_6862 = "_-2yA" (String#21400, DoABC#2)
// _SafeStr_6863 = "_-0f1" (String#15630, DoABC#2)
// _SafeStr_6864 = "_-19C" (String#16825, DoABC#2)
// _SafeStr_6865 = "_-2u2" (String#21240, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)


