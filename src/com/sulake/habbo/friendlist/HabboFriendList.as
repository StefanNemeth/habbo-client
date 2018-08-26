
package com.sulake.habbo.friendlist
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.messenger.IHabboMessenger;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.friendlist.domain.FriendListTabs;
    import com.sulake.habbo.friendlist.domain.FriendCategories;
    import com.sulake.habbo.friendlist.domain.FriendRequests;
    import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import flash.utils.Timer;
    import com.sulake.habbo.friendlist.domain.FriendCategoriesDeps;
    import com.sulake.habbo.friendlist.domain.AvatarSearchDeps;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.TimerEvent;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboMessenger;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.RequestBuddyMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.quest.FriendRequestQuestCompleteMessageComposer;
    import com.sulake.habbo.friendlist.domain.FriendListTab;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.MessengerInitMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendCategoryData;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
    import com.sulake.habbo.friendlist.domain.FriendCategory;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerInitMessageParser;
    import com.sulake.habbo.friendlist.domain.FriendRequestsDeps;
    import com.sulake.habbo.friendlist.domain.Friend;
    import com.sulake.habbo.friendlist.domain.FriendListTabsDeps;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FollowFriendFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.BuddyRequestsEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.NewBuddyRequestEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultEvent;
    import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteErrorEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.GetBuddyRequestsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FriendListUpdateMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
    import com.sulake.habbo.communication.messages.parser.friendlist.BuddyRequestsMessageParser;
    import com.sulake.habbo.friendlist.domain.FriendRequest;
    import com.sulake.habbo.communication.messages.parser.friendlist.NewBuddyRequestMessageParser;
    import com.sulake.habbo.communication.messages.incoming.friendlist.AcceptBuddyFailureData;
    import com.sulake.habbo.communication.messages.parser.friendlist.AcceptBuddyResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.HabboSearchResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.MessengerErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteErrorMessageParser;
    import com.sulake.habbo.communication.messages.parser.friendlist.FollowFriendFailedMessageParser;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import flash.geom.Point;
    import com.sulake.habbo.communication.messages.incoming.friendlist.*;
    import com.sulake.habbo.friendlist.domain.*;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.*;
    import com.sulake.habbo.communication.messages.parser.friendlist.*;

    public class HabboFriendList extends Component implements IHabboFriendList, IAvatarImageListener 
    {

        public static const _SafeStr_11259:String = "face";

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _messenger:IHabboMessenger;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _SafeStr_11072:IAvatarRenderManager;
        private var _sessionData:ISessionDataManager;
        private var _laf:FriendListLookAndFeel;
        private var _tabs:FriendListTabs;
        private var _view:FriendListView;
        private var _openedToWebPopup:OpenedToWebPopup;
        private var _avatarId:int;
        var _categories:FriendCategories;
        private var _friendRequests:FriendRequests;
        private var _searchResults:AvatarSearchResults;
        private var _toolbar:IHabboToolbar;
        private var _HabboSoundManagerFlash10:IHabboNotifications;
        private var _SafeStr_11313:Timer;

        public function HabboFriendList(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._laf = new FriendListLookAndFeel();
            super(_arg_1, _arg_2, _arg_3);
            this._categories = new FriendCategories(new FriendCategoriesDeps(this));
            this._searchResults = new AvatarSearchResults(new AvatarSearchDeps(this));
            queueInterface(new IIDHabboCommunicationManager(), this.HabboUserDefinedRoomEvents);
        }
        override public function dispose():void
        {
            if (this._SafeStr_11313){
                this._SafeStr_11313.stop();
                this._SafeStr_11313.removeEventListener(TimerEvent.TIMER, this.sendFriendListUpdate);
                this._SafeStr_11313 = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._messenger){
                this._messenger.release(new IIDHabboMessenger());
                this._messenger = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._SafeStr_11072){
                this._SafeStr_11072.release(new IIDAvatarRenderManager());
                this._SafeStr_11072 = null;
            };
            if (this._HabboSoundManagerFlash10){
                this._HabboSoundManagerFlash10.release(new IIDHabboNotifications());
                this._HabboSoundManagerFlash10 = null;
            };
            if (this._toolbar){
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._sessionData){
                this._sessionData.release(new IIDSessionDataManager());
                this._sessionData = null;
            };
            super.dispose();
        }
        public function send(_arg_1:IMessageComposer):void
        {
            this._communication.HabboCommunicationManager(null).send(_arg_1);
        }
        public function openHabboWebPage(linkAlias:String, params:Dictionary, x:int, y:int):void
        {
            var url:String = this.getVariable(linkAlias, params);
            var webWindowName:String = "habboMain";
            try {
                HabboWebTools.navigateToURL(url, webWindowName);
            }
            catch(e:Error) {
                Logger.log(("GOT ERROR: " + e));
            };
            if (this._openedToWebPopup == null){
                this._openedToWebPopup = new OpenedToWebPopup(this);
            };
            this._openedToWebPopup.show(x, y);
        }
        public function getText(_arg_1:String):String
        {
            return (this._localization.getKey(_arg_1));
        }
        public function registerParameter(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            this._localization.registerParameter(_arg_1, _arg_2, _arg_3);
        }
        public function showLimitReachedAlert():void
        {
            this.registerParameter("friendlist.listfull.text", "mylimit", ("" + this.friendRequests.limit));
            this.registerParameter("friendlist.listfull.text", "clublimit", ("" + this.friendRequests.clubLimit));
            this.registerParameter("friendlist.listfull.text", "viplimit", ("" + this.friendRequests.vipLimit));
            new SimpleAlertView(this, "${friendlist.listfull.title}", "${friendlist.listfull.text}").show();
        }
        public function getFriend(_arg_1:int):IFriend
        {
            if (this._view == null){
                Logger.log("Cannot process getFriend. Friendlist not initialized.");
                return (null);
            };
            return (this._categories.findFriend(_arg_1));
        }
        public function canBeAskedForAFriend(_arg_1:int):Boolean
        {
            if (this._view == null){
                Logger.log("Cannot process canBeAskedForAFriend. Friendlist not initialized.");
                return (false);
            };
            return ((((((this.getFriend(_arg_1) == null)) && (!(this.searchResults.isFriendRequestSent(_arg_1))))) && ((this.categories.getFriendCount(false) < this.friendRequests.limit))));
        }
        public function askForAFriend(_arg_1:int, _arg_2:String):Boolean
        {
            if (this._view == null){
                Logger.log("Cannot ask for friend. Friendlist not initialized.");
                return (false);
            };
            if (!this.canBeAskedForAFriend(_arg_1)){
                return (false);
            };
            this.send(new RequestBuddyMessageComposer(_arg_2));
            this.searchResults.setFriendRequestSent(_arg_1);
            this.send(new FriendRequestQuestCompleteMessageComposer());
            return (true);
        }
        public function openFriendList():void
        {
            this.openFriendListWithTab(FriendListTab._SafeStr_11144);
        }
        public function openFriendRequests():void
        {
            this.openFriendListWithTab(FriendListTab._SafeStr_11145);
        }
        public function openFriendSearch():void
        {
            this.openFriendListWithTab(FriendListTab._view);
        }
        public function close():void
        {
            if (this._view){
                this._view.close();
            };
        }
        public function IssueBrowser():Boolean
        {
            if (this._view){
                return (this._view.IssueBrowser());
            };
            return (false);
        }
        private function openFriendListWithTab(_arg_1:int):void
        {
            if (this._view == null){
                Logger.log("Cannot open friendlist. Friendlist not initialized.");
                return;
            };
            this._view.openFriendList();
            var _local_2:FriendListTab = this.tabs.findTab(_arg_1);
            if (_local_2 != this.tabs.findSelectedTab()){
                this.tabs.toggleSelected(_local_2);
                this.view.refresh("openFriendList");
            };
            this._view.mainWindow.activate();
        }
        public function getFriendCount(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (this._view == null){
                Logger.log("Cannot get friend count. Friendlist not initialized.");
                return (0);
            };
            return (this._categories.getFriendCount(_arg_1, _arg_2));
        }
        public function getButton(_arg_1:String, _arg_2:String, _arg_3:Function, _arg_4:int=0, _arg_5:int=0, _arg_6:int=0):IBitmapWrapperWindow
        {
            var _local_7:BitmapData = this.getButtonImage(_arg_2);
            var _local_8:IBitmapWrapperWindow = (this._windowManager.createWindow(_arg_1, "", HabboWindowType._SafeStr_6022, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_3731 | HabboWindowParam._SafeStr_6023), new Rectangle(_arg_4, _arg_5, _local_7.width, _local_7.height), _arg_3, _arg_6) as IBitmapWrapperWindow);
            _local_8.bitmap = _local_7;
            return (_local_8);
        }
        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_2:IAsset = assets.getAssetByName((_arg_1 + "_xml"));
            var _local_3:XmlAsset = XmlAsset(_local_2);
            return (this._windowManager.buildFromXML(XML(_local_3.content)));
        }
        public function getAvatarFaceBitmap(_arg_1:String):BitmapData
        {
            var _local_2:IAvatarImage = this._SafeStr_11072.createAvatarImage(_arg_1, AvatarScaleType._SafeStr_4337, null, this);
            if (!_local_2){
                return (null);
            };
            var _local_3:BitmapData = _local_2.getCroppedImage(AvatarSetType._SafeStr_4458);
            _local_2.dispose();
            return (_local_3);
        }
        public function isEmbeddedMinimailEnabled():Boolean
        {
            var _local_1:String = this._configuration.getKey("client.minimail.embed.enabled");
            return ((_local_1 == "true"));
        }
        private function getVariable(_arg_1:String, _arg_2:Dictionary):String
        {
            return (this._configuration.getKey(_arg_1, _arg_1, _arg_2));
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Friend list: communication available " + [_arg_1, _arg_2]));
            this._communication = (_arg_2 as IHabboCommunicationManager);
            queueInterface(new IIDHabboMessenger(), this.onMessengerComponentInit);
        }
        private function onMessengerComponentInit(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Friend list: messenger available " + [_arg_1, _arg_2]));
            this._messenger = (_arg_2 as IHabboMessenger);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderedReady);
        }
        private function onAvatarRenderedReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Messenger: avatar renderer " + [_arg_1, _arg_2]));
            this._SafeStr_11072 = (_arg_2 as IAvatarRenderManager);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Friend list: configuration " + [_arg_1, _arg_2]));
            this._configuration = (_arg_2 as IHabboConfigurationManager);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Friend list: localization " + [_arg_1, _arg_2]));
            this._localization = (_arg_2 as IHabboLocalizationManager);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = (IHabboToolbar(_arg_2) as IHabboToolbar);
            queueInterface(new IIDHabboNotifications(), this.HabboSoundManagerFlash10);
        }
        private function HabboSoundManagerFlash10(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._HabboSoundManagerFlash10 = (_arg_2 as IHabboNotifications);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            Logger.log(("Friend list: window manager " + [_arg_1, _arg_2]));
            this._windowManager = (_arg_2 as IHabboWindowManager);
            this._communication.HabboCommunicationManager(new AuthenticationOKMessageEvent(this.onAuthOK));
            this._communication.HabboCommunicationManager(new UserObjectEvent(this.onUserObject));
            queueInterface(new IIDSessionDataManager(), this.onSessionDataReady);
        }
        private function onSessionDataReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._sessionData = (_arg_2 as ISessionDataManager);
        }
        private function onAuthOK(_arg_1:IMessageEvent):void
        {
            this._communication.HabboCommunicationManager(new MessengerInitEvent(this.onMessengerInit));
            this.send(new MessengerInitMessageComposer());
        }
        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectMessageParser = (_arg_1 as UserObjectEvent).getParser();
            this._avatarId = int(_local_2.id);
        }
        private function onMessengerInit(_arg_1:IMessageEvent):void
        {
            var _local_3:FriendCategoryData;
            var _local_4:FriendData;
            var _local_5:FriendCategory;
            this._view = new FriendListView(this);
            var _local_2:MessengerInitMessageParser = (_arg_1 as MessengerInitEvent).getParser();
            this._friendRequests = new FriendRequests(new FriendRequestsDeps(this), _local_2.userFriendLimit, _local_2.extendedFriendLimit, _local_2.evenMoreExtendedFriendLimit);
            for each (_local_3 in _local_2.categories) {
                this._categories.addCategory(new FriendCategory(_local_3.id, _local_3.name));
            };
            this._categories.addCategory(new FriendCategory(FriendCategory._SafeStr_11172, this.getText("friendlist.friends")));
            this._categories.addCategory(new FriendCategory(FriendCategory._SafeStr_11173, this.getText("friendlist.friends.offlinecaption")));
            for each (_local_4 in this.getSortedFriends(_local_2.friends)) {
                this._categories.addFriend(new Friend(_local_4));
            };
            this._tabs = new FriendListTabs(new FriendListTabsDeps(this));
            if (!this._SafeStr_11313){
                this._SafeStr_11313 = new Timer(120000);
                this._SafeStr_11313.addEventListener(TimerEvent.TIMER, this.sendFriendListUpdate);
                this._SafeStr_11313.start();
            };
            this.getBuddyRequests();
            this.registerListeners();
            if (this._categories.getFriendCount(true, false) == 0){
                _local_5 = this._categories.findCategory(FriendCategory._SafeStr_11173);
                if (_local_5){
                    _local_5.setOpen(true);
                };
            };
            Logger.log("FRIENDLIST INITIALIZED SUCCESSFULLY");
        }
        public function trackFriendListEvent(_arg_1:String):void
        {
            events.dispatchEvent(new Event(_arg_1));
        }
        private function getSortedFriends(_arg_1:Array):Array
        {
            var _local_4:FriendData;
            var _local_5:Array;
            var _local_6:String;
            var _local_2:Array = new Array();
            var _local_3:Dictionary = new Dictionary();
            for each (_local_4 in _arg_1) {
                _local_2.push(_local_4.name.toLowerCase());
                _local_3[_local_4.name.toLowerCase()] = _local_4;
            };
            _local_2.sort();
            _local_5 = new Array();
            for each (_local_6 in _local_2) {
                _local_5.push(_local_3[_local_6]);
            };
            return (_local_5);
        }
        private function registerListeners():void
        {
            this._communication.HabboCommunicationManager(new FollowFriendFailedEvent(this.onFollowFriendFailed));
            this._communication.HabboCommunicationManager(new FriendListUpdateEvent(this.onFriendListUpdate));
            this._communication.HabboCommunicationManager(new BuddyRequestsEvent(this.onBuddyRequests));
            this._communication.HabboCommunicationManager(new NewBuddyRequestEvent(this.onNewBuddyRequest));
            this._communication.HabboCommunicationManager(new AcceptBuddyResultEvent(this.onAcceptBuddyResult));
            this._communication.HabboCommunicationManager(new MessengerErrorEvent(this.onMessengerError));
            this._communication.HabboCommunicationManager(new HabboSearchResultEvent(this.onHabboSearchResult));
            this._communication.HabboCommunicationManager(new RoomInviteErrorEvent(this.onRoomInviteError));
            this._communication.HabboCommunicationManager(new UserRightsMessageEvent(this.onUserRights));
        }
        private function getBuddyRequests():void
        {
            Logger.log("Sending buddy requests request");
            this.send(new GetBuddyRequestsMessageComposer());
        }
        protected function sendFriendListUpdate(_arg_1:Event):void
        {
            Logger.log("Sending update request");
            this.send(new FriendListUpdateMessageComposer());
        }
        private function onBuddyRequests(_arg_1:IMessageEvent):void
        {
            var _local_3:FriendRequestData;
            var _local_2:BuddyRequestsMessageParser = (_arg_1 as BuddyRequestsEvent).getParser();
            this._friendRequests.clearAndUpdateView(false);
            for each (_local_3 in _local_2.reqs) {
                this._friendRequests.addRequest(new FriendRequest(_local_3));
            };
            if (_local_2.reqs.length > 0){
                this._tabs.findTab(FriendListTab._SafeStr_11145).setNewMessageArrived(true);
            };
            this._view.refresh("buddyRequests");
        }
        private function onNewBuddyRequest(_arg_1:IMessageEvent):void
        {
            Logger.log("Received new buddy request");
            var _local_2:NewBuddyRequestMessageParser = (_arg_1 as NewBuddyRequestEvent).getParser();
            var _local_3:FriendRequest = new FriendRequest(_local_2.req);
            this._friendRequests.addRequestAndUpdateView(_local_3);
            var _local_4:FriendListTab = this._tabs.findTab(FriendListTab._SafeStr_11145);
            _local_4.setNewMessageArrived(true);
            this._view.refresh("newBuddyRequest");
        }
        private function onAcceptBuddyResult(_arg_1:IMessageEvent):void
        {
            var _local_3:AcceptBuddyFailureData;
            var _local_2:AcceptBuddyResultMessageParser = (_arg_1 as AcceptBuddyResultEvent).getParser();
            for each (_local_3 in _local_2.failures) {
                this.friendRequests.acceptFailed(_local_3.senderName);
            };
        }
        private function onHabboSearchResult(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboSearchResultMessageParser = (_arg_1 as HabboSearchResultEvent).getParser();
            this._searchResults.searchReceived(_local_2.friends, _local_2.others);
            this._view.refresh("search");
        }
        private function onMessengerError(_arg_1:IMessageEvent):void
        {
            var _local_2:MessengerErrorMessageParser = (_arg_1 as MessengerErrorEvent).getParser();
            var _local_3:String = "";
            switch (_local_2.errorCode){
                case 1:
                    _local_3 = "${friendlist.error.friendlistownlimit}";
                    break;
                case 2:
                    _local_3 = "${friendlist.error.friendlistlimitofrequester}";
                    break;
                case 3:
                    _local_3 = "${friendlist.error.friend_requests_disabled}";
                    break;
                case 4:
                    _local_3 = "${friendlist.error.requestnotfound}";
                    break;
                default:
                    _local_3 = ((("Received messenger error: msg: " + _local_2.clientMessageId) + ", errorCode: ") + _local_2.errorCode);
            };
            new SimpleAlertView(this, "${friendlist.alert.title}", _local_3).show();
        }
        private function onRoomInviteError(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomInviteErrorMessageParser = (_arg_1 as RoomInviteErrorEvent).getParser();
            var _local_3:String = ((("Received room invite error: errorCode: " + _local_2.errorCode) + ", recipients: ") + Util.arrayToString(_local_2.failedRecipients));
            new SimpleAlertView(this, "${friendlist.alert.title}", _local_3).show();
        }
        private function onFriendListUpdate(_arg_1:IMessageEvent):void
        {
            this._categories.onFriendListUpdate(_arg_1);
            this._view.refresh("friendListUpdate");
        }
        private function onFollowFriendFailed(_arg_1:IMessageEvent):void
        {
            var _local_2:FollowFriendFailedMessageParser = (_arg_1 as FollowFriendFailedEvent).getParser();
            var _local_3:String = this.getFollowFriendErrorText(_local_2.errorCode);
            Logger.log(((("Received follow friend failed: " + _local_2.errorCode) + ", ") + _local_3));
            new SimpleAlertView(this, "${friendlist.alert.title}", _local_3).show();
        }
        private function getFollowFriendErrorText(_arg_1:int):String
        {
            if (_arg_1 == 0){
                return ("${friendlist.followerror.notfriend}");
            };
            if (_arg_1 == 1){
                return ("${friendlist.followerror.offline}");
            };
            if (_arg_1 == 2){
                return ("${friendlist.followerror.hotelview}");
            };
            if (_arg_1 == 3){
                return ("${friendlist.followerror.prevented}");
            };
            return (("Unknown follow friend error " + _arg_1));
        }
        public function refreshText(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:String):void
        {
            var _local_5:IWindow = _arg_1.getChildByName(_arg_2);
            if (!_arg_3){
                _local_5.visible = false;
            }
            else {
                _local_5.visible = true;
                _local_5.caption = _arg_4;
            };
        }
        public function refreshButton(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IWindow = (_arg_1.findChildByName(_arg_2) as IWindow);
            if (!_arg_3){
                _local_6.visible = false;
            }
            else {
                this.HabboUserDefinedRoomEvents(_local_6, _arg_2, _arg_4, _arg_5);
                _local_6.visible = true;
            };
        }
        public function refreshIcon(_arg_1:IWindowContainer, _arg_2:String, _arg_3:Boolean, _arg_4:Function, _arg_5:int):void
        {
            var _local_6:IWindow = _arg_1.findChildByName(_arg_2);
            if (!_arg_3){
                _local_6.visible = false;
            }
            else {
                _local_6.id = _arg_5;
                _local_6.procedure = _arg_4;
                _local_6.visible = true;
            };
        }
        private function HabboUserDefinedRoomEvents(_arg_1:IWindow, _arg_2:String, _arg_3:Function, _arg_4:int):void
        {
            var _local_5:IBitmapWrapperWindow;
            _arg_1.id = _arg_4;
            if ((_arg_1 is IBitmapWrapperWindow)){
                _local_5 = (_arg_1 as IBitmapWrapperWindow);
            }
            else {
                _local_5 = (IWindowContainer(_arg_1).findChildByTag("bitmap") as IBitmapWrapperWindow);
            };
            if (_local_5.bitmap != null){
                return;
            };
            _local_5.bitmap = this.getButtonImage(_arg_2);
            _local_5.width = _local_5.bitmap.width;
            _local_5.height = _local_5.bitmap.height;
            _arg_1.procedure = _arg_3;
        }
        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_5:BitmapData;
            var _local_2:IAsset = assets.getAssetByName((_arg_1 + "_png"));
            var _local_3:BitmapDataAsset = (_local_2 as BitmapDataAsset);
            Logger.log(("GETTING ASSET: " + _arg_1));
            var _local_4:BitmapData = (_local_3.content as BitmapData);
            Logger.log(((("GOT ASSET: " + _local_2) + ", ") + _local_4));
            _local_5 = new BitmapData(_local_4.width, _local_4.height, true, 0);
            _local_5.draw(_local_4);
            return (_local_5);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get categories():FriendCategories
        {
            return (this._categories);
        }
        public function get friendRequests():FriendRequests
        {
            return (this._friendRequests);
        }
        public function get searchResults():AvatarSearchResults
        {
            return (this._searchResults);
        }
        public function get view():FriendListView
        {
            return (this._view);
        }
        public function get tabs():FriendListTabs
        {
            return (this._tabs);
        }
        public function get laf():FriendListLookAndFeel
        {
            return (this._laf);
        }
        public function get messenger():IHabboMessenger
        {
            return (this._messenger);
        }
        public function get avatarId():int
        {
            return (this._avatarId);
        }
        public function get notifications():IHabboNotifications
        {
            return (this._HabboSoundManagerFlash10);
        }
        public function get mainWindow():IWindowContainer
        {
            if (this._view == null){
                return (null);
            };
            return (this._view.mainWindow);
        }
        public function HabboFriendList():Array
        {
            if (this._categories == null){
                return ([]);
            };
            return (this._categories.HabboFriendList());
        }
        public function acceptFriendRequest(_arg_1:int):void
        {
            var _local_2:FriendListTab = this._tabs.findTab(FriendListTab._SafeStr_11145);
            if (!_local_2){
                return;
            };
            var _local_3:IFriendRequestsView = (_local_2.tabView as IFriendRequestsView);
            if (!_local_3){
                return;
            };
            _local_3.acceptRequest(_arg_1);
        }
        public function acceptAllFriendRequests():void
        {
            var _local_1:FriendListTab = this._tabs.findTab(FriendListTab._SafeStr_11145);
            if (!_local_1){
                return;
            };
            var _local_2:IFriendRequestsView = (_local_1.tabView as IFriendRequestsView);
            if (!_local_2){
                return;
            };
            _local_2.acceptAllRequests();
        }
        public function declineFriendRequest(_arg_1:int):void
        {
            var _local_2:FriendListTab = this._tabs.findTab(FriendListTab._SafeStr_11145);
            if (!_local_2){
                return;
            };
            var _local_3:IFriendRequestsView = (_local_2.tabView as IFriendRequestsView);
            if (!_local_3){
                return;
            };
            _local_3.declineRequest(_arg_1);
        }
        public function declineAllFriendRequests():void
        {
            var _local_1:FriendListTab = this._tabs.findTab(FriendListTab._SafeStr_11145);
            if (!_local_1){
                return;
            };
            var _local_2:IFriendRequestsView = (_local_1.tabView as IFriendRequestsView);
            if (!_local_2){
                return;
            };
            _local_2.declineAllRequests();
        }
        private function onUserRights(_arg_1:IMessageEvent):void
        {
            if (((!(this._sessionData)) || (!(this._friendRequests)))){
                return;
            };
            var _local_2:int;
            if (this._sessionData.hasUserRight("fuse_super_extended_buddylist", HabboClubLevelEnum._SafeStr_3939)){
                _local_2 = this._friendRequests.vipLimit;
            }
            else {
                if (this._sessionData.hasUserRight("fuse_extended_buddylist", HabboClubLevelEnum._SafeStr_3943)){
                    _local_2 = this._friendRequests.clubLimit;
                };
            };
            if (_local_2 > this._friendRequests.limit){
                this._friendRequests.limit = _local_2;
            };
        }
        public function avatarImageReady(_arg_1:String):void
        {
            var _local_3:Friend;
            var _local_4:IWindowContainer;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:BitmapData;
            if (((disposed) || ((this._categories == null)))){
                return;
            };
            var _local_2:Dictionary = this._categories.getAllFriends();
            if (_local_2 == null){
                return;
            };
            for each (_local_3 in _local_2) {
                if (((((!((_local_3 == null))) && (!(_local_3.disposed)))) && ((_local_3.figure == _arg_1)))){
                    _local_3.face = this.getAvatarFaceBitmap(_local_3.figure);
                    if (_local_3.face != null){
                        _local_4 = _local_3.view;
                        if (_local_4 != null){
                            _local_5 = (_local_4.getChildByName(_SafeStr_11259) as IBitmapWrapperWindow);
                            if (((!((_local_5 == null))) && (!(_local_5.disposed)))){
                                _local_6 = _local_5.bitmap;
                                if (_local_6 != null){
                                    _local_6.fillRect(_local_6.rect, 0);
                                    _local_6.copyPixels(_local_3.face, _local_3.face.rect, new Point(0, 0), null, null, true);
                                };
                                _local_5.invalidate();
                            };
                        };
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.friendlist

// IID = "_-3KV" (String#7712, DoABC#2)
// onUserRights = "_-36C" (String#632, DoABC#2)
// _sessionData = "_-2Bw" (String#1831, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// senderName = "_-1WP" (String#17758, DoABC#2)
// _friendRequests = "_-Sv" (String#8266, DoABC#2)
// openFriendRequests = "_-20l" (String#6059, DoABC#2)
// onFriendListUpdate = "_-2UT" (String#1887, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// _HabboSoundManagerFlash10 = "_-ef" (String#940, DoABC#2)
// _SafeStr_11072 = "_-2PE" (String#1873, DoABC#2)
// clearAndUpdateView = "_-3Bm" (String#21952, DoABC#2)
// acceptFailed = "_-1xS" (String#18867, DoABC#2)
// addRequestAndUpdateView = "_-2Pi" (String#20032, DoABC#2)
// vipLimit = "_-2S5" (String#20123, DoABC#2)
// _SafeStr_11144 = "_-0De" (String#14594, DoABC#2)
// _SafeStr_11145 = "_-1wt" (String#18841, DoABC#2)
// _view = "_-01Y" (String#14113, DoABC#2)
// tabView = "_-1CV" (String#16966, DoABC#2)
// toggleSelected = "_-0OB" (String#14995, DoABC#2)
// findTab = "_-055" (String#14246, DoABC#2)
// findSelectedTab = "_-3KI" (String#22294, DoABC#2)
// searchReceived = "_-39d" (String#21867, DoABC#2)
// setFriendRequestSent = "_-1kf" (String#18315, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// isFriendRequestSent = "_-9L" (String#22593, DoABC#2)
// _SafeStr_11172 = "_-0UQ" (String#15220, DoABC#2)
// _SafeStr_11173 = "_-2kn" (String#20876, DoABC#2)
// getFriendCount = "_-1oZ" (String#5833, DoABC#2)
// setOpen = "_-1u7" (String#18721, DoABC#2)
// getAllFriends = "_-An" (String#22647, DoABC#2)
// addCategory = "_-2MM" (String#19899, DoABC#2)
// findFriend = "_-1KM" (String#17288, DoABC#2)
// arrayToString = "_-20L" (String#19026, DoABC#2)
// acceptAllRequests = "_-3H1" (String#7647, DoABC#2)
// declineAllRequests = "_-0hJ" (String#4453, DoABC#2)
// trackFriendListEvent = "_-1w6" (String#18802, DoABC#2)
// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// friendRequests = "_-cP" (String#23730, DoABC#2)
// laf = "_-07z" (String#14364, DoABC#2)
// refreshIcon = "_-3EX" (String#7603, DoABC#2)
// showLimitReachedAlert = "_-1Mi" (String#17389, DoABC#2)
// searchResults = "_-1H2" (String#17153, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// isEmbeddedMinimailEnabled = "_-2F1" (String#19604, DoABC#2)
// openFriendSearch = "_-yV" (String#8846, DoABC#2)
// _laf = "_-27i" (String#19319, DoABC#2)
// _searchResults = "_-G3" (String#22855, DoABC#2)
// _SafeStr_11313 = "_-2WC" (String#20291, DoABC#2)
// HabboUserDefinedRoomEvents = "_-1hF" (String#443, DoABC#2)
// sendFriendListUpdate = "_-fu" (String#23886, DoABC#2)
// getVariable = "_-0xX" (String#4801, DoABC#2)
// openFriendListWithTab = "_-36V" (String#21747, DoABC#2)
// onMessengerComponentInit = "_-2Xu" (String#20354, DoABC#2)
// onAvatarRenderedReady = "_-NF" (String#8149, DoABC#2)
// HabboSoundManagerFlash10 = "_-AF" (String#2065, DoABC#2)
// onAuthOK = "_-lL" (String#2177, DoABC#2)
// onUserObject = "_-2A9" (String#617, DoABC#2)
// onSessionDataReady = "_-0J8" (String#3937, DoABC#2)
// onMessengerInit = "_-iQ" (String#8566, DoABC#2)
// getSortedFriends = "_-ts" (String#24442, DoABC#2)
// getBuddyRequests = "_-fL" (String#23862, DoABC#2)
// registerListeners = "_-24Z" (String#19204, DoABC#2)
// onFollowFriendFailed = "_-ES" (String#22791, DoABC#2)
// onBuddyRequests = "_-0zk" (String#16416, DoABC#2)
// onNewBuddyRequest = "_-0M-" (String#14914, DoABC#2)
// onAcceptBuddyResult = "_-1m0" (String#18378, DoABC#2)
// onMessengerError = "_-2PY" (String#20026, DoABC#2)
// onHabboSearchResult = "_-1vD" (String#18766, DoABC#2)
// onRoomInviteError = "_-04D" (String#14211, DoABC#2)
// getFollowFriendErrorText = "_-Fy" (String#22850, DoABC#2)
// HabboUserDefinedRoomEvents = "_-08W" (String#807, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IFriend = "_-2ET" (String#6332, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// MessengerInitEvent = "_-0pu" (String#4632, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// MessengerErrorMessageParser = "_-9x" (String#7864, DoABC#2)
// MessengerInitMessageComposer = "_-1gx" (String#18174, DoABC#2)
// BuddyRequestsMessageParser = "_-39D" (String#7495, DoABC#2)
// FriendRequests = "_-0Cf" (String#14555, DoABC#2)
// FriendRequestQuestCompleteMessageComposer = "_-3LQ" (String#22344, DoABC#2)
// FriendListTab = "_-Df" (String#7944, DoABC#2)
// FriendListTabs = "_-2a0" (String#6759, DoABC#2)
// GetBuddyRequestsMessageComposer = "_-03p" (String#14195, DoABC#2)
// FriendListTabsDeps = "_-2Nu" (String#6519, DoABC#2)
// FollowFriendFailedMessageParser = "_-0Sn" (String#4155, DoABC#2)
// FollowFriendFailedEvent = "_-1bO" (String#5583, DoABC#2)
// BuddyRequestsEvent = "_-2y" (String#7239, DoABC#2)
// FriendRequestData = "_-1aw" (String#17931, DoABC#2)
// NewBuddyRequestEvent = "_-1iS" (String#5721, DoABC#2)
// RoomInviteErrorEvent = "_-vN" (String#24504, DoABC#2)
// RoomInviteErrorMessageParser = "_-1Fp" (String#5168, DoABC#2)
// MessengerInitMessageParser = "_-1W5" (String#5474, DoABC#2)
// FriendCategoriesDeps = "_-1Vp" (String#5469, DoABC#2)
// FriendRequestsDeps = "_-0JU" (String#3943, DoABC#2)
// AvatarSearchResults = "_-2jF" (String#20813, DoABC#2)
// AcceptBuddyFailureData = "_-06x" (String#14321, DoABC#2)
// FriendCategoryData = "_-1Pd" (String#5346, DoABC#2)
// NewBuddyRequestMessageParser = "_-2Qd" (String#6572, DoABC#2)
// FriendCategory = "_-3FV" (String#7619, DoABC#2)
// IFriendRequestsView = "_-0Uk" (String#4198, DoABC#2)
// FriendData = "_-XR" (String#23541, DoABC#2)
// FriendListUpdateMessageComposer = "_-yk" (String#24641, DoABC#2)
// HabboSearchResultMessageParser = "_-2vu" (String#7199, DoABC#2)
// HabboSearchResultEvent = "_-20z" (String#6063, DoABC#2)
// AcceptBuddyResultMessageParser = "_-2AZ" (String#6257, DoABC#2)
// AcceptBuddyResultEvent = "_-32P" (String#7356, DoABC#2)
// MessengerErrorEvent = "_-2EF" (String#19577, DoABC#2)
// AvatarSearchDeps = "_-yr" (String#8857, DoABC#2)
// FriendListUpdateEvent = "_-l9" (String#8629, DoABC#2)
// RequestBuddyMessageComposer = "_-2QG" (String#20057, DoABC#2)
// FriendListLookAndFeel = "_-Qu" (String#23281, DoABC#2)
// FriendRequest = "_-2Nq" (String#887, DoABC#2)
// OpenedToWebPopup = "_-RA" (String#8230, DoABC#2)
// FriendListView = "_-1CA" (String#5113, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// _SafeStr_3939 = "_-2gR" (String#20706, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// tabs = "_-2Gc" (String#19666, DoABC#2)
// IssueBrowser = "_-2i4" (String#897, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// _avatarId = "_-0qk" (String#592, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// clientMessageId = "_-2xZ" (String#21376, DoABC#2)
// reqs = "_-31c" (String#21563, DoABC#2)
// failedRecipients = "_-X3" (String#23524, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// userFriendLimit = "_-N8" (String#23129, DoABC#2)
// extendedFriendLimit = "_-0uU" (String#16220, DoABC#2)
// friends = "_-10-" (String#16467, DoABC#2)
// evenMoreExtendedFriendLimit = "_-1AA" (String#16865, DoABC#2)
// req = "_-8J" (String#22555, DoABC#2)
// others = "_-224" (String#19094, DoABC#2)
// failures = "_-sX" (String#24379, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// setNewMessageArrived = "_-0rH" (String#4668, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// addRequest = "_-2i" (String#1927, DoABC#2)
// acceptRequest = "_-3CU" (String#7565, DoABC#2)
// declineRequest = "_-1A2" (String#5078, DoABC#2)
// _SafeStr_6022 = "_-1t4" (String#18679, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// getButton = "_-1sK" (String#18645, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// HabboFriendList = "_-3BP" (String#7538, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboMessenger = "_-0EF" (String#3832, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// askForAFriend = "_-3Iw" (String#7688, DoABC#2)
// canBeAskedForAFriend = "_-di" (String#8480, DoABC#2)
// getFriend = "_-WG" (String#8329, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// IHabboFriendList = "_-29N" (String#6237, DoABC#2)
// _tabs = "_-0QO" (String#585, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


