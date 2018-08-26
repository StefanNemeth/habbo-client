
package com.sulake.habbo.inventory
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListInsertEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListRemoveEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniListUpdateEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.PostItPlacedEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgesEvent;
    import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgePointLimitsEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementsScoreEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAcceptEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAcceptParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingConfirmationEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingConfirmationParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingAlreadyOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingAlreadyOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCloseEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCloseParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingCompletedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingCompletedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingItemListEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingItemListParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingNotOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingNotOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOpenEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOpenParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingOtherNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingOtherNotAllowedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.TradingYouAreNotAllowedEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.trading.TradingYouAreNotAllowedParser;
    import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetAddedToInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetRemovedFromInventoryEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.pets.PetInventoryUpdatedEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceConfigurationEvent;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceCanMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceMakeOfferResult;
    import com.sulake.habbo.communication.messages.incoming.marketplace.MarketplaceItemStatsEvent;
    import com.sulake.habbo.communication.messages.incoming.catalog.NotEnoughBalanceMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.notifications.UnseenItemsEvent;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListParser;
    import com.sulake.habbo.inventory.furni.FurniModel;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListInsertParser;
    import com.sulake.habbo.inventory.items.IItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.furni.FurniData;
    import com.sulake.habbo.inventory.items.FloorItem;
    import com.sulake.habbo.inventory.items.WallItem;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.FurniListRemoveParser;
    import com.sulake.habbo.communication.messages.outgoing.inventory.furni.RequestFurniInventoryComposer;
    import com.sulake.habbo.inventory.enum.InventoryCategory;
    import com.sulake.habbo.communication.messages.parser.inventory.furni.PostItPlacedParser;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffect;
    import com.sulake.habbo.inventory.effects.Effect;
    import com.sulake.habbo.inventory.effects.EffectsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectsMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectAddedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectActivatedMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.avatareffect.AvatarEffectExpiredMessageParser;
    import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
    import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgesParser;
    import com.sulake.habbo.inventory.badges.BadgesModel;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgeAndPointLimit;
    import com.sulake.habbo.communication.messages.parser.inventory.badges.BadgePointLimitsParser;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.achievements.AchievementsScoreMessageParser;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.session.IRoomSession;
    import com.sulake.habbo.inventory.enum.InventorySubCategory;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.inventory.trading.TradingModel;
    import com.sulake.habbo.inventory.items.GroupItem;
    import com.sulake.habbo.communication.messages.incoming.inventory.trading.ItemDataStructure;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.inventory.enum.FurniCategory;
    import com.sulake.habbo.inventory.enum.FurniModelCategory;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetData;
    import com.sulake.habbo.inventory.pets.PetsModel;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetInventoryMessageParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetAddedToInventoryParser;
    import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;
    import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceConfigurationParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceCanMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceMakeOfferResultParser;
    import com.sulake.habbo.communication.messages.parser.marketplace.MarketplaceItemStatsParser;
    import com.sulake.habbo.communication.messages.parser.notifications.UnseenItemsParser;
    import com.sulake.habbo.communication.messages.outgoing.notifications.UnseenItemCategoryEnum;

    public class IncomingMessages 
    {

        private var _inventory:HabboInventory;
        private var _SafeStr_11604:IHabboCommunicationManager;

        public function IncomingMessages(_arg_1:HabboInventory)
        {
            this._inventory = _arg_1;
            this._SafeStr_11604 = this._inventory.communication;
            this._SafeStr_11604.HabboCommunicationManager(new FurniListEvent(this.onFurniList));
            this._SafeStr_11604.HabboCommunicationManager(new FurniListInsertEvent(this.onFurniListInsert));
            this._SafeStr_11604.HabboCommunicationManager(new FurniListRemoveEvent(this.onFurniListRemove));
            this._SafeStr_11604.HabboCommunicationManager(new FurniListUpdateEvent(this.onFurniListUpdate));
            this._SafeStr_11604.HabboCommunicationManager(new PostItPlacedEvent(this.onPostItPlaced));
            this._SafeStr_11604.HabboCommunicationManager(new AvatarEffectsMessageEvent(this.onAvatarEffects));
            this._SafeStr_11604.HabboCommunicationManager(new AvatarEffectActivatedMessageEvent(this.onAvatarEffectActivated));
            this._SafeStr_11604.HabboCommunicationManager(new AvatarEffectAddedMessageEvent(this.onAvatarEffectAdded));
            this._SafeStr_11604.HabboCommunicationManager(new AvatarEffectExpiredMessageEvent(this.onAvatarEffectExpired));
            this._SafeStr_11604.HabboCommunicationManager(new ScrSendUserInfoEvent(this.onClubStatus));
            this._SafeStr_11604.HabboCommunicationManager(new BadgesEvent(this.onBadges));
            this._SafeStr_11604.HabboCommunicationManager(new HabboUserBadgesMessageEvent(this.InfostandWidget));
            this._SafeStr_11604.HabboCommunicationManager(new HabboAchievementNotificationMessageEvent(this.onAchievementReceived));
            this._SafeStr_11604.HabboCommunicationManager(new BadgePointLimitsEvent(this._SafeStr_11616));
            this._SafeStr_11604.HabboCommunicationManager(new AchievementsScoreEvent(this.onAchievementsScore));
            this._SafeStr_11604.HabboCommunicationManager(new TradingAcceptEvent(this.onTradingAccepted, TradingAcceptParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingConfirmationEvent(this.onTradingConfirmation, TradingConfirmationParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingAlreadyOpenEvent(this.onTradingAlreadyOpen, TradingAlreadyOpenParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingCloseEvent(this.onTradingClose, TradingCloseParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingCompletedEvent(this.onTradingCompleted, TradingCompletedParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingItemListEvent(this.onTradingItemList, TradingItemListParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingNotOpenEvent(this.onTradingNotOpen, TradingNotOpenParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingOpenEvent(this.onTradingOpen, TradingOpenParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingOtherNotAllowedEvent(this.onTradingOtherNotAllowed, TradingOtherNotAllowedParser));
            this._SafeStr_11604.HabboCommunicationManager(new TradingYouAreNotAllowedEvent(this.onTradingYouAreNotAllowed, TradingYouAreNotAllowedParser));
            this._SafeStr_11604.HabboCommunicationManager(new OpenConnectionMessageEvent(this.onRoomClosed));
            this._SafeStr_11604.HabboCommunicationManager(new CloseConnectionMessageEvent(this.onRoomClosed));
            this._SafeStr_11604.HabboCommunicationManager(new FlatAccessDeniedMessageEvent(this.onRoomClosed));
            this._SafeStr_11604.HabboCommunicationManager(new PetInventoryEvent(this.onPets));
            this._SafeStr_11604.HabboCommunicationManager(new PetAddedToInventoryEvent(this.onPetAdded));
            this._SafeStr_11604.HabboCommunicationManager(new PetRemovedFromInventoryEvent(this.onPetRemoved));
            this._SafeStr_11604.HabboCommunicationManager(new PetInventoryUpdatedEvent(this.onPetInventoryUpdated));
            this._SafeStr_11604.HabboCommunicationManager(new MarketplaceConfigurationEvent(this.onMarketplaceConfiguration));
            this._SafeStr_11604.HabboCommunicationManager(new MarketplaceCanMakeOfferResult(this.onMarketplaceCanMakeOfferResult));
            this._SafeStr_11604.HabboCommunicationManager(new MarketplaceMakeOfferResult(this.onMarketplaceMakeOfferResult));
            this._SafeStr_11604.HabboCommunicationManager(new MarketplaceItemStatsEvent(this.onMarketplaceItemStats));
            this._SafeStr_11604.HabboCommunicationManager(new NotEnoughBalanceMessageEvent(this.onNotEnoughCredits));
            this._SafeStr_11604.HabboCommunicationManager(new UserRightsMessageEvent(this.onUserRights));
            this._SafeStr_11604.HabboCommunicationManager(new UnseenItemsEvent(this.onUnseenItems));
        }
        public function dispose():void
        {
            this._inventory = null;
            this._SafeStr_11604 = null;
        }
        private function getConnection():IConnection
        {
            if (this._SafeStr_11604 == null){
                return (null);
            };
            return (this._SafeStr_11604.HabboCommunicationManager(null));
        }
        public function onFurniList(_arg_1:IMessageEvent):void
        {
            var _local_2:FurniListParser = (_arg_1 as FurniListEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:FurniModel = this._inventory.furniModel;
            if (_local_3 == null){
                return;
            };
            _local_3.FurniModel(_local_2.categoryType, _local_2.getFurni(), _local_2.totalFragments, _local_2.fragmentNo);
        }
        public function onFurniListInsert(_arg_1:IMessageEvent):void
        {
            var _local_2:FurniListInsertParser = (_arg_1 as FurniListInsertEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:FurniModel = this._inventory.furniModel;
            if ((((_local_3 == null)) || (!(_local_3.FurniModel())))){
                return;
            };
            var _local_4:IItem;
            var _local_5:FurniData;
            var _local_6:Array = _local_2.getFurni();
            var _local_7:int;
            while (_local_7 < _local_6.length) {
                _local_5 = FurniData(_local_6[_local_7]);
                if (_local_5.itemType == "S"){
                    _local_4 = new FloorItem(_local_5.stripId, _local_5.classId, _local_5.objId, _local_5.category, _local_5.isGroupable, _local_5.isTradeable, _local_5.isRecyclable, _local_5.isSellable, _local_5.stuffData, _local_5.extra, _local_5.expiryTime, 0, 0, 0, _local_5.slotId, _local_5.songId);
                }
                else {
                    if (_local_5.itemType == "I"){
                        _local_4 = new WallItem(_local_5.stripId, _local_5.classId, _local_5.objId, _local_5.category, _local_5.isGroupable, _local_5.isTradeable, _local_5.isRecyclable, _local_5.isSellable, _local_5.stuffData, _local_5.extra);
                    }
                    else {
                        throw (new Error((('Unknown inventory item category: "' + _local_5.itemType) + '"')));
                    };
                };
                _local_3.addFurniAsLast(_local_4);
                _local_7++;
            };
        }
        public function onFurniListRemove(_arg_1:IMessageEvent):void
        {
            var _local_2:FurniListRemoveParser = (_arg_1 as FurniListRemoveEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:FurniModel = this._inventory.furniModel;
            if (_local_3 == null){
                return;
            };
            var _local_4:int = _local_2.stripId;
            _local_3.removeFurni(_local_4);
        }
        public function onFurniListUpdate(_arg_1:IMessageEvent):void
        {
            var _local_2:IConnection = this.getConnection();
            if (_local_2 != null){
                _local_2.send(new RequestFurniInventoryComposer());
            };
            this._inventory.HabboInventory(InventoryCategory._SafeStr_5995, false);
        }
        public function onPostItPlaced(_arg_1:IMessageEvent):void
        {
            var _local_2:PostItPlacedParser = (_arg_1 as PostItPlacedEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:FurniModel = this._inventory.furniModel;
            if (_local_3 == null){
                return;
            };
            var _local_4:int = _local_2.id;
            var _local_5:int = _local_2.itemsLeft;
            _local_3.updatePostItCount(_local_4, _local_5);
        }
        public function onAvatarEffects(_arg_1:IMessageEvent):void
        {
            var _local_6:AvatarEffect;
            var _local_7:Effect;
            if (this._inventory == null){
                return;
            };
            var _local_2:EffectsModel = this._inventory.effectsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:AvatarEffectsMessageParser = (_arg_1 as AvatarEffectsMessageEvent).getParser();
            if (_local_3 == null){
                return;
            };
            var _local_4:Array = _local_3.effects;
            var _local_5:int;
            while (_local_5 < _local_4.length) {
                _local_6 = (_local_4[_local_5] as AvatarEffect);
                _local_7 = new Effect();
                _local_7.type = _local_6.type;
                _local_7.duration = _local_6.duration;
                _local_7.effectsInInventory = _local_6.inactiveEffectsInInventory;
                if (_local_6.secondsLeftIfActive >= 0){
                    _local_7.isActive = true;
                    _local_7.secondsLeft = _local_6.secondsLeftIfActive;
                    _local_7.effectsInInventory++;
                }
                else {
                    if (_local_6.secondsLeftIfActive == -1){
                        _local_7.isActive = false;
                        _local_7.secondsLeft = _local_6.duration;
                    };
                };
                _local_2.EffectsModel(_local_7, false);
                _local_5++;
            };
            this._inventory.HabboInventory(InventoryCategory.RWE_EFFECTS);
            _local_2.PetsModel();
            this._inventory.HabboInventory();
        }
        public function onAvatarEffectAdded(_arg_1:IMessageEvent):void
        {
            var _local_2:EffectsModel = this._inventory.effectsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:AvatarEffectAddedMessageParser = (_arg_1 as AvatarEffectAddedMessageEvent).getParser();
            if (_local_3 == null){
                return;
            };
            var _local_4:int = _local_3.type;
            var _local_5:int = _local_3.duration;
            var _local_6:Effect = new Effect();
            _local_6.type = _local_4;
            _local_6.duration = _local_5;
            _local_6.secondsLeft = _local_5;
            _local_2.EffectsModel(_local_6);
            this._inventory.HabboInventory();
        }
        public function onAvatarEffectActivated(_arg_1:IMessageEvent):void
        {
            var _local_2:EffectsModel = this._inventory.effectsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:AvatarEffectActivatedMessageParser = (_arg_1 as AvatarEffectActivatedMessageEvent).getParser();
            if (_local_3 == null){
                return;
            };
            var _local_4:int = _local_3.type;
            _local_2.EffectsModel(_local_4);
            this._inventory.HabboInventory();
        }
        public function onAvatarEffectExpired(_arg_1:IMessageEvent):void
        {
            var _local_2:EffectsModel = this._inventory.effectsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:AvatarEffectExpiredMessageParser = (_arg_1 as AvatarEffectExpiredMessageEvent).getParser();
            if (_local_3 == null){
                return;
            };
            var _local_4:int = _local_3.type;
            _local_2.EffectsModel(_local_4);
            this._inventory.HabboInventory();
        }
        public function onClubStatus(_arg_1:IMessageEvent):void
        {
            var _local_2:ScrSendUserInfoMessageParser = (_arg_1 as ScrSendUserInfoEvent).getParser();
            if ((((_local_2.productName == "habbo_club")) || ((_local_2.productName == "club_habbo")))){
                this._inventory.HabboInventory(_local_2.periodsSubscribedAhead, _local_2.daysToPeriodEnd, _local_2.hasEverBeenMember, _local_2.isVIP, (_local_2.responseType == ScrSendUserInfoMessageParser._SafeStr_5852));
                this._inventory.events.dispatchEvent(new HabboInventoryHabboClubEvent());
            };
        }
        public function onBadges(_arg_1:IMessageEvent):void
        {
            var _local_4:int;
            var _local_5:String;
            var _local_8:Boolean;
            var _local_9:int;
            var _local_2:BadgesParser = (_arg_1 as BadgesEvent).getParser();
            if (_local_2 == null){
                return;
            };
            var _local_3:BadgesModel = this._inventory.badgesModel;
            if (_local_3 == null){
                return;
            };
            var _local_6:Array = _local_2.getAllBadgeCodes();
            var _local_7:Array = _local_2.getActiveBadgeCodes();
            for each (_local_5 in _local_6) {
                _local_8 = (_local_7.indexOf(_local_5) > -1);
                _local_9 = _local_2.HabboGroupInfoManager(_local_5);
                _local_3.updateBadge(_local_5, _local_8, _local_9);
            };
            _local_3.forceSelection();
            _local_3.ProgressBar();
            this._inventory.HabboInventory(InventoryCategory._SafeStr_7061);
        }
        public function _SafeStr_11616(_arg_1:IMessageEvent):void
        {
            var _local_3:BadgeAndPointLimit;
            var _local_2:BadgePointLimitsParser = (_arg_1 as BadgePointLimitsEvent).getParser();
            for each (_local_3 in _local_2.data) {
                this._inventory.localization.setBadgePointLimit(_local_3.badgeId, _local_3.limit);
            };
        }
        public function InfostandWidget(_arg_1:IMessageEvent):void
        {
            var _local_4:String;
            var _local_2:HabboUserBadgesMessageEvent = (_arg_1 as HabboUserBadgesMessageEvent);
            if (_local_2.userId != this._inventory.sessionData.userId){
                return;
            };
            var _local_3:BadgesModel = this._inventory.badgesModel;
            if (_local_3 == null){
                return;
            };
            for each (_local_4 in _local_2.badges) {
                _local_3.updateBadge(_local_4, true);
            };
            _local_3.ProgressBar();
        }
        public function onAchievementReceived(_arg_1:IMessageEvent):void
        {
            var _local_2:HabboAchievementNotificationMessageEvent = (_arg_1 as HabboAchievementNotificationMessageEvent);
            var _local_3:HabboAchievementNotificationMessageParser = _local_2.getParser();
            var _local_4:BadgesModel = this._inventory.badgesModel;
            if (_local_4 != null){
                _local_4.updateBadge(_local_3.data.badgeCode, false, _local_3.data.badgeId);
                _local_4.removeBadge(_local_3.data.removedBadgeCode);
                _local_4.ProgressBar();
            };
        }
        public function onAchievementsScore(_arg_1:IMessageEvent):void
        {
            var _local_2:AchievementsScoreEvent = (_arg_1 as AchievementsScoreEvent);
            var _local_3:AchievementsScoreMessageParser = (_local_2.getParser() as AchievementsScoreMessageParser);
            if (_local_3 == null){
                return;
            };
            this._inventory.localization.registerParameter("achievements_score_description", "score", _local_3.score.toString());
        }
        private function onTradingOpen(_arg_1:IMessageEvent):void
        {
            var _local_14:int;
            var _local_15:String;
            var _local_16:Boolean;
            if (!this._inventory){
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - inventory is null!");
                return;
            };
            var _local_2:ISessionDataManager = this._inventory.sessionData;
            var _local_3:IRoomSession = this._inventory.roomSession;
            if (!_local_2){
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - sessionData not available!");
                return;
            };
            if (!_local_3){
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - roomSession not available!");
                return;
            };
            this._inventory.HabboInventory(InventorySubCategory._SafeStr_7064);
            var _local_4:TradingOpenEvent = (_arg_1 as TradingOpenEvent);
            if (!_local_4){
                ErrorReportStorage.addDebugData("IncomingEvent", (("event is of unknown type:" + _arg_1) + "!"));
                return;
            };
            var _local_5:int = _local_4.userID;
            var _local_6:IUserData = _local_3.userDataManager.getUserData(_local_5);
            if (!_local_6){
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve own user data!");
                return;
            };
            var _local_7:String = _local_6.name;
            var _local_8 = (_local_4.userCanTrade > 0);
            var _local_9:int = _local_4.otherUserID;
            var _local_10:IUserData = _local_3.userDataManager.getUserData(_local_9);
            if (!_local_10){
                ErrorReportStorage.addDebugData("IncomingEvent", "Trading open - failed to retrieve other user data!");
                return;
            };
            var _local_11:String = _local_10.name;
            var _local_12 = (_local_4.otherUserCanTrade > 0);
            if (_local_9 == _local_2.userId){
                _local_14 = _local_5;
                _local_15 = _local_7;
                _local_16 = _local_8;
                _local_5 = _local_9;
                _local_7 = _local_11;
                _local_8 = _local_12;
                _local_9 = _local_14;
                _local_11 = _local_15;
                _local_12 = _local_16;
            };
            var _local_13:TradingModel = this._inventory.tradingModel;
            if (_local_13 != null){
                _local_13.startTrading(_local_5, _local_7, _local_8, _local_9, _local_11, _local_12);
            };
        }
        private function onTradingAlreadyOpen(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingClose(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingCompleted(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingAccepted(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingConfirmation(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingItemList(_arg_1:IMessageEvent):void
        {
            var _local_5:uint;
            var _local_6:GroupItem;
            var _local_7:int;
            var _local_8:String;
            var _local_9:ItemDataStructure;
            var _local_10:int;
            var _local_2:TradingItemListEvent = (_arg_1 as TradingItemListEvent);
            var _local_3:Map = new Map();
            var _local_4:Map = new Map();
            var _local_11:FurniModel = this._inventory.furniModel;
            if (_local_11 == null){
                return;
            };
            _local_5 = _local_2.firstUserItemArray.length;
            _local_10 = 0;
            while (_local_10 < _local_5) {
                _local_9 = (_local_2.firstUserItemArray[_local_10] as ItemDataStructure);
                _local_7 = _local_9.itemTypeID;
                _local_8 = (_local_9.itemType + String(_local_7));
                if (!_local_9.groupable){
                    _local_8 = ("itemid" + _local_9.itemID);
                };
                if (_local_9.category == FurniCategory._SafeStr_7055){
                    _local_8 = ((String(_local_7) + "poster") + _local_9.stuffData);
                };
                _local_6 = ((_local_9.groupable) ? (_local_3.getValue(_local_8) as GroupItem) : null);
                if (_local_9.itemType == "S"){
                    if (_local_6 == null){
                        _local_6 = _local_11.createNewGroupItemTemplate(_local_7, FurniModelCategory.S, _local_9.category, _local_9.stuffData);
                        _local_3.add(_local_8, _local_6);
                    };
                    _local_6.push(new FloorItem(_local_9.itemID, _local_9.itemTypeID, _local_9.roomItemID, _local_9.category, true, true, true, true, _local_9.stuffData, _local_9.extra, _local_9.timeToExpiration, _local_9.creationDay, _local_9.creationMonth, _local_9.creationYear, null, _local_9.songID));
                }
                else {
                    if (_local_9.itemType == "I"){
                        if (_local_6 == null){
                            _local_6 = _local_11.createNewGroupItemTemplate(_local_7, FurniModelCategory.I, _local_9.category, _local_9.stuffData);
                            _local_3.add(_local_8, _local_6);
                        };
                        _local_6.push(new WallItem(_local_9.itemID, _local_9.itemTypeID, _local_9.roomItemID, _local_9.category, true, true, true, true, _local_9.stuffData, _local_9.extra));
                    }
                    else {
                        throw (new Error((('Unsupported item category: "' + _local_9.itemType) + '"')));
                    };
                };
                _local_10++;
            };
            _local_5 = _local_2.secondUserItemArray.length;
            _local_10 = 0;
            while (_local_10 < _local_5) {
                _local_9 = (_local_2.secondUserItemArray[_local_10] as ItemDataStructure);
                _local_7 = _local_9.itemTypeID;
                _local_8 = (_local_9.itemType + String(_local_7));
                if (!_local_9.groupable){
                    _local_8 = ("itemid" + _local_9.itemID);
                };
                if (_local_9.category == FurniCategory._SafeStr_7055){
                    _local_8 = ((String(_local_7) + "poster") + _local_9.stuffData);
                };
                _local_6 = ((_local_9.groupable) ? (_local_4.getValue(_local_8) as GroupItem) : null);
                if (_local_9.itemType == "S"){
                    if (_local_6 == null){
                        _local_6 = _local_11.createNewGroupItemTemplate(_local_7, FurniModelCategory.S, _local_9.category, _local_9.stuffData);
                        _local_4.add(_local_8, _local_6);
                    };
                    _local_6.push(new FloorItem(_local_9.itemID, _local_9.itemTypeID, _local_9.roomItemID, _local_9.category, true, true, true, true, _local_9.stuffData, _local_9.extra, _local_9.timeToExpiration, _local_9.creationDay, _local_9.creationMonth, _local_9.creationYear, null, _local_9.songID));
                }
                else {
                    if (_local_9.itemType == "I"){
                        if (_local_6 == null){
                            _local_6 = _local_11.createNewGroupItemTemplate(_local_7, FurniModelCategory.I, _local_9.category, _local_9.stuffData);
                            _local_4.add(_local_8, _local_6);
                        };
                        _local_6.push(new WallItem(_local_9.itemID, _local_9.itemTypeID, _local_9.roomItemID, _local_9.category, true, true, true, true, _local_9.stuffData, _local_9.extra));
                    }
                    else {
                        throw (new Error((('Unsupported item category: "' + _local_9.itemType) + '"')));
                    };
                };
                _local_10++;
            };
            var _local_12:TradingModel = this._inventory.tradingModel;
            if (_local_12 != null){
                _local_12.TradingModel(_local_2.firstUserID, _local_3, _local_2.secondUserID, _local_4);
            };
        }
        private function onTradingNotOpen(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingOtherNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onTradingYouAreNotAllowed(_arg_1:IMessageEvent):void
        {
            var _local_2:TradingModel = this._inventory.tradingModel;
            if (_local_2 != null){
                _local_2.TradingModel(_arg_1);
            };
        }
        private function onRoomClosed(_arg_1:IMessageEvent):void
        {
            this._inventory.HabboInventory();
        }
        private function onPets(_arg_1:PetInventoryEvent):void
        {
            var _local_4:PetData;
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:PetsModel = this._inventory.petsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:PetInventoryMessageParser = _arg_1.getParser();
            for each (_local_4 in _local_3.pets) {
                _local_2.PetsView(_local_4);
            };
            this._inventory.HabboInventory(InventoryCategory._SafeStr_5996);
            this._inventory.petsModel.setListInitialized();
        }
        private function onPetAdded(_arg_1:PetAddedToInventoryEvent):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:PetsModel = this._inventory.petsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:PetAddedToInventoryParser = _arg_1.getParser();
            _local_2.PetsView(_local_3.pet);
            this._inventory.furniModel.automaticSwitchToPetCategory();
        }
        private function onPetRemoved(_arg_1:PetRemovedFromInventoryEvent):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:PetsModel = this._inventory.petsModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:PetRemovedFromInventoryParser = _arg_1.getParser();
            _local_2.PetsView(_local_3.petId);
        }
        private function onPetInventoryUpdated(_arg_1:PetInventoryUpdatedEvent):void
        {
            var _local_2:PetsModel = this._inventory.petsModel;
            if (_local_2 == null){
                return;
            };
            _local_2.requestPetInventory();
        }
        private function onMarketplaceConfiguration(_arg_1:MarketplaceConfigurationEvent):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:MarketplaceModel = this._inventory.marketplaceModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketplaceConfigurationParser = _arg_1.getParser();
            _local_2.isEnabled = _local_3.isEnabled;
            _local_2.commission = _local_3.commission;
            _local_2.tokenBatchPrice = _local_3.tokenBatchPrice;
            _local_2.tokenBatchSize = _local_3.tokenBatchSize;
            _local_2.offerMinPrice = _local_3.offerMinPrice;
            _local_2.offerMaxPrice = _local_3.offerMaxPrice;
            _local_2.expirationHours = _local_3.expirationHours;
            _local_2.averagePricePeriod = _local_3.averagePricePeriod;
            this._inventory.HabboInventory(InventoryCategory._SafeStr_7062);
            var _local_4:FurniModel = this._inventory.furniModel;
            if (_local_4 != null){
                _local_4.ProgressBar();
            };
        }
        private function onMarketplaceCanMakeOfferResult(_arg_1:MarketplaceCanMakeOfferResult):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:MarketplaceModel = this._inventory.marketplaceModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketplaceCanMakeOfferResultParser = _arg_1.getParser();
            _local_2.MarketplaceModel(_local_3.resultCode, _local_3.tokenCount);
        }
        private function onMarketplaceMakeOfferResult(_arg_1:MarketplaceMakeOfferResult):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:MarketplaceModel = this._inventory.marketplaceModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketplaceMakeOfferResultParser = _arg_1.getParser();
            _local_2._SafeStr_8583(_local_3.result);
        }
        private function onMarketplaceItemStats(_arg_1:MarketplaceItemStatsEvent):void
        {
            if ((((_arg_1 == null)) || ((this._inventory == null)))){
                return;
            };
            var _local_2:MarketplaceModel = this._inventory.marketplaceModel;
            if (_local_2 == null){
                return;
            };
            var _local_3:MarketplaceItemStatsParser = _arg_1.getParser();
            _local_2.MarketplaceModel(_local_3.furniCategoryId, _local_3.furniTypeId, _local_3.averagePrice);
        }
        private function onNotEnoughCredits(_arg_1:NotEnoughBalanceMessageEvent):void
        {
            if (((!(_arg_1)) || (!(this._inventory)))){
                return;
            };
            var _local_2:MarketplaceModel = this._inventory.marketplaceModel;
            if (_local_2 == null){
                return;
            };
            _local_2.onNotEnoughCredits();
        }
        private function onUserRights(_arg_1:IMessageEvent):void
        {
            var _local_2:MarketplaceModel;
            if (this._inventory.HabboInventory(InventoryCategory._SafeStr_7062)){
                _local_2 = this._inventory.marketplaceModel;
                if (_local_2 == null){
                    return;
                };
                _local_2.TradingModel();
            };
        }
        private function onUnseenItems(_arg_1:UnseenItemsEvent):void
        {
            var _local_2:UnseenItemsParser = _arg_1.getParser();
            this._inventory.furniModel.FurniModel(_local_2.getItemsByCategory(UnseenItemCategoryEnum._SafeStr_6767));
            this._inventory.furniModel.FurniModel(_local_2.getItemsByCategory(UnseenItemCategoryEnum._SafeStr_6768));
            this._inventory.petsModel.PetsModel(_local_2.getItemsByCategory(UnseenItemCategoryEnum._SafeStr_6769));
            this._inventory.badgesModel.addUnseenBadges(_local_2.getItemsByCategory(UnseenItemCategoryEnum._SafeStr_6770));
            this._inventory.HabboInventory();
        }

    }
}//package com.sulake.habbo.inventory

// onUserRights = "_-36C" (String#632, DoABC#2)
// onMarketplaceItemStats = "_-xw" (String#8837, DoABC#2)
// onMarketplaceConfiguration = "_-xL" (String#8831, DoABC#2)
// onMarketplaceMakeOfferResult = "_-OR" (String#8172, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// startTrading = "_-0Ci" (String#14557, DoABC#2)
// HabboInventory = "_-NR" (String#8153, DoABC#2)
// TradingModel = "_-1JS" (String#17254, DoABC#2)
// TradingModel = "_-0mn" (String#15930, DoABC#2)
// _SafeStr_11604 = "_-1Fz" (String#17115, DoABC#2)
// onFurniList = "_-0ng" (String#15963, DoABC#2)
// onFurniListInsert = "_-345" (String#21662, DoABC#2)
// onFurniListRemove = "_-2dw" (String#20599, DoABC#2)
// onFurniListUpdate = "_-2DB" (String#19532, DoABC#2)
// onPostItPlaced = "_-0Ba" (String#14510, DoABC#2)
// onAvatarEffectActivated = "_-kd" (String#24055, DoABC#2)
// onAvatarEffectAdded = "_-Bw" (String#22686, DoABC#2)
// onAvatarEffectExpired = "_-2u8" (String#21244, DoABC#2)
// onClubStatus = "_-0iT" (String#15771, DoABC#2)
// onBadges = "_-0YZ" (String#15383, DoABC#2)
// onAchievementReceived = "_-3D" (String#21996, DoABC#2)
// _SafeStr_11616 = "import" (String#45697, DoABC#2)
// onAchievementsScore = "_-28h" (String#6216, DoABC#2)
// onTradingAccepted = "_-OZ" (String#23190, DoABC#2)
// onTradingConfirmation = "_-0md" (String#15922, DoABC#2)
// onTradingAlreadyOpen = "_-0l7" (String#15871, DoABC#2)
// onTradingClose = "_-38k" (String#21831, DoABC#2)
// onTradingCompleted = "_-2Nj" (String#19953, DoABC#2)
// onTradingItemList = "_-T8" (String#23370, DoABC#2)
// onTradingNotOpen = "_-1MY" (String#17380, DoABC#2)
// onTradingOpen = "_-3Aw" (String#21916, DoABC#2)
// onTradingOtherNotAllowed = "_-2NV" (String#19944, DoABC#2)
// onTradingYouAreNotAllowed = "_-1G7" (String#17119, DoABC#2)
// onRoomClosed = "_-0gE" (String#15683, DoABC#2)
// onPets = "_-1nt" (String#18456, DoABC#2)
// onPetAdded = "_-1sm" (String#18667, DoABC#2)
// onPetRemoved = "_-2tf" (String#21228, DoABC#2)
// onMarketplaceCanMakeOfferResult = "_-2w8" (String#21315, DoABC#2)
// onUnseenItems = "_-169" (String#16702, DoABC#2)
// getConnection = "_-2BQ" (String#19461, DoABC#2)
// effectsModel = "_-0CR" (String#14547, DoABC#2)
// HabboInventory = "_-2Bc" (String#19469, DoABC#2)
// HabboInventory = "_-0VB" (String#15251, DoABC#2)
// badgesModel = "_-mf" (String#24135, DoABC#2)
// setBadgePointLimit = "_-0HA" (String#3898, DoABC#2)
// HabboInventory = "_-3Jx" (String#22282, DoABC#2)
// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// ScrSendUserInfoEvent = "_-202" (String#6048, DoABC#2)
// FurniCategory = "_-0lm" (String#15890, DoABC#2)
// ScrSendUserInfoMessageParser = "_-1vA" (String#18764, DoABC#2)
// InventoryCategory = "_-04Y" (String#14224, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// MarketplaceMakeOfferResult = "_-0tP" (String#4715, DoABC#2)
// MarketplaceMakeOfferResultParser = "_-G-" (String#22853, DoABC#2)
// NotEnoughBalanceMessageEvent = "_-2Ju" (String#6437, DoABC#2)
// MarketplaceItemStatsParser = "_-Fz" (String#22851, DoABC#2)
// MarketplaceConfigurationEvent = "_-2eI" (String#6839, DoABC#2)
// MarketplaceConfigurationParser = "_-0-L" (String#14026, DoABC#2)
// MarketplaceItemStatsEvent = "_-2iN" (String#6918, DoABC#2)
// IItem = "_-1-k" (String#4863, DoABC#2)
// TradingModel = "_-1PM" (String#5341, DoABC#2)
// GroupItem = "_-0qS" (String#4647, DoABC#2)
// BadgesModel = "_-2zV" (String#7278, DoABC#2)
// EffectsModel = "_-ja" (String#8589, DoABC#2)
// InventorySubCategory = "_-1nz" (String#18460, DoABC#2)
// PetsModel = "_-1sv" (String#5899, DoABC#2)
// FurniModelCategory = "_-1a8" (String#5563, DoABC#2)
// FurniModel = "_-1ur" (String#5936, DoABC#2)
// MarketplaceModel = "_-2M1" (String#6484, DoABC#2)
// UserRightsMessageEvent = "_-8n" (String#7837, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// HabboUserBadgesMessageEvent = "_-1fc" (String#5656, DoABC#2)
// AvatarEffectsMessageParser = "_-2m-" (String#20918, DoABC#2)
// AvatarEffectsMessageEvent = "_-2SA" (String#6610, DoABC#2)
// OpenConnectionMessageEvent = "_-UX" (String#8296, DoABC#2)
// FlatAccessDeniedMessageEvent = "_-3Cj" (String#7570, DoABC#2)
// BadgePointLimitsParser = "_-2ak" (String#20477, DoABC#2)
// PetInventoryUpdatedEvent = "_-0UN" (String#4191, DoABC#2)
// FurniData = "_-2AO" (String#19422, DoABC#2)
// TradingConfirmationEvent = "_-j2" (String#8578, DoABC#2)
// BadgesParser = "_-14Z" (String#16638, DoABC#2)
// TradingYouAreNotAllowedParser = "_-43" (String#22379, DoABC#2)
// UnseenItemsParser = "_-185" (String#16780, DoABC#2)
// PetInventoryMessageParser = "_-0OD" (String#14997, DoABC#2)
// PetAddedToInventoryEvent = "_-2W" (String#6683, DoABC#2)
// ItemDataStructure = "_-2zB" (String#21429, DoABC#2)
// AvatarEffectAddedMessageParser = "_-317" (String#21543, DoABC#2)
// TradingOtherNotAllowedParser = "_-0Lk" (String#14903, DoABC#2)
// FurniListRemoveEvent = "_-3Ij" (String#7684, DoABC#2)
// UnseenItemCategoryEnum = "_-0Ua" (String#15227, DoABC#2)
// HabboInventoryHabboClubEvent = "_-0Pe" (String#15048, DoABC#2)
// TradingAcceptParser = "_-2oK" (String#21016, DoABC#2)
// AvatarEffectActivatedMessageParser = "_-Mc" (String#23109, DoABC#2)
// FurniListInsertParser = "_-2oG" (String#21013, DoABC#2)
// FurniListRemoveParser = "_-1Ep" (String#17062, DoABC#2)
// TradingNotOpenEvent = "_-2Du" (String#6318, DoABC#2)
// BadgesEvent = "_-3HC" (String#7652, DoABC#2)
// AvatarEffectExpiredMessageEvent = "_-0Sv" (String#4158, DoABC#2)
// AchievementsScoreEvent = "_-JF" (String#8067, DoABC#2)
// AvatarEffectActivatedMessageEvent = "_-fk" (String#8508, DoABC#2)
// TradingOpenParser = "_-0we" (String#16297, DoABC#2)
// PostItPlacedEvent = "_-2op" (String#7053, DoABC#2)
// TradingConfirmationParser = "_-0BB" (String#14493, DoABC#2)
// TradingItemListEvent = "_-1LI" (String#5267, DoABC#2)
// Effect = "_-0Ka" (String#14863, DoABC#2)
// TradingAlreadyOpenParser = "_-2FW" (String#19624, DoABC#2)
// TradingNotOpenParser = "_-22T" (String#19108, DoABC#2)
// FurniListUpdateEvent = "_-0Xr" (String#4265, DoABC#2)
// FurniListInsertEvent = "_-0Ey" (String#3848, DoABC#2)
// TradingAlreadyOpenEvent = "_-QK" (String#8207, DoABC#2)
// RequestFurniInventoryComposer = "_-17" (String#16734, DoABC#2)
// MarketplaceCanMakeOfferResultParser = "_-RY" (String#23306, DoABC#2)
// PetRemovedFromInventoryParser = "_-1Ra" (String#17567, DoABC#2)
// TradingItemListParser = "_-1R6" (String#17550, DoABC#2)
// TradingCompletedEvent = "_-2gA" (String#6872, DoABC#2)
// TradingCompletedParser = "_-1vy" (String#18795, DoABC#2)
// MarketplaceCanMakeOfferResult = "_-1OM" (String#5320, DoABC#2)
// PetAddedToInventoryParser = "_-0Y8" (String#15363, DoABC#2)
// AvatarEffectAddedMessageEvent = "_-MW" (String#8132, DoABC#2)
// TradingCloseParser = "_-1qf" (String#18570, DoABC#2)
// PetRemovedFromInventoryEvent = "_-0LF" (String#3986, DoABC#2)
// FurniListParser = "_-1q6" (String#18548, DoABC#2)
// FurniListEvent = "_-1DK" (String#5131, DoABC#2)
// UnseenItemsEvent = "_-0ZA" (String#4282, DoABC#2)
// PostItPlacedParser = "_-10u" (String#16494, DoABC#2)
// BadgeAndPointLimit = "_-2-t" (String#19006, DoABC#2)
// TradingOtherNotAllowedEvent = "_-PA" (String#8187, DoABC#2)
// AvatarEffect = "_-3JC" (String#22249, DoABC#2)
// WallItem = "_-2ZP" (String#20413, DoABC#2)
// TradingYouAreNotAllowedEvent = "_-2vg" (String#7191, DoABC#2)
// TradingOpenEvent = "_-3JK" (String#7692, DoABC#2)
// BadgePointLimitsEvent = "_-1hx" (String#5705, DoABC#2)
// TradingCloseEvent = "_-WD" (String#8328, DoABC#2)
// TradingAcceptEvent = "_-38I" (String#7478, DoABC#2)
// AchievementsScoreMessageParser = "_-hH" (String#23941, DoABC#2)
// FloorItem = "_-2DW" (String#19547, DoABC#2)
// PetInventoryEvent = "_-2t6" (String#7140, DoABC#2)
// AvatarEffectExpiredMessageParser = "_-0bx" (String#15509, DoABC#2)
// itemType = "_-De" (String#22756, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// badgeId = "_-g6" (String#23896, DoABC#2)
// petId = "_-JP" (String#8074, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// extra = "_-2We" (String#6693, DoABC#2)
// expiryTime = "_-1FG" (String#17083, DoABC#2)
// effectsInInventory = "_-0U0" (String#4183, DoABC#2)
// secondsLeft = "_-I-" (String#8040, DoABC#2)
// isActive = "_-0q4" (String#4638, DoABC#2)
// RWE_EFFECTS = "_-mU" (String#24127, DoABC#2)
// itemID = "_-103" (String#16469, DoABC#2)
// roomItemID = "_-07X" (String#14347, DoABC#2)
// itemTypeID = "_-33B" (String#21627, DoABC#2)
// stuffData = "_-0vz" (String#1580, DoABC#2)
// timeToExpiration = "_-0VG" (String#15254, DoABC#2)
// creationDay = "_-0jt" (String#15824, DoABC#2)
// creationMonth = "_-1T6" (String#17629, DoABC#2)
// creationYear = "_-0Ts" (String#15202, DoABC#2)
// groupable = "_-1YM" (String#5527, DoABC#2)
// songID = "_-367" (String#21734, DoABC#2)
// firstUserID = "_-2QT" (String#20065, DoABC#2)
// secondUserID = "_-1i1" (String#18211, DoABC#2)
// firstUserItemArray = "_-1L1" (String#17314, DoABC#2)
// secondUserItemArray = "_-1KD" (String#17282, DoABC#2)
// userID = "_-1hY" (String#18192, DoABC#2)
// userCanTrade = "_-6P" (String#22480, DoABC#2)
// otherUserID = "_-5F" (String#22431, DoABC#2)
// otherUserCanTrade = "_-0wj" (String#16300, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0r" (String#4663, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// isVIP = "_-3K4" (String#7705, DoABC#2)
// badgeCode = "_-2XO" (String#20338, DoABC#2)
// removedBadgeCode = "_-4X" (String#22399, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _SafeStr_5852 = "_-1gA" (String#18147, DoABC#2)
// daysToPeriodEnd = "_-3L6" (String#22328, DoABC#2)
// periodsSubscribedAhead = "_-08y" (String#14405, DoABC#2)
// responseType = "_-0wX" (String#16291, DoABC#2)
// hasEverBeenMember = "_-iw" (String#23995, DoABC#2)
// furniModel = "_-Sp" (String#23358, DoABC#2)
// TradingModel = "_-2eX" (String#6842, DoABC#2)
// _SafeStr_5995 = "_-2qT" (String#21102, DoABC#2)
// _SafeStr_5996 = "_-Jg" (String#22993, DoABC#2)
// inactiveEffectsInInventory = "_-66" (String#22469, DoABC#2)
// secondsLeftIfActive = "_-11s" (String#16532, DoABC#2)
// getUserData = "_-1-1" (String#4848, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// InfostandWidget = "_-8z" (String#2063, DoABC#2)
// onAvatarEffects = "_-33k" (String#7381, DoABC#2)
// getFurni = "_-0B5" (String#3779, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// categoryType = "_-2lC" (String#20890, DoABC#2)
// totalFragments = "_-32p" (String#21611, DoABC#2)
// fragmentNo = "_-98" (String#22586, DoABC#2)
// itemsLeft = "_-1Og" (String#17456, DoABC#2)
// getItemsByCategory = "_-1Md" (String#17385, DoABC#2)
// songId = "_-2fw" (String#20688, DoABC#2)
// _SafeStr_6767 = "for" (String#45121, DoABC#2)
// _SafeStr_6768 = "_-QD" (String#23258, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// _SafeStr_6770 = "_-39Q" (String#7500, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// ProgressBar = "_-1Js" (String#847, DoABC#2)
// _SafeStr_7055 = "_-0z3" (String#16396, DoABC#2)
// _SafeStr_7061 = "_-3KY" (String#22306, DoABC#2)
// _SafeStr_7062 = "_-1SW" (String#17601, DoABC#2)
// _SafeStr_7064 = "_-08P" (String#14380, DoABC#2)
// S = "_-Ch" (String#22713, DoABC#2)
// I = "_-3-D" (String#21470, DoABC#2)
// petsModel = "_-227" (String#19096, DoABC#2)
// FurniModel = "_-2RU" (String#20098, DoABC#2)
// HabboInventory = "_-0py" (String#16050, DoABC#2)
// objId = "_-1VD" (String#17710, DoABC#2)
// isGroupable = "_-19p" (String#16849, DoABC#2)
// isTradeable = "_-2td" (String#21226, DoABC#2)
// isRecyclable = "_-1jA" (String#18251, DoABC#2)
// isSellable = "_-0aB" (String#4305, DoABC#2)
// addFurniAsLast = "_-0fn" (String#15663, DoABC#2)
// removeFurni = "_-1-n" (String#16459, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// setListInitialized = "_-Mb" (String#23108, DoABC#2)
// FurniModel = "_-cQ" (String#23731, DoABC#2)
// createNewGroupItemTemplate = "_-0Bl" (String#14518, DoABC#2)
// automaticSwitchToPetCategory = "_-2NP" (String#19940, DoABC#2)
// tradingModel = "_-1s3" (String#18635, DoABC#2)
// updatePostItCount = "_-274" (String#19294, DoABC#2)
// marketplaceModel = "_-051" (String#14244, DoABC#2)
// HabboInventory = "_-0fQ" (String#15648, DoABC#2)
// FurniModel = "_-2XU" (String#20341, DoABC#2)
// FurniModel = "_-2YX" (String#20379, DoABC#2)
// HabboInventory = "_-ik" (String#23988, DoABC#2)
// resultCode = "_-09c" (String#14431, DoABC#2)
// EffectsModel = "_-1uY" (String#18737, DoABC#2)
// PetsModel = "_-tx" (String#24446, DoABC#2)
// EffectsModel = "_-2LA" (String#19854, DoABC#2)
// EffectsModel = "_-iZ" (String#23980, DoABC#2)
// averagePrice = "_-2h" (String#6892, DoABC#2)
// HabboGroupInfoManager = "_-Jj" (String#22995, DoABC#2)
// getAllBadgeCodes = "_-0eP" (String#15603, DoABC#2)
// getActiveBadgeCodes = "_-2pI" (String#21050, DoABC#2)
// HabboAchievementNotificationMessageParser = "_-Zs" (String#8418, DoABC#2)
// furniTypeId = "_-2n-" (String#20961, DoABC#2)
// furniCategoryId = "_-0bd" (String#15499, DoABC#2)
// tokenBatchPrice = "_-wK" (String#24546, DoABC#2)
// tokenBatchSize = "_-2Aa" (String#19429, DoABC#2)
// offerMinPrice = "_-026" (String#14129, DoABC#2)
// offerMaxPrice = "_-2pR" (String#21056, DoABC#2)
// expirationHours = "_-0xj" (String#16342, DoABC#2)
// averagePricePeriod = "_-0lE" (String#4528, DoABC#2)
// tokenCount = "_-pY" (String#24255, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// HabboAchievementNotificationMessageEvent = "_-2LH" (String#6465, DoABC#2)
// CloseConnectionMessageEvent = "_-2cv" (String#6811, DoABC#2)
// requestPetInventory = "_-1VZ" (String#17725, DoABC#2)
// PetsView = "_-3DW" (String#22016, DoABC#2)
// PetsView = "_-lb" (String#24093, DoABC#2)
// PetsModel = "_-2Rw" (String#20116, DoABC#2)
// updateBadge = "_-0FX" (String#14667, DoABC#2)
// removeBadge = "_-002" (String#14054, DoABC#2)
// forceSelection = "_-Jl" (String#22996, DoABC#2)
// addUnseenBadges = "_-2jp" (String#20839, DoABC#2)
// MarketplaceModel = "_-11Q" (String#16513, DoABC#2)
// _SafeStr_8583 = "try" (String#10537, DoABC#2)
// MarketplaceModel = "_-1q8" (String#18550, DoABC#2)
// onNotEnoughCredits = "_-0xN" (String#4799, DoABC#2)


