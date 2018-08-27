
package com.sulake.habbo.session
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.window.IHabboWindowManager;
    import flash.utils.Dictionary;
    import com.sulake.habbo.session.product.ProductDataParser;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.session.furniture.FurnitureDataParser;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.session.facebook.FaceBookSession;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.availability.AvailabilityStatusMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.pets.PetRespectFailedEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.session.furniture.IFurniDataListener;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
    import com.sulake.habbo.session.events.HabboSessionFigureUpdatedEvent;
    import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
    import com.sulake.habbo.session.events.UserNameUpdateEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.parser.availability.AvailabilityStatusMessageParser;
    import flash.display.BitmapData;
    import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.room.pets.RespectPetMessageComposer;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.habbo.window.utils.IConfirmDialog;
    import com.sulake.habbo.session.product.IProductDataListener;
    import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.room.chat.ChatMessageComposer;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.iid.*;

    public class SessionDataManager extends Component implements ISessionDataManager 
    {

        private var _communication:IHabboCommunicationManager;
        private var _windowManager:IHabboWindowManager;
        private var _roomSessionManager:IRoomSessionManager;
        private var _id:int;
        private var _name:String;
        private var _figure:String;
        private var _gender:String;
        private var _realName:String;
        private var _respectTotal:int = 0;
        private var _respectLeft:int = 0;
        private var _petRespectLeft:int = 0;
        private var _SafeStr_13674:Array;
        private var _systemOpen:Boolean;
        private var _systemShutDown:Boolean;
        private var _products:Dictionary;
        private var _SafeStr_13677:ProductDataParser;
        private var _SafeStr_8133:Map;
        private var _wallItems:Map;
        private var _SafeStr_13678:Map;
        private var _SafeStr_13679:FurnitureDataParser;
        private var _SafeStr_13680:UserTagManager;
        private var _SafeStr_13681:BadgeImageManager;
        private var _SafeStr_13682:HabboGroupInfoManager;
        private var _SafeStr_13683:IgnoredUsersManager;
        private var _configuration:IHabboConfigurationManager;
        private var _localization:IHabboLocalizationManager;
        private var _SafeStr_13684:Boolean = false;
        private var _SafeStr_13685:Array;
        private var _SafeStr_13686:Array;
        private var _clubLevel:int;
        private var _securityLevel:int;
        private var _SafeStr_13687:FaceBookSession;

        public function SessionDataManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_13674 = [];
            this._SafeStr_13680 = new UserTagManager(events);
            this._SafeStr_13682 = new HabboGroupInfoManager(this, events);
            this._SafeStr_13683 = new IgnoredUsersManager(this);
            this._SafeStr_13687 = new FaceBookSession();
            this._products = new Dictionary();
            this._SafeStr_13685 = [];
            this._SafeStr_13686 = [];
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onHabboCommunicationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
        }
        override public function dispose():void
        {
            if (this._SafeStr_8133){
                this._SafeStr_8133.dispose();
                this._SafeStr_8133 = null;
            };
            if (this._SafeStr_13678){
                this._SafeStr_13678.dispose();
                this._SafeStr_13678 = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._roomSessionManager){
                this._roomSessionManager.release(new IIDHabboRoomSessionManager());
                this._roomSessionManager = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            this._SafeStr_13686 = null;
            if (this._SafeStr_13679){
                this._SafeStr_13679.removeEventListener(FurnitureDataParser._localization, this.onFurnitureReady);
                this._SafeStr_13679.dispose();
                this._SafeStr_13679 = null;
            };
            if (this._SafeStr_13677){
                this._SafeStr_13677.removeEventListener(ProductDataParser._localization, this.onProductsReady);
                this._SafeStr_13677.dispose();
                this._SafeStr_13677 = null;
            };
            if (this._SafeStr_13687){
                this._SafeStr_13687.dispose();
                this._SafeStr_13687 = null;
            };
            super.dispose();
        }
        private function initBadgeImageManager():void
        {
            if (this._SafeStr_13681 != null){
                return;
            };
            if ((((this._configuration == null)) || ((this._localization == null)))){
                return;
            };
            this._SafeStr_13681 = new BadgeImageManager(assets, events, this._configuration, this._localization);
        }
        private function onWindowManagerReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        private function onHabboCommunicationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._communication = (_arg_2 as IHabboCommunicationManager);
            if (this._communication == null){
                return;
            };
            this._communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(this.onUserRights));
            this._communication.addHabboConnectionMessageEvent(new UserObjectEvent(this.onUserObject));
            this._communication.addHabboConnectionMessageEvent(new UserChangeMessageEvent(this.onUserChange));
            this._communication.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(this.onUserNameChange));
            this._communication.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(this.onChangeUserNameResult));
            this._communication.addHabboConnectionMessageEvent(new AvailabilityStatusMessageEvent(this.onAvailabilityStatus));
            this._communication.addHabboConnectionMessageEvent(new PetRespectFailedEvent(this.onPetRespectFailed));
            this._communication.addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(this.onAuthenticationOK));
            this._communication.addHabboConnectionMessageEvent((new RoomReadyMessageEvent(this.onRoomReady) as IMessageEvent));
            this._SafeStr_13680.communication = this._communication;
            this._SafeStr_13682.communication = this._communication;
            this._SafeStr_13687.communication = this._communication;
            this._SafeStr_13683.registerMessageEvents();
        }
        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            var _local_3:String;
            if (_arg_2 == null){
                return;
            };
            this._configuration = (_arg_2 as IHabboConfigurationManager);
            this.initBadgeImageManager();
            if (!this._SafeStr_13679){
                this._SafeStr_8133 = new Map();
                this._wallItems = new Map();
                this._SafeStr_13678 = new Map();
                this._SafeStr_13679 = new FurnitureDataParser(this._SafeStr_8133, this._wallItems, this._SafeStr_13678, this._localization);
                this._SafeStr_13679.addEventListener(FurnitureDataParser._localization, this.onFurnitureReady);
                if (this._configuration.keyExists("furnidata.load.url")){
                    _local_3 = this._configuration.getKey("furnidata.load.url");
                    this._SafeStr_13679.loadData(_local_3);
                };
            };
        }
        private function onLocalizationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            if (_arg_2 == null){
                return;
            };
            this._localization = (_arg_2 as IHabboLocalizationManager);
            this.initBadgeImageManager();
            if (this._SafeStr_13679){
                this._SafeStr_13679.localization = this._localization;
                this._SafeStr_13679.registerFurnitureLocalizations();
            };
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._roomSessionManager = (_arg_2 as IRoomSessionManager);
        }
        private function onFurnitureReady(_arg_1:Event=null):void
        {
            var _local_2:IFurniDataListener;
            this._SafeStr_13679.removeEventListener(FurnitureDataParser._localization, this.onFurnitureReady);
            for each (_local_2 in this._SafeStr_13686) {
                _local_2.furniDataReady();
            };
            this._SafeStr_13686 = [];
        }
        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:UserRightsMessageEvent = UserRightsMessageEvent(_arg_1);
            this._clubLevel = _local_2.clubLevel;
            this._securityLevel = _local_2.securityLevel;
        }
        private function onUserObject(_arg_1:IMessageEvent):void
        {
            var _local_2:UserObjectEvent = (_arg_1 as UserObjectEvent);
            var _local_3:UserObjectMessageParser = _local_2.getParser();
            this._id = _local_3.id;
            this._name = _local_3.name;
            this._respectTotal = _local_3.respectTotal;
            this._respectLeft = _local_3.respectLeft;
            this._petRespectLeft = _local_3.petRespectLeft;
            this._figure = _local_3.figure;
            this._gender = _local_3.sex;
            this._realName = _local_3.realName;
            this._SafeStr_13683.initIgnoreList();
        }
        private function onUserChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserChangeMessageEvent = (_arg_1 as UserChangeMessageEvent);
            if (_local_2 == null){
                return;
            };
            if (_local_2.id == -1){
                this._figure = _local_2.figure;
                this._gender = _local_2.sex;
                events.dispatchEvent(new HabboSessionFigureUpdatedEvent(this._id, this._figure, this._gender));
            };
        }
        private function onUserNameChange(_arg_1:IMessageEvent):void
        {
            var _local_2:UserNameChangedMessageEvent = (_arg_1 as UserNameChangedMessageEvent);
            if ((((_local_2 == null)) || ((_local_2.getParser() == null)))){
                return;
            };
            var _local_3:UserNameChangedMessageParser = _local_2.getParser();
            if (_local_3.webId == this._id){
                this._name = _local_3.newName;
                events.dispatchEvent(new UserNameUpdateEvent(this._name));
            };
        }
        private function onChangeUserNameResult(_arg_1:ChangeUserNameResultMessageEvent):void
        {
            var _local_2:ChangeUserNameResultMessageParser = _arg_1.getParser();
            if (_local_2.resultCode == ChangeUserNameResultMessageEvent._SafeStr_7096){
                events.dispatchEvent(new UserNameUpdateEvent(_local_2.name));
            };
        }
        private function onAvailabilityStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:AvailabilityStatusMessageParser = (_arg_1 as AvailabilityStatusMessageEvent).getParser();
            if (_local_2 == null){
                return;
            };
            this._systemOpen = _local_2.isOpen;
            this._systemShutDown = _local_2.onShutDown;
        }
        private function onPetRespectFailed(_arg_1:PetRespectFailedEvent):void
        {
            if (_arg_1 == null){
                return;
            };
            this._petRespectLeft++;
        }
        private function onAuthenticationOK(_arg_1:IMessageEvent):void
        {
            this.loadProductData();
        }
        public function get systemOpen():Boolean
        {
            return (this._systemOpen);
        }
        public function get systemShutDown():Boolean
        {
            return (this._systemShutDown);
        }
        public function hasSecurity(_arg_1:int):Boolean
        {
            return ((this._securityLevel >= _arg_1));
        }
        public function hasUserRight(_arg_1:String, _arg_2:int):Boolean
        {
            return ((this._clubLevel >= _arg_2));
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }
        public function get userId():int
        {
            return (this._id);
        }
        public function get userName():String
        {
            return (this._name);
        }
        public function get realName():String
        {
            return (this._realName);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get isAnyRoomController():Boolean
        {
            return ((this._securityLevel >= SecurityLevelEnum._SafeStr_11990));
        }
        public function getUserTags(_arg_1:int):Array
        {
            return (this._SafeStr_13680.getTags(_arg_1));
        }
        public function getBadgeImage(_arg_1:String):BitmapData
        {
            return (this._SafeStr_13681.getBadgeImage(_arg_1));
        }
        public function requestBadgeImage(_arg_1:String):BitmapData
        {
            return (this._SafeStr_13681.getBadgeImage(_arg_1, BadgeImageManager._SafeStr_13617, false));
        }
        public function getBadgeImageWithInfo(_arg_1:String):BadgeInfo
        {
            return (this._SafeStr_13681.getBadgeImageWithInfo(_arg_1));
        }
        public function showGroupBadgeInfo(_arg_1:int):void
        {
            if (this._configuration.getKey("groupBadgeInfo.enabled") == "false"){
                this._windowManager.alert("${group.inconstruction.title}", "${group.inconstruction.desc}", 0, this.onAlertClose);
            }
            else {
                this.send(new GetHabboGroupDetailsMessageComposer(_arg_1));
            };
            this.send(new EventLogMessageComposer(GroupDetailsView._SafeStr_13629, ("" + _arg_1), "badge clicked"));
        }
        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        public function getGroupBadgeId(_arg_1:int):String
        {
            return (this._SafeStr_13682.getBadgeId(_arg_1));
        }
        public function send(_arg_1:IMessageComposer):void
        {
            this._communication.getHabboMainConnection(null).send(_arg_1);
        }
        public function getGroupBadgeImage(_arg_1:String):BitmapData
        {
            return (this._SafeStr_13681.getBadgeImage(_arg_1, BadgeImageManager._SafeStr_13616));
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function isIgnored(_arg_1:String):Boolean
        {
            return (this._SafeStr_13683.isIgnored(_arg_1));
        }
        public function ignoreUser(_arg_1:String):void
        {
            this._SafeStr_13683.ignoreUser(_arg_1);
        }
        public function unignoreUser(_arg_1:String):void
        {
            this._SafeStr_13683.unignoreUser(_arg_1);
        }
        public function get respectLeft():int
        {
            return (this._respectLeft);
        }
        public function get petRespectLeft():int
        {
            return (this._petRespectLeft);
        }
        public function giveRespect(_arg_1:int):void
        {
            if ((((_arg_1 < 0)) || ((this._respectLeft < 1)))){
                throw (new Error(("Failed to give respect to user: " + _arg_1)));
            };
            this.send(new RespectUserMessageComposer(_arg_1));
            this._respectLeft = (this._respectLeft - 1);
        }
        public function givePetRespect(_arg_1:int):void
        {
            if ((((_arg_1 < 0)) || ((this._petRespectLeft < 1)))){
                throw (new Error(("Failed to give respect to pet: " + _arg_1)));
            };
            this.send(new RespectPetMessageComposer(_arg_1));
            this._petRespectLeft = (this._petRespectLeft - 1);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function getProductData(_arg_1:String):IProductData
        {
            if (!this._SafeStr_13684){
                this.loadProductData();
            };
            return (this._products[_arg_1]);
        }
        public function getFloorItemData(_arg_1:int):IFurnitureData
        {
            if (this._SafeStr_8133 == null){
                return (null);
            };
            return (this._SafeStr_8133.getValue(_arg_1.toString()));
        }
        public function getWallItemData(_arg_1:int):IFurnitureData
        {
            if (this._wallItems == null){
                return (null);
            };
            return (this._wallItems.getValue(_arg_1.toString()));
        }
        public function getFloorItemDataByName(_arg_1:String, _arg_2:int=0):IFurnitureData
        {
            var _local_4:int;
            if (this._SafeStr_13678 == null){
                return (null);
            };
            var _local_3:Array = this._SafeStr_13678.getValue(_arg_1);
            if (((!((_local_3 == null))) && ((_arg_2 <= (_local_3.length - 1))))){
                _local_4 = _local_3[_arg_2];
                return (this.getFloorItemData(_local_4));
            };
            return (null);
        }
        public function getWallItemDataByName(_arg_1:String, _arg_2:int=0):IFurnitureData
        {
            var _local_4:int;
            if (this._SafeStr_13678 == null){
                return (null);
            };
            var _local_3:Array = this._SafeStr_13678.getValue(_arg_1);
            if (((!((_local_3 == null))) && ((_arg_2 <= (_local_3.length - 1))))){
                _local_4 = _local_3[_arg_2];
                return (this.getWallItemData(_local_4));
            };
            return (null);
        }
        public function openHabboHomePage(userId:int):void
        {
            var urlString:String;
            if (this._configuration != null){
                urlString = this._configuration.getKey("link.format.userpage");
                urlString = urlString.replace("%ID%", String(userId));
                try {
                    HabboWebTools.navigateToURL(urlString, "habboMain");
                }
                catch(e:Error) {
                    Logger.log("Error occurred!");
                };
            };
        }
        public function pickAllFurniture(roomId:int, roomCategory:int):void
        {
            if ((((this._roomSessionManager == null)) || ((this._windowManager == null)))){
                return;
            };
            var session:IRoomSession = this._roomSessionManager.getSession(roomId, roomCategory);
            if (session == null){
                return;
            };
            if (((session.isRoomOwner) || (this.isAnyRoomController))){
                this._windowManager.confirm("${generic.alert.title}", "${room.confirm.pick_all}", 0, function (_arg_1:IConfirmDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                    if (_arg_2.type == WindowEvent.WE_OK){
                        sendPickAllFurnitureMessage();
                    };
                });
            };
        }
        public function loadProductData(_arg_1:IProductDataListener=null):Boolean
        {
            var _local_2:String;
            if (this._SafeStr_13684){
                return (true);
            };
            if (((_arg_1) && ((this._SafeStr_13685.indexOf(_arg_1) == -1)))){
                this._SafeStr_13685.push(_arg_1);
            };
            if (!this._configuration){
                return (false);
            };
            if (this._SafeStr_13677 == null){
                _local_2 = this._configuration.getKey("productdata.load.url");
                this._SafeStr_13677 = new ProductDataParser(_local_2, this._products);
                this._SafeStr_13677.addEventListener(ProductDataParser._localization, this.onProductsReady);
            };
            return (false);
        }
        private function onProductsReady(_arg_1:Event):void
        {
            var _local_2:IProductDataListener;
            this._SafeStr_13677.removeEventListener(ProductDataParser._localization, this.onProductsReady);
            this._SafeStr_13684 = true;
            for each (_local_2 in this._SafeStr_13685) {
                if (((!((_local_2 == null))) && (!(_local_2.disposed)))){
                    _local_2.productDataReady();
                };
            };
            this._SafeStr_13685 = [];
        }
        private function onRoomReady(_arg_1:IMessageEvent):void
        {
            var _local_2:RoomReadyMessageEvent = (_arg_1 as RoomReadyMessageEvent);
            if ((((((_local_2 == null)) || ((_local_2.getParser() == null)))) || ((_arg_1.connection == null)))){
                return;
            };
            var _local_3:RoomReadyMessageParser = _local_2.getParser();
            HabboWebTools.roomVisited(_local_3.roomId);
        }
        private function sendPickAllFurnitureMessage():void
        {
            this.send(new ChatMessageComposer(":pickall"));
        }
        public function get roomSessionManager():IRoomSessionManager
        {
            return (this._roomSessionManager);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function getFurniData(_arg_1:IFurniDataListener):Array
        {
            if (this._SafeStr_8133.length == 0){
                if (this._SafeStr_13686.indexOf(_arg_1) == -1){
                    this._SafeStr_13686.push(_arg_1);
                };
                return (null);
            };
            var _local_2:Array = this._SafeStr_8133.getValues();
            return (_local_2.concat(this._wallItems.getValues()));
        }
        public function getXmlWindow(name:String):IWindow
        {
            var asset:IAsset;
            var xmlAsset:XmlAsset;
            var window:IWindow;
            try {
                asset = assets.getAssetByName(name);
                xmlAsset = XmlAsset(asset);
                window = this._windowManager.buildFromXML(XML(xmlAsset.content));
            }
            catch(e:Error) {
            };
            return (window);
        }
        public function getButtonImage(_arg_1:String):BitmapData
        {
            var _local_2:String = _arg_1;
            var _local_3:IAsset = assets.getAssetByName(_local_2);
            var _local_4:BitmapDataAsset = BitmapDataAsset(_local_3);
            var _local_5:BitmapData = BitmapData(_local_4.content);
            var _local_6:BitmapData = new BitmapData(_local_5.width, _local_5.height, true, 0);
            _local_6.draw(_local_5);
            return (_local_6);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }

    }
}//package com.sulake.habbo.session

// IID = "_-3KV" (String#7712, DoABC#2)
// onUserRights = "_-36C" (String#632, DoABC#2)
// _roomSessionManager = "_-2nJ" (String#249, DoABC#2)
// loadProductData = "_-0cU" (String#4353, DoABC#2)
// keyExists = "_-2ME" (String#6487, DoABC#2)
// onAuthenticationOK = "_-20A" (String#612, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// onUserObject = "_-2A9" (String#617, DoABC#2)
// onChangeUserNameResult = "_-06v" (String#1405, DoABC#2)
// onAlertClose = "_-34G" (String#309, DoABC#2)
// _SafeStr_11990 = "_-1wS" (String#18819, DoABC#2)
// onPetRespectFailed = "_-38M" (String#7479, DoABC#2)
// getBadgeImageWithInfo = "_-0SD" (String#4143, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// IProductData = "_-0jc" (String#4494, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// PetRespectFailedEvent = "_-1Pw" (String#17506, DoABC#2)
// getFurniData = "_-07h" (String#3715, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// systemOpen = "_-10P" (String#4880, DoABC#2)
// getFloorItemDataByName = "_-0y8" (String#4814, DoABC#2)
// getWallItemDataByName = "_-2ne" (String#7033, DoABC#2)
// _SafeStr_13616 = "_-26w" (String#19289, DoABC#2)
// _SafeStr_13617 = "_-0BM" (String#14499, DoABC#2)
// _SafeStr_13629 = "_-0RY" (String#15122, DoABC#2)
// registerMessageEvents = "_-do" (String#23792, DoABC#2)
// initIgnoreList = "_-xQ" (String#24586, DoABC#2)
// getTags = "_-f" (String#23844, DoABC#2)
// _SafeStr_13674 = "_-1vH" (String#18768, DoABC#2)
// _systemOpen = "_-0UA" (String#15211, DoABC#2)
// _systemShutDown = "_-ZX" (String#23617, DoABC#2)
// _SafeStr_13677 = "_-6R" (String#22481, DoABC#2)
// _SafeStr_13678 = "_-62" (String#22468, DoABC#2)
// _SafeStr_13679 = "_-0tp" (String#16196, DoABC#2)
// _SafeStr_13680 = "_-t" (String#24404, DoABC#2)
// _SafeStr_13681 = "_-bm" (String#23704, DoABC#2)
// _SafeStr_13682 = "_-1zF" (String#18937, DoABC#2)
// _SafeStr_13683 = "_-2B7" (String#19449, DoABC#2)
// _SafeStr_13684 = "_-1VT" (String#17719, DoABC#2)
// _SafeStr_13685 = "_-1a2" (String#17895, DoABC#2)
// _SafeStr_13686 = "_-06F" (String#14295, DoABC#2)
// _SafeStr_13687 = "_-0cJ" (String#15526, DoABC#2)
// onHabboCommunicationReady = "_-1KZ" (String#17296, DoABC#2)
// onFurnitureReady = "_-rD" (String#24324, DoABC#2)
// onProductsReady = "_-2rR" (String#21135, DoABC#2)
// initBadgeImageManager = "_-2xW" (String#21373, DoABC#2)
// onAvailabilityStatus = "_-2f4" (String#20648, DoABC#2)
// sendPickAllFurnitureMessage = "_-0K2" (String#14844, DoABC#2)
// IConfirmDialog = "_-35c" (String#7421, DoABC#2)
// IProductDataListener = "_-0H" (String#3894, DoABC#2)
// IFurniDataListener = "_-02J" (String#3612, DoABC#2)
// BadgeInfo = "_-3V" (String#7736, DoABC#2)
// RespectPetMessageComposer = "_-13h" (String#16606, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// GetHabboGroupDetailsMessageComposer = "_-1BD" (String#16906, DoABC#2)
// BadgeImageManager = "_-1l8" (String#18336, DoABC#2)
// RespectUserMessageComposer = "_-7y" (String#22542, DoABC#2)
// ChatMessageComposer = "_-Fl" (String#22841, DoABC#2)
// FaceBookSession = "_-32h" (String#21605, DoABC#2)
// ProductDataParser = "_-aW" (String#23653, DoABC#2)
// ChangeUserNameResultMessageParser = "_-9" (String#22578, DoABC#2)
// ChangeUserNameResultMessageEvent = "_-3HW" (String#22180, DoABC#2)
// HabboGroupInfoManager = "_-1EL" (String#5150, DoABC#2)
// GroupDetailsView = "_-7M" (String#7812, DoABC#2)
// UserNameUpdateEvent = "_-1FC" (String#17079, DoABC#2)
// UserObjectMessageParser = "_-04X" (String#14223, DoABC#2)
// UserChangeMessageEvent = "_-a9" (String#23638, DoABC#2)
// IgnoredUsersManager = "_-00Q" (String#3572, DoABC#2)
// UserTagManager = "_-2D" (String#19521, DoABC#2)
// RoomReadyMessageEvent = "_-1uW" (String#5930, DoABC#2)
// FurnitureDataParser = "_-06k" (String#14315, DoABC#2)
// UserNameChangedMessageParser = "_-1TI" (String#17637, DoABC#2)
// HabboSessionFigureUpdatedEvent = "_-1Yz" (String#17851, DoABC#2)
// UserNameChangedMessageEvent = "_-1J2" (String#17238, DoABC#2)
// UserObjectEvent = "_-1HL" (String#17163, DoABC#2)
// AvailabilityStatusMessageEvent = "_-09L" (String#14423, DoABC#2)
// AvailabilityStatusMessageParser = "_-h8" (String#23936, DoABC#2)
// SecurityLevelEnum = "_-2xM" (String#21364, DoABC#2)
// RoomReadyMessageParser = "_-1zm" (String#18958, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// sex = "_-0tG" (String#4712, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// _respectTotal = "_-00y" (String#1384, DoABC#2)
// _respectLeft = "_-1Pr" (String#853, DoABC#2)
// _petRespectLeft = "_-36a" (String#913, DoABC#2)
// realName = "_-3HH" (String#922, DoABC#2)
// respectTotal = "_-3KU" (String#22304, DoABC#2)
// respectLeft = "_-2Yo" (String#6743, DoABC#2)
// petRespectLeft = "_-0wV" (String#4782, DoABC#2)
// _securityLevel = "_-0wx" (String#4790, DoABC#2)
// isOpen = "_-2i4" (String#897, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// addHabboConnectionMessageEvent = "_-0r" (String#4663, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// roomVisited = "_-1bz" (String#17970, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// _products = "_-f0" (String#640, DoABC#2)
// productDataReady = "_-0HL" (String#3901, DoABC#2)
// _localization = "_-1" (String#16427, DoABC#2)
// webId = "_-27Z" (String#19314, DoABC#2)
// newName = "_-2Fm" (String#19634, DoABC#2)
// onUserChange = "_-0uf" (String#827, DoABC#2)
// onUserNameChange = "_-37e" (String#2005, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// onRoomReady = "_-0KO" (String#583, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// isIgnored = "_-0NV" (String#4031, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_7096 = "_-OP" (String#23184, DoABC#2)
// hasSecurity = "_-0x9" (String#4794, DoABC#2)
// pickAllFurniture = "_-1Q1" (String#5353, DoABC#2)
// getFloorItemData = "_-08L" (String#3728, DoABC#2)
// getWallItemData = "_-Hc" (String#8029, DoABC#2)
// roomSessionManager = "_-1bj" (String#5594, DoABC#2)
// givePetRespect = "_-0Gq" (String#3891, DoABC#2)
// ignoreUser = "_-2nM" (String#7029, DoABC#2)
// unignoreUser = "_-2jq" (String#6950, DoABC#2)
// openHabboHomePage = "_-25Y" (String#6152, DoABC#2)
// showGroupBadgeInfo = "_-1Qo" (String#1680, DoABC#2)
// getBadgeImage = "_-3DK" (String#7581, DoABC#2)
// systemShutDown = "_-0D0" (String#3809, DoABC#2)
// getUserTags = "_-cs" (String#8469, DoABC#2)
// getGroupBadgeId = "_-3Cg" (String#2022, DoABC#2)
// getGroupBadgeImage = "_-KC" (String#2087, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// furniDataReady = "_-1V2" (String#5456, DoABC#2)
// _SafeStr_8133 = "_-0VO" (String#4213, DoABC#2)
// loadData = "_-lE" (String#24078, DoABC#2)
// registerFurnitureLocalizations = "_-2pu" (String#21078, DoABC#2)
// getBadgeId = "_-Jj" (String#22995, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// onShutDown = "_-2YQ" (String#20374, DoABC#2)
// WE_OK = "_-0UB" (String#15212, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


