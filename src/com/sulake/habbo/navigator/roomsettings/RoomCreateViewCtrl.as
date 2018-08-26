
package com.sulake.habbo.navigator.roomsettings
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.TextFieldManager;
    import com.sulake.habbo.navigator.domain.RoomLayout;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.events.Event;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.habbo.navigator.Util;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IIconWindow;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CreateFlatMessageComposer;
    import com.sulake.habbo.navigator.*;

    public class RoomCreateViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _content:IItemListWindow;
        private var _SafeStr_6871:TextFieldManager;
        private var _SafeStr_5911:Array;
        private var _SafeStr_6872:RoomLayout;
        private var _SafeStr_6873:Timer;
        private var _SafeStr_6874:Boolean = true;

        public function RoomCreateViewCtrl(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
            this._SafeStr_6873 = new Timer(100);
            this._SafeStr_6873.addEventListener(TimerEvent.TIMER, this.updateArrowPos);
            this._SafeStr_5911 = new Array();
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 104, "a"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 94, "b"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 36, "c"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 84, "d"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 80, "e"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 80, "f"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 416, "i"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 320, "j"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 448, "k"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 352, "l"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 384, "m"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3942, 372, "n"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 80, "g"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 74, "h"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 416, "o"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 352, "p"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 304, "q"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 336, "r"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 748, "u"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3943, 438, "v"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 540, "t"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 0x0200, "w"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 396, "x"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 440, "y"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 456, "z"));
            this._SafeStr_5911.push(new RoomLayout(HabboClubLevelEnum._SafeStr_3939, 208, "0"));
        }
        public function dispose():void
        {
            if (this._SafeStr_6873){
                this._SafeStr_6873.removeEventListener(TimerEvent.TIMER, this.updateArrowPos);
                this._SafeStr_6873.reset();
                this._SafeStr_6873 = null;
            };
        }
        private function updateArrowPos(_arg_1:Event):void
        {
            var _local_2:String = "select_arrow";
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(this._SafeStr_6872.view.findChildByName(_local_2));
            var _local_4:int;
            var _local_5:int = 15;
            var _local_6:int = (((((Math.abs((_local_3.y - _local_4)) < 2)) || ((Math.abs((_local_3.y - _local_5)) < 2)))) ? 1 : 2);
            _local_3.y = (_local_3.y + ((this._SafeStr_6874) ? _local_6 : -(_local_6)));
            if (_local_3.y < _local_4){
                this._SafeStr_6874 = true;
                _local_3.y = (_local_4 + 1);
            }
            else {
                if (_local_3.y > _local_5){
                    this._SafeStr_6874 = false;
                    _local_3.y = (_local_5 - 1);
                };
            };
        }
        public function show():void
        {
            this.prepare();
            this._content.visible = true;
            this.refresh();
            this._content.activate();
            this._SafeStr_6873.start();
        }
        private function RoomEventViewCtrl(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        private function prepare():void
        {
            if (this._content != null){
                return;
            };
            this._content = IWindowContainer(this._navigator.getXmlWindow("roc_create_room"));
            this._content = IItemListWindow(this._content.findChildByName("item_list"));
            this.refreshRoomThumbnails();
            var _local_1:IButtonWindow = this.getCreateButton();
            this.RoomEventViewCtrl(_local_1, this.RoomEventViewCtrl);
            var _local_2:IButtonWindow = this.getCancelButton();
            this.RoomEventViewCtrl(_local_2, this.RoomEventViewCtrl);
            var _local_3:IWindow = this._content.findChildByTag("close");
            this.RoomEventViewCtrl(_local_3, this.RoomEventViewCtrl);
            this._SafeStr_6871 = new TextFieldManager(this._navigator, ITextFieldWindow(this._content.findChildByName("room_name_input")), 25, null, this._navigator.getText("navigator.createroom.roomnameinfo"));
            var _local_4:Rectangle = Util.getLocationRelativeTo(this._content.desktop, this._content.width, this._content.height);
            this._content.x = _local_4.x;
            this._content.y = _local_4.y;
        }
        public function refresh():void
        {
            this._SafeStr_6871.goBackToInitialState();
            this._SafeStr_6871.input.textBackgroundColor = 0xFFFFFFFF;
            this._SafeStr_6872 = this._SafeStr_5911[0];
            this.refreshRoomThumbnails();
            this.refreshSelection();
        }
        private function refreshSelection():void
        {
            var _local_1:RoomLayout;
            var _local_2:Boolean;
            var _local_3:ITextWindow;
            for each (_local_1 in this._SafeStr_5911) {
                if (_local_1.view != null){
                    _local_2 = (_local_1 == this._SafeStr_6872);
                    _local_1.view.findChildByName("bg_sel").visible = _local_2;
                    _local_1.view.findChildByName("bg_unsel").visible = !(_local_2);
                    _local_3 = ITextWindow(_local_1.view.findChildByName("tile_size_txt"));
                    _local_3.textColor = ((_local_2) ? 0xFFFFFFFF : 0xFF000000);
                    _local_3.color = ((_local_2) ? 4285432196 : 4291546059);
                    this._navigator.refreshButton(_local_1.view, "tile_icon_black", !(_local_2), null, 0);
                    this._navigator.refreshButton(_local_1.view, "tile_icon_white", _local_2, null, 0);
                    this._navigator.refreshButton(_local_1.view, "select_arrow", _local_2, null, 0);
                };
            };
        }
        private function refreshRoomThumbnails():void
        {
            var _local_1:RoomLayout;
            var _local_2:int;
            var _local_3:IWindowContainer;
            var _local_4:int;
            var _local_6:IWindow;
            var _local_7:RoomLayout;
            var _local_8:IWindowContainer;
            var _local_9:IWindow;
            while (this._content.numListItems > 0) {
                _local_6 = this._content.IItemListWindow(0);
                _local_6.destroy();
            };
            for each (_local_1 in this._SafeStr_5911) {
                if (_local_1.view != null){
                    _local_1.view.destroy();
                    _local_1.view = null;
                };
            };
            _local_2 = 0;
            _local_4 = 0;
            while (_local_4 < this._SafeStr_5911.length) {
                _local_7 = this._SafeStr_5911[_local_4];
                if (this.isAllowed(_local_7)){
                    if (_local_2 == 0){
                        _local_3 = this.getRow();
                        this._content.addListItem(_local_3);
                    };
                    this.addThumbnail(_local_3, this._SafeStr_5911[_local_4], ((_local_2 % 2) == 0));
                    _local_2 = (((_local_2 == 0)) ? 1 : 0);
                };
                _local_4++;
            };
            this.refreshSelection();
            var _local_5:String = "roc_hc_promo";
            if (this._navigator.sessionData.hasUserRight("fuse_use_special_room_layouts", HabboClubLevelEnum._SafeStr_3943)){
                if (this._navigator.sessionData.hasUserRight("fuse_use_vip_room_layouts", HabboClubLevelEnum._SafeStr_3939)){
                    _local_5 = null;
                }
                else {
                    _local_5 = "roc_vip_promo";
                };
            };
            if (_local_5){
                _local_8 = IWindowContainer(this._navigator.getXmlWindow(_local_5));
                if (_local_8){
                    _local_9 = _local_8.findChildByName("link");
                    this.RoomEventViewCtrl(_local_9, this.onHcMoreClick);
                    this._content.addListItem(_local_8);
                };
            };
        }
        private function addThumbnail(_arg_1:IWindowContainer, _arg_2:RoomLayout, _arg_3:Boolean):void
        {
            var _local_4:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("roc_room_thumbnail"));
            _local_4.tags.push(_arg_2.name);
            if (!_arg_3){
                _local_4.x = _local_4.width;
            };
            this.RoomEventViewCtrl(_local_4, this.onContPicClick);
            var _local_5:IWindowContainer = (_local_4.findChildByName("bg_pic") as IWindowContainer);
            var _local_6:IBitmapWrapperWindow = this._navigator.getButton(_arg_2.name, ("model_" + _arg_2.name), null, 0, 0, 0);
            _local_6.setParamFlag(HabboWindowParam._SafeStr_3731, false);
            _local_5.addChild(_local_6);
            var _local_7:Rectangle = Util.getLocationRelativeTo(_local_5, _local_6.width, _local_6.height);
            _local_6.x = _local_7.x;
            _local_6.y = _local_7.y;
            _arg_1.addChild(_local_4);
            _arg_1.width = (2 * _local_4.width);
            _arg_1.height = _local_4.height;
            _arg_2.view = _local_4;
            ITextWindow(_arg_2.view.findChildByName("tile_size_txt")).text = ((_arg_2.tileSize + " ") + this._navigator.getText("navigator.createroom.tilesize"));
            var _local_8:IIconWindow = (_local_4.findChildByName("club_icon") as IIconWindow);
            if (_local_8){
                switch (_arg_2.requiredClubLevel){
                    case HabboClubLevelEnum._SafeStr_3943:
                        _local_8.style = 11;
                        return;
                    case HabboClubLevelEnum._SafeStr_3939:
                        _local_8.style = 12;
                        return;
                    default:
                        _local_8.visible = false;
                };
            };
        }
        private function isAllowed(_arg_1:RoomLayout):Boolean
        {
            switch (_arg_1.requiredClubLevel){
                case HabboClubLevelEnum._SafeStr_3942:
                    return (true);
                case HabboClubLevelEnum._SafeStr_3943:
                    return (this._navigator.sessionData.hasUserRight("fuse_use_special_room_layouts", HabboClubLevelEnum._SafeStr_3943));
                case HabboClubLevelEnum._SafeStr_3939:
                    return (this._navigator.sessionData.hasUserRight("fuse_use_vip_room_layouts", HabboClubLevelEnum._SafeStr_3939));
            };
            return (false);
        }
        private function getRow():IWindowContainer
        {
            return (IWindowContainer(this._navigator.windowManager.createWindow("", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, 100, 300))));
        }
        private function RoomEventViewCtrl():Boolean
        {
            return (this._SafeStr_6871.checkMandatory(this._navigator.getText("navigator.createroom.nameerr")));
        }
        private function getCreateButton():IButtonWindow
        {
            return (IButtonWindow(this._content.findChildByName("create_button")));
        }
        private function getCancelButton():IButtonWindow
        {
            return (IButtonWindow(this._content.findChildByName("back_button")));
        }
        private function onChooseLayout(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:RoomLayout = this.getLayout(_arg_2);
            if (this.isAllowed(_local_3)){
                this._SafeStr_6872 = _local_3;
                this.refreshSelection();
            };
        }
        private function getLayout(_arg_1:IWindow):RoomLayout
        {
            return (this.findLayout(_arg_1.tags[0]));
        }
        private function findLayout(_arg_1:String):RoomLayout
        {
            var _local_2:RoomLayout;
            for each (_local_2 in this._SafeStr_5911) {
                if (_local_2.name == _arg_1){
                    return (_local_2);
                };
            };
            return (this._SafeStr_5911[0]);
        }
        private function onContPicClick(_arg_1:WindowEvent):void
        {
            var _local_2:IWindowContainer = (_arg_1.target as IWindowContainer);
            this.onChooseLayout(_arg_1, _local_2);
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            this.close();
        }
        private function onHcMoreClick(_arg_1:WindowEvent):void
        {
            this._navigator.openCatalogClubPage();
        }
        private function RoomEventViewCtrl(_arg_1:WindowEvent):void
        {
            var _local_2:String = this._SafeStr_6871.getText();
            var _local_3:String = ("model_" + this._SafeStr_6872.name);
            if (!this.RoomEventViewCtrl()){
                return;
            };
            this._navigator.send(new CreateFlatMessageComposer(_local_2, _local_3));
            this._content.visible = false;
        }
        private function close():void
        {
            this._content.visible = false;
            this._SafeStr_6873.reset();
        }

    }
}//package com.sulake.habbo.navigator.roomsettings

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IIconWindow = "_-1ph" (String#1764, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomCreateViewCtrl = "_-1gR" (String#5672, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// RoomLayout = "_-Oa" (String#8174, DoABC#2)
// TextFieldManager = "_-Em" (String#7966, DoABC#2)
// CreateFlatMessageComposer = "_-27w" (String#19327, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// _SafeStr_5911 = "_-Kn" (String#8097, DoABC#2)
// RoomEventViewCtrl = "_-10B" (String#595, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// _SafeStr_6871 = "_-5h" (String#22449, DoABC#2)
// _SafeStr_6872 = "_-2zz" (String#21460, DoABC#2)
// _SafeStr_6873 = "_-1Kz" (String#17311, DoABC#2)
// _SafeStr_6874 = "_-2Ys" (String#20389, DoABC#2)
// updateArrowPos = "_-0uQ" (String#16217, DoABC#2)
// refreshRoomThumbnails = "_-1ka" (String#18311, DoABC#2)
// getCreateButton = "_-2vD" (String#21286, DoABC#2)
// RoomEventViewCtrl = "_-2kt" (String#6975, DoABC#2)
// getCancelButton = "_-3Hz" (String#7666, DoABC#2)
// RoomEventViewCtrl = "_-0ir" (String#1534, DoABC#2)
// getLocationRelativeTo = "_-2tz" (String#21236, DoABC#2)
// goBackToInitialState = "_-27b" (String#19315, DoABC#2)
// textBackgroundColor = "_-11u" (String#1606, DoABC#2)
// refreshSelection = "_-2oB" (String#21010, DoABC#2)
// IItemListWindow = "_-Td" (String#8279, DoABC#2)
// isAllowed = "_-3EW" (String#22056, DoABC#2)
// getRow = "_-TF" (String#23374, DoABC#2)
// addThumbnail = "_-md" (String#24133, DoABC#2)
// onHcMoreClick = "_-1z3" (String#18930, DoABC#2)
// onContPicClick = "_-1rz" (String#18630, DoABC#2)
// tileSize = "_-2va" (String#21298, DoABC#2)
// requiredClubLevel = "_-1AJ" (String#16873, DoABC#2)
// RoomEventViewCtrl = "_-36s" (String#7447, DoABC#2)
// checkMandatory = "_-2zP" (String#21436, DoABC#2)
// onChooseLayout = "_-0jO" (String#15805, DoABC#2)
// getLayout = "_-2n6" (String#20966, DoABC#2)
// findLayout = "_-2Q3" (String#20045, DoABC#2)


