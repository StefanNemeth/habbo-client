
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.sound.IHabboMusicController;
    import com.sulake.habbo.ui.widget.infostand.InfostandWidget;
    import com.sulake.habbo.sound.events.NowPlayingEvent;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.session.events.UserTagsReceivedEvent;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.habbo.session.events.RoomSessionUserFigureUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetInfoUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionPetCommandsUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionFavouriteGroupUpdateEvent;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomTagSearchMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeImageMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeMottoMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectOperationEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetBadgeImageUpdateEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectNameEvent;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.sound.IPlayListController;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.friendlist.IFriend;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetInfostandExtraParamEnum;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.session.events.RoomSessionUserBadgesEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserBadgesUpdateEvent;
    import flash.events.Event;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserTagsUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUserFigureUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
    import com.sulake.habbo.session.IPetInfo;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;

    public class InfoStandWidgetHandler implements IRoomWidgetHandler 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_7318:Map;
        private var _musicController:IHabboMusicController;
        private var _widget:InfostandWidget;

        public function InfoStandWidgetHandler(_arg_1:IHabboMusicController)
        {
            this._SafeStr_7318 = new Map();
            super();
            this._musicController = _arg_1;
            if (this._musicController != null){
                this._musicController.events.addEventListener(NowPlayingEvent.RWPLENPE_SONG_CHANGED, this.InfoStandWidgetHandler);
                this._musicController.events.addEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
            };
        }
        public function set widget(_arg_1:InfostandWidget):void
        {
            this._widget = _arg_1;
        }
        public function get container():IRoomWidgetHandlerContainer
        {
            return (this._container);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_INFOSTAND);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            if (this._container != null){
                if (this._container.sessionDataManager != null){
                    this._container.sessionDataManager.events.removeEventListener(UserTagsReceivedEvent.RWUTUE_USER_TAGS, this.InfostandWidget);
                    this._container.sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.InfostandWidget);
                };
                if (this._container.roomSessionManager != null){
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionUserFigureUpdateEvent.RWUTUE_USER_FIGURE, this.onFigureUpdate);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetInfoUpdateEvent.PET_INFO, this.InfostandWidget);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
                    this._container.roomSessionManager.events.removeEventListener(RoomSessionFavouriteGroupUpdateEvent._SafeStr_4800, this.InfoStandWidgetHandler);
                };
            };
            this._container = _arg_1;
            if (_arg_1 == null){
                return;
            };
            if (this._container.sessionDataManager != null){
                this._container.sessionDataManager.events.addEventListener(UserTagsReceivedEvent.RWUTUE_USER_TAGS, this.InfostandWidget);
                this._container.sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this.InfostandWidget);
            };
            if (this._container.roomSessionManager != null){
                this._container.roomSessionManager.events.addEventListener(RoomSessionUserFigureUpdateEvent.RWUTUE_USER_FIGURE, this.onFigureUpdate);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetInfoUpdateEvent.PET_INFO, this.InfostandWidget);
                this._container.roomSessionManager.events.addEventListener(RoomSessionPetCommandsUpdateEvent.PET_COMMANDS, this.onPetCommands);
                this._container.roomSessionManager.events.addEventListener(RoomSessionFavouriteGroupUpdateEvent._SafeStr_4800, this.InfoStandWidgetHandler);
            };
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:BitmapData;
            if (this._SafeStr_7318 != null){
                _local_1 = (this._SafeStr_7318.length - 1);
                while (_local_1 >= 0) {
                    _local_2 = this._SafeStr_7318.getWithIndex(_local_1);
                    if (_local_2){
                        _local_2.dispose();
                    };
                    _local_2 = null;
                    _local_1--;
                };
                this._SafeStr_7318.dispose();
                this._SafeStr_7318 = null;
            };
            if (this._musicController != null){
                this._musicController.events.removeEventListener(NowPlayingEvent.RWPLENPE_SONG_CHANGED, this.InfoStandWidgetHandler);
                this._musicController.events.removeEventListener(SongInfoReceivedEvent.SIR_TRAX_SONG_INFO_RECEIVED, this.onSongInfoReceivedEvent);
                this._musicController = null;
            };
            this._disposed = true;
            this.container = null;
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO);
            _local_1.push(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_NAME);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_SEND_FRIEND_REQUEST);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_RESPECT_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_WHISPER_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_IGNORE_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_UNIGNORE_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_KICK_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_BAN_USER);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_GIVE_RIGHTS);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_TAKE_RIGHTS);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_START_TRADING);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_OPEN_HOME_PAGE);
            _local_1.push(RoomWidgetFurniActionMessage.RWFAM_MOVE);
            _local_1.push(RoomWidgetFurniActionMessage.RWFUAM_ROTATE);
            _local_1.push(RoomWidgetFurniActionMessage.RWFAM_PICKUP);
            _local_1.push(RoomWidgetFurniActionMessage.RWFAM_USE);
            _local_1.push(RoomWidgetFurniActionMessage.RWFAM_SAVE_STUFF_DATA);
            _local_1.push(RoomWidgetRoomTagSearchMessage.RWRTSM_ROOM_TAG_SEARCH);
            _local_1.push(RoomWidgetGetBadgeDetailsMessage.RWGOI_MESSAGE_GET_BADGE_DETAILS);
            _local_1.push(RoomWidgetGetBadgeImageMessage.RWGOI_MESSAGE_GET_BADGE_IMAGE);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_KICK_BOT);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_REPORT);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_PICKUP_PET);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_TRAIN_PET);
            _local_1.push(RoomWidgetPetCommandMessage.RWPCM_PET_COMMAND);
            _local_1.push(RoomWidgetPetCommandMessage.RWPCM_REQUEST_PET_COMMANDS);
            _local_1.push(RoomWidgetUserActionMessage. RWUAM_RESPECT_PET);
            _local_1.push(RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE);
            _local_1.push(RoomWidgetChangeMottoMessage.RWVM_CHANGE_MOTTO_MESSAGE);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_3:IUserData;
            var _local_4:RoomWidgetUserActionMessage;
            var _local_7:RoomWidgetFurniActionMessage;
            var _local_8:RoomWidgetChatInputContentUpdateEvent;
            var _local_9:IUserData;
            var _local_10:String;
            var _local_11:RoomWidgetRoomTagSearchMessage;
            var _local_12:RoomWidgetGetBadgeDetailsMessage;
            var _local_13:RoomWidgetGetBadgeImageMessage;
            var _local_14:BitmapData;
            var _local_15:RoomWidgetPetCommandMessage;
            var _local_16:RoomWidgetPetCommandMessage;
            var _local_17:RoomWidgetChangeMottoMessage;
            var _local_18:Map;
            var _local_19:Array;
            var _local_20:String;
            var _local_21:Array;
            var _local_22:String;
            var _local_23:String;
            if (_arg_1 == null){
                return (null);
            };
            if (this._container == null){
                return (null);
            };
            var _local_2:int;
            _local_4 = (_arg_1 as RoomWidgetUserActionMessage);
            if (_local_4 != null){
                _local_2 = _local_4.userId;
                if (_local_4.type == RoomWidgetUserActionMessage.RWUAM_KICK_BOT){
                    _local_3 = this._container.roomSession.userDataManager.getUserDataByIndex(_local_2);
                }
                else {
                    if ((((((_arg_1.type == RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE)) || ((_arg_1.type == RoomWidgetUserActionMessage. RWUAM_RESPECT_PET)))) || ((_arg_1.type == RoomWidgetUserActionMessage.RWUAM_PICKUP_PET)))){
                        _local_3 = this._container.roomSession.userDataManager.getPetUserData(_local_2);
                    }
                    else {
                        _local_3 = this._container.roomSession.userDataManager.getUserData(_local_2);
                    };
                };
                if (_local_3 == null){
                    return (null);
                };
            };
            var _local_5:int;
            var _local_6:int;
            _local_7 = (_arg_1 as RoomWidgetFurniActionMessage);
            if (_local_7 != null){
                _local_5 = _local_7.furniId;
                _local_6 = _local_7.furniCategory;
            };
            switch (_arg_1.type){
                case RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO:
                    return (this.InfoStandWidgetHandler((_arg_1 as RoomWidgetRoomObjectMessage)));
                case RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_NAME:
                    return (this.InfoStandWidgetHandler((_arg_1 as RoomWidgetRoomObjectMessage)));
                case RoomWidgetUserActionMessage.RWUAM_SEND_FRIEND_REQUEST:
                    this._container.friendList.askForAFriend(_local_2, _local_3.name);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_RESPECT_USER:
                    this._container.sessionDataManager.giveRespect(_local_2);
                    break;
                case RoomWidgetUserActionMessage. RWUAM_RESPECT_PET:
                    this._container.sessionDataManager.givePetRespect(_local_2);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_WHISPER_USER:
                    _local_8 = new RoomWidgetChatInputContentUpdateEvent(RoomWidgetChatInputContentUpdateEvent._SafeStr_6208, _local_3.name);
                    this._container.events.dispatchEvent(_local_8);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_IGNORE_USER:
                    this._container.sessionDataManager.SessionDataManager(_local_3.name);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_UNIGNORE_USER:
                    this._container.sessionDataManager.SessionDataManager(_local_3.name);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_KICK_USER:
                    this._container.roomSession.RoomSession(_local_3.webID);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_BAN_USER:
                    this._container.roomSession.RoomSession(_local_3.webID);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_GIVE_RIGHTS:
                    this._container.roomSession.RoomSession(_local_3.webID);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_TAKE_RIGHTS:
                    this._container.roomSession.RoomSession(_local_3.webID);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_START_TRADING:
                    _local_9 = this._container.roomSession.userDataManager.getUserData(_local_4.userId);
                    this._container.inventory.HabboInventory(_local_9.id, _local_9.name);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_OPEN_HOME_PAGE:
                    this._container.sessionDataManager.SessionDataManager(_local_3.webID);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_PICKUP_PET:
                    this._container.roomSession.RoomSession(_local_2);
                    break;
                case RoomWidgetFurniActionMessage.RWFUAM_ROTATE:
                    this._container.roomEngine.RoomEngine(_local_5, _local_6, RoomObjectOperationEnum.OBJECT_ROTATE_POSITIVE);
                    break;
                case RoomWidgetFurniActionMessage.RWFAM_MOVE:
                    this._container.roomEngine.RoomEngine(_local_5, _local_6, RoomObjectOperationEnum.OBJECT_MOVE);
                    break;
                case RoomWidgetFurniActionMessage.RWFAM_PICKUP:
                    this._container.roomEngine.RoomEngine(_local_5, _local_6, RoomObjectOperationEnum.OBJECT_PICKUP);
                    break;
                case RoomWidgetFurniActionMessage.RWFAM_USE:
                    this._container.roomEngine.RoomEngine(_local_5, _local_6);
                    break;
                case RoomWidgetFurniActionMessage.RWFAM_SAVE_STUFF_DATA:
                    _local_10 = _local_7.objectData;
                    if (_local_10 != null){
                        _local_18 = new Map();
                        _local_19 = _local_10.split("\t");
                        if (_local_19 != null){
                            for each (_local_20 in _local_19) {
                                _local_21 = _local_20.split("=", 2);
                                if (((!((_local_21 == null))) && ((_local_21.length == 2)))){
                                    _local_22 = _local_21[0];
                                    _local_23 = _local_21[1];
                                    _local_18.add(_local_22, _local_23);
                                };
                            };
                        };
                        this._container.roomEngine.RoomEngine(_local_5, _local_6, RoomObjectOperationEnum.OBJECT_SAVE_STUFF_DATA, _local_18);
                        if (!_local_18.disposed){
                            _local_18.dispose();
                        };
                    };
                    break;
                case RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE:
                    if (((!((this._container.roomSession == null))) && (!((this._container.roomSession.userDataManager == null))))){
                        this._container.roomSession.userDataManager.requestPetInfo(_local_2);
                    };
                    break;
                case RoomWidgetRoomTagSearchMessage.RWRTSM_ROOM_TAG_SEARCH:
                    _local_11 = (_arg_1 as RoomWidgetRoomTagSearchMessage);
                    if (_local_11 == null){
                        return (null);
                    };
                    this._container.navigator.performTagSearch(_local_11.tag);
                    break;
                case RoomWidgetGetBadgeDetailsMessage.RWGOI_MESSAGE_GET_BADGE_DETAILS:
                    _local_12 = (_arg_1 as RoomWidgetGetBadgeDetailsMessage);
                    if (_local_12 == null){
                        return (null);
                    };
                    this._container.sessionDataManager.InfoStandUserView(_local_12.groupId);
                    break;
                case RoomWidgetGetBadgeImageMessage.RWGOI_MESSAGE_GET_BADGE_IMAGE:
                    _local_13 = (_arg_1 as RoomWidgetGetBadgeImageMessage);
                    if (_local_13 == null){
                        return (null);
                    };
                    _local_14 = this._container.sessionDataManager.SessionDataManager(_local_13.badgeId);
                    if (_local_14 != null){
                        this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_local_13.badgeId, _local_14));
                    };
                    break;
                case RoomWidgetUserActionMessage.RWUAM_KICK_BOT:
                    this._container.roomSession.RoomSession(_local_2);
                    break;
                case RoomWidgetUserActionMessage.RWUAM_REPORT:
                    if ((((this._container == null)) || ((this._container.habboHelp == null)))) break;
                    if (_local_3 == null) break;
                    this._container.habboHelp.reportUser(_local_2, _local_3.name);
                    break;
                case RoomWidgetPetCommandMessage.RWPCM_REQUEST_PET_COMMANDS:
                    _local_15 = (_arg_1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.RoomSession(_local_15.petId);
                    break;
                case RoomWidgetPetCommandMessage.RWPCM_PET_COMMAND:
                    _local_16 = (_arg_1 as RoomWidgetPetCommandMessage);
                    this._container.roomSession.RoomSession(_local_16.value);
                    break;
                case RoomWidgetChangeMottoMessage.RWVM_CHANGE_MOTTO_MESSAGE:
                    _local_17 = (_arg_1 as RoomWidgetChangeMottoMessage);
                    this._container.roomSession.RoomSession(_local_17.motto);
                    break;
            };
            return (null);
        }
        private function InfoStandWidgetHandler(_arg_1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _local_2:int;
            var _local_3:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:IRoomObject;
            var _local_8:String;
            var _local_9:IUserData;
            var _local_10:int;
            var _local_11:int;
            var _local_12:IFurnitureData;
            _local_2 = this._container.roomSession.roomId;
            _local_3 = this._container.roomSession.roomCategory;
            var _local_4:String;
            switch (_arg_1.category){
                case RoomObjectCategoryEnum._SafeStr_4329:
                case RoomObjectCategoryEnum._SafeStr_4330:
                    if ((((this._container.events == null)) || ((this._container.roomEngine == null)))){
                        return (null);
                    };
                    _local_7 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2, _local_3, _arg_1.id, _arg_1.category);
                    _local_8 = _local_7.getType();
                    if (_local_8.indexOf("poster") == 0){
                        _local_10 = int(_local_8.replace("poster", ""));
                        _local_4 = (("${poster_" + _local_10) + "_name}");
                        _local_5 = _local_7.getId();
                        _local_6 = -1;
                    }
                    else {
                        _local_11 = _local_7.getModel().getNumber(RoomObjectVariableEnum._SafeStr_7294);
                        if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4329){
                            _local_12 = this._container.sessionDataManager.SessionDataManager(_local_11);
                        }
                        else {
                            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330){
                                _local_12 = this._container.sessionDataManager.SessionDataManager(_local_11);
                            };
                        };
                        if (_local_12 == null){
                            return (null);
                        };
                        _local_4 = _local_12.title;
                        _local_5 = _local_7.getId();
                        _local_6 = _local_12.id;
                    };
                    break;
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                    if ((((((((((this._container.roomSession == null)) || ((this._container.sessionDataManager == null)))) || ((this._container.events == null)))) || ((this._container.roomEngine == null)))) || ((this._container.friendList == null)))){
                        return (null);
                    };
                    _local_9 = this._container.roomSession.userDataManager.getUserDataByIndex(_arg_1.id);
                    if (_local_9 == null){
                        return (null);
                    };
                    _local_4 = _local_9.name;
                    _local_5 = _local_9.id;
                    _local_6 = _local_9.webID;
                    break;
            };
            if (_local_4 != null){
                this._container.events.dispatchEvent(new RoomWidgetRoomObjectNameEvent(_local_6, _arg_1.category, _local_4, _local_5));
            };
            return (null);
        }
        private function InfoStandWidgetHandler(_arg_1:RoomWidgetRoomObjectMessage):RoomWidgetUpdateEvent
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:uint;
            var _local_5:ImageResult;
            var _local_6:RoomWidgetFurniInfoUpdateEvent;
            var _local_7:IRoomObject;
            var _local_8:IRoomObjectModel;
            var _local_9:String;
            var _local_10:int;
            var _local_11:int;
            var _local_12:IUserData;
            var _local_13:String;
            var _local_14:RoomWidgetUserInfoUpdateEvent;
            var _local_15:Array;
            var _local_16:String;
            var _local_17:IRoomObject;
            var _local_18:String;
            var _local_19:String;
            var _local_20:IAvatarImage;
            var _local_21:BitmapData;
            var _local_22:String;
            var _local_23:int;
            var _local_24:int;
            var _local_25:IFurnitureData;
            var _local_26:int;
            var _local_27:String;
            var _local_28:String;
            var _local_29:String;
            var _local_30:IPlayListController;
            var _local_31:String;
            var _local_32:ISongInfo;
            var _local_33:IFriend;
            var _local_34:Boolean;
            var _local_35:Boolean;
            var _local_36:int;
            var _local_37:Array;
            var _local_38:String;
            var _local_39:Array;
            var _local_40:int;
            var _local_41:BitmapData;
            _local_2 = this._container.roomSession.roomId;
            _local_3 = this._container.roomSession.roomCategory;
            switch (_arg_1.category){
                case RoomObjectCategoryEnum._SafeStr_4329:
                case RoomObjectCategoryEnum._SafeStr_4330:
                    if ((((this._container.events == null)) || ((this._container.roomEngine == null)))){
                        return (null);
                    };
                    if (_arg_1.id < 0){
                        return (null);
                    };
                    _local_4 = 4282203453;
                    _local_5 = this._container.roomEngine.RoomEngine(_local_2, _local_3, _arg_1.id, _arg_1.category, new Vector3d(180), 32, null, _local_4);
                    _local_6 = new RoomWidgetFurniInfoUpdateEvent(RoomWidgetFurniInfoUpdateEvent.RWFIUE_FURNI);
                    _local_6.id = _arg_1.id;
                    _local_6.category = _arg_1.category;
                    _local_7 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2, _local_3, _arg_1.id, _arg_1.category);
                    _local_8 = _local_7.getModel();
                    if (_local_8.getString(RoomWidgetInfostandExtraParamEnum.RWEIEP_INFOSTAND_EXTRA_PARAM) != null){
                        _local_6.extraParam = _local_8.getString(RoomWidgetInfostandExtraParamEnum.RWEIEP_INFOSTAND_EXTRA_PARAM);
                    }
                    else {
                        if (_local_8.getNumber(RoomObjectVariableEnum._SafeStr_7348) == 1){
                            _local_6.extraParam = RoomWidgetInfostandExtraParamEnum.RWEIEP_USABLE;
                        };
                    };
                    _local_9 = _local_7.getType();
                    if (_local_9.indexOf("poster") == 0){
                        _local_23 = int(_local_9.replace("poster", ""));
                        _local_6.name = (("${poster_" + _local_23) + "_name}");
                        _local_6.description = (("${poster_" + _local_23) + "_desc}");
                    }
                    else {
                        _local_24 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_7294);
                        if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4329){
                            _local_25 = this._container.sessionDataManager.SessionDataManager(_local_24);
                        }
                        else {
                            if (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330){
                                _local_25 = this._container.sessionDataManager.SessionDataManager(_local_24);
                            };
                        };
                        if (_local_25 != null){
                            _local_6.name = _local_25.title;
                            _local_6.description = _local_25.description;
                            _local_6.catalogPageId = _local_25.catalogPageId;
                            _local_6.offerId = _local_25.offerId;
                            if (((!((this._container.userDefinedRoomEvents == null))) && ((_arg_1.category == RoomObjectCategoryEnum._SafeStr_4329)))){
                                this._container.userDefinedRoomEvents.stuffSelected(_local_7.getId(), _local_25.title);
                            };
                        };
                    };
                    if (_local_9.indexOf("post_it") > -1){
                        _local_6.isStickie = true;
                    };
                    _local_6.image = _local_5.data;
                    _local_10 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_7353);
                    _local_11 = _local_8.getNumber(RoomObjectVariableEnum._SafeStr_7354);
                    _local_6.expiration = (_local_10 - ((getTimer() - _local_11) / 60000));
                    _local_6.isWallItem = (_arg_1.category == RoomObjectCategoryEnum._SafeStr_4330);
                    _local_6.isRoomOwner = this._container.roomSession.isRoomOwner;
                    _local_6.isRoomController = this._container.roomSession.isRoomController;
                    _local_6.isAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                    this._container.events.dispatchEvent(_local_6);
                    if (((!((_local_6.extraParam == null))) && ((_local_6.extraParam.length > 0)))){
                        _local_26 = -1;
                        _local_27 = "";
                        _local_28 = "";
                        _local_29 = "";
                        if (_local_6.extraParam == RoomWidgetInfostandExtraParamEnum.RWEIEP_JUKEBOX){
                            _local_30 = this._musicController.getRoomItemPlaylist();
                            if (_local_30 != null){
                                _local_26 = _local_30.nowPlayingSongId;
                                _local_29 = RoomWidgetSongUpdateEvent.RWSUE_PLAYING_CHANGED;
                            };
                        }
                        else {
                            if (_local_6.extraParam.indexOf(RoomWidgetInfostandExtraParamEnum.RWEIEP_SONGDISK) == 0){
                                _local_31 = _local_6.extraParam.substr(RoomWidgetInfostandExtraParamEnum.RWEIEP_SONGDISK.length);
                                _local_26 = parseInt(_local_31);
                                _local_29 = RoomWidgetSongUpdateEvent.RWSUE_DATA_RECEIVED;
                            };
                        };
                        if (_local_26 != -1){
                            _local_32 = this._musicController.getSongInfo(_local_26);
                            if (_local_32 != null){
                                _local_27 = _local_32.name;
                                _local_28 = _local_32.creator;
                            };
                            this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(_local_29, _local_26, _local_27, _local_28));
                        };
                    };
                    break;
                case RoomObjectCategoryEnum.OBJECT_CATEGORY_USER:
                    if ((((((((((this._container.roomSession == null)) || ((this._container.sessionDataManager == null)))) || ((this._container.events == null)))) || ((this._container.roomEngine == null)))) || ((this._container.friendList == null)))){
                        return (null);
                    };
                    _local_12 = this._container.roomSession.userDataManager.getUserDataByIndex(_arg_1.id);
                    if (_local_12 == null){
                        return (null);
                    };
                    if (_local_12.type == RoomObjectTypeEnum._SafeStr_3747){
                        this._container.roomSession.userDataManager.requestPetInfo(_local_12.webID);
                        return (null);
                    };
                    if (_local_12.type == RoomObjectTypeEnum._SafeStr_3740){
                        _local_13 = RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER;
                        if (_local_12.webID != this._container.sessionDataManager.userId){
                            _local_13 = RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER;
                        };
                    }
                    else {
                        if (_local_12.type == RoomObjectTypeEnum._SafeStr_3749){
                            _local_13 = RoomWidgetUserInfoUpdateEvent.BOT;
                        }
                        else {
                            return (null);
                        };
                    };
                    _local_14 = new RoomWidgetUserInfoUpdateEvent(_local_13);
                    _local_14.isSpectatorMode = this._container.roomSession.isSpectatorMode;
                    _local_14.name = _local_12.name;
                    _local_14.motto = _local_12.custom;
                    _local_14.achievementScore = _local_12.achievementScore;
                    _local_14.webID = _local_12.webID;
                    _local_14.userRoomId = _arg_1.id;
                    _local_15 = new Array();
                    _local_17 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_2, _local_3, _arg_1.id, _arg_1.category);
                    if (_local_17 != null){
                        _local_14.carryItem = _local_17.getModel().getNumber(RoomObjectVariableEnum._SafeStr_6552);
                    };
                    if (_local_13 == RoomWidgetUserInfoUpdateEvent.RWUIUE_OWN_USER){
                        _local_14.realName = this._container.sessionDataManager.realName;
                        _local_14.allowNameChange = !(this._container.habboHelp.hasChangedName());
                    };
                    if (_local_13 == RoomWidgetUserInfoUpdateEvent.RWUIUE_PEER){
                        _local_14.canBeAskedAsFriend = this._container.friendList.canBeAskedForAFriend(_local_12.webID);
                        _local_33 = this._container.friendList.getFriend(_local_12.webID);
                        if (_local_33 != null){
                            _local_14.realName = _local_33.realName;
                        };
                        if (_local_17 != null){
                            _local_38 = _local_17.getModel().getString(RoomObjectVariableEnum._SafeStr_7361);
                            _local_14.hasFlatControl = (((((_local_38 == "onlyfurniture")) || ((_local_38 == "useradmin")))) || ((_local_38 == "")));
                            _local_14.canBeKicked = this._container.roomSession.isPrivateRoom;
                        };
                        _local_14.isIgnored = this._container.sessionDataManager.isIgnored(_local_12.name);
                        _local_14.amIOwner = this._container.roomSession.isRoomOwner;
                        _local_14.amIController = this._container.roomSession.isRoomController;
                        _local_14.amIAnyRoomController = this._container.sessionDataManager.isAnyRoomController;
                        _local_14.respectLeft = this._container.sessionDataManager.respectLeft;
                        _local_34 = !(this._container.sessionDataManager.systemShutDown);
                        _local_35 = this._container.roomSession.isTradingRoom;
                        _local_14.canTrade = ((_local_34) && (_local_35));
                        _local_14.canTradeReason = RoomWidgetUserInfoUpdateEvent.TRADE_REASON_OK;
                        if (!_local_34){
                            _local_14.canTradeReason = RoomWidgetUserInfoUpdateEvent._SafeStr_6864;
                        };
                        if (!_local_35){
                            _local_14.canTradeReason = RoomWidgetUserInfoUpdateEvent._SafeStr_6865;
                        };
                        _local_36 = this._container.sessionDataManager.userId;
                        _local_37 = this._container.sessionDataManager.SessionDataManager(_local_36);
                        this.InfoStandWidgetHandler(_local_36, _local_37);
                    };
                    if (_local_13 == RoomWidgetUserInfoUpdateEvent.BOT){
                        _local_14.canBeKicked = this._container.roomSession.isRoomOwner;
                        _local_15.push(RoomWidgetUserInfoUpdateEvent.BOT);
                    }
                    else {
                        _local_15 = this._container.roomSession.userDataManager.getUserBadges(_local_12.webID);
                        _local_16 = this._container.sessionDataManager.SessionDataManager(int(_local_12.groupID));
                        _local_14.groupId = int(_local_12.groupID);
                        _local_14.groupBadgeId = _local_16;
                    };
                    _local_14.badges = _local_15;
                    _local_18 = _local_12.figure;
                    _local_19 = _local_12.sex;
                    _local_20 = this._container.avatarRenderManager.createAvatarImage(_local_18, AvatarScaleType._SafeStr_4336, _local_19);
                    if (_local_20 != null){
                        _local_20.setDirection(AvatarSetType._SafeStr_4457, 4);
                        _local_14.image = _local_20.TwinkleImages(AvatarSetType._SafeStr_4457, true);
                        _local_20.dispose();
                    };
                    this._container.events.dispatchEvent(_local_14);
                    if (_local_12.type == RoomObjectTypeEnum._SafeStr_3740){
                        _local_39 = this._container.sessionDataManager.SessionDataManager(_local_12.webID);
                        this.InfoStandWidgetHandler(_local_12.webID, _local_39);
                    };
                    _local_40 = 0;
                    while (_local_40 < _local_15.length) {
                        _local_22 = _local_15[_local_40];
                        _local_21 = this._container.sessionDataManager.SessionDataManager(_local_22);
                        if (_local_21 != null){
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_local_22, _local_21));
                        };
                        _local_40++;
                    };
                    if (_local_16 != null){
                        _local_41 = this._container.sessionDataManager.SessionDataManager(_local_16);
                        if (_local_41 != null){
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_local_16, _local_41));
                        };
                    };
                    break;
            };
            return (null);
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomSessionUserBadgesEvent.RWUBUE_USER_BADGES]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
            var _local_2:RoomSessionUserBadgesEvent;
            var _local_3:int;
            var _local_4:String;
            var _local_5:BitmapData;
            switch (_arg_1.type){
                case RoomSessionUserBadgesEvent.RWUBUE_USER_BADGES:
                    _local_2 = (_arg_1 as RoomSessionUserBadgesEvent);
                    if (_local_2 == null){
                        return;
                    };
                    this._container.events.dispatchEvent(new RoomWidgetUserBadgesUpdateEvent(_local_2.userId, _local_2.badges));
                    _local_3 = 0;
                    while (_local_3 < _local_2.badges.length) {
                        _local_4 = _local_2.badges[_local_3];
                        _local_5 = this._container.sessionDataManager.SessionDataManager(_local_4);
                        if (_local_5 != null){
                            this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_local_4, _local_5));
                        };
                        _local_3++;
                    };
                    return;
            };
        }
        private function InfostandWidget(_arg_1:UserTagsReceivedEvent):void
        {
            this.InfoStandWidgetHandler(_arg_1.userId, _arg_1.tags);
        }
        private function InfoStandWidgetHandler(_arg_1:int, _arg_2:Array):void
        {
            if (_arg_2 == null){
                return;
            };
            var _local_3:Boolean;
            if (this._container.sessionDataManager != null){
                _local_3 = (_arg_1 == this._container.sessionDataManager.userId);
            };
            if (((!((this._container == null))) && (!((this._container.events == null))))){
                this._container.events.dispatchEvent(new RoomWidgetUserTagsUpdateEvent(_arg_1, _arg_2, _local_3));
            };
        }
        private function InfostandWidget(_arg_1:BadgeImageReadyEvent):void
        {
            if (((!((this._container == null))) && (!((this._container.events == null))))){
                this._container.events.dispatchEvent(new RoomWidgetBadgeImageUpdateEvent(_arg_1.badgeId, _arg_1.badgeImage));
            };
        }
        private function onFigureUpdate(_arg_1:RoomSessionUserFigureUpdateEvent):void
        {
            var _local_5:IAvatarImage;
            var _local_6:Boolean;
            if (this._container == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            if (_arg_1.userId < 0){
                return;
            };
            var _local_2:IUserData = this._container.roomSession.userDataManager.getUserDataByIndex(_arg_1.userId);
            if (_local_2 == null){
                return;
            };
            var _local_3:int = _local_2.webID;
            var _local_4:BitmapData;
            if (this._container.avatarRenderManager != null){
                _local_5 = this._container.avatarRenderManager.createAvatarImage(_arg_1.figure, AvatarScaleType._SafeStr_4336, _arg_1.gender);
                if (_local_5 != null){
                    _local_5.setDirection(AvatarSetType._SafeStr_4457, 4);
                    _local_4 = _local_5.TwinkleImages(AvatarSetType._SafeStr_4457, true);
                    _local_5.dispose();
                };
                _local_6 = (_local_3 == this._container.sessionDataManager.userId);
                if (((!((this._container == null))) && (!((this._container.events == null))))){
                    this._container.events.dispatchEvent(new RoomWidgetUserFigureUpdateEvent(_local_3, _local_4, _local_6, _arg_1.customInfo, _arg_1.achievementScore));
                };
            };
        }
        private function InfostandWidget(_arg_1:RoomSessionPetInfoUpdateEvent):void
        {
            var _local_8:Boolean;
            var _local_9:RoomWidgetPetInfoUpdateEvent;
            var _local_10:Boolean;
            var _local_11:int;
            var _local_12:int;
            var _local_13:IUserData;
            var _local_14:IRoomObject;
            var _local_15:String;
            var _local_2:IPetInfo = _arg_1.petInfo;
            if (_local_2 == null){
                return;
            };
            var _local_3:IUserData = this._container.roomSession.userDataManager.getPetUserData(_local_2.petId);
            if (_local_3 == null){
                return;
            };
            var _local_4:String = _local_3.figure;
            var _local_5:int = this.RoomEngine(_local_4);
            var _local_6:int = this.InfoStandWidgetHandler(_local_4);
            var _local_7:BitmapData = (this._SafeStr_7318.getValue(_local_4) as BitmapData);
            if (_local_7 == null){
                _local_7 = this.RoomEngine(_local_4);
                this._SafeStr_7318.add(_local_4, _local_7);
            };
            if (((!((this._container == null))) && (!((this._container.events == null))))){
                _local_8 = (_local_2.ownerId == this._container.sessionDataManager.userId);
                _local_9 = new RoomWidgetPetInfoUpdateEvent(_local_5, _local_6, _local_3.name, _local_2.petId, _local_7, _local_8, _local_2.ownerId, _local_2.ownerName, _local_3.id);
                _local_9.level = _local_2.level;
                _local_9.levelMax = _local_2.levelMax;
                _local_9.experience = _local_2.experience;
                _local_9.experienceMax = _local_2.experienceMax;
                _local_9.energy = _local_2.energy;
                _local_9.energyMax = _local_2.energyMax;
                _local_9.nutrition = _local_2.nutrition;
                _local_9.nutritionMax = _local_2.nutritionMax;
                _local_9.petRespect = _local_2.respect;
                _local_9.petRespectLeft = this._container.sessionDataManager.petRespectLeft;
                _local_9.age = _local_2.age;
                _local_10 = false;
                _local_11 = this._container.roomSession.roomId;
                _local_12 = this._container.roomSession.roomCategory;
                _local_13 = this._container.roomSession.userDataManager.getUserData(_local_2.ownerId);
                if (_local_13 != null){
                    _local_14 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_11, _local_12, _local_13.id, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                    if (_local_14 != null){
                        _local_15 = _local_14.getModel().getString(RoomObjectVariableEnum._SafeStr_7361);
                        _local_10 = ((((((((((this._container.roomSession.isRoomOwner) || (this._container.roomSession.isRoomController))) || (this._container.sessionDataManager.isAnyRoomController))) && (!((_local_15 == "useradmin"))))) && (this._container.roomSession.isPrivateRoom))) && (!(_local_8)));
                    };
                };
                _local_9.canOwnerBeKicked = _local_10;
                this._container.events.dispatchEvent(_local_9);
            };
        }
        private function onPetCommands(_arg_1:RoomSessionPetCommandsUpdateEvent):void
        {
            var _local_2:RoomWidgetPetCommandsUpdateEvent;
            if (((!((this._container == null))) && (!((this._container.events == null))))){
                _local_2 = new RoomWidgetPetCommandsUpdateEvent(_arg_1.petId, _arg_1.allCommands, _arg_1.enabledCommands);
                this._container.events.dispatchEvent(_local_2);
            };
        }
        private function InfoStandWidgetHandler(_arg_1:RoomSessionFavouriteGroupUpdateEvent):void
        {
            if (this._widget){
                this._widget.InfostandWidget(_arg_1.roomIndex, _arg_1.habboGroupId, _arg_1.status);
            };
        }
        public function update():void
        {
        }
        private function RoomEngine(_arg_1:String):BitmapData
        {
            var _local_4:IAvatarImage;
            var _local_5:int;
            var _local_6:uint;
            var _local_7:ImageResult;
            var _local_2:BitmapData;
            var _local_3:int = this.RoomEngine(_arg_1);
            if (_local_3 < 8){
                _local_4 = this._container.avatarRenderManager.createPetImageFromFigure(_arg_1, AvatarScaleType._SafeStr_4336, null);
                if (_local_4 != null){
                    _local_2 = _local_4.getCroppedImage(AvatarSetType._SafeStr_4457);
                    _local_4.dispose();
                };
            }
            else {
                _local_5 = this.InfoStandWidgetHandler(_arg_1);
                _local_6 = 0;
                _local_7 = this._container.roomEngine.RoomEngine(_local_3, _local_5, new Vector3d(90), 64, null, _local_6);
                if (_local_7 != null){
                    _local_2 = _local_7.data;
                };
            };
            if (_local_2 == null){
                _local_2 = new BitmapData(30, 30, false, 4289374890);
            };
            return (_local_2);
        }
        private function RoomEngine(_arg_1:String):int
        {
            return (this.InfoStandWidgetHandler(_arg_1, 0));
        }
        private function InfoStandWidgetHandler(_arg_1:String):int
        {
            return (this.InfoStandWidgetHandler(_arg_1, 1));
        }
        private function InfoStandWidgetHandler(_arg_1:String, _arg_2:int):int
        {
            var _local_3:Array;
            if (_arg_1 != null){
                _local_3 = _arg_1.split(" ");
                if (_local_3.length > _arg_2){
                    return (int(_local_3[_arg_2]));
                };
            };
            return (-1);
        }
        private function InfoStandWidgetHandler(_arg_1:NowPlayingEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            var _local_5:ISongInfo;
            if (this._musicController != null){
                _local_2 = _arg_1.id;
                _local_3 = "";
                _local_4 = "";
                if (_local_2 != -1){
                    _local_5 = this._musicController.getSongInfo(_local_2);
                    if (_local_5 != null){
                        _local_3 = _local_5.name;
                        _local_4 = _local_5.creator;
                    };
                };
                this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.RWSUE_PLAYING_CHANGED, _local_2, _local_3, _local_4));
            };
        }
        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            var _local_2:ISongInfo;
            if (this._musicController != null){
                _local_2 = this._musicController.getSongInfo(_arg_1.id);
                if (_local_2 != null){
                    this._container.events.dispatchEvent(new RoomWidgetSongUpdateEvent(RoomWidgetSongUpdateEvent.RWSUE_DATA_RECEIVED, _arg_1.id, _local_2.name, _local_2.creator));
                };
            };
        }

    }
}//package com.sulake.habbo.ui.handler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// IFriend = "_-2ET" (String#6332, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionUserBadgesEvent = "_-0-O" (String#14028, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// RoomSessionPetInfoUpdateEvent = "_-Xz" (String#23559, DoABC#2)
// RoomSessionPetCommandsUpdateEvent = "_-AD" (String#22626, DoABC#2)
// IPetInfo = "_-1od" (String#5834, DoABC#2)
// RoomSessionUserFigureUpdateEvent = "_-387" (String#21808, DoABC#2)
// RoomSessionFavouriteGroupUpdateEvent = "_-0xo" (String#16346, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// NowPlayingEvent = "_-1nK" (String#5803, DoABC#2)
// RoomWidgetInfostandExtraParamEnum = "_-2ru" (String#7121, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomObjectOperationEnum = "_-0Zp" (String#15436, DoABC#2)
// InfoStandWidgetHandler = "_-2fW" (String#6859, DoABC#2)
// RoomWidgetFurniActionMessage = "_-02g" (String#3622, DoABC#2)
// RoomWidgetChatInputContentUpdateEvent = "_-2V7" (String#20243, DoABC#2)
// RoomWidgetUserInfoUpdateEvent = "_-28z" (String#6226, DoABC#2)
// RoomWidgetUserBadgesUpdateEvent = "_-18I" (String#16786, DoABC#2)
// RoomWidgetFurniInfoUpdateEvent = "_-1V1" (String#5455, DoABC#2)
// RoomWidgetPetCommandsUpdateEvent = "_-0xD" (String#16321, DoABC#2)
// RoomWidgetUserTagsUpdateEvent = "_-006" (String#14057, DoABC#2)
// RoomWidgetPetInfoUpdateEvent = "_-KB" (String#8087, DoABC#2)
// RoomWidgetBadgeImageUpdateEvent = "_-1Sg" (String#17609, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RoomWidgetUserFigureUpdateEvent = "_-3DM" (String#22010, DoABC#2)
// RoomWidgetSongUpdateEvent = "_-0rz" (String#16120, DoABC#2)
// RoomWidgetRoomObjectNameEvent = "_-0gJ" (String#15686, DoABC#2)
// UserTagsReceivedEvent = "_-09C" (String#14416, DoABC#2)
// RoomWidgetGetBadgeImageMessage = "_-0U-" (String#4182, DoABC#2)
// RoomWidgetGetBadgeDetailsMessage = "_-3AO" (String#7522, DoABC#2)
// RoomWidgetChangeMottoMessage = "_-iB" (String#8557, DoABC#2)
// RoomWidgetPetCommandMessage = "_-1W9" (String#5475, DoABC#2)
// RoomWidgetRoomTagSearchMessage = "_-2ev" (String#6850, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWFUAM_ROTATE = "_-1J1" (String#17237, DoABC#2)
// RWFAM_MOVE = "_-07t" (String#14359, DoABC#2)
// RWFAM_PICKUP = "_-0VQ" (String#15258, DoABC#2)
// RWFAM_USE = "_-7c" (String#22527, DoABC#2)
// RWFAM_SAVE_STUFF_DATA = "_-0oi" (String#16001, DoABC#2)
// furniCategory = "_-UL" (String#23423, DoABC#2)
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
// RWUAM_OPEN_HOME_PAGE = "_-0z1" (String#16395, DoABC#2)
// RWUAM_KICK_BOT = "_-0BZ" (String#14509, DoABC#2)
// RWUAM_REPORT = "_-3-T" (String#21480, DoABC#2)
// RWUAM_PICKUP_PET = "_-2JW" (String#19790, DoABC#2)
// RWUAM_TRAIN_PET = "_-3F2" (String#22078, DoABC#2)
//  RWUAM_RESPECT_PET = "_-0nn" (String#15968, DoABC#2)
// RWUAM_REQUEST_PET_UPDATE = "_-0Ro" (String#15130, DoABC#2)
// RWGOI_MESSAGE_GET_BADGE_IMAGE = "_-1w2" (String#18800, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// RWGOI_MESSAGE_GET_BADGE_DETAILS = "_-1LU" (String#17332, DoABC#2)
// RWVM_CHANGE_MOTTO_MESSAGE = "_-0xu" (String#16349, DoABC#2)
// RWPCM_REQUEST_PET_COMMANDS = "_-1pG" (String#18512, DoABC#2)
// RWPCM_PET_COMMAND = "_-3K8" (String#22288, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// RWRTSM_ROOM_TAG_SEARCH = "_-1oq" (String#18491, DoABC#2)
// RWROM_GET_OBJECT_INFO = "_-cp" (String#23747, DoABC#2)
// RWROM_GET_OBJECT_NAME = "_-1vl" (String#18788, DoABC#2)
// custom = "_-1sW" (String#5894, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3740 = "_-39-" (String#21844, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// groupID = "_-37J" (String#7452, DoABC#2)
// achievementScore = "_-16Z" (String#5005, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// _SafeStr_3749 = "_-1aR" (String#17911, DoABC#2)
// habboGroupId = "_-PC" (String#23215, DoABC#2)
// customInfo = "_-2Mk" (String#19916, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// widget = "_-1yo" (String#18920, DoABC#2)
// RWUIUE_OWN_USER = "_-13K" (String#16592, DoABC#2)
// RWEIEP_INFOSTAND_EXTRA_PARAM = "_-3J-" (String#22238, DoABC#2)
// RWEIEP_JUKEBOX = "_-2Bo" (String#19475, DoABC#2)
// RWEIEP_SONGDISK = "_-0eV" (String#15606, DoABC#2)
// RWEIEP_USABLE = "_-0ax" (String#15472, DoABC#2)
// RWE_INFOSTAND = "_-0SA" (String#15142, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// createPetImageFromFigure = "_-0Sk" (String#4153, DoABC#2)
// _SafeStr_4336 = "_-1wM" (String#18815, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// TwinkleImages = "_-eg" (String#2150, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// badgeImage = "_-250" (String#19222, DoABC#2)
// RWUBUE_USER_BADGES = "_-21B" (String#19059, DoABC#2)
// petInfo = "_-YX" (String#23581, DoABC#2)
// allCommands = "_-2QF" (String#20056, DoABC#2)
// enabledCommands = "_-0yX" (String#16375, DoABC#2)
// RWUTUE_USER_FIGURE = "_-0QV" (String#15081, DoABC#2)
// _SafeStr_4800 = "_-F" (String#22812, DoABC#2)
// RWUTUE_USER_TAGS = "_-1la" (String#18357, DoABC#2)
// offerId = "_-9g" (String#928, DoABC#2)
// extraParam = "_-AM" (String#7874, DoABC#2)
// expiration = "_-1G1" (String#1648, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// RWUIUE_PEER = "_-2Tv" (String#20195, DoABC#2)
// _SafeStr_6208 = "_-Px" (String#23247, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// getPetUserData = "_-2Rz" (String#6606, DoABC#2)
// InfostandWidget = "_-0dE" (String#1512, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// levelMax = "_-2dd" (String#6823, DoABC#2)
// experienceMax = "_-1bq" (String#5596, DoABC#2)
// energyMax = "_-8m" (String#7836, DoABC#2)
// nutrition = "_-0yZ" (String#4819, DoABC#2)
// nutritionMax = "_-1m9" (String#5783, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// isRoomController = "_-xz" (String#8838, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isSpectatorMode = "_-10C" (String#4874, DoABC#2)
// isTradingRoom = "_-0eT" (String#4400, DoABC#2)
// _SafeStr_6552 = "_-0ig" (String#15779, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// RWPLENPE_SONG_CHANGED = "_-5w" (String#22462, DoABC#2)
// getRoomItemPlaylist = "_-2Su" (String#6624, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// InfoStandWidgetHandler = "_-17C" (String#5020, DoABC#2)
// _musicController = "_-3Bw" (String#458, DoABC#2)
// nowPlayingSongId = "_-2A0" (String#6248, DoABC#2)
// SIR_TRAX_SONG_INFO_RECEIVED = "_-02" (String#14127, DoABC#2)
// onSongInfoReceivedEvent = "_-1Di" (String#360, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// RWFIUE_FURNI = "_-U0" (String#23409, DoABC#2)
// allowNameChange = "_-KQ" (String#23022, DoABC#2)
// amIAnyRoomController = "_-09r" (String#14441, DoABC#2)
// amIController = "_-01W" (String#14111, DoABC#2)
// amIOwner = "_-15r" (String#16691, DoABC#2)
// canBeAskedAsFriend = "_-0c9" (String#15521, DoABC#2)
// canBeKicked = "_-34-" (String#21658, DoABC#2)
// canTrade = "_-07S" (String#14342, DoABC#2)
// canTradeReason = "_-01A" (String#14098, DoABC#2)
// hasFlatControl = "_-282" (String#19332, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// _SafeStr_6864 = "_-19C" (String#16825, DoABC#2)
// _SafeStr_6865 = "_-2u2" (String#21240, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// RoomEngine = "_-0Zc" (String#437, DoABC#2)
// RoomSession = "_-3D4" (String#7576, DoABC#2)
// RoomEngine = "_-1qN" (String#867, DoABC#2)
// InfoStandWidgetHandler = "_-33i" (String#7380, DoABC#2)
// onFigureUpdate = "_-2uZ" (String#1961, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// _SafeStr_7294 = "_-Uf" (String#23433, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// _SafeStr_7318 = "_-2Ym" (String#20386, DoABC#2)
// InfostandWidget = "_-T6" (String#2113, DoABC#2)
// InfostandWidget = "_-0fM" (String#1522, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// InfoStandWidgetHandler = "_-17d" (String#16760, DoABC#2)
// InfoStandWidgetHandler = "_-01D" (String#14100, DoABC#2)
// InfoStandWidgetHandler = "_-2wG" (String#21322, DoABC#2)
// askForAFriend = "_-3Iw" (String#7688, DoABC#2)
// givePetRespect = "_-0Gq" (String#3891, DoABC#2)
// SessionDataManager = "_-2nM" (String#7029, DoABC#2)
// SessionDataManager = "_-2jq" (String#6950, DoABC#2)
// RoomSession = "_-3-1" (String#7287, DoABC#2)
// RoomSession = "_-1Hb" (String#5200, DoABC#2)
// RoomSession = "_-32C" (String#7350, DoABC#2)
// RoomSession = "_-MI" (String#8128, DoABC#2)
// HabboInventory = "_-26E" (String#6170, DoABC#2)
// SessionDataManager = "_-25Y" (String#6152, DoABC#2)
// RoomSession = "_-Tm" (String#8281, DoABC#2)
// RoomEngine = "_-09k" (String#3753, DoABC#2)
// RoomEngine = "_-2p8" (String#7061, DoABC#2)
// RoomEngine = "_-1Vg" (String#5468, DoABC#2)
// requestPetInfo = "_-12z" (String#4933, DoABC#2)
// performTagSearch = "_-29O" (String#6238, DoABC#2)
// InfoStandUserView = "_-1Qo" (String#1680, DoABC#2)
// SessionDataManager = "_-3DK" (String#7581, DoABC#2)
// RoomSession = "_-YS" (String#8382, DoABC#2)
// reportUser = "_-233" (String#6107, DoABC#2)
// RoomSession = "_-q5" (String#8711, DoABC#2)
// RoomSession = "_-mX" (String#8653, DoABC#2)
// RoomEngine = "_-4G" (String#7750, DoABC#2)
// _SafeStr_7348 = "_-2Po" (String#20036, DoABC#2)
// catalogPageId = "_-2oc" (String#7050, DoABC#2)
// userDefinedRoomEvents = "_-2pN" (String#7068, DoABC#2)
// stuffSelected = "_-0oj" (String#4608, DoABC#2)
// isStickie = "_-15M" (String#16668, DoABC#2)
// _SafeStr_7353 = "_-0su" (String#16158, DoABC#2)
// _SafeStr_7354 = "_-2xF" (String#21360, DoABC#2)
// isWallItem = "_-92" (String#22582, DoABC#2)
// RWSUE_PLAYING_CHANGED = "_-3LG" (String#22337, DoABC#2)
// RWSUE_DATA_RECEIVED = "_-0BQ" (String#14503, DoABC#2)
// carryItem = "_-0WF" (String#15289, DoABC#2)
// canBeAskedForAFriend = "_-di" (String#8480, DoABC#2)
// getFriend = "_-WG" (String#8329, DoABC#2)
// _SafeStr_7361 = "_-0xm" (String#16345, DoABC#2)
// isPrivateRoom = "_-1Wr" (String#5489, DoABC#2)
// systemShutDown = "_-0D0" (String#3809, DoABC#2)
// SessionDataManager = "_-cs" (String#8469, DoABC#2)
// InfoStandWidgetHandler = "_-Sc" (String#23351, DoABC#2)
// BOT = "_-1T3" (String#17627, DoABC#2)
// getUserBadges = "_-2Ny" (String#6521, DoABC#2)
// SessionDataManager = "_-3Cg" (String#2022, DoABC#2)
// groupBadgeId = "_-s" (String#24362, DoABC#2)
// SessionDataManager = "_-KC" (String#2087, DoABC#2)
// petRespect = "_-2a9" (String#6762, DoABC#2)
// canOwnerBeKicked = "_-2Yz" (String#20395, DoABC#2)
// InfostandWidget = "_-X4" (String#23525, DoABC#2)
// InfoStandWidgetHandler = "_-0iF" (String#15761, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


