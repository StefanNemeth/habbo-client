
package com.sulake.habbo.navigator.mainview
{
    import com.sulake.habbo.navigator.IViewCtrl;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.navigator.RoomPopupCtrl;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.habbo.navigator.UserCountRenderer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomSettingsFlatInfo;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.components.*;
    import com.sulake.habbo.navigator.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;

    public class GuestRoomListCtrl implements IViewCtrl 
    {

        private var _navigator:HabboNavigator;
        private var _content:IWindowContainer;
        private var _content:IItemListWindow;
        private var _SafeStr_4171:RoomPopupCtrl;
        private var _scrollV:IScrollbarWindow;
        private var _SafeStr_4104:UserCountRenderer;
        private var _SafeStr_4173:IWindowContainer;
        private var _SafeStr_4174:int;
        private var _SafeStr_4175:Boolean;

        public function GuestRoomListCtrl(_arg_1:HabboNavigator):void
        {
            this._navigator = _arg_1;
            this._SafeStr_4171 = new RoomPopupCtrl(this._navigator, 5, -5);
            this._SafeStr_4104 = new UserCountRenderer(this._navigator);
        }
        public function dispose():void
        {
            if (this._SafeStr_4171){
                this._SafeStr_4171.dispose();
                this._SafeStr_4171 = null;
            };
            if (this._SafeStr_4104){
                this._SafeStr_4104.dispose();
                this._SafeStr_4104 = null;
            };
        }
        public function set content(_arg_1:IWindowContainer):void
        {
            this._content = _arg_1;
            this._content = IItemListWindow(this._content.findChildByName("item_list"));
            this._scrollV = IScrollbarWindow(this._content.findChildByName("scroller"));
        }
        public function get content():IWindowContainer
        {
            return (this._content);
        }
        public function refresh():void
        {
            var _local_4:Boolean;
            var _local_1:Array = this._navigator.data.guestRoomSearchResults.rooms;
            var _local_2:int = this.getVisibleEntryCount();
            this._content.autoArrangeItems = false;
            var _local_3:int;
            while (true) {
                if (_local_3 < _local_1.length){
                    this.refreshEntry(true, _local_3, _local_1[_local_3]);
                }
                else {
                    _local_4 = this.refreshEntry(false, _local_3, null);
                    if (_local_4) break;
                };
                _local_3++;
            };
            this._content.autoArrangeItems = true;
            if (this.getVisibleEntryCount() != _local_2){
                this._scrollV.scrollV = 0;
            };
            this._content.findChildByName("no_rooms_found").visible = (_local_1.length < 1);
        }
        private function getVisibleEntryCount():int
        {
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this._content.numListItems) {
                if (this._content.getListItemAt(_local_2).visible){
                    _local_1++;
                };
                _local_2++;
            };
            return (_local_1);
        }
        private function getListEntry(_arg_1:int):IWindowContainer
        {
            var _local_2:IWindowContainer = IWindowContainer(this._navigator.getXmlWindow("grs_guest_room_details_short"));
            _local_2.background = true;
            _local_2.addEventListener(WindowMouseEvent.WME_MOVE, this.onMouseMove);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.ClubGiftNotification);
            _local_2.addEventListener(WindowMouseEvent.WME_OUT, this.ClubGiftNotification);
            _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.WelcomeScreenController);
            _local_2.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            _local_2.setParamFlag(HabboWindowParam._SafeStr_4184, true);
            _local_2.color = this.getBgColor(_arg_1);
            _local_2.tags.push(_arg_1);
            return (_local_2);
        }
        private function getBgColor(_arg_1:int):uint
        {
            return (((((_arg_1 % 2))!=0) ? 0xFFFFFFFF : 4292797682));
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:GuestRoomData):Boolean
        {
            var _local_4:IWindowContainer = IWindowContainer(this._content.getListItemAt(_arg_2));
            var _local_5:Boolean;
            if (_local_4 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_4 = this.getListEntry(_arg_2);
                this._content.addListItem(_local_4);
                _local_5 = true;
            };
            Util.InfostandWidget(_local_4);
            if (_arg_1){
                this.refreshEntryDetails(_local_4, _arg_3);
                _local_4.visible = true;
                _local_4.height = 17;
            }
            else {
                _local_4.height = 0;
                _local_4.visible = false;
            };
            if (_local_5){
                this._navigator.mainViewCtrl.stretchNewEntryIfNeeded(this, _local_4);
            };
            return (false);
        }
        public function refreshEntryDetails(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            _arg_1.visible = true;
            Util.InfostandWidget(_arg_1);
            this.refreshFavouriteIcon(_arg_1, _arg_2);
            this._navigator.refreshButton(_arg_1, "home", this.isHome(_arg_2), null, 0);
            this._navigator.refreshButton(_arg_1, "doormode_doorbell_small", (_arg_2.doorMode == RoomSettingsFlatInfo._SafeStr_4188), null, 0);
            this._navigator.refreshButton(_arg_1, "doormode_password_small", (_arg_2.doorMode == RoomSettingsFlatInfo._SafeStr_4148), null, 0);
            this.refreshRoomName(_arg_1, _arg_2);
            this._SafeStr_4104.refreshUserCount(_arg_2.maxUserCount, _arg_1, _arg_2.userCount, "${navigator.usercounttooltip.users}", 233, 2);
        }
        private function refreshRoomName(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            var _local_3:ITextWindow = ITextWindow(_arg_1.getChildByName("roomname"));
            _local_3.visible = true;
            var _local_4:Boolean = ((((_arg_1.findChildByName("home").visible) || (_arg_1.findChildByName("favourite").visible))) || (_arg_1.findChildByName("make_favourite").visible));
            Util.cutTextToWidth(_local_3, _arg_2.roomName, ((_local_4) ? (_local_3.width - 20) : _local_3.width));
        }
        private function onMouseMove(_arg_1:WindowEvent):void
        {
            this.checkFastHorizontalMove(_arg_1);
        }
        private function ClubGiftNotification(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if (((this._SafeStr_4171.visible) && (this._SafeStr_4175))){
                return;
            };
            this.hilite(IWindowContainer(_local_2));
            var _local_3:int = _local_2.tags[0];
            if (this._navigator.data.guestRoomSearchResults == null){
                Logger.log("No guest room search results while room entry mouse over");
                return;
            };
            var _local_4:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_local_3];
            if (_local_4 == null){
                Logger.log(((("No room found " + _local_3) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._SafeStr_4171.room = _local_4;
            this._SafeStr_4171.PopupCtrl(_local_2);
        }
        private function ClubGiftNotification(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if (Util.containsMouse(_local_2)){
                Logger.log(("Mouse entered contained element: " + _local_2.rectangle));
                return;
            };
            var _local_3:int = _local_2.tags[0];
            _local_2.color = this.getBgColor(_local_3);
            this._SafeStr_4171.PopupCtrl();
        }
        private function WelcomeScreenController(_arg_1:WindowEvent):void
        {
            var _local_5:Point;
            var _local_2:IWindow = _arg_1.target;
            var _local_3:int = _local_2.tags[0];
            if (this._navigator.data.guestRoomSearchResults == null){
                Logger.log("No guest room search results while room entry mouse click");
                return;
            };
            var _local_4:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_local_3];
            if (_local_4 == null){
                Logger.log(((("No room found " + _local_3) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            if (_local_4.ownerName != this._navigator.sessionData.userName){
                _local_5 = new Point((_arg_1 as WindowMouseEvent).stageX, (_arg_1 as WindowMouseEvent).stageY);
                switch (_local_4.doorMode){
                    case RoomSettingsFlatInfo._SafeStr_4148:
                        this._navigator.passwordInput.show(_local_4, _local_5);
                        return;
                    case RoomSettingsFlatInfo._SafeStr_4188:
                        this._navigator.doorbell.show(_local_4, _local_5);
                        return;
                };
            };
            this._navigator.goToRoom(_local_4.flatId, true, "", _local_3);
            this._SafeStr_4171.PopupCtrl();
        }
        private function refreshFavouriteIcon(_arg_1:IWindowContainer, _arg_2:GuestRoomData):void
        {
            var _local_3:Boolean = this._navigator.data.isRoomFavourite(_arg_2.flatId);
            var _local_4:Boolean = this.isHome(_arg_2);
            this.refreshRegion(_arg_1, "make_favourite", ((!(_local_3)) && (!(_local_4))), this.onAddFavouriteClick);
            this.refreshRegion(_arg_1, "favourite", ((_local_3) && (!(_local_4))), this.onRemoveFavouriteClick);
        }
        private function isHome(_arg_1:GuestRoomData):Boolean
        {
            return ((_arg_1.flatId == this._navigator.data.homeRoomId));
        }
        private function refreshRegion(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function):void
        {
            var _local_5:IRegionWindow = (_arg_1.findChildByName(_arg_2) as IRegionWindow);
            if (!_arg_3){
                _local_5.visible = false;
                if (_local_5.hasEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)){
                    _local_5.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_4);
                };
            }
            else {
                _local_5.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_4);
                _local_5.visible = true;
                this._navigator.refreshButton(_local_5, _arg_2, _arg_3, null, 0);
            };
        }
        private function onRemoveFavouriteClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if ((((_local_2 == null)) || ((_local_2.parent == null)))){
                return;
            };
            if ((((this._navigator == null)) || ((this._navigator.data == null)))){
                return;
            };
            if ((((this._navigator.data.guestRoomSearchResults == null)) || ((this._navigator.data.guestRoomSearchResults.rooms == null)))){
                return;
            };
            var _local_3:int = int(_local_2.parent.tags[0]);
            var _local_4:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_local_3];
            if (_local_4 == null){
                Logger.log(((("No room found at index " + _local_3) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(_local_4.flatId));
        }
        private function onAddFavouriteClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = _arg_1.target;
            if ((((_local_2 == null)) || ((_local_2.parent == null)))){
                return;
            };
            if ((((this._navigator == null)) || ((this._navigator.data == null)))){
                return;
            };
            if ((((this._navigator.data.guestRoomSearchResults == null)) || ((this._navigator.data.guestRoomSearchResults.rooms == null)))){
                return;
            };
            var _local_3:int = int(_local_2.parent.tags[0]);
            var _local_4:GuestRoomData = this._navigator.data.guestRoomSearchResults.rooms[_local_3];
            if (_local_4 == null){
                Logger.log(((("No room found " + _local_3) + ", ") + this._navigator.data.guestRoomSearchResults.rooms.length));
                return;
            };
            this._navigator.send(new AddFavouriteRoomMessageComposer(_local_4.flatId));
        }
        private function hilite(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            if (this._SafeStr_4173 != null){
                _local_2 = this._SafeStr_4173.tags[0];
                this._SafeStr_4173.color = this.getBgColor(_local_2);
            };
            this._SafeStr_4173 = _arg_1;
            _arg_1.color = 4288861930;
        }
        private function checkFastHorizontalMove(_arg_1:WindowEvent):void
        {
            var _local_2:WindowMouseEvent = WindowMouseEvent(_arg_1);
            var _local_3:int = Math.abs((this._SafeStr_4174 - _local_2.stageX));
            this._SafeStr_4174 = _local_2.stageX;
            this._SafeStr_4175 = (_local_3 > 2);
        }

    }
}//package com.sulake.habbo.navigator.mainview

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// IViewCtrl = "_-D9" (String#7935, DoABC#2)
// GuestRoomListCtrl = "_-302" (String#7304, DoABC#2)
// UserCountRenderer = "_-LP" (String#8111, DoABC#2)
// RoomSettingsFlatInfo = "_-0K6" (String#14847, DoABC#2)
// DeleteFavouriteRoomMessageComposer = "_-2sr" (String#21193, DoABC#2)
// AddFavouriteRoomMessageComposer = "_-36q" (String#21758, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// _SafeStr_4104 = "_-2dY" (String#6821, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// getBgColor = "_-1GR" (String#600, DoABC#2)
// InfostandWidget = "_-14q" (String#1615, DoABC#2)
// refreshUserCount = "_-2dF" (String#6816, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4148 = "_-1IG" (String#17204, DoABC#2)
// passwordInput = "_-2kR" (String#20861, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// _SafeStr_4171 = "_-s3" (String#24366, DoABC#2)
// _scrollV = "_-0Ir" (String#1449, DoABC#2)
// _SafeStr_4173 = "_-068" (String#14288, DoABC#2)
// _SafeStr_4174 = "_-30h" (String#21527, DoABC#2)
// _SafeStr_4175 = "_-0vT" (String#16255, DoABC#2)
// guestRoomSearchResults = "_-fX" (String#23866, DoABC#2)
// getVisibleEntryCount = "_-0Hm" (String#14747, DoABC#2)
// getListEntry = "_-S4" (String#8248, DoABC#2)
// WME_MOVE = "_-1ee" (String#18084, DoABC#2)
// onMouseMove = "_-of" (String#24221, DoABC#2)
// ClubGiftNotification = "_-21W" (String#613, DoABC#2)
// ClubGiftNotification = "_-1ap" (String#608, DoABC#2)
// WelcomeScreenController = "_-0Kd" (String#584, DoABC#2)
// _SafeStr_4184 = "_-17w" (String#16770, DoABC#2)
// refreshEntryDetails = "_-xU" (String#24589, DoABC#2)
// stretchNewEntryIfNeeded = "_-1D8" (String#16986, DoABC#2)
// refreshFavouriteIcon = "_-3h" (String#22361, DoABC#2)
// _SafeStr_4188 = "_-1xJ" (String#18860, DoABC#2)
// refreshRoomName = "_-gr" (String#8530, DoABC#2)
// maxUserCount = "_-1O9" (String#17440, DoABC#2)
// cutTextToWidth = "_-1qz" (String#18580, DoABC#2)
// checkFastHorizontalMove = "_-0ED" (String#14616, DoABC#2)
// hilite = "_-0UM" (String#15218, DoABC#2)
// PopupCtrl = "_-0pi" (String#16042, DoABC#2)
// containsMouse = "_-0ij" (String#15781, DoABC#2)
// PopupCtrl = "_-1eW" (String#18078, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// PopupCtrl = "_-DX" (String#22750, DoABC#2)
// isRoomFavourite = "_-0Wv" (String#15312, DoABC#2)
// refreshRegion = "_-x8" (String#24574, DoABC#2)
// onAddFavouriteClick = "_-2CO" (String#6291, DoABC#2)
// onRemoveFavouriteClick = "_-dW" (String#8476, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)


