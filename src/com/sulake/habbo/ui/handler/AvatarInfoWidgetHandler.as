
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.session.events.UserNameUpdateEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarInfoEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.session.events.RoomSessionUserDataUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionDanceEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserDataUpdateEvent;
    import flash.events.Event;

    public class AvatarInfoWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _widget:AvatarInfoWidget;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function set widget(_arg_1:AvatarInfoWidget):void
        {
            this._widget = _arg_1;
        }
        public function dispose():void
        {
            if (!this._disposed){
                this.container = null;
                this._widget = null;
                this._disposed = true;
            };
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWAIE_AVATAR_INFO);
        }
        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }
        public function get roomEngine():IRoomEngine
        {
            return (((this._container) ? this._container.roomEngine : null));
        }
        public function get roomSession():IRoomSession
        {
            return (((this._container) ? this._container.roomSession : null));
        }
        public function get friendList():IHabboFriendList
        {
            return (((this._container) ? this._container.friendList : null));
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (((((this._container) && (this._container.toolbar))) && (this._container.toolbar.events))){
                this._container.toolbar.events.removeEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onToolbarClicked);
            };
            if (((((this._container) && (this._container.sessionDataManager))) && (this._container.sessionDataManager.events))){
                this._container.sessionDataManager.events.removeEventListener(UserNameUpdateEvent._SafeStr_4791, this.onUserNameUpdate);
            };
            this._container = _arg_1;
            if (((((this._container) && (this._container.toolbar))) && (this._container.toolbar.events))){
                this._container.toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onToolbarClicked);
            };
            if (((((this._container) && (this._container.sessionDataManager))) && (this._container.sessionDataManager.events))){
                this._container.sessionDataManager.events.addEventListener(UserNameUpdateEvent._SafeStr_4791, this.onUserNameUpdate);
            };
        }
        private function onToolbarClicked(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.iconId == HabboToolbarIconEnum.MEMENU){
                if (((this.container.config.getBoolean("simple.memenu.enabled", false)) && (this.container.config.getBoolean("menu.own_avatar.enabled", false)))){
                    this._widget.selectOwnAvatar();
                }
                else {
                    this.dispatchOwnAvatarInfo();
                };
            };
        }
        private function onUserNameUpdate(_arg_1:UserNameUpdateEvent):void
        {
            this._widget.close();
        }
        private function dispatchOwnAvatarInfo():void
        {
            var _local_1:int = this._container.sessionDataManager.userId;
            var _local_2:String = this._container.sessionDataManager.userName;
            var _local_3 = !(this._container.habboHelp.hasChangedName());
            var _local_4:IUserData = this._container.roomSession.userDataManager.getUserData(_local_1);
            if (_local_4){
                this._container.events.dispatchEvent(new RoomWidgetAvatarInfoEvent(_local_1, _local_2, _local_4.id, _local_3));
            };
        }
        public function getWidgetMessages():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetRoomObjectMessage.RWROM_GET_OWN_CHARACTER_INFO);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_START_NAME_CHANGE);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE);
            return (_local_1);
        }
        public function getProcessedEvents():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomSessionUserDataUpdateEvent._SafeStr_4720);
            _local_1.push(RoomSessionDanceEvent.RSDE_DANCE);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            if (!_arg_1){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetRoomObjectMessage.RWROM_GET_OWN_CHARACTER_INFO:
                    this.dispatchOwnAvatarInfo();
                    break;
                case RoomWidgetUserActionMessage.RWUAM_START_NAME_CHANGE:
                    this._container.habboHelp.startNameChange();
                    break;
                case RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE:
                    this._widget.handlePetInfo = false;
                    break;
            };
            return (null);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_2:RoomSessionDanceEvent;
            var _local_3:IUserData;
            switch (_arg_1.type){
                case RoomSessionUserDataUpdateEvent._SafeStr_4720:
                    this._container.events.dispatchEvent(new RoomWidgetUserDataUpdateEvent());
                    return;
                case RoomSessionDanceEvent.RSDE_DANCE:
                    _local_2 = (_arg_1 as RoomSessionDanceEvent);
                    if (((((((((_local_2) && (this._widget))) && (this.container))) && (this.container.roomSession))) && (this.container.roomSession.userDataManager))){
                        _local_3 = this.container.roomSession.userDataManager.getUserData(this.container.sessionDataManager.userId);
                        if (((_local_3) && ((_local_2.userId == _local_3.id)))){
                            this._widget.isDancing = !((_local_2.danceStyle == 0));
                        };
                    };
                    return;
            };
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// RoomSessionDanceEvent = "_-nx" (String#24188, DoABC#2)
// RoomSessionUserDataUpdateEvent = "_-10F" (String#16473, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// AvatarInfoWidget = "_-3Bt" (String#7549, DoABC#2)
// UserNameUpdateEvent = "_-1FC" (String#17079, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// AvatarInfoWidgetHandler = "_-26a" (String#6178, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RoomWidgetUserDataUpdateEvent = "_-1IM" (String#5212, DoABC#2)
// RoomWidgetAvatarInfoEvent = "_-2sQ" (String#7129, DoABC#2)
// RWUAM_REQUEST_PET_UPDATE = "_-0Ro" (String#15130, DoABC#2)
// RWUAM_START_NAME_CHANGE = "_-21I" (String#19065, DoABC#2)
// RWROM_GET_OWN_CHARACTER_INFO = "_-1C2" (String#16944, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// onToolbarClicked = "_-hN" (String#941, DoABC#2)
// RWAIE_AVATAR_INFO = "_-2QK" (String#20059, DoABC#2)
// RSDE_DANCE = "_-0-n" (String#14045, DoABC#2)
// danceStyle = "_-0M0" (String#14915, DoABC#2)
// _SafeStr_4720 = "_-XT" (String#23542, DoABC#2)
// _SafeStr_4791 = "_-28D" (String#19339, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// handlePetInfo = "_-0im" (String#15783, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// selectOwnAvatar = "_-1mU" (String#18400, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// onUserNameUpdate = "_-1eB" (String#18065, DoABC#2)
// dispatchOwnAvatarInfo = "_-2AD" (String#19412, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// startNameChange = "_-1qU" (String#5864, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)


