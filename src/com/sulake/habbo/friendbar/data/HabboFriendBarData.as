
package com.sulake.habbo.friendbar.data
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.friendlist.IHabboFriendList;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.friendbar.stream.IHabboEventStream;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboFriendList;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.friendlist.events.FriendRequestEvent;
    import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
    import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.friendbar.events.NewMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.utils.WindowToggle;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.BuddyRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
    import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.messenger.IConversation;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.friendbar.events.NotificationEvent;
    import com.sulake.habbo.tracking.HabboTracking;

    public class HabboFriendBarData extends Component implements IHabboFriendBarData 
    {

        private static const _SafeStr_10870:Boolean = false;
        private static const _SafeStr_10871:Boolean = false;
        private static const _SafeStr_10872:String = "Navigation";
        private static const _SafeStr_10873:String = "Friend Bar";
        private static const _SafeStr_10874:String = "go.friendbar";
        private static const _SafeStr_10875:String = "chat_btn_click";
        private static const _SafeStr_10876:String = "find_friends_btn_click";
        private static const _SafeStr_10877:String = "Toolbar";
        private static const _SafeStr_10878:String = "open";
        private static const _SafeStr_10879:String = "close";
        private static const FRIENDLIST:String = "FRIENDLIST";
        private static const MESSENGER:String = "MESSENGER";

        private var _SafeStr_10882:IHabboConfigurationManager;
        private var _SafeStr_10883:IHabboCommunicationManager;
        private var _SafeStr_10884:IHabboFriendList;
        private var _SafeStr_10885:IHabboMessenger;
        private var _SafeStr_10886:IHabboEventStream;
        private var _SafeStr_10887:Array;
        private var _SafeStr_10888:Map;
        private var _friendRequests:Array;
        private var _SafeStr_10890:int;
        private var _SafeStr_10891:Boolean = false;
        private var _SafeStr_10892:Boolean = false;

        public function HabboFriendBarData(_arg_1:HabboFriendBar, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_10887 = new Array();
            this._SafeStr_10888 = new Map();
            this._friendRequests = new Array();
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerAvailable);
            queueInterface(new IIDHabboFriendList(), this.onFriendListComponentAvailable);
            queueInterface(new IIDHabboMessenger(), this.onMessengerComponentAvailable);
            queueInterface(new IIDHabboEventStream(), this.onOfflineStreamAvailable);
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._SafeStr_10882){
                    this._SafeStr_10882.release(new IIDHabboConfigurationManager());
                    this._SafeStr_10882 = null;
                };
                if (this._SafeStr_10883){
                    this._SafeStr_10883.release(new IIDHabboCommunicationManager());
                    this._SafeStr_10883 = null;
                };
                if (this._SafeStr_10884){
                    if (!this._SafeStr_10884.disposed){
                        this._SafeStr_10884.events.removeEventListener(FriendRequestEvent.RWDE_ACCEPTED, this.onFriendRequestEvent);
                        this._SafeStr_10884.events.removeEventListener(FriendRequestEvent.FRE_DECLINED, this.onFriendRequestEvent);
                    };
                    this._SafeStr_10884.release(new IIDHabboFriendList());
                    this._SafeStr_10884 = null;
                };
                if (this._SafeStr_10885){
                    this._SafeStr_10885.release(new IIDHabboMessenger());
                    this._SafeStr_10885 = null;
                };
                if (this._SafeStr_10886){
                    this._SafeStr_10886.release(new IIDHabboEventStream());
                    this._SafeStr_10886 = null;
                };
                this._SafeStr_10887 = null;
                this._SafeStr_10888.dispose();
                this._SafeStr_10888 = null;
                this._friendRequests = null;
                super.dispose();
            };
        }
        public function get numFriends():int
        {
            return (this._SafeStr_10887.length);
        }
        public function getFriendAt(_arg_1:int):IFriendEntity
        {
            return (this._SafeStr_10887[_arg_1]);
        }
        public function getFriendByID(_arg_1:int):IFriendEntity
        {
            return (this._SafeStr_10888.getValue(_arg_1));
        }
        public function getFriendByName(_arg_1:String):IFriendEntity
        {
            var _local_2:FriendEntity;
            for each (_local_2 in this._SafeStr_10887) {
                if (_local_2.name == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function setFriendAt(_arg_1:IFriendEntity, _arg_2:int):void
        {
            var _local_3:int = this._SafeStr_10887.indexOf(_arg_1);
            if ((((_local_3 > -1)) && (!((_local_3 == _arg_2))))){
                this._SafeStr_10887.splice(_local_3, 1);
                this._SafeStr_10887.splice(_arg_2, 0, _arg_1);
                events.dispatchEvent(new FriendBarUpdateEvent());
            };
        }
        public function get numFriendRequests():int
        {
            return (((this._friendRequests) ? this._friendRequests.length : 0));
        }
        public function getFriendRequestAt(_arg_1:int):FriendRequest
        {
            return (((this._friendRequests) ? this._friendRequests[_arg_1] : null));
        }
        public function getFriendRequestByID(_arg_1:int):FriendRequest
        {
            var _local_2:FriendRequest;
            if (this._friendRequests){
                for each (_local_2 in this._friendRequests) {
                    if (_local_2.id == _arg_1){
                        return (_local_2);
                    };
                };
            };
            return (null);
        }
        public function getFriendRequestByName(_arg_1:String):FriendRequest
        {
            var _local_2:FriendRequest;
            if (this._friendRequests){
                for each (_local_2 in this._friendRequests) {
                    if (_local_2.name == _arg_1){
                        return (_local_2);
                    };
                };
            };
            return (null);
        }
        public function getFriendRequestList():Array
        {
            return (this._friendRequests);
        }
        public function acceptFriendRequest(_arg_1:int):void
        {
            this.removeFriendRequest(_arg_1);
            if (this._SafeStr_10884){
                if (!this._SafeStr_10884.disposed){
                    this._SafeStr_10884.acceptFriendRequest(_arg_1);
                };
            };
        }
        public function acceptAllFriendRequests():void
        {
            this._friendRequests = [];
            this._SafeStr_10884.acceptAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }
        public function declineFriendRequest(_arg_1:int):void
        {
            this.removeFriendRequest(_arg_1);
            if (this._SafeStr_10884){
                if (!this._SafeStr_10884.disposed){
                    this._SafeStr_10884.declineFriendRequest(_arg_1);
                };
            };
        }
        public function declineAllFriendRequests():void
        {
            this._friendRequests = [];
            this._SafeStr_10884.declineAllFriendRequests();
            events.dispatchEvent(new FriendRequestUpdateEvent());
        }
        private function removeFriendRequest(_arg_1:int):void
        {
            var _local_2:FriendRequest;
            if (this._friendRequests){
                for each (_local_2 in this._friendRequests) {
                    if (_local_2.id == _arg_1){
                        this._friendRequests.splice(this._friendRequests.indexOf(_local_2), 1);
                        events.dispatchEvent(new FriendRequestUpdateEvent());
                        return;
                    };
                };
            };
        }
        public function followToRoom(_arg_1:int):void
        {
            if (this._SafeStr_10883){
                this._SafeStr_10883.getHabboMainConnection(null).send(new FollowFriendMessageComposer(_arg_1));
                this._SafeStr_10883.getHabboMainConnection(null).send(new EventLogMessageComposer(_SafeStr_10872, _SafeStr_10873, _SafeStr_10874));
            };
        }
        public function startConversation(_arg_1:int):void
        {
            if (this._SafeStr_10885){
                this._SafeStr_10885.startConversation(_arg_1);
                events.dispatchEvent(new NewMessageEvent(false, _arg_1));
                if (this._SafeStr_10883){
                    this._SafeStr_10883.getHabboMainConnection(null).send(new EventLogMessageComposer(_SafeStr_10872, _SafeStr_10873, _SafeStr_10875));
                };
            };
        }
        public function findNewFriends():void
        {
            if (this._SafeStr_10883){
                this._SafeStr_10883.getHabboMainConnection(null).send(new FindNewFriendsMessageComposer());
                this._SafeStr_10883.getHabboMainConnection(null).send(new EventLogMessageComposer(_SafeStr_10872, _SafeStr_10873, _SafeStr_10876));
            };
        }
        public function toggleFriendList():void
        {
            var _local_1:IWindowContainer;
            if (this._SafeStr_10884){
                if (!this._SafeStr_10884.disposed){
                    if (!this._SafeStr_10884.isOpen()){
                        if (this._friendRequests.length > 0){
                            this._SafeStr_10884.openFriendRequests();
                        }
                        else {
                            this._SafeStr_10884.openFriendList();
                        };
                    }
                    else {
                        _local_1 = this._SafeStr_10884.mainWindow;
                        if (((!((_local_1 == null))) && (WindowToggle.isHiddenByOtherWindows(_local_1)))){
                            _local_1.activate();
                            return;
                        };
                        this._SafeStr_10884.close();
                    };
                    if (this._SafeStr_10883){
                        this._SafeStr_10883.getHabboMainConnection(null).send(new EventLogMessageComposer(_SafeStr_10877, FRIENDLIST, ((this._SafeStr_10884.isOpen()) ? _SafeStr_10878 : _SafeStr_10879)));
                    };
                };
            };
        }
        public function toggleMessenger():void
        {
            if (this._SafeStr_10885){
                if (!this._SafeStr_10885.disposed){
                    this._SafeStr_10885.toggleMessenger();
                    if (this._SafeStr_10883){
                        this._SafeStr_10883.getHabboMainConnection(null).send(new EventLogMessageComposer(_SafeStr_10877, MESSENGER, ((this._SafeStr_10885.isOpen()) ? _SafeStr_10878 : _SafeStr_10879)));
                    };
                };
            };
        }
        public function toggleOfflineStream():void
        {
            if (this._SafeStr_10886){
                if (!this._SafeStr_10886.disposed){
                    this._SafeStr_10886.visible = !(this._SafeStr_10886.visible);
                };
            };
        }
        public function refreshOfflineStream():void
        {
            if (this._SafeStr_10886){
                if (!this._SafeStr_10886.disposed){
                    this._SafeStr_10886.refreshEventStream();
                };
            };
        }
        private function onConfigurationAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10882 = (_arg_2 as IHabboConfigurationManager);
            this._SafeStr_10891 = this._SafeStr_10882.getBoolean("friendbar.notifications.enabled", false);
            this._SafeStr_10892 = this._SafeStr_10882.getBoolean("friendbar.requests.enabled", false);
        }
        private function onCommunicationManagerAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10883 = (_arg_2 as IHabboCommunicationManager);
            this._SafeStr_10883.addHabboConnectionMessageEvent(new MessengerInitEvent(this.onMessengerInitialized));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new FriendListUpdateEvent(this.onFriendListUpdate));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(this.onFindFriendProcessResult));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new NewBuddyRequestEvent(this.onNewFriendRequest));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new BuddyRequestsEvent(this.onFriendRequestList));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(this.onNewConsoleMessage));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new RoomInviteEvent(this.onRoomInvite));
            this._SafeStr_10883.addHabboConnectionMessageEvent(new FriendNotificationEvent(this.onFriendNotification));
        }
        private function onMessengerComponentAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10885 = (_arg_2 as IHabboMessenger);
        }
        private function onOfflineStreamAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10886 = (_arg_2 as IHabboEventStream);
        }
        private function onFriendListComponentAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10884 = (_arg_2 as IHabboFriendList);
            this._SafeStr_10884.events.addEventListener(FriendRequestEvent.RWDE_ACCEPTED, this.onFriendRequestEvent);
            this._SafeStr_10884.events.addEventListener(FriendRequestEvent.FRE_DECLINED, this.onFriendRequestEvent);
        }
        private function onMessengerInitialized(_arg_1:IMessageEvent):void
        {
            this.buildFriendList(MessengerInitEvent(_arg_1).getParser().friends);
        }
        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            var _local_3:FriendEntity;
            var _local_4:FriendData;
            var _local_8:int;
            var _local_2:FriendListUpdateMessageParser = FriendListUpdateEvent(_arg_1).getParser();
            var _local_5:Array = _local_2.removedFriendIds;
            var _local_6:Array = _local_2.updatedFriends;
            var _local_7:Array = _local_2.addedFriends;
            for each (_local_8 in _local_5) {
                _local_3 = this._SafeStr_10888.getValue(_local_8);
                if (_local_3){
                    this._SafeStr_10888.remove(_local_8);
                    this._SafeStr_10887.splice(this._SafeStr_10887.indexOf(_local_3), 1);
                };
            };
            for each (_local_4 in _local_6) {
                _local_3 = this._SafeStr_10888.getValue(_local_4.id);
                if (_local_3){
                    if (((_local_4.online) || (_SafeStr_10870))){
                        _local_3.name = _local_4.name;
                        _local_3.realName = _local_4.realName;
                        _local_3.motto = _local_4.motto;
                        _local_3.gender = _local_4.gender;
                        _local_3.online = _local_4.online;
                        _local_3.allowFollow = _local_4.followingAllowed;
                        _local_3.figure = _local_4.figure;
                        _local_3.categoryId = _local_4.categoryId;
                        _local_3.lastAccess = _local_4.lastAccess;
                    }
                    else {
                        this._SafeStr_10888.remove(_local_4.id);
                        this._SafeStr_10887.splice(this._SafeStr_10887.indexOf(_local_3), 1);
                    };
                }
                else {
                    if (((_local_4.online) || (_SafeStr_10870))){
                        _local_3 = new FriendEntity(_local_4.id, _local_4.name, _local_4.realName, _local_4.motto, _local_4.gender, _local_4.online, _local_4.followingAllowed, _local_4.figure, _local_4.categoryId, _local_4.lastAccess);
                        this._SafeStr_10887.splice(0, 0, _local_3);
                        this._SafeStr_10888.add(_local_3.id, _local_3);
                    };
                };
            };
            for each (_local_4 in _local_7) {
                if (((_local_4.online) || (_SafeStr_10870))){
                    if (this._SafeStr_10888.getValue(_local_4.id) == null){
                        _local_3 = new FriendEntity(_local_4.id, _local_4.name, _local_4.realName, _local_4.motto, _local_4.gender, _local_4.online, _local_4.followingAllowed, _local_4.figure, _local_4.categoryId, _local_4.lastAccess);
                        this._SafeStr_10887.push(_local_3);
                        this._SafeStr_10888.add(_local_3.id, _local_3);
                    };
                };
                this.removeFriendRequest(_local_4.id);
            };
            if ((((_local_7.length > 0)) || ((_local_6.length > 0)))){
                this._SafeStr_10887 = ((_SafeStr_10870) ? this.sortByNameAndOnlineStatus(this._SafeStr_10887) : this.sortByName(this._SafeStr_10887));
            };
            events.dispatchEvent(new FriendBarUpdateEvent());
        }
        private function onFindFriendProcessResult(_arg_1:FindFriendsProcessResultEvent):void
        {
            events.dispatchEvent(new FindFriendsNotificationEvent(_arg_1.success));
        }
        private function onNewFriendRequest(_arg_1:NewBuddyRequestEvent):void
        {
            var _local_2:FriendRequestData;
            if (this._SafeStr_10892){
                _local_2 = _arg_1.getParser().req;
                this._friendRequests.push(new FriendRequest(_local_2.requestId, _local_2.requesterName, _local_2.figureString));
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }
        private function onFriendRequestList(_arg_1:BuddyRequestsEvent):void
        {
            var _local_2:Array;
            var _local_3:FriendRequestData;
            if (this._SafeStr_10892){
                _local_2 = _arg_1.getParser().reqs;
                for each (_local_3 in _local_2) {
                    this._friendRequests.push(new FriendRequest(_local_3.requestId, _local_3.requesterName, _local_3.figureString));
                };
                events.dispatchEvent(new FriendRequestUpdateEvent());
            };
        }
        private function onFriendRequestEvent(_arg_1:FriendRequestEvent):void
        {
            this.removeFriendRequest(_arg_1.requestId);
        }
        private function onNewConsoleMessage(_arg_1:NewConsoleMessageEvent):void
        {
            var _local_4:IConversation;
            var _local_2:NewConsoleMessageMessageParser = _arg_1.getParser();
            this._SafeStr_10890 = _local_2.senderId;
            var _local_3:Boolean = true;
            if (this._SafeStr_10885){
                if (this._SafeStr_10885.isOpen()){
                    _local_4 = this._SafeStr_10885.getActiveConversation();
                    if (_local_4){
                        if (_local_4.id == this._SafeStr_10890){
                            _local_3 = false;
                        };
                    };
                };
            };
            if (_local_3){
                events.dispatchEvent(new NewMessageEvent(true, this._SafeStr_10890));
                this.makeNotification(String(this._SafeStr_10890), FriendNotification._SafeStr_10917, null, false, false);
            };
        }
        private function onRoomInvite(_arg_1:RoomInviteEvent):void
        {
            var _local_2:RoomInviteMessageParser = _arg_1.getParser();
            this._SafeStr_10890 = _local_2.senderId;
            if (((this._SafeStr_10885) && (!(this._SafeStr_10885.isOpen())))){
                events.dispatchEvent(new NewMessageEvent(true, this._SafeStr_10890));
                this.makeNotification(String(this._SafeStr_10890), FriendNotification._SafeStr_10917, null, true, false);
            };
        }
        private function onFriendNotification(_arg_1:FriendNotificationEvent):void
        {
            var _local_2:FriendNotificationMessageParser = _arg_1.getParser();
            this.makeNotification(_local_2.avatarId, _local_2.typeCode, _local_2.message, true, true);
        }
        private function makeNotification(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean):void
        {
            var _local_6:IFriendEntity;
            var _local_7:FriendNotification;
            var _local_8:Vector.<FriendNotification>;
            if (this._SafeStr_10891){
                _local_6 = this.getFriendByID(parseInt(_arg_1));
                if (_local_6){
                    _local_8 = _local_6.notifications;
                    for each (_local_7 in _local_8) {
                        if (_local_7.typeCode == _arg_2){
                            _local_7.message = _arg_3;
                            _local_7.viewOnce = _arg_4;
                            break;
                        };
                        _local_7 = null;
                    };
                    if (!_local_7){
                        _local_7 = new FriendNotification(_arg_2, _arg_3, _arg_4);
                        _local_8.push(_local_7);
                    };
                    events.dispatchEvent(new NotificationEvent(_local_6.id, _local_7));
                    if (_arg_5){
                        this.setFriendAt(_local_6, 0);
                    };
                    if (_local_6.logEventId < 0){
                        _local_6.logEventId = _local_6.getNextLogEventId();
                    };
                    HabboTracking.getInstance().trackEventLog("FriendBar", FriendNotification.typeCodeToString(_arg_2), "notified", "", (((_local_6.logEventId > 0)) ? _local_6.logEventId : 0));
                };
            };
        }
        private function buildFriendList(_arg_1:Array):void
        {
            var _local_2:FriendData;
            var _local_3:FriendEntity;
            for each (_local_2 in _arg_1) {
                if (((_local_2.online) || (_SafeStr_10870))){
                    _local_3 = new FriendEntity(_local_2.id, _local_2.name, _local_2.realName, _local_2.motto, _local_2.gender, _local_2.online, _local_2.followingAllowed, _local_2.figure, _local_2.categoryId, _local_2.lastAccess);
                    this._SafeStr_10887.push(_local_3);
                    this._SafeStr_10888.add(_local_3.id, _local_3);
                };
            };
            this._SafeStr_10887 = ((_SafeStr_10870) ? this.sortByNameAndOnlineStatus(this._SafeStr_10887) : this.sortByName(this._SafeStr_10887));
            events.dispatchEvent(new FriendBarUpdateEvent());
        }
        private function sortByName(_arg_1:Array):Array
        {
            if (_SafeStr_10871){
                _arg_1.sortOn("name", [Array.CASEINSENSITIVE]);
            };
            return (_arg_1);
        }
        private function sortByNameAndOnlineStatus(_arg_1:Array):Array
        {
            var _local_4:FriendEntity;
            var _local_2:Array = [];
            var _local_3:Array = [];
            var _local_5:int = _arg_1.length;
            while (_local_5-- > 0) {
                _local_4 = _arg_1[_local_5];
                if (_local_4.online){
                    _local_2.push(_local_4);
                }
                else {
                    _local_3.push(_local_4);
                };
            };
            if (_SafeStr_10871){
                _local_2.sortOn("name", [Array.CASEINSENSITIVE]);
                _local_3.sortOn("name", [(Array.CASEINSENSITIVE | Array.DESCENDING)]);
            };
            _local_5 = _local_3.length;
            while (_local_5-- > 0) {
                _local_2.push(_local_3.pop());
            };
            return (_local_2);
        }

    }
}//package com.sulake.habbo.friendbar.data

// IID = "_-3KV" (String#7712, DoABC#2)
// lastAccess = "_-Es" (String#7968, DoABC#2)
// numFriends = "_-nN" (String#8666, DoABC#2)
// getFriendAt = "_-1K4" (String#5244, DoABC#2)
// getFriendByID = "_-m3" (String#8644, DoABC#2)
// getFriendByName = "_-0QT" (String#4102, DoABC#2)
// numFriendRequests = "_-0" (String#3548, DoABC#2)
// getFriendRequestAt = "_-3-l" (String#7299, DoABC#2)
// getFriendRequestByID = "_-1LM" (String#5268, DoABC#2)
// getFriendRequestByName = "_-GP" (String#8003, DoABC#2)
// getFriendRequestList = "_-0Wl" (String#4243, DoABC#2)
// toggleFriendList = "_-tA" (String#8753, DoABC#2)
// toggleMessenger = "_-2E7" (String#1838, DoABC#2)
// toggleOfflineStream = "_-2ED" (String#6325, DoABC#2)
// refreshOfflineStream = "_-ul" (String#8779, DoABC#2)
// _SafeStr_10870 = "_-1iC" (String#18218, DoABC#2)
// _SafeStr_10871 = "_-0l6" (String#15870, DoABC#2)
// _SafeStr_10872 = "_-R0" (String#23282, DoABC#2)
// _SafeStr_10873 = "_-2-J" (String#18983, DoABC#2)
// _SafeStr_10874 = "_-1ow" (String#18497, DoABC#2)
// _SafeStr_10875 = "_-1wy" (String#18844, DoABC#2)
// _SafeStr_10876 = "_-00h" (String#14082, DoABC#2)
// _SafeStr_10877 = "_-0Mm" (String#14943, DoABC#2)
// _SafeStr_10878 = "_-18l" (String#16802, DoABC#2)
// _SafeStr_10879 = "_-0UZ" (String#15226, DoABC#2)
// FRIENDLIST = "_-2y8" (String#21398, DoABC#2)
// MESSENGER = "_-Xq" (String#23555, DoABC#2)
// _SafeStr_10882 = "_-0Yz" (String#15401, DoABC#2)
// _SafeStr_10883 = "_-0Kv" (String#3975, DoABC#2)
// _SafeStr_10884 = "_-1o-" (String#18462, DoABC#2)
// _SafeStr_10885 = "_-1-X" (String#16449, DoABC#2)
// _SafeStr_10886 = "_-18p" (String#16806, DoABC#2)
// _SafeStr_10887 = "_-1rW" (String#18608, DoABC#2)
// _SafeStr_10888 = "_-1KF" (String#17284, DoABC#2)
// _friendRequests = "_-Sv" (String#8266, DoABC#2)
// _SafeStr_10890 = "_-1it" (String#18241, DoABC#2)
// _SafeStr_10891 = "_-0Rc" (String#15125, DoABC#2)
// _SafeStr_10892 = "_-1ws" (String#18840, DoABC#2)
// onConfigurationAvailable = "_-pU" (String#2202, DoABC#2)
// onCommunicationManagerAvailable = "_-1id" (String#5725, DoABC#2)
// onFriendListComponentAvailable = "_-0xC" (String#16320, DoABC#2)
// onMessengerComponentAvailable = "_-NQ" (String#23142, DoABC#2)
// onOfflineStreamAvailable = "_-0wR" (String#16289, DoABC#2)
// onFriendRequestEvent = "_-01J" (String#14103, DoABC#2)
// setFriendAt = "_-1B2" (String#16902, DoABC#2)
// removeFriendRequest = "_-04n" (String#14231, DoABC#2)
// openFriendRequests = "_-20l" (String#6059, DoABC#2)
// refreshEventStream = "_-1Zw" (String#1711, DoABC#2)
// onMessengerInitialized = "_-1xP" (String#18864, DoABC#2)
// onFriendListUpdate = "_-2UT" (String#1887, DoABC#2)
// onFindFriendProcessResult = "_-0YV" (String#15380, DoABC#2)
// onNewFriendRequest = "_-2mE" (String#20927, DoABC#2)
// onFriendRequestList = "_-gu" (String#23925, DoABC#2)
// onNewConsoleMessage = "_-1Gn" (String#5184, DoABC#2)
// onRoomInvite = "_-3Fn" (String#7626, DoABC#2)
// onFriendNotification = "_-Mx" (String#8141, DoABC#2)
// buildFriendList = "_-06H" (String#14297, DoABC#2)
// allowFollow = "_-1Va" (String#5466, DoABC#2)
// sortByNameAndOnlineStatus = "_-0YI" (String#15370, DoABC#2)
// sortByName = "_-1LA" (String#17321, DoABC#2)
// getActiveConversation = "_-0WJ" (String#4233, DoABC#2)
// makeNotification = "_-0Ml" (String#14942, DoABC#2)
// _SafeStr_10917 = "_-0Pj" (String#15051, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// viewOnce = "_-3JO" (String#22260, DoABC#2)
// logEventId = "_-Vm" (String#8316, DoABC#2)
// getNextLogEventId = "_-0OK" (String#4053, DoABC#2)
// typeCodeToString = "_-AL" (String#22630, DoABC#2)
// WindowToggle = "_-1Ud" (String#17689, DoABC#2)
// IHabboEventStream = "_-2Uk" (String#6661, DoABC#2)
// IHabboFriendBarData = "_-1hC" (String#5689, DoABC#2)
// HabboFriendBarData = "_-3DB" (String#7579, DoABC#2)
// IConversation = "_-1me" (String#5792, DoABC#2)
// RoomInviteEvent = "_-38C" (String#7476, DoABC#2)
// RoomInviteMessageParser = "_-1OK" (String#17445, DoABC#2)
// NewConsoleMessageMessageParser = "_-01u" (String#14124, DoABC#2)
// MessengerInitEvent = "_-0pu" (String#4632, DoABC#2)
// BuddyRequestsEvent = "_-2y" (String#7239, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// NewBuddyRequestEvent = "_-1iS" (String#5721, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// FriendListUpdateEvent = "_-l9" (String#8629, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// FollowFriendMessageComposer = "_-MN" (String#23099, DoABC#2)
// FriendRequestUpdateEvent = "_-0JS" (String#14820, DoABC#2)
// NotificationEvent = "_-mt" (String#24147, DoABC#2)
// NewMessageEvent = "_-3Cc" (String#21980, DoABC#2)
// IFriendEntity = "_-2nQ" (String#7031, DoABC#2)
// FriendBarUpdateEvent = "_-UZ" (String#23430, DoABC#2)
// FindFriendsNotificationEvent = "_-2xi" (String#21383, DoABC#2)
// FriendListUpdateMessageParser = "_-1B-" (String#5094, DoABC#2)
// FriendNotificationMessageParser = "_-0Ns" (String#14984, DoABC#2)
// FindNewFriendsMessageComposer = "_-2eU" (String#20624, DoABC#2)
// FriendRequestEvent = "_-1SF" (String#17590, DoABC#2)
// FriendEntity = "_-0R1" (String#15104, DoABC#2)
// FriendNotificationEvent = "_-2Vl" (String#6679, DoABC#2)
// FindFriendsProcessResultEvent = "_-3IG" (String#7672, DoABC#2)
// requestId = "_-li" (String#24099, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// figureString = "_-P1" (String#23207, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// isHiddenByOtherWindows = "_-1OQ" (String#17449, DoABC#2)
// trackEventLog = "_-0ML" (String#14927, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// RWDE_ACCEPTED = "_-1OB" (String#17441, DoABC#2)
// FRE_DECLINED = "_-2IY" (String#19749, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// senderId = "_-2GI" (String#19654, DoABC#2)
// reqs = "_-31c" (String#21563, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// req = "_-8J" (String#22555, DoABC#2)
// removedFriendIds = "_-27p" (String#19323, DoABC#2)
// addedFriends = "_-1B0" (String#16900, DoABC#2)
// updatedFriends = "_-D2" (String#22729, DoABC#2)
// typeCode = "_-vq" (String#24522, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// requesterName = "_-1ki" (String#18318, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)


