
package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.core.window.components.IRadioButtonWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveableRoomSettingsData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomSettingsCtrl 
    {

        private var _SafeStr_6899:Boolean;
        private var _owner:IRoomSettingsCtrlOwner;
        private var _flatId:int;
        private var _navigator:HabboNavigator;
        private var _SafeStr_6900:RoomSettingsData;
        private var _SafeStr_6901:int;
        private var _window:IWindowContainer;
        private var _active:Boolean;
        private var _SafeStr_6902:Boolean;
        private var _SafeStr_6903:Boolean;
        private var _SafeStr_6904:TextFieldManager;
        private var _SafeStr_6905:TextFieldManager;
        private var _SafeStr_6906:TextFieldManager;
        private var _SafeStr_6907:TextFieldManager;
        private var _passwordInput:TextFieldManager;
        private var _SafeStr_6909:TextFieldManager;
        private var _SafeStr_6910:ICheckBoxWindow;
        private var _SafeStr_6911:ICheckBoxWindow;
        private var _SafeStr_6912:ICheckBoxWindow;
        private var _SafeStr_6913:ICheckBoxWindow;
        private var _SafeStr_6914:ITextWindow;
        private var _SafeStr_6915:IDropMenuWindow;
        private var _SafeStr_6916:IDropMenuWindow;
        private var _SafeStr_6917:IWindowContainer;
        private var _SafeStr_6918:IWindowContainer;
        private var _SafeStr_6919:IWindowContainer;
        private var _SafeStr_6920:IWindowContainer;
        private var _SafeStr_6921:IWindowContainer;
        private var _SafeStr_6922:IWindowContainer;
        private var _SafeStr_6923:IWindowContainer;
        private var _SafeStr_6924:ITextWindow;

        public function RoomSettingsCtrl(_arg_1:HabboNavigator, _arg_2:IRoomSettingsCtrlOwner, _arg_3:Boolean)
        {
            this._navigator = _arg_1;
            this._owner = _arg_2;
            this._SafeStr_6899 = _arg_3;
        }
        public function set active(_arg_1:Boolean):void
        {
            this._active = _arg_1;
        }
        public function get active():Boolean
        {
            return (this._active);
        }
        public function RoomSettingsCtrl():void
        {
            this._SafeStr_6903 = false;
        }
        public function load(_arg_1:int):void
        {
            this._flatId = _arg_1;
            this._navigator.send(new GetRoomSettingsMessageComposer(this._flatId));
            if (this._SafeStr_6923 != null){
                this._SafeStr_6923.visible = false;
            };
        }
        public function RoomSettingsCtrl(_arg_1:RoomSettingsData):void
        {
            if (_arg_1.roomId != this._flatId){
                return;
            };
            this._SafeStr_6900 = _arg_1;
            this._active = true;
            this._SafeStr_6902 = true;
            this._owner.roomSettingsRefreshNeeded();
        }
        public function IncomingMessages(_arg_1:int, _arg_2:FlatControllerData):void
        {
            if (_arg_1 != this._flatId){
                return;
            };
            if (this._SafeStr_6900 == null){
                return;
            };
            if (!this.RoomSettingsCtrl(_arg_2.userId)){
                this._SafeStr_6900.controllers.splice(0, 0, _arg_2);
                this._SafeStr_6900.controllerCount++;
            };
            if (this._SafeStr_6903){
                this._owner.roomSettingsRefreshNeeded();
            };
        }
        private function RoomSettingsCtrl(_arg_1:int):Boolean
        {
            var _local_3:FlatControllerData;
            var _local_2:int;
            while (_local_2 < this._SafeStr_6900.controllers.length) {
                _local_3 = this._SafeStr_6900.controllers[_local_2];
                if (_local_3.userId == _arg_1){
                    return (true);
                };
                _local_2++;
            };
            return (false);
        }
        public function IncomingMessages(_arg_1:int, _arg_2:int):void
        {
            var _local_4:FlatControllerData;
            if (_arg_1 != this._flatId){
                return;
            };
            if (this._SafeStr_6900 == null){
                return;
            };
            this._SafeStr_6900.controllerCount--;
            var _local_3:int;
            while (_local_3 < this._SafeStr_6900.controllers.length) {
                _local_4 = this._SafeStr_6900.controllers[_local_3];
                if (_local_4.userId == _arg_2){
                    this._SafeStr_6900.controllers.splice(_local_3, 1);
                }
                else {
                    _local_3++;
                };
            };
            if (this._SafeStr_6903){
                this._owner.roomSettingsRefreshNeeded();
            };
        }
        public function IncomingMessages(_arg_1:int):void
        {
            if (((!((_arg_1 == this._flatId))) || ((this._SafeStr_6901 < 1)))){
                return;
            };
            this.close();
            this._owner.roomSettingsRefreshNeeded();
        }
        public function IncomingMessages(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            if (((!((_arg_1 == this._flatId))) || ((this._SafeStr_6901 < 1)))){
                return;
            };
            this._SafeStr_6901 = 0;
            if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5570){
                this._SafeStr_6904.displayError("${navigator.roomsettings.roomnameismandatory}");
            }
            else {
                if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5571){
                    this._SafeStr_6904.displayError("${navigator.roomsettings.unacceptablewords}");
                }
                else {
                    if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5573){
                        this._SafeStr_6905.displayError("${navigator.roomsettings.unacceptablewords}");
                    }
                    else {
                        if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5574){
                            this.RoomSettingsCtrl(this._SafeStr_6906, _arg_3, "${navigator.roomsettings.unacceptablewords}");
                            this.RoomSettingsCtrl(this._SafeStr_6907, _arg_3, "${navigator.roomsettings.unacceptablewords}");
                        }
                        else {
                            if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5575){
                                this.RoomSettingsCtrl(this._SafeStr_6906, _arg_3, "${navigator.roomsettings.nonuserchoosabletag}");
                                this.RoomSettingsCtrl(this._SafeStr_6907, _arg_3, "${navigator.roomsettings.nonuserchoosabletag}");
                            }
                            else {
                                if (_arg_2 == RoomSettingsSaveErrorMessageParser._SafeStr_5568){
                                    this._passwordInput.displayError("${navigator.roomsettings.passwordismandatory}");
                                }
                                else {
                                    this._SafeStr_6904.displayError(("Update failed: error " + _arg_2));
                                };
                            };
                        };
                    };
                };
            };
        }
        private function RoomSettingsCtrl(_arg_1:TextFieldManager, _arg_2:String, _arg_3:String):void
        {
            if (_arg_2 == _arg_1.getText().toLowerCase()){
                _arg_1.displayError(_arg_3);
            };
        }
        public function close():void
        {
            this._active = false;
            this._flatId = 0;
            this._SafeStr_6900 = null;
            this._SafeStr_6901 = 0;
        }
        private function clearErrors():void
        {
            this._SafeStr_6904.clearErrors();
            this._SafeStr_6905.clearErrors();
            this._SafeStr_6906.clearErrors();
            this._SafeStr_6907.clearErrors();
            this._passwordInput.clearErrors();
            this._SafeStr_6909.clearErrors();
        }
        private function prepareWindow(_arg_1:IWindowContainer):void
        {
            if (this._window != null){
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("ros_room_settings"));
            _arg_1.addChildAt(this._window, 0);
            var _local_2:IRadioButtonWindow = (this._window.findChildByName("doormode_password") as IRadioButtonWindow);
            _local_2.addEventListener(WindowEvent.WE_SELECT, this.RoomSettingsCtrl);
            _local_2.addEventListener(WindowEvent.WE_UNSELECT, this.RoomSettingsCtrl);
            this.RoomSettingsCtrl().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this.getCancelButton().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomEventViewCtrl);
            this.RoomSettingsCtrl().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this.RoomSettingsCtrl().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this.RoomSettingsCtrl().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this.RoomSettingsCtrl().addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this._SafeStr_6904 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("room_name")), 60);
            this._SafeStr_6905 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("description")), 0xFF);
            this._SafeStr_6906 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag1")), 30);
            this._SafeStr_6907 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("tag2")), 30);
            this._passwordInput = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password")), 30);
            this._SafeStr_6909 = new TextFieldManager(this._navigator, ITextFieldWindow(this._window.findChildByName("password_confirm")), 30);
            this._SafeStr_6910 = ICheckBoxWindow(this._window.findChildByName("allow_pets_checkbox"));
            this._SafeStr_6911 = ICheckBoxWindow(this._window.findChildByName("allow_foodconsume_checkbox"));
            this._SafeStr_6912 = ICheckBoxWindow(this._window.findChildByName("allow_walk_through_checkbox"));
            this._SafeStr_6913 = ICheckBoxWindow(this._window.findChildByName("hide_walls_checkbox"));
            this._SafeStr_6914 = (this._window.findChildByName("hide_walls_text") as ITextWindow);
            this._SafeStr_6915 = IDropMenuWindow(this._window.findChildByName("wall_thickness"));
            this._SafeStr_6916 = IDropMenuWindow(this._window.findChildByName("floor_thickness"));
            this._SafeStr_6917 = IWindowContainer(this._window.findChildByName("thumbnail_container"));
            this._SafeStr_6918 = IWindowContainer(this._window.findChildByName("basic_settings_container"));
            this._SafeStr_6919 = IWindowContainer(this._window.findChildByName("advanced_settings_container"));
            this._SafeStr_6920 = IWindowContainer(this._window.findChildByName("switch_view_container"));
            this._SafeStr_6921 = IWindowContainer(this._window.findChildByName("footer_container"));
            this._SafeStr_6922 = IWindowContainer(this._window.findChildByName("flat_controllers_container"));
            this._SafeStr_6923 = IWindowContainer(this._window.findChildByName("password_container"));
            this._SafeStr_6924 = ITextWindow(this._window.findChildByName("switch_view_text"));
            this._SafeStr_6924.mouseThreshold = 0;
            this._SafeStr_6924.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
            this._SafeStr_6923.visible = false;
            if (!this._SafeStr_6899){
                this._window.color = 0xFFFFFFFF;
                Util.setColors(this._window, 0xFF000000);
            };
        }
        private function RoomSettingsCtrl():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("save")));
        }
        private function getCancelButton():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("cancel")));
        }
        private function RoomSettingsCtrl():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("delete")));
        }
        private function RoomSettingsCtrl():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("edit_thumbnail")));
        }
        private function RoomSettingsCtrl():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("remove_all_flat_ctrls")));
        }
        private function RoomSettingsCtrl():IButtonWindow
        {
            return (IButtonWindow(this._window.findChildByName("remove_flat_ctrl")));
        }
        public function refresh(_arg_1:IWindowContainer):void
        {
            if (!this._active){
                return;
            };
            this.prepareWindow(_arg_1);
            Util.InfostandWidget(this._window);
            this._SafeStr_6920.visible = this._SafeStr_6899;
            this.RoomSettingsCtrl();
            if (this._SafeStr_6903){
                this._SafeStr_6919.visible = true;
                this._SafeStr_6921.visible = true;
                this.RoomSettingsCtrl();
                this._SafeStr_6919.height = (Util.getLowestPoint(this._SafeStr_6919) + 4);
            }
            else {
                this._SafeStr_6918.visible = true;
                this._SafeStr_6921.visible = true;
                this._SafeStr_6917.visible = this._SafeStr_6899;
                this._SafeStr_6918.height = (Util.getLowestPoint(this._SafeStr_6918) + 4);
            };
            this._SafeStr_6924.text = ((this._SafeStr_6903) ? "${navigator.roomsettings.tobasicsettings}" : "${navigator.roomsettings.toadvancedsettings}");
            Util.moveChildrenToColumn(this._window, [this._SafeStr_6918.name, this._SafeStr_6919.name, this._SafeStr_6921.name, this._SafeStr_6920.name], 0, 0);
            this._window.height = (Util.getLowestPoint(this._window) + 4);
            this._window.visible = true;
        }
        private function RoomSettingsCtrl(_arg_1:IWindow):void
        {
            if (_arg_1 != null){
                _arg_1.disable();
                _arg_1.blend = 0.5;
            };
        }
        private function RoomSettingsCtrl(_arg_1:IWindow):void
        {
            if (_arg_1 != null){
                _arg_1.enable();
                _arg_1.blend = 1;
            };
        }
        private function RoomSettingsCtrl(_arg_1:int):int
        {
            switch (_arg_1){
                case -2:
                    return (0);
                case -1:
                    return (1);
                case 1:
                    return (3);
                default:
                    return (2);
            };
        }
        private function RoomSettingsCtrl():void
        {
            var _local_4:IRadioButtonWindow;
            var _local_5:IRadioButtonWindow;
            if (!this._SafeStr_6902){
                return;
            };
            this._SafeStr_6902 = false;
            var _local_1:RoomSettingsData = this._SafeStr_6900;
            this._SafeStr_6904.CurrencyIndicatorBase(_local_1.name);
            this._SafeStr_6905.CurrencyIndicatorBase(_local_1.description);
            this._passwordInput.CurrencyIndicatorBase("");
            this._SafeStr_6909.CurrencyIndicatorBase("");
            var _local_2:ISelectorWindow = (this._window.findChildByName("doormode") as ISelectorWindow);
            var _local_3:IRadioButtonWindow = (this._window.findChildByName("doormode_password") as IRadioButtonWindow);
            switch (_local_1.doorMode){
                case RoomSettingsData._SafeStr_4188:
                    _local_4 = (this._window.findChildByName("doormode_doorbell") as IRadioButtonWindow);
                    _local_2.setSelected(_local_4);
                    break;
                case RoomSettingsData._SafeStr_4148:
                    _local_2.setSelected(_local_3);
                    break;
                default:
                    _local_5 = (this._window.findChildByName("doormode_open") as IRadioButtonWindow);
                    _local_2.setSelected(_local_5);
            };
            this.RoomSettingsCtrl((_local_1.doorMode == RoomSettingsData._SafeStr_4148));
            Logger.log(("CATEGORY ID: " + _local_1.categoryId));
            this.RoomSettingsCtrl(_local_1.categoryId);
            this.RoomSettingsCtrl(_local_1);
            this.DirectionData(this._SafeStr_6906, _local_1.tags[0]);
            this.DirectionData(this._SafeStr_6907, _local_1.tags[1]);
            if (this._SafeStr_6910){
                if (_local_1.allowPets){
                    this._SafeStr_6910.select();
                }
                else {
                    this._SafeStr_6910.ISelectableWindow();
                };
            };
            if (this._SafeStr_6911){
                if (_local_1.allowFoodConsume){
                    this._SafeStr_6911.select();
                }
                else {
                    this._SafeStr_6911.ISelectableWindow();
                };
            };
            if (this._SafeStr_6912){
                if (_local_1.allowWalkThrough){
                    this._SafeStr_6912.select();
                }
                else {
                    this._SafeStr_6912.ISelectableWindow();
                };
            };
            if (!this.RoomSettingsCtrl()){
                this.RoomSettingsCtrl(this._SafeStr_6913);
                this.RoomSettingsCtrl(this._SafeStr_6915);
                this.RoomSettingsCtrl(this._SafeStr_6916);
                this.RoomSettingsCtrl(this._SafeStr_6914);
            }
            else {
                this.RoomSettingsCtrl(this._SafeStr_6913);
                this.RoomSettingsCtrl(this._SafeStr_6915);
                this.RoomSettingsCtrl(this._SafeStr_6916);
                this.RoomSettingsCtrl(this._SafeStr_6914);
            };
            if (this._SafeStr_6913){
                if (_local_1.hideWalls){
                    this._SafeStr_6913.select();
                }
                else {
                    this._SafeStr_6913.ISelectableWindow();
                };
            };
            if (this._SafeStr_6915){
                this._SafeStr_6915.selection = this.RoomSettingsCtrl(_local_1.wallThickness);
            };
            if (this._SafeStr_6916){
                this._SafeStr_6916.selection = this.RoomSettingsCtrl(_local_1.floorThickness);
            };
            this.clearErrors();
        }
        private function RoomSettingsCtrl():Boolean
        {
            return (this._navigator.sessionData.hasUserRight("fuse_hide_room_walls", HabboClubLevelEnum._SafeStr_3939));
        }
        private function DirectionData(_arg_1:TextFieldManager, _arg_2:String):void
        {
            _arg_1.CurrencyIndicatorBase((((_arg_2 == null)) ? "" : _arg_2));
        }
        private function RoomSettingsCtrl(_arg_1:RoomSettingsData):void
        {
            var _local_2:Array = new Array();
            var _local_3:int = -1;
            var _local_4:int;
            var _local_5:int = 10;
            while (_local_5 <= _arg_1.maximumVisitorsLimit) {
                _local_2.push(("" + _local_5));
                if (_local_5 == _arg_1.maximumVisitors){
                    _local_3 = _local_4;
                };
                _local_4++;
                _local_5 = (_local_5 + 5);
            };
            var _local_6:IDropMenuWindow = (this._window.findChildByName("maxvisitors") as IDropMenuWindow);
            _local_6.populate(_local_2);
            _local_6.selection = (((_local_3 > -1)) ? _local_3 : 0);
        }
        private function RoomSettingsCtrl(_arg_1:int):void
        {
            var _local_6:FlatCategory;
            var _local_2:IDropMenuWindow = (this._window.findChildByName("categories") as IDropMenuWindow);
            var _local_3:Array = new Array();
            var _local_4:int;
            var _local_5:int;
            for each (_local_6 in this._navigator.data.allCategories) {
                if (((_local_6.visible) || ((_arg_1 == _local_6.nodeId)))){
                    _local_3.push(_local_6.nodeName);
                    if (_arg_1 == _local_6.nodeId){
                        _local_4 = _local_5;
                    };
                    _local_5++;
                };
            };
            _local_2.populate(_local_3);
            _local_2.selection = _local_4;
        }
        private function RoomSettingsCtrl(_arg_1:int, _arg_2:int):FlatCategory
        {
            var _local_4:FlatCategory;
            var _local_3:int;
            for each (_local_4 in this._navigator.data.allCategories) {
                if (((_local_4.visible) || ((_arg_1 == _local_4.nodeId)))){
                    if (_arg_2 == _local_3){
                        return (_local_4);
                    };
                    _local_3++;
                };
            };
            return (null);
        }
        private function RoomSettingsCtrl(_arg_1:WindowMouseEvent):void
        {
            this._navigator.roomInfoViewCtrl.startThumbnailEdit();
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            this._SafeStr_6903 = !(this._SafeStr_6903);
            this._owner.roomSettingsRefreshNeeded();
        }
        private function RoomSettingsCtrl(_arg_1:WindowMouseEvent):void
        {
            var _local_8:String;
            var _local_9:String;
            if ((((((this._SafeStr_6900 == null)) || ((this._window == null)))) || (this._window.disposed))){
                return;
            };
            var _local_2:SaveableRoomSettingsData = new SaveableRoomSettingsData();
            _local_2.roomId = this._SafeStr_6900.roomId;
            _local_2.name = this._SafeStr_6904.getText();
            _local_2.description = this._SafeStr_6905.getText();
            var _local_3:ISelectorWindow = (this._window.findChildByName("doormode") as ISelectorWindow);
            var _local_4:IWindow = _local_3.ISelectorWindow();
            switch (_local_4.name){
                case "doormode_doorbell":
                    _local_2.doorMode = RoomSettingsFlatInfo._SafeStr_4188;
                    break;
                case "doormode_password":
                    _local_2.doorMode = RoomSettingsFlatInfo._SafeStr_4148;
                    break;
                default:
                    _local_2.doorMode = RoomSettingsFlatInfo._SafeStr_5334;
            };
            if (_local_2.doorMode == RoomSettingsFlatInfo._SafeStr_4148){
                _local_8 = this._passwordInput.getText();
                _local_9 = this._SafeStr_6909.getText();
                if (_local_8 != _local_9){
                    this._passwordInput.clearErrors();
                    this._SafeStr_6909.displayError("${navigator.roomsettings.invalidconfirm}");
                    return;
                };
                if (_local_8 != ""){
                    _local_2.password = _local_8;
                };
            };
            var _local_5:IDropMenuWindow = (this._window.findChildByName("categories") as IDropMenuWindow);
            var _local_6:FlatCategory = this.RoomSettingsCtrl(this._SafeStr_6900.categoryId, _local_5.selection);
            _local_2.categoryId = _local_6.nodeId;
            var _local_7:IDropMenuWindow = (this._window.findChildByName("maxvisitors") as IDropMenuWindow);
            _local_2.maximumVisitors = (10 + (_local_7.selection * 5));
            _local_2.allowPets = this._SafeStr_6910.isSelected;
            _local_2.allowFoodConsume = this._SafeStr_6911.isSelected;
            _local_2.allowWalkThrough = this._SafeStr_6912.isSelected;
            _local_2.hideWalls = this._SafeStr_6913.isSelected;
            _local_2.wallThickness = (this._SafeStr_6915.selection - 2);
            _local_2.floorThickness = (this._SafeStr_6916.selection - 2);
            _local_2.tags = new Array();
            this.addTag(this._SafeStr_6906, _local_2.tags);
            this.addTag(this._SafeStr_6907, _local_2.tags);
            this.clearErrors();
            this._SafeStr_6901 = _local_2.roomId;
            this._navigator.send(new SaveRoomSettingsMessageComposer(_local_2));
        }
        private function addTag(_arg_1:TextFieldManager, _arg_2:Array):void
        {
            if (_arg_1.getText() != ""){
                _arg_2.push(_arg_1.getText());
            };
        }
        private function RoomEventViewCtrl(_arg_1:WindowMouseEvent):void
        {
            this.close();
            this._owner.roomSettingsRefreshNeeded();
        }
        private function RoomSettingsCtrl(_arg_1:WindowMouseEvent):void
        {
            Logger.log(("[RoomSettingsCtrl.onDeleteButtonClick] " + this._flatId));
            if (this._SafeStr_6900 == null){
                return;
            };
            this._navigator.registerParameter("navigator.roomsettings.deleteroom.confirm.message", "room_name", this._SafeStr_6900.name);
            var _local_2:ConfirmDialogView = new ConfirmDialogView(IFrameWindow(this._navigator.getXmlWindow("ros_room_delete_confirm")), this, this.RoomSettingsCtrl, [this._flatId]);
            _local_2.show();
        }
        private function RoomSettingsCtrl(_arg_1:WindowMouseEvent, _arg_2:int):void
        {
            var _local_3:GuestRoomSearchResultData;
            this._navigator.send(new DeleteRoomMessageComposer(_arg_2));
            this.close();
            this._owner.roomSettingsRefreshNeeded();
            if (this._navigator.data.guestRoomSearchResults != null){
                _local_3 = this._navigator.data.guestRoomSearchResults;
                this._navigator.mainViewCtrl.startSearch(this._navigator.tabs.ISelectorWindow().id, _local_3.searchType, _local_3.searchParam);
            };
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            this.RoomSettingsCtrl(true);
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            this.RoomSettingsCtrl(false);
        }
        private function RoomSettingsCtrl(_arg_1:Boolean):void
        {
            this._SafeStr_6923.visible = _arg_1;
            this._owner.roomSettingsRefreshNeeded();
        }
        private function RoomSettingsCtrl():void
        {
            var _local_5:IWindow;
            var _local_6:IWindow;
            var _local_7:IWindowContainer;
            var _local_8:Boolean;
            var _local_9:int;
            var _local_10:FlatControllerData;
            if ((((this._SafeStr_6922 == null)) || (this._SafeStr_6922.disposed))){
                return;
            };
            Util.InfostandWidget(this._SafeStr_6922);
            var _local_1:IWindow = this._SafeStr_6922.findChildByName("ruler");
            if (_local_1 != null){
                _local_1.visible = true;
            };
            var _local_2:IWindow = this._SafeStr_6922.findChildByName("flat_ctrls_caption_txt");
            if (_local_2 != null){
                this._navigator.registerParameter("navigator.roomsettings.flatctrls.caption", "cnt", ("" + this._SafeStr_6900.controllerCount));
                _local_2.visible = true;
            };
            var _local_3:IWindowContainer = IWindowContainer(this._SafeStr_6922.findChildByName("flat_controller_list"));
            if (_local_3 != null){
                Util.InfostandWidget(_local_3);
                if (this._SafeStr_6900 != null){
                    _local_8 = false;
                    _local_9 = 0;
                    while (_local_9 < this._SafeStr_6900.controllers.length) {
                        _local_10 = this._SafeStr_6900.controllers[_local_9];
                        this.RoomSettingsCtrl(_local_3, _local_9, _local_10);
                        if (_local_10.selected){
                            _local_8 = true;
                        };
                        _local_9++;
                    };
                };
                Util.layoutChildrenInArea(_local_3, _local_3.width, 15);
                _local_3.height = Util.getLowestPoint(_local_3);
                _local_5 = this._SafeStr_6922.findChildByName("flat_ctrls_info_txt");
                _local_6 = this._SafeStr_6922.findChildByName("flat_ctrls_limit_txt");
                _local_7 = IWindowContainer(this._SafeStr_6922.findChildByName("flat_controllers_footer"));
                if (((!((this._SafeStr_6900 == null))) && ((this._SafeStr_6900.controllers.length > 0)))){
                    _local_3.visible = true;
                    _local_7.visible = true;
                    _local_5.visible = true;
                    if (this._SafeStr_6900.controllerCount > this._SafeStr_6900.controllers.length){
                        this._navigator.registerParameter("navigator.roomsettings.flatctrls.limitinfo", "cnt", ("" + this._SafeStr_6900.controllers.length));
                        _local_6.visible = true;
                    };
                    Util.moveChildrenToColumn(this._SafeStr_6922, ["flat_ctrls_caption_txt", "flat_ctrls_limit_txt", "flat_controller_list", "flat_ctrls_info_txt", "flat_controllers_footer"], _local_2.y, 5);
                }
                else {
                    _local_7.visible = false;
                    _local_5.visible = false;
                    _local_7.y = ((_local_3.y + _local_3.height) + 5);
                };
            };
            var _local_4:IButtonWindow = IButtonWindow(this._SafeStr_6922.findChildByName("remove_flat_ctrl"));
            if (_local_4 != null){
                if (_local_8){
                    _local_4.enable();
                }
                else {
                    _local_4.disable();
                };
            };
            this._SafeStr_6922.height = Util.getLowestPoint(this._SafeStr_6922);
        }
        private function RoomSettingsCtrl(_arg_1:IWindowContainer, _arg_2:int, _arg_3:FlatControllerData):void
        {
            var _local_6:ITextWindow;
            var _local_4:String = ("fc." + _arg_2);
            var _local_5:IWindowContainer = IWindowContainer(_arg_1.getChildByName(_local_4));
            if (_arg_3 == null){
                if (_local_5 != null){
                    _local_5.visible = false;
                };
            }
            else {
                if (_local_5 == null){
                    _local_5 = this.RoomSettingsCtrl(_local_4);
                    _arg_1.addChild(_local_5);
                    _local_5.addChild(this._navigator.getXmlWindow("ros_flat_controller"));
                };
                _local_6 = ITextWindow(_local_5.findChildByName("flat_controller"));
                _local_6.text = _arg_3.userName;
                _local_6.id = _arg_3.userId;
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.RoomSettingsCtrl);
                _local_6.width = (_local_6.textWidth + 5);
                _local_5.width = (_local_6.width + 3);
                _local_5.height = _local_6.height;
                _local_6.color = ((_arg_3.selected) ? 0xFFFFFFFF : 4286216826);
                Logger.log(((((("HUMP: " + _arg_3.userName) + ", ") + _arg_3.selected) + ", ") + _local_6.textBackgroundColor));
                _local_5.visible = true;
            };
        }
        private function RoomSettingsCtrl(_arg_1:String):IWindowContainer
        {
            return (IWindowContainer(this._navigator.windowManager.createWindow(_arg_1, "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, 100, 20))));
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            var _local_2:ITextWindow = ITextWindow(_arg_1.target);
            var _local_3:int = _local_2.id;
            Logger.log(((("FC clicked: " + _local_2.name) + ", ") + _local_3));
            var _local_4:FlatControllerData = this.RoomSettingsCtrl(_local_3);
            if (_local_4 == null){
                Logger.log(("Couldn't find fc: " + _local_3));
                return;
            };
            _local_4.selected = !(_local_4.selected);
            this._owner.roomSettingsRefreshNeeded();
        }
        private function RoomSettingsCtrl(_arg_1:int):FlatControllerData
        {
            var _local_2:FlatControllerData;
            if (this._SafeStr_6900 != null){
                for each (_local_2 in this._SafeStr_6900.controllers) {
                    if (_local_2.userId == _arg_1){
                        return (_local_2);
                    };
                };
            };
            return (null);
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            Logger.log("Remove all clicked: ");
            this._navigator.send(new RemoveAllRightsMessageComposer(this._flatId));
        }
        private function RoomSettingsCtrl(_arg_1:WindowEvent):void
        {
            var _local_3:FlatControllerData;
            var _local_4:RemoveRightsMessageComposer;
            Logger.log("Remove clicked: ");
            if (this._SafeStr_6900 == null){
                return;
            };
            var _local_2:Array = new Array();
            for each (_local_3 in this._SafeStr_6900.controllers) {
                if (_local_3.selected){
                    _local_2.push(_local_3.userId);
                };
            };
            _local_4 = new RemoveRightsMessageComposer(_local_2);
            this._navigator.send(_local_4);
        }

    }
}//package com.sulake.habbo.navigator.roomsettings

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// IRoomSettingsCtrlOwner = "_-2px" (String#7077, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// IRadioButtonWindow = "_-234" (String#1804, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// RemoveRightsMessageComposer = "_-1Op" (String#17460, DoABC#2)
// GuestRoomSearchResultData = "_-SV" (String#8256, DoABC#2)
// FlatCategory = "_-1Lo" (String#5274, DoABC#2)
// RoomSettingsData = "_-we" (String#8817, DoABC#2)
// RoomSettingsCtrl = "_-0kX" (String#4511, DoABC#2)
// RoomSettingsSaveErrorMessageParser = "_-33e" (String#7377, DoABC#2)
// RoomSettingsFlatInfo = "_-0K6" (String#14847, DoABC#2)
// TextFieldManager = "_-Em" (String#7966, DoABC#2)
// GetRoomSettingsMessageComposer = "_-7i" (String#22531, DoABC#2)
// DeleteRoomMessageComposer = "_-SK" (String#23338, DoABC#2)
// SaveRoomSettingsMessageComposer = "_-0Od" (String#15013, DoABC#2)
// RemoveAllRightsMessageComposer = "_-0Rw" (String#15132, DoABC#2)
// ConfirmDialogView = "_-2FS" (String#6352, DoABC#2)
// FlatControllerData = "_-0aS" (String#4311, DoABC#2)
// SaveableRoomSettingsData = "_-Yk" (String#8388, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4148 = "_-1IG" (String#17204, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// guestRoomSearchResults = "_-fX" (String#23866, DoABC#2)
// _SafeStr_4188 = "_-1xJ" (String#18860, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// layoutChildrenInArea = "_-0f9" (String#15635, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// ISelectorWindow = "_-88" (String#7825, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// searchType = "_-2UR" (String#20218, DoABC#2)
// ISelectableWindow = "_-2aK" (String#6764, DoABC#2)
// _SafeStr_5334 = "_-25s" (String#19252, DoABC#2)
// allowPets = "_-2Zu" (String#20436, DoABC#2)
// allowFoodConsume = "_-18w" (String#16812, DoABC#2)
// allowWalkThrough = "_-1aX" (String#17916, DoABC#2)
// hideWalls = "_-2O7" (String#19970, DoABC#2)
// wallThickness = "_-bn" (String#23705, DoABC#2)
// maximumVisitors = "_-1Ex" (String#17069, DoABC#2)
// maximumVisitorsLimit = "_-S3" (String#23327, DoABC#2)
// controllers = "_-0A4" (String#14450, DoABC#2)
// controllerCount = "_-0WL" (String#15293, DoABC#2)
// CurrencyIndicatorBase = "_-1vu" (String#243, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// _SafeStr_5568 = "_-0Xj" (String#15344, DoABC#2)
// _SafeStr_5570 = "_-2OU" (String#19985, DoABC#2)
// _SafeStr_5571 = "_-d7" (String#23763, DoABC#2)
// _SafeStr_5573 = "_-1KG" (String#17285, DoABC#2)
// _SafeStr_5574 = "_-2XS" (String#20340, DoABC#2)
// _SafeStr_5575 = "_-Vh" (String#23480, DoABC#2)
// WE_SELECT = "_-335" (String#21624, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// roomInfoViewCtrl = "_-HS" (String#22911, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// searchParam = "_-1jk" (String#18273, DoABC#2)
// nodeName = "_-2F3" (String#19606, DoABC#2)
// getCancelButton = "_-3Hz" (String#7666, DoABC#2)
// RoomEventViewCtrl = "_-0ir" (String#1534, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// roomSettingsRefreshNeeded = "_-QW" (String#8214, DoABC#2)
// _SafeStr_6899 = "_-2Tt" (String#20193, DoABC#2)
// _SafeStr_6900 = "_-0uR" (String#16218, DoABC#2)
// _SafeStr_6901 = "_-0hp" (String#15740, DoABC#2)
// _SafeStr_6902 = "_-2pi" (String#21069, DoABC#2)
// _SafeStr_6903 = "_-jo" (String#24027, DoABC#2)
// _SafeStr_6904 = "_-1Vu" (String#17739, DoABC#2)
// _SafeStr_6905 = "_-3Iz" (String#22236, DoABC#2)
// _SafeStr_6906 = "_-0cV" (String#4354, DoABC#2)
// _SafeStr_6907 = "_-0Og" (String#4061, DoABC#2)
// _passwordInput = "_-1TS" (String#5422, DoABC#2)
// _SafeStr_6909 = "_-1hi" (String#18199, DoABC#2)
// _SafeStr_6910 = "_-3-A" (String#21467, DoABC#2)
// _SafeStr_6911 = "_-1Jr" (String#17269, DoABC#2)
// _SafeStr_6912 = "_-0EE" (String#14617, DoABC#2)
// _SafeStr_6913 = "_-2-R" (String#18989, DoABC#2)
// _SafeStr_6914 = "_-2dC" (String#20571, DoABC#2)
// _SafeStr_6915 = "_-3GG" (String#22131, DoABC#2)
// _SafeStr_6916 = "_-127" (String#16541, DoABC#2)
// _SafeStr_6917 = "_-2x0" (String#21348, DoABC#2)
// _SafeStr_6918 = "_-dA" (String#23766, DoABC#2)
// _SafeStr_6919 = "_-2d-" (String#20562, DoABC#2)
// _SafeStr_6920 = "_-18o" (String#16805, DoABC#2)
// _SafeStr_6921 = "_-0sc" (String#16146, DoABC#2)
// _SafeStr_6922 = "_-8l" (String#22571, DoABC#2)
// _SafeStr_6923 = "_-qi" (String#24303, DoABC#2)
// _SafeStr_6924 = "_-2xG" (String#21361, DoABC#2)
// RoomSettingsCtrl = "_-1Go" (String#17143, DoABC#2)
// RoomSettingsCtrl = "_-1Tg" (String#17652, DoABC#2)
// IncomingMessages = "_-9F" (String#7848, DoABC#2)
// RoomSettingsCtrl = "_-mp" (String#24143, DoABC#2)
// IncomingMessages = "_-MZ" (String#8134, DoABC#2)
// IncomingMessages = "_-1-A" (String#4849, DoABC#2)
// IncomingMessages = "_-0Fh" (String#3867, DoABC#2)
// displayError = "_-ky" (String#24070, DoABC#2)
// RoomSettingsCtrl = "_-1wX" (String#18822, DoABC#2)
// clearErrors = "_-1FQ" (String#1642, DoABC#2)
// RoomSettingsCtrl = "_-0FB" (String#14651, DoABC#2)
// WE_UNSELECT = "_-sx" (String#24402, DoABC#2)
// RoomSettingsCtrl = "_-vO" (String#24505, DoABC#2)
// RoomSettingsCtrl = "_-0kZ" (String#15850, DoABC#2)
// RoomSettingsCtrl = "_-0j4" (String#15795, DoABC#2)
// RoomSettingsCtrl = "_-0iV" (String#15772, DoABC#2)
// RoomSettingsCtrl = "_-1af" (String#17921, DoABC#2)
// RoomSettingsCtrl = "_-0ml" (String#15928, DoABC#2)
// RoomSettingsCtrl = "_-OO" (String#23183, DoABC#2)
// RoomSettingsCtrl = "_-B3" (String#22657, DoABC#2)
// RoomSettingsCtrl = "_-1kJ" (String#18302, DoABC#2)
// RoomSettingsCtrl = "_-3Iq" (String#22231, DoABC#2)
// RoomSettingsCtrl = "_-8-" (String#22544, DoABC#2)
// RoomSettingsCtrl = "_-0yn" (String#16383, DoABC#2)
// setColors = "_-1Dl" (String#17014, DoABC#2)
// RoomSettingsCtrl = "_-2sA" (String#21165, DoABC#2)
// RoomSettingsCtrl = "_-s7" (String#24368, DoABC#2)
// RoomSettingsCtrl = "_-326" (String#21585, DoABC#2)
// RoomSettingsCtrl = "_-24J" (String#19190, DoABC#2)
// RoomSettingsCtrl = "_-26f" (String#19278, DoABC#2)
// RoomSettingsCtrl = "_-2Rc" (String#20104, DoABC#2)
// RoomSettingsCtrl = "_-1Rr" (String#17576, DoABC#2)
// RoomSettingsCtrl = "_-Or" (String#23199, DoABC#2)
// DirectionData = "_-l" (String#8622, DoABC#2)
// RoomSettingsCtrl = "_-035" (String#14167, DoABC#2)
// RoomSettingsCtrl = "_-3IW" (String#22220, DoABC#2)
// startThumbnailEdit = "_-S7" (String#23329, DoABC#2)
// RoomSettingsCtrl = "_-nS" (String#24170, DoABC#2)
// RoomSettingsCtrl = "_-00D" (String#14063, DoABC#2)
// RoomSettingsCtrl = "_-0d6" (String#15553, DoABC#2)
// RoomSettingsCtrl = "_-3KH" (String#22293, DoABC#2)
// RoomSettingsCtrl = "_-pO" (String#24249, DoABC#2)


