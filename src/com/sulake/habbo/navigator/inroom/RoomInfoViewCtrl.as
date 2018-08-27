
package com.sulake.habbo.navigator.inroom
{
    import com.sulake.habbo.navigator.roomsettings.IRoomSettingsCtrlOwner;
    import com.sulake.habbo.navigator.HabboNavigator;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Timer;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.navigator.roomthumbnails.RoomThumbnailCtrl;
    import com.sulake.habbo.navigator.TagRenderer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import com.sulake.habbo.navigator.events.HabboRoomSettingsTrackingEvent;
    import com.sulake.habbo.navigator.Util;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicRoomShortData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.SimpleAlertView;
    import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateEventMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.UpdateNavigatorSettingsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.RateFlatMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.navigator.ToggleStaffPickMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.navigator.events.HabboNavigatorEvent;
    import com.sulake.habbo.navigator.*;

    public class RoomInfoViewCtrl implements IRoomSettingsCtrlOwner 
    {

        private const _SafeStr_8376:int = 185;
        private const _SafeStr_8377:int = 3;
        private const _SafeStr_8378:int = 45;

        private var _navigator:HabboNavigator;
        private var _window:IWindowContainer;
        private var _content:IWindowContainer;
        private var _SafeStr_8379:int;
        private var _SafeStr_8380:RoomEventViewCtrl;
        private var _SafeStr_8381:Timer;
        private var _SafeStr_8382:RoomSettingsCtrl;
        private var _SafeStr_8383:RoomThumbnailCtrl;
        private var _SafeStr_4206:TagRenderer;
        private var _SafeStr_6253:IWindowContainer;
        private var _SafeStr_8384:IWindowContainer;
        private var _SafeStr_8385:IWindowContainer;
        private var _SafeStr_8386:IWindowContainer;
        private var _SafeStr_8387:IWindowContainer;
        private var _SafeStr_8388:IWindowContainer;
        private var _roomName:ITextWindow;
        private var _SafeStr_8389:ITextWindow;
        private var _ownerName:ITextWindow;
        private var _SafeStr_8390:ITextWindow;
        private var _SafeStr_8391:ITextWindow;
        private var _SafeStr_8392:ITextWindow;
        private var _SafeStr_8393:ITextWindow;
        private var _rating:ITextWindow;
        private var _SafeStr_8394:IWindowContainer;
        private var _SafeStr_8395:IWindowContainer;
        private var _SafeStr_8396:IWindowContainer;
        private var _eventName:ITextWindow;
        private var _SafeStr_8397:ITextWindow;
        private var _SafeStr_8398:IWindow;
        private var _SafeStr_8399:IContainerButtonWindow;
        private var _SafeStr_8400:IContainerButtonWindow;
        private var _SafeStr_8401:IContainerButtonWindow;
        private var _remFavouriteButton:IContainerButtonWindow;
        private var _SafeStr_8402:IContainerButtonWindow;
        private var _SafeStr_8403:IButtonWindow;
        private var _SafeStr_8404:IButtonWindow;
        private var _SafeStr_8405:IButtonWindow;
        private var _SafeStr_8406:IWindowContainer;
        private var _SafeStr_8407:ITextWindow;
        private var _SafeStr_8408:ITextFieldWindow;
        private var _buttons:IWindowContainer;
        private var _SafeStr_8409:IButtonWindow;
        private var _SafeStr_8410:Boolean = false;

        public function RoomInfoViewCtrl(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
            this._SafeStr_8380 = new RoomEventViewCtrl(this._navigator);
            this._SafeStr_8382 = new RoomSettingsCtrl(this._navigator, this, true);
            this._SafeStr_8383 = new RoomThumbnailCtrl(this._navigator);
            this._SafeStr_4206 = new TagRenderer(this._navigator);
            this._navigator.roomSettingsCtrls.push(this._SafeStr_8382);
            this._SafeStr_8381 = new Timer(6000, 1);
            this._SafeStr_8381.addEventListener(TimerEvent.TIMER, this.hideInfo);
        }
        public function dispose():void
        {
            if (this._SafeStr_8381){
                this._SafeStr_8381.removeEventListener(TimerEvent.TIMER, this.hideInfo);
                this._SafeStr_8381.reset();
                this._SafeStr_8381 = null;
            };
            this._navigator = null;
            this._SafeStr_8380 = null;
            this._SafeStr_8382 = null;
            this._SafeStr_8383 = null;
            if (this._SafeStr_4206){
                this._SafeStr_4206.dispose();
                this._SafeStr_4206 = null;
            };
            this._content = null;
            this._SafeStr_6253 = null;
            this._SafeStr_8384 = null;
            this._SafeStr_8385 = null;
            this._SafeStr_8386 = null;
            this._SafeStr_8387 = null;
            this._SafeStr_8388 = null;
            this._roomName = null;
            this._SafeStr_8389 = null;
            this._ownerName = null;
            this._SafeStr_8390 = null;
            this._SafeStr_8391 = null;
            this._SafeStr_8392 = null;
            this._SafeStr_8393 = null;
            this._rating = null;
            this._SafeStr_8394 = null;
            this._SafeStr_8395 = null;
            this._SafeStr_8396 = null;
            this._eventName = null;
            this._SafeStr_8397 = null;
            this._SafeStr_8398 = null;
            this._SafeStr_8399 = null;
            this._SafeStr_8400 = null;
            this._SafeStr_8401 = null;
            this._remFavouriteButton = null;
            this._SafeStr_8402 = null;
            this._SafeStr_8403 = null;
            this._SafeStr_8404 = null;
            this._SafeStr_8405 = null;
            this._SafeStr_8406 = null;
            this._SafeStr_8407 = null;
            this._SafeStr_8408 = null;
            this._buttons = null;
            this._SafeStr_8409 = null;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
        }
        public function roomSettingsRefreshNeeded():void
        {
            this.refresh();
        }
        public function startEventEdit():void
        {
            this._SafeStr_8381.reset();
            this._SafeStr_8380.active = true;
            this._SafeStr_8382.active = false;
            this._SafeStr_8383.active = false;
            this.reload();
        }
        public function startRoomSettingsEdit(_arg_1:int):void
        {
            this._SafeStr_8381.reset();
            this._SafeStr_8382.load(_arg_1);
            this._SafeStr_8382.active = true;
            this._SafeStr_8380.active = false;
            this._SafeStr_8383.active = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }
        public function backToRoomSettings():void
        {
            this._SafeStr_8382.active = true;
            this._SafeStr_8380.active = false;
            this._SafeStr_8383.active = false;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT));
        }
        public function startThumbnailEdit():void
        {
            this._SafeStr_8381.reset();
            this._SafeStr_8382.active = false;
            this._SafeStr_8380.active = false;
            this._SafeStr_8383.active = true;
            this.reload();
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS));
        }
        public function close():void
        {
            if (this._window == null){
                return;
            };
            this._window.visible = false;
            this._SafeStr_8410 = false;
            this._navigator.events.dispatchEvent(new Event(HabboRoomSettingsTrackingEvent.HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED));
        }
        public function reload():void
        {
            if (((!((this._window == null))) && (this._window.visible))){
                this.refresh();
            };
        }
        public function toggle():void
        {
            this._SafeStr_8381.reset();
            this._SafeStr_8380.active = false;
            this._SafeStr_8382.active = false;
            this._SafeStr_8383.active = false;
            this.refresh();
            this._window.visible = !(this._window.visible);
            this._window.x = ((this._window.desktop.width - this._window.width) - this._SafeStr_8377);
            this._window.y = this._SafeStr_8376;
            if (((this._navigator.configuration.getBoolean("club.membership.extend.vip.promotion.enabled", false)) || (this._navigator.configuration.getBoolean("club.membership.extend.basic.promotion.enabled", false)))){
                this._window.y = 91;
            };
            if (this._window.visible){
                this._window.activate();
            };
        }
        private function refresh():void
        {
            this.prepareWindow();
            this.refreshRoom();
            this.refreshEvent();
            this.refreshEmbed();
            this.refreshButtons();
            Util.moveChildrenToColumn(this._content, ["room_info", "event_info", "embed_info", "buttons_container"], 0, 2);
            this._content.height = Util.getLowestPoint(this._content);
            var _local_1:int = ((this._window.desktop.height - this._window.height) - this._SafeStr_8378);
            if (this._window.y > _local_1){
                this._window.y = (((_local_1 < 0)) ? 0 : _local_1);
            };
        }
        private function refreshRoom():void
        {
            Util.hideChildren(this._SafeStr_6253);
            var _local_1:GuestRoomData = this._navigator.data.enteredGuestRoom;
            var _local_2:Boolean = ((!((_local_1 == null))) && ((_local_1.flatId == this._navigator.data.homeRoomId)));
            this.refreshRoomDetails(_local_1, _local_2);
            this.refreshPublicSpaceDetails(this._navigator.data.enteredPublicSpace);
            this.refreshRoomButtons(_local_2);
            this._SafeStr_8382.refresh(this._SafeStr_6253);
            this._SafeStr_8383.refresh(this._SafeStr_6253);
            Util.moveChildrenToColumn(this._SafeStr_6253, ["room_details", "room_buttons"], 0, 2);
            this._SafeStr_6253.height = Util.getLowestPoint(this._SafeStr_6253);
            this._SafeStr_6253.visible = true;
            Logger.log(((((((((("XORP: " + this._SafeStr_8384.visible) + ", ") + this._SafeStr_8388.visible) + ", ") + this._SafeStr_8385.visible) + ", ") + this._SafeStr_8385.rectangle) + ", ") + this._SafeStr_6253.rectangle));
        }
        private function refreshEvent():void
        {
            Util.hideChildren(this._SafeStr_8394);
            var _local_1:RoomEventData = this._navigator.data.roomEventData;
            this.refreshEventDetails(_local_1);
            this.refreshEventButtons(_local_1);
            this._SafeStr_8380.refresh(this._SafeStr_8394);
            if (((Util.hasVisibleChildren(this._SafeStr_8394)) && (!(((this._SafeStr_8382.active) || (this._SafeStr_8383.active)))))){
                Util.moveChildrenToColumn(this._SafeStr_8394, ["event_details", "event_buttons"], 0, 2);
                this._SafeStr_8394.height = Util.getLowestPoint(this._SafeStr_8394);
                this._SafeStr_8394.visible = true;
            }
            else {
                this._SafeStr_8394.visible = false;
            };
            Logger.log(((("EVENT: " + this._SafeStr_8394.visible) + ", ") + this._SafeStr_8394.rectangle));
        }
        private function refreshEmbed():void
        {
            var _local_1 = (this._navigator.configuration.getKey("embed.showInRoomInfo", "false") == "true");
            var _local_2 = !((this._navigator.data.enteredGuestRoom == null));
            if (((((((((_local_2) && (_local_1))) && (!(this._SafeStr_8382.active)))) && (!(this._SafeStr_8383.active)))) && (!(this._SafeStr_8380.active)))){
                this._SafeStr_8406.visible = true;
                this._SafeStr_8408.text = this.getEmbedData();
            }
            else {
                this._SafeStr_8406.visible = false;
            };
        }
        private function refreshButtons():void
        {
            var _local_1:Boolean;
            if (!this._buttons){
                return;
            };
            if (this._SafeStr_8382.active){
                this._buttons.visible = false;
                return;
            };
            this._buttons.visible = true;
            if (this._SafeStr_8409){
                _local_1 = !((this._navigator.data.enteredGuestRoom == null));
                this._SafeStr_8409.visible = _local_1;
                if (this._SafeStr_8410){
                    this._SafeStr_8409.caption = ("$" + "{navigator.zoom.in}");
                }
                else {
                    this._SafeStr_8409.caption = ("$" + "{navigator.zoom.out}");
                };
            };
        }
        private function refreshRoomDetails(_arg_1:GuestRoomData, _arg_2:Boolean):void
        {
            if ((((((_arg_1 == null)) || (this._SafeStr_8382.active))) || (this._SafeStr_8383.active))){
                return;
            };
            this._roomName.text = _arg_1.roomName;
            this._roomName.height = (this._roomName.textHeight + 5);
            this._ownerName.text = _arg_1.ownerName;
            this._SafeStr_8390.text = _arg_1.description;
            this._SafeStr_4206.refreshTags(this._SafeStr_8384, _arg_1.tags);
            this._SafeStr_8390.visible = false;
            if (_arg_1.description != ""){
                this._SafeStr_8390.height = (this._SafeStr_8390.textHeight + 5);
                this._SafeStr_8390.visible = true;
            };
            var _local_3:Boolean = Boolean((this._navigator.configuration.getKey("client.allow.facebook.like") == "1"));
            this._navigator.refreshButton(this._SafeStr_8400, "facebook_logo_small", _local_3, null, 0);
            this._SafeStr_8400.visible = _local_3;
            var _local_4 = (this._navigator.data.currentRoomRating == -1);
            this._navigator.refreshButton(this._SafeStr_8399, "thumb_up", _local_4, null, 0);
            this._SafeStr_8399.visible = _local_4;
            this._SafeStr_8393.visible = !(_local_4);
            this._rating.visible = !(_local_4);
            this._rating.text = ("" + this._navigator.data.currentRoomRating);
            this.refreshStuffPick();
            this._navigator.refreshButton(this._SafeStr_8384, "home", _arg_2, null, 0);
            this._navigator.refreshButton(this._SafeStr_8384, "favourite", ((!(_arg_2)) && (this._navigator.data.isCurrentRoomFavourite())), null, 0);
            Util.moveChildrenToColumn(this._SafeStr_8384, ["room_name", "owner_name_cont", "tags", "room_desc", "rating_cont", "staff_pick_button"], this._roomName.y, 0);
            this._SafeStr_8384.visible = true;
            this._SafeStr_8384.height = Util.getLowestPoint(this._SafeStr_8384);
        }
        private function refreshStuffPick():void
        {
            var _local_1:IWindow = this._SafeStr_8384.findChildByName("staff_pick_button");
            if (!this._navigator.data.roomPicker){
                _local_1.visible = false;
                return;
            };
            _local_1.visible = true;
            _local_1.caption = this._navigator.getText(((this._navigator.data.currentRoomIsStaffPick) ? "navigator.staffpicks.unpick" : "navigator.staffpicks.pick"));
        }
        private function refreshPublicSpaceDetails(_arg_1:PublicRoomShortData):void
        {
            if ((((((_arg_1 == null)) || (this._SafeStr_8382.active))) || (this._SafeStr_8383.active))){
                return;
            };
            this._SafeStr_8389.text = this._navigator.getPublicSpaceName(_arg_1.unitPropertySet, _arg_1.worldId);
            this._SafeStr_8389.height = (this._SafeStr_8389.textHeight + 5);
            this._SafeStr_8391.text = this._navigator.getPublicSpaceDesc(_arg_1.unitPropertySet, _arg_1.worldId);
            this._SafeStr_8391.height = (this._SafeStr_8391.textHeight + 5);
            Util.moveChildrenToColumn(this._SafeStr_8385, ["public_space_name", "public_space_desc"], this._SafeStr_8389.y, 0);
            this._SafeStr_8385.visible = true;
            this._SafeStr_8385.height = Math.max(86, Util.getLowestPoint(this._SafeStr_8385));
        }
        private function refreshEventDetails(_arg_1:RoomEventData):void
        {
            if ((((_arg_1 == null)) || (this._SafeStr_8380.active))){
                return;
            };
            this._eventName.text = _arg_1.eventName;
            this._SafeStr_8397.text = _arg_1.eventDescription;
            this._SafeStr_4206.refreshTags(this._SafeStr_8395, [this._navigator.getText(("roomevent_type_" + _arg_1.eventType)), _arg_1.tags[0], _arg_1.tags[1]]);
            this._SafeStr_8397.visible = false;
            if (_arg_1.eventDescription != ""){
                this._SafeStr_8397.height = (this._SafeStr_8397.textHeight + 5);
                this._SafeStr_8397.y = (Util.getLowestPoint(this._SafeStr_8395) + 2);
                this._SafeStr_8397.visible = true;
            };
            this._SafeStr_8395.visible = true;
            this._SafeStr_8395.height = Util.getLowestPoint(this._SafeStr_8395);
        }
        private function refreshRoomButtons(_arg_1:Boolean):void
        {
            if ((((((this._navigator.data.enteredGuestRoom == null)) || (this._SafeStr_8382.active))) || (this._SafeStr_8383.active))){
                return;
            };
            this._SafeStr_8403.visible = this._navigator.data.canEditRoomSettings;
            var _local_2:Boolean = this._navigator.data.isCurrentRoomFavourite();
            this._SafeStr_8401.visible = ((this._navigator.data.canAddFavourite) && (!(_local_2)));
            this._remFavouriteButton.visible = ((this._navigator.data.canAddFavourite) && (_local_2));
            this._SafeStr_8402.visible = ((this._navigator.data.canEditRoomSettings) && (!(_arg_1)));
            this._SafeStr_8388.visible = Util.hasVisibleChildren(this._SafeStr_8388);
        }
        private function refreshEventButtons(_arg_1:RoomEventData):void
        {
            if (this._SafeStr_8380.active){
                return;
            };
            this._SafeStr_8404.visible = (((_arg_1 == null)) && (this._navigator.data.currentRoomOwner));
            this._SafeStr_8405.visible = ((!((_arg_1 == null))) && (((this._navigator.data.currentRoomOwner) || (this._navigator.data.eventMod))));
            this._SafeStr_8396.visible = Util.hasVisibleChildren(this._SafeStr_8396);
        }
        private function prepareWindow():void
        {
            if (this._window != null){
                return;
            };
            this._window = IWindowContainer(this._navigator.getXmlWindow("iro_room_details_framed"));
            this._content = (this._window.findChildByName("content") as IWindowContainer);
            this._window.visible = false;
            this._SafeStr_6253 = IWindowContainer(this.find("room_info"));
            this._SafeStr_8384 = IWindowContainer(this.find("room_details"));
            this._SafeStr_8385 = IWindowContainer(this.find("public_space_details"));
            this._SafeStr_8386 = IWindowContainer(this.find("owner_name_cont"));
            this._SafeStr_8387 = IWindowContainer(this.find("rating_cont"));
            this._SafeStr_8388 = IWindowContainer(this.find("room_buttons"));
            this._roomName = ITextWindow(this.find("room_name"));
            this._SafeStr_8389 = ITextWindow(this.find("public_space_name"));
            this._ownerName = ITextWindow(this.find("owner_name"));
            this._SafeStr_8390 = ITextWindow(this.find("room_desc"));
            this._SafeStr_8391 = ITextWindow(this.find("public_space_desc"));
            this._SafeStr_8392 = ITextWindow(this.find("owner_caption"));
            this._SafeStr_8393 = ITextWindow(this.find("rating_caption"));
            this._rating = ITextWindow(this.find("rating_txt"));
            this._SafeStr_8394 = IWindowContainer(this.find("event_info"));
            this._SafeStr_8395 = IWindowContainer(this.find("event_details"));
            this._SafeStr_8396 = IWindowContainer(this.find("event_buttons"));
            this._eventName = ITextWindow(this.find("event_name"));
            this._SafeStr_8397 = ITextWindow(this.find("event_desc"));
            this._SafeStr_8400 = IContainerButtonWindow(this.find("facebook_like_button"));
            this._SafeStr_8399 = IContainerButtonWindow(this.find("rate_up_button"));
            this._SafeStr_8398 = this.find("staff_pick_button");
            this._SafeStr_8401 = IContainerButtonWindow(this.find("add_favourite_button"));
            this._remFavouriteButton = IContainerButtonWindow(this.find("rem_favourite_button"));
            this._SafeStr_8402 = IContainerButtonWindow(this.find("make_home_button"));
            this._SafeStr_8403 = IButtonWindow(this.find("room_settings_button"));
            this._SafeStr_8404 = IButtonWindow(this.find("create_event_button"));
            this._SafeStr_8405 = IButtonWindow(this.find("edit_event_button"));
            this._SafeStr_8406 = IWindowContainer(this.find("embed_info"));
            this._SafeStr_8407 = ITextWindow(this.find("embed_info_txt"));
            this._SafeStr_8408 = ITextFieldWindow(this.find("embed_src_txt"));
            this._buttons = IWindowContainer(this.find("buttons_container"));
            this._SafeStr_8409 = IButtonWindow(this.find("zoom_button"));
            this.addMouseClickListener(this._SafeStr_8401, this.onAddFavouriteClick);
            this.addMouseClickListener(this._remFavouriteButton, this.onRemoveFavouriteClick);
            this.addMouseClickListener(this._SafeStr_8403, this.onRoomSettingsClick);
            this.addMouseClickListener(this._SafeStr_8402, this.onMakeHomeClick);
            this.addMouseClickListener(this._SafeStr_8404, this.onEventSettingsClick);
            this.addMouseClickListener(this._SafeStr_8405, this.onEventSettingsClick);
            this.addMouseClickListener(this._SafeStr_8408, this.onEmbedSrcClick);
            this.addMouseClickListener(this._SafeStr_8399, this.onThumbUp);
            this.addMouseClickListener(this._SafeStr_8398, this.onStaffPick);
            this.addMouseClickListener(this._SafeStr_8400, this.onFacebookLike);
            this.addMouseClickListener(this._SafeStr_8409, this.onZoomClick);
            this._navigator.refreshButton(this._SafeStr_8401, "favourite", true, null, 0);
            this._navigator.refreshButton(this._remFavouriteButton, "favourite", true, null, 0);
            this._navigator.refreshButton(this._SafeStr_8402, "home", true, null, 0);
            this.addMouseClickListener(this._window.findChildByTag("close"), this.onCloseButtonClick);
            this.addMouseOverListener(this._SafeStr_6253, this.onHover);
            this.addMouseOverListener(this._SafeStr_8394, this.onHover);
            this._SafeStr_8392.width = this._SafeStr_8392.textWidth;
            Util.moveChildrenToRow(this._SafeStr_8386, ["owner_caption", "owner_name"], this._SafeStr_8392.x, this._SafeStr_8392.y, 3);
            this._SafeStr_8393.width = this._SafeStr_8393.textWidth;
            Util.moveChildrenToRow(this._SafeStr_8387, ["rating_caption", "rating_txt"], this._SafeStr_8393.x, this._SafeStr_8393.y, 3);
            this._SafeStr_8407.height = (this._SafeStr_8407.textHeight + 5);
            Util.moveChildrenToColumn(this._SafeStr_8406, ["embed_info_txt", "embed_src_txt"], this._SafeStr_8407.y, 2);
            this._SafeStr_8406.height = (Util.getLowestPoint(this._SafeStr_8406) + 5);
            this._SafeStr_8379 = (this._window.y + this._window.height);
        }
        private function addMouseClickListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        private function addMouseOverListener(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1 != null){
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, _arg_2);
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
        public function onAddFavouriteClick(_arg_1:WindowEvent):void
        {
            var _local_2:SimpleAlertView;
            if (this._navigator.data.enteredGuestRoom == null){
                return;
            };
            if (this._navigator.data.isFavouritesFull()){
                _local_2 = new SimpleAlertView(this._navigator, "${navigator.favouritesfull.title}", "${navigator.favouritesfull.body}");
                _local_2.show();
            }
            else {
                this._navigator.send(new AddFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
            };
        }
        public function onRemoveFavouriteClick(_arg_1:WindowEvent):void
        {
            if (this._navigator.data.enteredGuestRoom == null){
                return;
            };
            this._navigator.send(new DeleteFavouriteRoomMessageComposer(this._navigator.data.enteredGuestRoom.flatId));
        }
        private function onEventSettingsClick(_arg_1:WindowEvent):void
        {
            if (this._navigator.data.roomEventData == null){
                if (this._navigator.data.currentRoomOwner){
                    this._navigator.send(new CanCreateEventMessageComposer());
                };
            }
            else {
                this.startEventEdit();
            };
        }
        private function onRoomSettingsClick(_arg_1:WindowEvent):void
        {
            var _local_2:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_local_2 == null){
                Logger.log("No entered room data?!");
                return;
            };
            this.startRoomSettingsEdit(_local_2.flatId);
        }
        private function onMakeHomeClick(_arg_1:WindowEvent):void
        {
            var _local_2:GuestRoomData = this._navigator.data.enteredGuestRoom;
            if (_local_2 == null){
                Logger.log("No entered room data?!");
                return;
            };
            Logger.log(("SETTING HOME ROOM TO: " + _local_2.flatId));
            this._navigator.send(new UpdateNavigatorSettingsMessageComposer(_local_2.flatId));
        }
        private function onCloseButtonClick(_arg_1:WindowEvent):void
        {
            this.hideInfo(null);
        }
        private function onThumbUp(_arg_1:WindowEvent):void
        {
            this._navigator.send(new RateFlatMessageComposer(1));
        }
        private function onStaffPick(_arg_1:WindowEvent):void
        {
            this._navigator.send(new ToggleStaffPickMessageComposer(this._navigator.data.enteredGuestRoom.flatId, this._navigator.data.currentRoomIsStaffPick));
        }
        private function onFacebookLike(_arg_1:WindowEvent):void
        {
            HabboWebTools.facebookLike(this._navigator.data.enteredGuestRoom.flatId);
        }
        private function onEmbedSrcClick(_arg_1:WindowEvent):void
        {
            this._SafeStr_8408.setSelection(0, this._SafeStr_8408.text.length);
        }
        private function onZoomClick(_arg_1:WindowEvent):void
        {
            this._navigator.events.dispatchEvent(new HabboNavigatorEvent(HabboNavigatorEvent.HTIE_ICON_ZOOM));
            this._SafeStr_8410 = !(this._SafeStr_8410);
            this.refreshButtons();
        }
        private function onHover(_arg_1:WindowEvent):void
        {
            this._SafeStr_8381.reset();
        }
        private function hideInfo(_arg_1:Event):void
        {
            this._window.visible = false;
            if (this._SafeStr_8382 != null){
                this._SafeStr_8382.resetView();
            };
        }
        private function getEmbedData():String
        {
            var _local_1:String;
            var _local_2:String;
            if (this._navigator.data.enteredGuestRoom != null){
                _local_1 = "private";
                _local_2 = ("" + this._navigator.data.enteredGuestRoom.flatId);
            }
            else {
                _local_1 = "public";
                _local_2 = ("" + this._navigator.data.publicSpaceNodeId);
                Logger.log(("Node id is: " + _local_2));
            };
            var _local_3:String = this._navigator.configuration.getKey("user.hash", "");
            this._navigator.registerParameter("navigator.embed.src", "roomType", _local_1);
            this._navigator.registerParameter("navigator.embed.src", "embedCode", _local_3);
            this._navigator.registerParameter("navigator.embed.src", "roomId", _local_2);
            return (this._navigator.getText("navigator.embed.src"));
        }

    }
}//package com.sulake.habbo.navigator.inroom

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IRoomSettingsCtrlOwner = "_-2px" (String#7077, DoABC#2)
// RoomInfoViewCtrl = "_-0ZH" (String#4286, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// PublicRoomShortData = "_-0ae" (String#4315, DoABC#2)
// GuestRoomData = "_-06S" (String#3692, DoABC#2)
// RoomEventData = "_-07q" (String#3718, DoABC#2)
// RoomSettingsCtrl = "_-0kX" (String#4511, DoABC#2)
// RateFlatMessageComposer = "_-1DX" (String#17004, DoABC#2)
// RoomThumbnailCtrl = "_-2z2" (String#7264, DoABC#2)
// ToggleStaffPickMessageComposer = "_-2Rb" (String#20103, DoABC#2)
// DeleteFavouriteRoomMessageComposer = "_-2sr" (String#21193, DoABC#2)
// AddFavouriteRoomMessageComposer = "_-36q" (String#21758, DoABC#2)
// TagRenderer = "_-35E" (String#7412, DoABC#2)
// RoomEventViewCtrl = "_-Od" (String#8176, DoABC#2)
// UpdateNavigatorSettingsMessageComposer = "_-0C2" (String#14528, DoABC#2)
// CanCreateEventMessageComposer = "_-0T6" (String#15175, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// getPublicSpaceName = "_-Zw" (String#23629, DoABC#2)
// unitPropertySet = "_-ix" (String#23996, DoABC#2)
// worldId = "_-2Ip" (String#19760, DoABC#2)
// getPublicSpaceDesc = "_-0-e" (String#14038, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// onAddFavouriteClick = "_-2CO" (String#6291, DoABC#2)
// onRemoveFavouriteClick = "_-dW" (String#8476, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)
// _SafeStr_4206 = "_-2ux" (String#901, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// toggle = "_-2MR" (String#19903, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// hasVisibleChildren = "_-0js" (String#15823, DoABC#2)
// facebookLike = "_-2nq" (String#20993, DoABC#2)
// _roomName = "_-bX" (String#253, DoABC#2)
// addMouseClickListener = "_-10B" (String#595, DoABC#2)
// enteredGuestRoom = "_-2Qx" (String#20085, DoABC#2)
// prepareWindow = "_-RN" (String#219, DoABC#2)
// backToRoomSettings = "_-fe" (String#23873, DoABC#2)
// reload = "_-3AK" (String#7519, DoABC#2)
// _SafeStr_6253 = "_-037" (String#3630, DoABC#2)
// _eventName = "_-1p-" (String#5838, DoABC#2)
// eventType = "_-2Se" (String#20142, DoABC#2)
// eventName = "_-1tL" (String#18690, DoABC#2)
// eventDescription = "_-1i8" (String#18215, DoABC#2)
// roomSettingsRefreshNeeded = "_-QW" (String#8214, DoABC#2)
// resetView = "_-1Go" (String#17143, DoABC#2)
// startThumbnailEdit = "_-S7" (String#23329, DoABC#2)
// _rating = "_-PE" (String#8188, DoABC#2)
// HabboRoomSettingsTrackingEvent = "_-1NO" (String#17413, DoABC#2)
// _SafeStr_8376 = "_-2JG" (String#6425, DoABC#2)
// _SafeStr_8377 = "_-2RO" (String#6593, DoABC#2)
// _SafeStr_8378 = "_-v6" (String#8786, DoABC#2)
// _SafeStr_8379 = "_-31P" (String#21555, DoABC#2)
// _SafeStr_8380 = "_-2QS" (String#20064, DoABC#2)
// _SafeStr_8381 = "_-rl" (String#24351, DoABC#2)
// _SafeStr_8382 = "_-11o" (String#16530, DoABC#2)
// _SafeStr_8383 = "_-0Gc" (String#14705, DoABC#2)
// _SafeStr_8384 = "_-1Kw" (String#17308, DoABC#2)
// _SafeStr_8385 = "_-1u5" (String#18720, DoABC#2)
// _SafeStr_8386 = "_-31g" (String#21566, DoABC#2)
// _SafeStr_8387 = "_-35p" (String#21723, DoABC#2)
// _SafeStr_8388 = "_-1zo" (String#18960, DoABC#2)
// _SafeStr_8389 = "_-1Sj" (String#17612, DoABC#2)
// _SafeStr_8390 = "_-0M2" (String#14916, DoABC#2)
// _SafeStr_8391 = "_-ox" (String#24233, DoABC#2)
// _SafeStr_8392 = "_-0Ec" (String#14629, DoABC#2)
// _SafeStr_8393 = "_-YD" (String#23570, DoABC#2)
// _SafeStr_8394 = "_-ap" (String#23664, DoABC#2)
// _SafeStr_8395 = "_-1ru" (String#18627, DoABC#2)
// _SafeStr_8396 = "_-2h4" (String#20730, DoABC#2)
// _SafeStr_8397 = "_-1L8" (String#17320, DoABC#2)
// _SafeStr_8398 = "_-23y" (String#19175, DoABC#2)
// _SafeStr_8399 = "_-2Tu" (String#20194, DoABC#2)
// _SafeStr_8400 = "_-1yG" (String#18898, DoABC#2)
// _SafeStr_8401 = "_-2H" (String#19683, DoABC#2)
// _SafeStr_8402 = "_-19H" (String#16827, DoABC#2)
// _SafeStr_8403 = "_-2Tl" (String#20190, DoABC#2)
// _SafeStr_8404 = "_-SA" (String#23331, DoABC#2)
// _SafeStr_8405 = "_-3-4" (String#21464, DoABC#2)
// _SafeStr_8406 = "_-2B3" (String#19446, DoABC#2)
// _SafeStr_8407 = "_-Cx" (String#22725, DoABC#2)
// _SafeStr_8408 = "_-2yC" (String#21401, DoABC#2)
// _SafeStr_8409 = "_-0Mc" (String#14936, DoABC#2)
// HabboNavigatorEvent = "_-2Y9" (String#20361, DoABC#2)
// _SafeStr_8410 = "_-2T1" (String#20163, DoABC#2)
// roomSettingsCtrls = "_-2xJ" (String#21362, DoABC#2)
// hideInfo = "_-03W" (String#14182, DoABC#2)
// startEventEdit = "_-29X" (String#19386, DoABC#2)
// startRoomSettingsEdit = "_-1K3" (String#17276, DoABC#2)
// refreshRoom = "_-1kB" (String#18295, DoABC#2)
// refreshEvent = "_-29G" (String#19375, DoABC#2)
// refreshEmbed = "_-1jy" (String#18284, DoABC#2)
// refreshButtons = "_-1ep" (String#859, DoABC#2)
// refreshRoomDetails = "_-1k2" (String#18290, DoABC#2)
// refreshPublicSpaceDetails = "_-1Wg" (String#17765, DoABC#2)
// enteredPublicSpace = "_-2Gp" (String#19674, DoABC#2)
// refreshRoomButtons = "_-2o7" (String#21007, DoABC#2)
// roomEventData = "_-0tV" (String#16179, DoABC#2)
// refreshEventDetails = "_-1q2" (String#18544, DoABC#2)
// refreshEventButtons = "_-1lP" (String#18348, DoABC#2)
// getEmbedData = "_-0JI" (String#14814, DoABC#2)
// refreshTags = "_-0s5" (String#16127, DoABC#2)
// currentRoomRating = "_-0zd" (String#16413, DoABC#2)
// refreshStuffPick = "_-o6" (String#24193, DoABC#2)
// isCurrentRoomFavourite = "_-0ul" (String#16227, DoABC#2)
// roomPicker = "_-2QD" (String#20055, DoABC#2)
// currentRoomIsStaffPick = "_-0QZ" (String#15085, DoABC#2)
// canEditRoomSettings = "_-1Wi" (String#17767, DoABC#2)
// canAddFavourite = "_-1mo" (String#18413, DoABC#2)
// currentRoomOwner = "_-oK" (String#24205, DoABC#2)
// eventMod = "_-167" (String#16700, DoABC#2)
// onRoomSettingsClick = "_-1H1" (String#17152, DoABC#2)
// onMakeHomeClick = "_-1Bb" (String#16923, DoABC#2)
// onEventSettingsClick = "_-wI" (String#24544, DoABC#2)
// onEmbedSrcClick = "_-3Ak" (String#21909, DoABC#2)
// onThumbUp = "_-0e2" (String#15586, DoABC#2)
// onStaffPick = "_-0-0" (String#14010, DoABC#2)
// onFacebookLike = "_-1VX" (String#17723, DoABC#2)
// onZoomClick = "_-3Hg" (String#22188, DoABC#2)
// onCloseButtonClick = "_-39Y" (String#7505, DoABC#2)
// addMouseOverListener = "_-2VI" (String#20252, DoABC#2)
// onHover = "_-ks" (String#24065, DoABC#2)
// moveChildrenToRow = "_-0xS" (String#16331, DoABC#2)
// isFavouritesFull = "_-10D" (String#16472, DoABC#2)
// HTIE_ICON_ZOOM = "_-0HB" (String#14726, DoABC#2)
// publicSpaceNodeId = "_-1m2" (String#18380, DoABC#2)


