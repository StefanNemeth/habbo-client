
package com.sulake.habbo.navigator
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.OfficialRoomsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEventEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.PublicSpaceCastLibsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomForwardMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.NavigatorSettingsEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.UserFlatCatsEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsDataEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSavedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsSaveErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomInfoUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomThumbnailUpdateResultEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouritesEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FavouriteChangedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerAddedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerRemovedEvent;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.NoSuchFlatEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.RoomRatingEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.CanCreateRoomEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.DoorbellMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CantConnectMessageEvent;
    import com.sulake.habbo.navigator.domain.NavigatorData;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetUserFlatCatsMessageComposer;
    import com.sulake.habbo.session.SecurityLevelEnum;
    import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsMessageParser;
    import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomSearchResultData;
    import com.sulake.habbo.communication.messages.incoming.navigator.PopularRoomTagsData;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetGuestRoomMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.roomsettings.RoomSettingsData;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.communication.messages.parser.navigator.PublicSpaceCastLibsMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.navigator.domain.Tabs;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomForwardMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.NavigatorSettingsMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.parser.navigator.UserFlatCatsMessageParser;
    import com.sulake.habbo.navigator.mainview.tabpagedecorators.RoomsTabPageDecorator;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsDataMessageParser;
    import com.sulake.habbo.navigator.roomsettings.RoomSettingsCtrl;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSavedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.RoomSettingsSaveErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomInfoUpdatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomThumbnailUpdateResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouritesMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FavouriteChangedMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomMessageParser;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.roomsettings.FlatControllerRemovedMessageParser;
    import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingMessageParser;
    import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.navigator.GetPublicSpaceCastLibsMessageComposer;
    import com.sulake.core.window.IWindowContext;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.parser.room.session.CantConnectMessageParser;

    public class IncomingMessages 
    {

        private var _navigator:HabboNavigator;

        public function IncomingMessages(_arg_1:HabboNavigator)
        {
            this._navigator = _arg_1;
            var _local_2:IHabboCommunicationManager = this._navigator.communication;
            _local_2.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthOK));
            _local_2.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            _local_2.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
            _local_2.addHabboConnectionMessageEvent(new OfficialRoomsEvent(this.onOfficialRooms));
            _local_2.addHabboConnectionMessageEvent(new GuestRoomSearchResultEvent(this.onGuestRoomSearchResult));
            _local_2.addHabboConnectionMessageEvent(new PopularRoomTagsResultEvent(this.onPopularRoomTagsResult));
            _local_2.addHabboConnectionMessageEvent(new RoomEventEvent(this.onRoomEventEvent));
            _local_2.addHabboConnectionMessageEvent(new CanCreateRoomEventEvent(this.onCanCreateRoomEventEvent));
            _local_2.addHabboConnectionMessageEvent(new RoomEntryInfoMessageEvent(this.onRoomEnter));
            _local_2.addHabboConnectionMessageEvent(new CloseConnectionMessageEvent(this.onRoomExit));
            _local_2.addHabboConnectionMessageEvent(new GetGuestRoomResultEvent(this.onRoomInfo));
            _local_2.addHabboConnectionMessageEvent(new PublicSpaceCastLibsEvent(this.onPublicSpaceCastLibs));
            _local_2.addHabboConnectionMessageEvent(new FlatCreatedEvent(this.onFlatCreated));
            _local_2.addHabboConnectionMessageEvent(new ScrSendUserInfoEvent(this.onSubscriptionInfo));
            _local_2.addHabboConnectionMessageEvent(new RoomForwardMessageEvent(this.onRoomForward));
            _local_2.addHabboConnectionMessageEvent(new NavigatorSettingsEvent(this.onNavigatorSettings));
            _local_2.addHabboConnectionMessageEvent(new UserFlatCatsEvent(this.onUserFlatCats));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsDataEvent(this.onRoomSettingsData));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsErrorEvent(this.onRoomSettingsError));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsSavedEvent(this.onRoomSettingsSaved));
            _local_2.addHabboConnectionMessageEvent(new RoomSettingsSaveErrorEvent(this.onRoomSettingsSaveError));
            _local_2.addHabboConnectionMessageEvent(new RoomInfoUpdatedEvent(this.onRoomInfoUpdated));
            _local_2.addHabboConnectionMessageEvent(new RoomThumbnailUpdateResultEvent(this.onThumbnailUpdated));
            _local_2.addHabboConnectionMessageEvent(new FavouritesEvent(this.onFavourites));
            _local_2.addHabboConnectionMessageEvent(new FavouriteChangedEvent(this.onFavouriteChanged));
            _local_2.addHabboConnectionMessageEvent(new FlatControllerAddedEvent(this.onFlatControllerAdded));
            _local_2.addHabboConnectionMessageEvent(new FlatControllerRemovedEvent(this.onFlatControllerRemoved));
            _local_2.addHabboConnectionMessageEvent(new NoSuchFlatEvent(this.onNoSuchFlat));
            _local_2.addHabboConnectionMessageEvent(new RoomRatingEvent(this.onRoomRating));
            _local_2.addHabboConnectionMessageEvent(new CanCreateRoomEvent(this.onCanCreateRoom));
            _local_2.addHabboConnectionMessageEvent(new GenericErrorEvent(this.onError));
            _local_2.addHabboConnectionMessageEvent(new DoorbellMessageEvent(this.onDoorbell));
            _local_2.addHabboConnectionMessageEvent(new FlatAccessibleMessageEvent(this.onDoorOpened));
            _local_2.addHabboConnectionMessageEvent(new FlatAccessDeniedMessageEvent(this.onFlatAccessDenied));
            _local_2.addHabboConnectionMessageEvent(new CantConnectMessageEvent(this.onCantConnect));
        }
        public function get data():NavigatorData
        {
            return (this._navigator.data);
        }
        private function onNoSuchFlat(_arg_1:IMessageEvent):void
        {
        }
        private function onAuthOK(_arg_1:IMessageEvent):void
        {
            this._navigator.onAuthOk();
        }
        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = UserObjectEvent(_arg_1).getParser();
            this.data.avatarId = _local_2.id;
            this._navigator.send(new GetUserFlatCatsMessageComposer());
        }
        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRightsMessageEvent = UserRightsMessageEvent(_arg_1);
            if (_local_2.securityLevel >= SecurityLevelEnum._SafeStr_11990){
                this._navigator.data.eventMod = true;
            };
            if (_local_2.securityLevel >= SecurityLevelEnum._SafeStr_11991){
                this._navigator.data.roomPicker = true;
            };
        }
        private function onOfficialRooms(_arg_1:IMessageEvent):void
        {
            var _local_2:OfficialRoomsMessageParser = OfficialRoomsEvent(_arg_1).getParser();
            this.data.officialRooms = _local_2.data;
            this.data.adRoom = _local_2.adRoom;
            Logger.log(("Received Official rooms: " + this.data.officialRooms.entries.length));
        }
        private function onGuestRoomSearchResult(_arg_1:IMessageEvent):void
        {
            var _local_2:GuestRoomSearchResultData = GuestRoomSearchResultEvent(_arg_1).getParser().data;
            this.data.guestRoomSearchResults = _local_2;
            Logger.log(("Received GuestRoomSearch: " + this.data.guestRoomSearchResults.rooms.length));
        }
        private function onPopularRoomTagsResult(_arg_1:IMessageEvent):void
        {
            var _local_2:PopularRoomTagsData = PopularRoomTagsResultEvent(_arg_1).getParser().data;
            this.data.popularTags = _local_2;
            Logger.log(("Received popular room tags: " + this.data.popularTags.tags.length));
        }
        private function onRoomEventEvent(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomEventMessageParser = RoomEventEvent(_arg_1).getParser();
            Logger.log(((("Got room event: " + _local_2.data.ownerAvatarId) + ", ") + _local_2.data.eventName));
            this.data.roomEventData = (((_local_2.data.ownerAvatarId > 0)) ? _local_2.data : null);
            this._navigator.roomInfoViewCtrl.reload();
        }
        private function onCanCreateRoomEventEvent(_arg_1:IMessageEvent):void
        {
            var _local_3:SimpleAlertView;
            var _local_2:CanCreateRoomEventMessageParser = CanCreateRoomEventEvent(_arg_1).getParser();
            Logger.log(("CAN CREATE EVENT: " + _local_2.canCreateEvent));
            if (_local_2.canCreateEvent){
                this._navigator.roomInfoViewCtrl.startEventEdit();
            }
            else {
                _local_3 = new SimpleAlertView(this._navigator, "${navigator.cannotcreateevent.title}", (("${navigator.cannotcreateevent.error." + _local_2.errorCode) + "}"));
                _local_3.show();
                Logger.log("Cannot create an event just now...");
            };
        }
        private function onRoomEnter(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(_arg_1).getParser();
            Logger.log("Navigator: entering room");
            this.data.onRoomEnter(_local_2);
            this.closeOpenCantConnectAlerts();
            this._navigator.roomInfoViewCtrl.close();
            if (_local_2.privateRoom){
                this._navigator.send(new GetGuestRoomMessageComposer(_local_2.guestRoomId, true, false));
                Logger.log("Sent get guest room...");
            }
            else {
                this.requestRoomEnterAd();
            };
        }
        private function onRoomInfo(_arg_1:IMessageEvent):void
        {
            var _local_3:Boolean;
            var _local_2:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(_arg_1).getParser();
            Logger.log(((("Got room info: " + _local_2.enterRoom) + ", ") + _local_2.roomForward));
            if (_local_2.enterRoom){
                this.data.enteredRoom = _local_2.data;
                this.data.currentRoomIsStaffPick = _local_2.staffPick;
                _local_3 = (this.data.createdFlatId == _local_2.data.flatId);
                if (((!(_local_3)) && (_local_2.data.displayRoomEntryAd))){
                    this.requestRoomEnterAd();
                };
                this.data.createdFlatId = 0;
            }
            else {
                if (_local_2.roomForward){
                    if ((((_local_2.data.doorMode == RoomSettingsData._SafeStr_4188)) && (!((this._navigator.sessionData.userName == _local_2.data.ownerName))))){
                        this._navigator.doorbell.show(_local_2.data);
                    }
                    else {
                        if ((((_local_2.data.doorMode == RoomSettingsData._SafeStr_4148)) && (!((this._navigator.sessionData.userName == _local_2.data.ownerName))))){
                            this._navigator.passwordInput.show(_local_2.data);
                        }
                        else {
                            this._navigator.goToRoom(_local_2.data.flatId, false);
                        };
                    };
                }
                else {
                    this.data.enteredRoom = _local_2.data;
                    this.data.currentRoomIsStaffPick = _local_2.staffPick;
                    this._navigator.roomInfoViewCtrl.reload();
                };
            };
        }
        private function requestRoomEnterAd():void
        {
            if ((((this._navigator.configuration.getKey("roomenterad.habblet.enabled") == "true")) && (ExternalInterface.available))){
                ExternalInterface.call("FlashExternalInterface.openHabblet", "roomenterad", "");
            };
        }
        private function onPublicSpaceCastLibs(_arg_1:IMessageEvent):void
        {
            var _local_2:PublicSpaceCastLibsMessageParser = PublicSpaceCastLibsEvent(_arg_1).getParser();
            Logger.log(((((("Got public space cast libs: " + _local_2.nodeId) + ", ") + _local_2.unitPort) + ", ") + _local_2.castLibs));
            this._navigator.data.publicSpaceNodeId = _local_2.nodeId;
            this._navigator.goToPublicSpace(_local_2.unitPort, _local_2.castLibs);
        }
        private function onFlatCreated(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatCreatedMessageParser = FlatCreatedEvent(_arg_1).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ((("Flat created: " + _local_2.flatId) + ", ") + _local_2.flatName));
            this.data.createdFlatId = _local_2.flatId;
            this._navigator.goToRoom(_local_2.flatId, true);
            this._navigator.mainViewCtrl.reloadRoomList(Tabs._SafeStr_4301);
        }
        private function onSubscriptionInfo(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(_arg_1).getParser();
            Logger.log(((((((((("Got subscription info: " + _local_2.productName) + ", ") + _local_2.daysToPeriodEnd) + ", ") + _local_2.memberPeriods) + ", ") + _local_2.periodsSubscribedAhead) + ", ") + _local_2.responseType));
            this.data.hcMember = (_local_2.daysToPeriodEnd > 0);
        }
        private function onRoomForward(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomForwardMessageParser = RoomForwardMessageEvent(_arg_1).getParser();
            Logger.log(((("Got room forward: " + _local_2.publicRoom) + ", ") + _local_2.roomId));
            this.forwardToRoom(_local_2.publicRoom, _local_2.roomId);
        }
        private function onNavigatorSettings(_arg_1:IMessageEvent):void
        {
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_2:NavigatorSettingsMessageParser = NavigatorSettingsEvent(_arg_1).getParser();
            Logger.log(("Got navigator settings: " + _local_2.homeRoomId));
            var _local_3 = !(this._navigator.data.settingsReceived);
            this._navigator.data.homeRoomId = _local_2.homeRoomId;
            this._navigator.data.settingsReceived = true;
            this._navigator.mainViewCtrl.refresh();
            var _local_4:int = -1;
            var _local_5:int = -1;
            if (_local_3){
                _local_6 = false;
                if (this._navigator.configuration != null){
                    if (this._navigator.configuration.keyExists("friend.id")){
                        _local_4 = 0;
                        this._navigator.send(new FollowFriendMessageComposer(int(this._navigator.configuration.getKey("friend.id"))));
                    };
                    if (((this._navigator.configuration.keyExists("forward.type")) && (this._navigator.configuration.keyExists("forward.id")))){
                        _local_4 = int(this._navigator.configuration.getKey("forward.type"));
                        _local_5 = int(this._navigator.configuration.getKey("forward.id"));
                    };
                    if (parseInt(this._navigator.configuration.getKey("navigator.always_open_after_login")) == 1){
                        _local_6 = true;
                    };
                };
                if (_local_4 == 2){
                    Logger.log(("Guest room forward on enter: " + _local_5));
                    this.forwardToRoom(false, _local_5);
                }
                else {
                    if (_local_4 == 1){
                        Logger.log(("Public room forward on enter: " + _local_5));
                        this.forwardToRoom(true, _local_5);
                    }
                    else {
                        if (_local_4 == -1){
                            _local_7 = this._navigator.goToHomeRoom();
                            if (!_local_7){
                                _local_6 = true;
                            };
                        };
                    };
                };
                if (((_local_6) && (!(this._navigator.mainViewCtrl.isOpen())))){
                    this._navigator.mainViewCtrl.onNavigatorToolBarIconClick();
                };
            }
            else {
                this._navigator.roomInfoViewCtrl.reload();
            };
        }
        private function onRoomExit(_arg_1:IMessageEvent):void
        {
            Logger.log("Navigator: exiting room");
            this.data.onRoomExit();
            this._navigator.roomInfoViewCtrl.close();
            if (!this._navigator.mainViewCtrl.isOpen()){
                this._navigator.mainViewCtrl.onNavigatorToolBarIconClick();
            };
            if (ExternalInterface.available){
                ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
            };
        }
        private function onUserFlatCats(_arg_1:IMessageEvent):void
        {
            var _local_2:UserFlatCatsMessageParser = (_arg_1 as UserFlatCatsEvent).getParser();
            this._navigator.data.categories = _local_2.nodes;
            var _local_3:RoomsTabPageDecorator = RoomsTabPageDecorator(this._navigator.tabs.getTab(Tabs._SafeStr_4288).tabPageDecorator);
            _local_3.prepareRoomCategories();
        }
        private function onRoomSettingsData(event:IMessageEvent):void
        {
            var parser:RoomSettingsDataMessageParser;
            var ctrl:RoomSettingsCtrl;
            try {
                parser = (event as RoomSettingsDataEvent).getParser();
                for each (ctrl in this._navigator.roomSettingsCtrls) {
                    ctrl.onRoomSettings(parser.data);
                };
                Logger.log(((((("GOT ROOM SETTINGS DATA: " + parser.data.name) + ", ") + parser.data.maximumVisitors) + ", ") + parser.data.maximumVisitorsLimit));
            }
            catch(e:Error) {
                Logger.log("CRASHED WHILE PROCESSING ROOM SETTINGS DATA!");
            };
        }
        private function onRoomSettingsError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomSettingsErrorMessageParser = (_arg_1 as RoomSettingsErrorEvent).getParser();
        }
        private function onRoomSettingsSaved(_arg_1:IMessageEvent):void
        {
            var _local_3:RoomSettingsCtrl;
            var _local_2:RoomSettingsSavedMessageParser = (_arg_1 as RoomSettingsSavedEvent).getParser();
            ErrorReportStorage.addDebugData("IncomingEvent", ("Room settings saved: " + _local_2.roomId));
            for each (_local_3 in this._navigator.roomSettingsCtrls) {
                _local_3.onRoomSettingsSaved(_local_2.roomId);
            };
            this._navigator.mainViewCtrl.reloadRoomList(Tabs._SafeStr_4301);
        }
        private function onRoomSettingsSaveError(_arg_1:IMessageEvent):void
        {
            var _local_3:RoomSettingsCtrl;
            var _local_2:RoomSettingsSaveErrorMessageParser = (_arg_1 as RoomSettingsSaveErrorEvent).getParser();
            for each (_local_3 in this._navigator.roomSettingsCtrls) {
                _local_3.onRoomSettingsSaveError(_local_2.roomId, _local_2.errorCode, _local_2.info);
            };
        }
        private function onRoomInfoUpdated(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInfoUpdatedMessageParser = (_arg_1 as RoomInfoUpdatedEvent).getParser();
            Logger.log(("ROOM UPDATED: " + _local_2.flatId));
            this._navigator.send(new GetGuestRoomMessageComposer(_local_2.flatId, false, false));
        }
        private function onThumbnailUpdated(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomThumbnailUpdateResultMessageParser = (_arg_1 as RoomThumbnailUpdateResultEvent).getParser();
            Logger.log(("THUMBNAIL UPDATED: " + _local_2.resultCode));
            this._navigator.roomInfoViewCtrl.backToRoomSettings();
            this._navigator.send(new GetGuestRoomMessageComposer(_local_2.flatId, false, false));
        }
        private function onFavourites(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouritesMessageParser = (_arg_1 as FavouritesEvent).getParser();
            Logger.log(((("Received favourites: " + _local_2.limit) + ", ") + _local_2.favouriteRoomIds.length));
            this._navigator.data.onFavourites(_local_2);
        }
        private function onFavouriteChanged(_arg_1:IMessageEvent):void
        {
            var _local_2:FavouriteChangedMessageParser = (_arg_1 as FavouriteChangedEvent).getParser();
            Logger.log(((("Received favourite changed: " + _local_2.flatId) + ", ") + _local_2.added));
            this._navigator.data.favouriteChanged(_local_2.flatId, _local_2.added);
            this._navigator.roomInfoViewCtrl.reload();
            this._navigator.mainViewCtrl.refresh();
        }
        private function onCanCreateRoom(_arg_1:IMessageEvent):void
        {
            var _local_3:AlertView;
            var _local_2:CanCreateRoomMessageParser = (_arg_1 as CanCreateRoomEvent).getParser();
            Logger.log(((("Can create room: " + _local_2.resultCode) + ", ") + _local_2.roomLimit));
            if (_local_2.resultCode == 0){
                this._navigator.roomCreateViewCtrl.show();
            }
            else {
                this._navigator.registerParameter("navigator.createroom.limitreached", "limit", ("" + _local_2.roomLimit));
                if (this._navigator.sessionData.hasUserRight("fuse_can_create_more_rooms", HabboClubLevelEnum._SafeStr_3939)){
                    _local_3 = new SimpleAlertView(this._navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}");
                }
                else {
                    _local_3 = new ClubPromoAlertView(this._navigator, "${navigator.createroom.error}", "${navigator.createroom.limitreached}", "${navigator.createroom.vippromo}");
                };
                _local_3.show();
            };
        }
        private function onFlatControllerAdded(_arg_1:IMessageEvent):void
        {
            var _local_3:RoomSettingsCtrl;
            var _local_2:FlatControllerAddedMessageParser = (_arg_1 as FlatControllerAddedEvent).getParser();
            Logger.log(((((("Flat controller added: " + _local_2.flatId) + ", ") + _local_2.data.userId) + ", ") + _local_2.data.userName));
            for each (_local_3 in this._navigator.roomSettingsCtrls) {
                _local_3.onFlatControllerAdded(_local_2.flatId, _local_2.data);
            };
        }
        private function onFlatControllerRemoved(_arg_1:IMessageEvent):void
        {
            var _local_3:RoomSettingsCtrl;
            var _local_2:FlatControllerRemovedMessageParser = (_arg_1 as FlatControllerRemovedEvent).getParser();
            Logger.log(((("Flat controller removed: " + _local_2.flatId) + ", ") + _local_2.userId));
            for each (_local_3 in this._navigator.roomSettingsCtrls) {
                _local_3.onFlatControllerRemoved(_local_2.flatId, _local_2.userId);
            };
        }
        private function onError(_arg_1:IMessageEvent):void
        {
            var _local_2:GenericErrorEvent = (_arg_1 as GenericErrorEvent);
            if (_local_2 == null){
                return;
            };
            switch (_local_2.getParser().errorCode){
                case -100002:
                    this._navigator.passwordInput.showRetry();
                    return;
            };
        }
        private function onDoorbell(_arg_1:IMessageEvent):void
        {
            var _local_2:DoorbellMessageEvent = (_arg_1 as DoorbellMessageEvent);
            if (_local_2 == null){
                return;
            };
            if (_local_2.userName != ""){
                return;
            };
            this._navigator.doorbell.showWaiting();
        }
        private function onDoorOpened(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatAccessibleMessageEvent = (_arg_1 as FlatAccessibleMessageEvent);
            if (_local_2 == null){
                return;
            };
            var _local_3:FlatAccessibleMessageParser = _local_2.getParser();
            if (((!((_local_3 == null))) && ((((_local_3.userName == null)) || ((_local_3.userName.length == 0)))))){
                this._navigator.doorbell.hide();
            };
        }
        private function onRoomRating(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomRatingMessageParser = (_arg_1 as RoomRatingEvent).getParser();
            Logger.log(("Received room rating: " + _local_2.rating));
            this._navigator.data.currentRoomRating = _local_2.rating;
            this._navigator.roomInfoViewCtrl.reload();
        }
        private function onFlatAccessDenied(_arg_1:IMessageEvent):void
        {
            var _local_2:FlatAccessDeniedMessageParser = (_arg_1 as FlatAccessDeniedMessageEvent).getParser();
            if ((((_local_2.userName == null)) || ((_local_2.userName == "")))){
                this._navigator.doorbell.showNoAnswer();
            };
        }
        private function forwardToRoom(_arg_1:Boolean, _arg_2:int):void
        {
            this._navigator.send(((_arg_1) ? new GetPublicSpaceCastLibsMessageComposer(_arg_2) : new GetGuestRoomMessageComposer(_arg_2, false, true)));
            this._navigator.trackNavigationDataPoint("Room Forward", "go.roomforward", "", _arg_2);
        }
        private function closeOpenCantConnectAlerts():void
        {
            var _local_1:Array;
            var _local_2:IWindowContext;
            var _local_3:int;
            var _local_4:int;
            var _local_5:IWindow;
            var _local_6:IWindow;
            var _local_7:AlertView;
            if (this._navigator != null){
                _local_1 = new Array();
                _local_2 = this._navigator.windowManager.getWindowContext(2);
                _local_3 = _local_2.getDesktopWindow().numChildren;
                _local_4 = 0;
                while (_local_4 < _local_3) {
                    _local_5 = _local_2.getDesktopWindow().getChildAt(_local_4);
                    if (_local_5.tags.indexOf("SimpleAlertView") > -1){
                        _local_1.push(_local_5);
                    };
                    _local_4++;
                };
                if (_local_1.length > 0){
                    for each (_local_6 in _local_1) {
                        _local_7 = AlertView.findAlertView(_local_6);
                        if (_local_7 != null){
                            _local_7.dispose();
                        };
                    };
                };
            };
        }
        private function onCantConnect(_arg_1:IMessageEvent):void
        {
            var _local_3:SimpleAlertView;
            var _local_2:CantConnectMessageParser = (_arg_1 as CantConnectMessageEvent).getParser();
            Logger.log(("FAILED TO CONNECT: REASON: " + _local_2.reason));
            switch (_local_2.reason){
                case CantConnectMessageParser._SafeStr_8510:
                    _local_3 = new SimpleAlertView(this._navigator, "${navigator.guestroomfull.title}", "${navigator.guestroomfull.text}");
                    _local_3.show();
                    return;
                case CantConnectMessageParser._SafeStr_8512:
                    _local_3 = new SimpleAlertView(this._navigator, "${room.queue.error.title}", (("${room.queue.error." + _local_2.parameter) + "}"));
                    _local_3.show();
                    return;
                case CantConnectMessageParser._SafeStr_8513:
                    _local_3 = new SimpleAlertView(this._navigator, "${navigator.banned.title}", "${navigator.banned.text}");
                    _local_3.show();
                    return;
                default:
                    _local_3 = new SimpleAlertView(this._navigator, "${room.queue.error.title}", "${room.queue.error.title}");
                    _local_3.show();
            };
        }

    }
}//package com.sulake.habbo.navigator

// onUserRights = "_-36C" (String#632, DoABC#2)
// onSubscriptionInfo = "_-3-R" (String#1981, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// onAuthOK = "_-lL" (String#2177, DoABC#2)
// onUserObject = "_-2A9" (String#617, DoABC#2)
// onRoomInfo = "_-az" (String#2136, DoABC#2)
// onPublicSpaceCastLibs = "_-0X3" (String#4251, DoABC#2)
// onOfficialRooms = "_-0Sp" (String#15162, DoABC#2)
// onGuestRoomSearchResult = "_-1F2" (String#17073, DoABC#2)
// onPopularRoomTagsResult = "_-2tQ" (String#21217, DoABC#2)
// onRoomEventEvent = "_-bv" (String#23710, DoABC#2)
// onCanCreateRoomEventEvent = "_-0wQ" (String#16288, DoABC#2)
// onFlatCreated = "_-2s9" (String#21164, DoABC#2)
// onRoomForward = "_-2TZ" (String#20184, DoABC#2)
// onNavigatorSettings = "_-0uy" (String#16237, DoABC#2)
// onUserFlatCats = "_-2nK" (String#20972, DoABC#2)
// onRoomSettingsData = "_-11e" (String#16522, DoABC#2)
// onRoomSettingsError = "_-0qN" (String#16065, DoABC#2)
// onRoomInfoUpdated = "_-1mi" (String#18409, DoABC#2)
// onThumbnailUpdated = "_-2AS" (String#19425, DoABC#2)
// onFavouriteChanged = "_-11T" (String#16516, DoABC#2)
// onNoSuchFlat = "_-te" (String#24433, DoABC#2)
// onRoomRating = "_-bi" (String#23701, DoABC#2)
// onCanCreateRoom = "_-1zk" (String#18957, DoABC#2)
// onDoorOpened = "_-1QL" (String#17526, DoABC#2)
// onCantConnect = "_-2UL" (String#20213, DoABC#2)
// onAuthOk = "_-0iC" (String#15758, DoABC#2)
// _SafeStr_11990 = "_-1wS" (String#18819, DoABC#2)
// _SafeStr_11991 = "_-2W9" (String#20288, DoABC#2)
// closeOpenCantConnectAlerts = "_-2tZ" (String#21223, DoABC#2)
// requestRoomEnterAd = "_-LX" (String#23064, DoABC#2)
// goToPublicSpace = "_-080" (String#14367, DoABC#2)
// forwardToRoom = "_-0u6" (String#16207, DoABC#2)
// roomCreateViewCtrl = "_-0RP" (String#15117, DoABC#2)
// showRetry = "_-0pv" (String#16049, DoABC#2)
// showWaiting = "_-0jH" (String#15802, DoABC#2)
// showNoAnswer = "_-45" (String#22381, DoABC#2)
// findAlertView = "_-3F7" (String#22083, DoABC#2)
// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// NavigatorData = "_-1Uq" (String#5451, DoABC#2)
// Tabs = "_-1b9" (String#5579, DoABC#2)
// IWindowContext = "_-8b" (String#2061, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// SecurityLevelEnum = "_-2xM" (String#21364, DoABC#2)
// GenericErrorEvent = "_-2X" (String#6699, DoABC#2)
// AlertView = "_-2G6" (String#883, DoABC#2)
// DoorbellMessageEvent = "_-03C" (String#14170, DoABC#2)
// FlatAccessDeniedMessageParser = "_-1oe" (String#5835, DoABC#2)
// FlatAccessibleMessageEvent = "_-e-" (String#23802, DoABC#2)
// FlatAccessDeniedMessageEvent = "_-3Cj" (String#7570, DoABC#2)
// FlatAccessibleMessageParser = "_-1d1" (String#5616, DoABC#2)
// GetGuestRoomResultMessageParser = "_-0lh" (String#4540, DoABC#2)
// GetGuestRoomResultEvent = "_-2XI" (String#20334, DoABC#2)
// GuestRoomSearchResultData = "_-SV" (String#8256, DoABC#2)
// FavouritesMessageParser = "_-Om" (String#8181, DoABC#2)
// PopularRoomTagsData = "_-1Bn" (String#5105, DoABC#2)
// CanCreateRoomMessageParser = "_-303" (String#7305, DoABC#2)
// RoomEventMessageParser = "_-1on" (String#5836, DoABC#2)
// RoomSettingsSavedMessageParser = "_-2XT" (String#6711, DoABC#2)
// OfficialRoomsMessageParser = "_-28N" (String#6209, DoABC#2)
// GetUserFlatCatsMessageComposer = "_-Y0" (String#23561, DoABC#2)
// RoomSettingsData = "_-we" (String#8817, DoABC#2)
// FavouriteChangedEvent = "_-44" (String#22380, DoABC#2)
// RoomForwardMessageParser = "_-0s2" (String#4687, DoABC#2)
// NavigatorSettingsEvent = "_-3KS" (String#22302, DoABC#2)
// RoomInfoUpdatedEvent = "_-047" (String#14207, DoABC#2)
// RoomInfoUpdatedMessageParser = "_-2KL" (String#6452, DoABC#2)
// GetGuestRoomMessageComposer = "_-0va" (String#16260, DoABC#2)
// PublicSpaceCastLibsEvent = "_-ms" (String#24146, DoABC#2)
// FavouriteChangedMessageParser = "_-QN" (String#8210, DoABC#2)
// CantConnectMessageParser = "_-07a" (String#3712, DoABC#2)
// RoomSettingsDataEvent = "_-6N" (String#22479, DoABC#2)
// RoomSettingsErrorEvent = "_-1sV" (String#18654, DoABC#2)
// RoomSettingsCtrl = "_-0kX" (String#4511, DoABC#2)
// RoomThumbnailUpdateResultMessageParser = "_-2v2" (String#7180, DoABC#2)
// FlatCreatedEvent = "_-2fj" (String#20682, DoABC#2)
// FlatCreatedMessageParser = "_-2nr" (String#7037, DoABC#2)
// RoomSettingsErrorMessageParser = "_-zc" (String#8872, DoABC#2)
// GetPublicSpaceCastLibsMessageComposer = "_-38Z" (String#21824, DoABC#2)
// NoSuchFlatEvent = "_-0fA" (String#15636, DoABC#2)
// CanCreateRoomEventMessageParser = "_-cN" (String#8463, DoABC#2)
// FlatControllerAddedEvent = "_-24H" (String#19188, DoABC#2)
// UserFlatCatsEvent = "_-eB" (String#23810, DoABC#2)
// RoomSettingsSavedEvent = "_-QI" (String#23262, DoABC#2)
// ClubPromoAlertView = "_-c3" (String#8457, DoABC#2)
// FlatControllerAddedMessageParser = "_-0zG" (String#4832, DoABC#2)
// PublicSpaceCastLibsMessageParser = "_-3Dk" (String#7592, DoABC#2)
// PopularRoomTagsResultEvent = "_-37E" (String#21777, DoABC#2)
// RoomRatingMessageParser = "_-3KE" (String#7710, DoABC#2)
// RoomThumbnailUpdateResultEvent = "_-VE" (String#23458, DoABC#2)
// FavouritesEvent = "_-39L" (String#21859, DoABC#2)
// NavigatorSettingsMessageParser = "_-nt" (String#8676, DoABC#2)
// CantConnectMessageEvent = "_-0qQ" (String#16067, DoABC#2)
// RoomSettingsSaveErrorMessageParser = "_-33e" (String#7377, DoABC#2)
// RoomSettingsSaveErrorEvent = "_-iy" (String#23997, DoABC#2)
// FlatControllerRemovedMessageParser = "_-00q" (String#3580, DoABC#2)
// FollowFriendMessageComposer = "_-MN" (String#23099, DoABC#2)
// CanCreateRoomEventEvent = "_-2E4" (String#19572, DoABC#2)
// GuestRoomSearchResultEvent = "_-7-" (String#22500, DoABC#2)
// OfficialRoomsEvent = "_-o0" (String#24191, DoABC#2)
// RoomEventEvent = "_-1Bg" (String#16928, DoABC#2)
// RoomsTabPageDecorator = "_-vM" (String#8791, DoABC#2)
// FlatControllerRemovedEvent = "_-0ki" (String#15855, DoABC#2)
// UserFlatCatsMessageParser = "_-FJ" (String#7976, DoABC#2)
// RoomSettingsDataMessageParser = "_-0dz" (String#4391, DoABC#2)
// CanCreateRoomEvent = "_-1fL" (String#18111, DoABC#2)
// RoomForwardMessageEvent = "_-33g" (String#21648, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// reason = "_-053" (String#14245, DoABC#2)
// privateRoom = "_-26S" (String#19271, DoABC#2)
// guestRoomId = "_-1NR" (String#17415, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// adRoom = "_-m" (String#24110, DoABC#2)
// castLibs = "_-0m9" (String#15901, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// doorMode = "_-2zu" (String#21456, DoABC#2)
// _SafeStr_4148 = "_-1IG" (String#17204, DoABC#2)
// passwordInput = "_-2kR" (String#20861, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// nodeId = "_-3K6" (String#22286, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// officialRooms = "_-f3" (String#23847, DoABC#2)
// entries = "_-1eU" (String#18076, DoABC#2)
// guestRoomSearchResults = "_-fX" (String#23866, DoABC#2)
// _SafeStr_4188 = "_-1xJ" (String#18860, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// homeRoomId = "_-0jF" (String#15801, DoABC#2)
// popularTags = "_-dQ" (String#23778, DoABC#2)
// onNavigatorToolBarIconClick = "_-2Ic" (String#19751, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// tabPageDecorator = "_-09G" (String#14418, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// getTab = "_-0mC" (String#15903, DoABC#2)
// _SafeStr_4288 = "_-1Ja" (String#17261, DoABC#2)
// reloadRoomList = "_-1n6" (String#18428, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// _SafeStr_4301 = "_-1o0" (String#18463, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// onError = "_-1cU" (String#1723, DoABC#2)
// maximumVisitors = "_-1Ex" (String#17069, DoABC#2)
// maximumVisitorsLimit = "_-S3" (String#23327, DoABC#2)
// nodes = "_-7H" (String#22513, DoABC#2)
// daysToPeriodEnd = "_-3L6" (String#22328, DoABC#2)
// memberPeriods = "_-1m3" (String#18381, DoABC#2)
// periodsSubscribedAhead = "_-08y" (String#14405, DoABC#2)
// responseType = "_-0wX" (String#16291, DoABC#2)
// backToRoomSettings = "_-fe" (String#23873, DoABC#2)
// roomInfoViewCtrl = "_-HS" (String#22911, DoABC#2)
// reload = "_-3AK" (String#7519, DoABC#2)
// onDoorbell = "_-nT" (String#8667, DoABC#2)
// onFlatAccessDenied = "_-1qT" (String#5863, DoABC#2)
// displayRoomEntryAd = "_-2mS" (String#20938, DoABC#2)
// ownerAvatarId = "_-34" (String#21657, DoABC#2)
// eventName = "_-1tL" (String#18690, DoABC#2)
// unitPort = "_-2js" (String#20840, DoABC#2)
// prepareRoomCategories = "_-1PU" (String#17488, DoABC#2)
// trackNavigationDataPoint = "_-17A" (String#16741, DoABC#2)
// onRoomSettings = "_-1Tg" (String#17652, DoABC#2)
// onFlatControllerAdded = "_-9F" (String#7848, DoABC#2)
// onFlatControllerRemoved = "_-MZ" (String#8134, DoABC#2)
// onRoomSettingsSaved = "_-1-A" (String#4849, DoABC#2)
// onRoomSettingsSaveError = "_-0Fh" (String#3867, DoABC#2)
// goToHomeRoom = "_-LH" (String#8108, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// enterRoom = "_-Lu" (String#23077, DoABC#2)
// staffPick = "_-11I" (String#16509, DoABC#2)
// favouriteRoomIds = "_-0Az" (String#14487, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// roomLimit = "_-0tF" (String#16169, DoABC#2)
// added = "_-38D" (String#21811, DoABC#2)
// flatName = "_-Js" (String#23002, DoABC#2)
// canCreateEvent = "_-nu" (String#24186, DoABC#2)
// RoomEntryInfoMessageParser = "_-2Z9" (String#6747, DoABC#2)
// RoomEntryInfoMessageEvent = "_-nk" (String#24182, DoABC#2)
// roomSettingsCtrls = "_-2xJ" (String#21362, DoABC#2)
// startEventEdit = "_-29X" (String#19386, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// roomEventData = "_-0tV" (String#16179, DoABC#2)
// currentRoomRating = "_-0zd" (String#16413, DoABC#2)
// roomPicker = "_-2QD" (String#20055, DoABC#2)
// currentRoomIsStaffPick = "_-0QZ" (String#15085, DoABC#2)
// eventMod = "_-167" (String#16700, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// publicSpaceNodeId = "_-1m2" (String#18380, DoABC#2)
// publicRoom = "_-1f-" (String#18098, DoABC#2)
// _SafeStr_8510 = "_-0Oa" (String#15010, DoABC#2)
// _SafeStr_8512 = "_-2ja" (String#20829, DoABC#2)
// _SafeStr_8513 = "_-xJ" (String#24581, DoABC#2)
// onRoomEnter = "_-El" (String#460, DoABC#2)
// onRoomExit = "_-0Na" (String#356, DoABC#2)
// enteredRoom = "_-7F" (String#22511, DoABC#2)
// hcMember = "_-Pz" (String#23249, DoABC#2)
// createdFlatId = "_-0bB" (String#15484, DoABC#2)
// settingsReceived = "_-197" (String#16822, DoABC#2)
// onFavourites = "_-2ms" (String#7018, DoABC#2)
// favouriteChanged = "_-GF" (String#22861, DoABC#2)


