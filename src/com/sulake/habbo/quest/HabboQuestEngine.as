
package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.notifications.IHabboNotifications;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.IHabboHelp;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDHabboNotifications;
    import com.sulake.iid.IIDHabboHelp;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class HabboQuestEngine extends Component implements IHabboQuestEngine, IUpdateReceiver 
    {

        private static const _SafeStr_12330:int = 5;
        private static const _SafeStr_12331:int = 800;
        private static const _SafeStr_12332:int = 15;
        private static const _SafeStr_12333:int = 300;
        private static const QUESTS_WITH_PROMPTS:Array = ["MOVEITEM", "ENTEROTHERSROOM", "CHANGEFIGURE", "FINDLIFEGUARDTOWER", "SCRATCHAPET"];

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _SafeStr_11492:IncomingMessages;
        private var _questController:QuestController;
        private var _achievementController:AchievementController;
        private var _toolbar:IHabboToolbar;
        private var _catalog:IHabboCatalog;
        private var _navigator:IHabboNavigator;
        private var _HabboSoundManagerFlash10:IHabboNotifications;
        private var _sessionDataManager:ISessionDataManager;
        private var _habboHelp:IHabboHelp;
        private var _twinkleImages:TwinkleImages;
        private var _currentlyInRoom:Boolean = false;

        public function HabboQuestEngine(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._questController = new QuestController(this);
            this._achievementController = new AchievementController(this);
            queueInterface(new IIDHabboCommunicationManager(), this.HabboUserDefinedRoomEvents);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDHabboNotifications(), this.HabboSoundManagerFlash10);
            queueInterface(new IIDHabboHelp(), this.onHabboHelpReady);
            queueInterface(new IIDHabboNavigator(), this.onHabboNavigatorReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            IContext(this, _SafeStr_12330);
        }
        public static function moveChildrenToRow(_arg_1:IWindowContainer, _arg_2:Array, _arg_3:int, _arg_4:int):void
        {
            var _local_5:String;
            var _local_6:IWindow;
            for each (_local_5 in _arg_2) {
                _local_6 = _arg_1.getChildByName(_local_5);
                if (((!((_local_6 == null))) && (_local_6.visible))){
                    _local_6.x = _arg_3;
                    _arg_3 = (_arg_3 + (_local_6.width + _arg_4));
                };
            };
        }

        override public function dispose():void
        {
            removeUpdateReceiver(this);
            super.dispose();
            if (this._toolbar){
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._catalog != null){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._HabboSoundManagerFlash10 != null){
                this._HabboSoundManagerFlash10.release(new IIDHabboNotifications());
                this._HabboSoundManagerFlash10 = null;
            };
            if (this._windowManager != null){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._configuration != null){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._localization != null){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._communication != null){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._sessionDataManager != null){
                this._sessionDataManager.events.removeEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this._achievementController.onBadgeImageReady);
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._SafeStr_11492){
                this._SafeStr_11492.dispose();
            };
            if (this._habboHelp != null){
                this._habboHelp.release(new IIDHabboHelp());
                this._habboHelp = null;
            };
            if (this._navigator != null){
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this._twinkleImages){
                this._twinkleImages.dispose();
                this._twinkleImages = null;
            };
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
        private function HabboUserDefinedRoomEvents(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communication = IHabboCommunicationManager(_arg_2);
            this._SafeStr_11492 = new IncomingMessages(this);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(_arg_2);
        }
        private function onConfigurationReady(_arg_1:IID, _arg_2:IUnknown):void
        {
            if (_arg_2 == null){
                return;
            };
            this._configuration = (_arg_2 as IHabboConfigurationManager);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._catalog = (_arg_2 as IHabboCatalog);
        }
        private function HabboSoundManagerFlash10(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._HabboSoundManagerFlash10 = (_arg_2 as IHabboNotifications);
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
            this._sessionDataManager.events.addEventListener(BadgeImageReadyEvent.BIRE_BADGE_IMAGE_READY, this._achievementController.onBadgeImageReady);
        }
        private function onHabboHelpReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._habboHelp = (_arg_2 as IHabboHelp);
        }
        private function onHabboNavigatorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._navigator = (_arg_2 as IHabboNavigator);
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function get habboHelp():IHabboHelp
        {
            return (this._habboHelp);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function get questController():QuestController
        {
            return (this._questController);
        }
        public function get achievementController():AchievementController
        {
            return (this._achievementController);
        }
        public function get toolbar():IHabboToolbar
        {
            return (this._toolbar);
        }
        public function openCatalog(_arg_1:QuestMessageData):void
        {
            var _local_2:String = ("catalog.page.quest." + _arg_1.campaignCode);
            Logger.log(("Questing->Open Catalog: " + _local_2));
            this._catalog.openCatalogPage(_local_2, true);
        }
        public function openNavigator(_arg_1:QuestMessageData):void
        {
            var _local_3:String;
            var _local_2:Boolean = this._localization.hasKey((_arg_1.QuestMessageData() + ".searchtag"));
            if (_local_2){
                _local_3 = (_arg_1.QuestMessageData() + ".searchtag");
            }
            else {
                _local_3 = (_arg_1.QuestMessageData() + ".searchtag");
            };
            var _local_4:String = this._localization.getKey(_local_3);
            Logger.log(("Questing->Open Navigator: " + _local_4));
            this._navigator.performTagSearch(_local_4);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = (IHabboToolbar(_arg_2) as IHabboToolbar);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK){
                if (_arg_1.iconId == HabboToolbarIconEnum.QUESTS){
                    this._questController.onToolbarClick();
                };
                if (_arg_1.iconId == HabboToolbarIconEnum.ACHIEVEMENTS){
                    this._achievementController.onToolbarClick();
                };
            };
        }
        public function showAchievements():void
        {
            if (this._achievementController != null){
                this._achievementController.show();
            };
        }
        public function showQuests():void
        {
        }
        public function get notifications():IHabboNotifications
        {
            return (this._HabboSoundManagerFlash10);
        }
        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function send(_arg_1:IMessageComposer):void
        {
            this.communication.HabboCommunicationManager(null).send(_arg_1);
        }
        public function isTrackerVisible():Boolean
        {
            return (this._questController.questTracker.isVisible());
        }
        public function getQuestRowTitle(_arg_1:QuestMessageData):String
        {
            var _local_2:String = (((_arg_1.waitPeriodSeconds < 1)) ? (_arg_1.QuestMessageData() + ".name") : "quests.list.questdelayed");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getQuestName(_arg_1:QuestMessageData):String
        {
            var _local_2 = (_arg_1.QuestMessageData() + ".name");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getQuestDesc(_arg_1:QuestMessageData):String
        {
            var _local_2 = (_arg_1.QuestMessageData() + ".desc");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getQuestHint(_arg_1:QuestMessageData):String
        {
            var _local_2 = (_arg_1.QuestMessageData() + ".hint");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getActivityPointName(_arg_1:int):String
        {
            var _local_2:String = ("achievements.activitypoint." + _arg_1);
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getCampaignName(_arg_1:QuestMessageData):String
        {
            var _local_2 = (_arg_1.QuestMessageData() + ".name");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function getAchievementCategoryName(_arg_1:String):String
        {
            var _local_2 = (("quests." + _arg_1) + ".name");
            return (this._localization.getKey(_local_2, _local_2));
        }
        public function setupQuestImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData):void
        {
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("quest_pic_bitmap"));
            var _local_4:String = ((this.isQuestWithPrompts(_arg_2)) ? "_a" : "");
            var _local_5:String = (((_arg_2.waitPeriodSeconds > 0)) ? "quest_timer_questionmark" : ((((_arg_2.campaignCode + "_") + _arg_2.localizationCode) + _arg_2.imageVersion) + _local_4).toLowerCase());
            if (_local_3.tags[0] == _local_5){
                return;
            };
            Logger.log(("Refreshing quest image: " + _local_5));
            _local_3.tags[0] = _local_5;
            new PendingImage(this, _local_3, _local_5);
        }
        public function setupPromptFrameImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData, _arg_3:String):void
        {
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName(("prompt_pic_" + _arg_3)));
            if (_local_4.id == _arg_2.id){
                Logger.log("No need to refresh prompt image...");
                return;
            };
            _local_4.id = _arg_2.id;
            new PendingImage(this, _local_4, (((((_arg_2.campaignCode + "_") + _arg_2.localizationCode) + _arg_2.imageVersion) + "_") + _arg_3).toLowerCase());
        }
        public function setupRewardImage(_arg_1:IWindowContainer, _arg_2:int):void
        {
            var _local_4:String;
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("currency_bitmap"));
            if (_local_3.id == _arg_2){
                Logger.log("No need to refresh reward image...");
                return;
            };
            _local_3.id = _arg_2;
            switch (_arg_2){
                case 0:
                    _local_4 = "quest_pixel";
                    break;
                case 1:
                    _local_4 = "icon_xmas10_pixeltype";
                    break;
                case 2:
                    _local_4 = "icon_val11_pixeltype";
                    break;
                case 4:
                    _local_4 = "quest_shells";
                    break;
                default:
                    _local_4 = "quest_pixel";
            };
            new PendingImage(this, _local_3, _local_4);
        }
        public function setupCampaignImage(_arg_1:IWindowContainer, _arg_2:QuestMessageData, _arg_3:Boolean):void
        {
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("campaign_pic_bitmap"));
            if (!_arg_3){
                _local_4.visible = false;
                return;
            };
            _local_4.visible = true;
            if (_local_4.tags[0] == _arg_2.campaignCode){
                Logger.log("No need to refresh campaign image...");
                return;
            };
            _local_4.tags[0] = _arg_2.campaignCode;
            new PendingImage(this, _local_4, _arg_2.campaignCode);
        }
        public function setupAchievementCategoryImage(_arg_1:IWindowContainer, _arg_2:AchievementCategory, _arg_3:Boolean):void
        {
            var _local_4:IBitmapWrapperWindow = IBitmapWrapperWindow(_arg_1.findChildByName("category_pic_bitmap"));
            var _local_5:String = ((_arg_3) ? (("achcategory_" + _arg_2.code) + (((_arg_2.getProgress() > 0)) ? "_active" : "_inactive")) : ("achicon_" + _arg_2.code));
            if (_local_4.tags[0] == _local_5){
                Logger.log("No need to refresh category image...");
                return;
            };
            _local_4.tags[0] = _local_5;
            new PendingImage(this, _local_4, _local_5);
        }
        public function isQuestWithPrompts(_arg_1:QuestMessageData):Boolean
        {
            return ((QUESTS_WITH_PROMPTS.indexOf(_arg_1.localizationCode) > -1));
        }
        public function refreshReward(_arg_1:Boolean, _arg_2:IWindowContainer, _arg_3:int, _arg_4:int):void
        {
            var _local_5:IWindow = _arg_2.findChildByName("reward_caption_txt");
            var _local_6:IWindow = _arg_2.findChildByName("reward_amount_txt");
            var _local_7:IWindow = _arg_2.findChildByName("currency_bitmap");
            _local_6.visible = _arg_1;
            _local_5.visible = _arg_1;
            _local_7.visible = _arg_1;
            if (!_arg_1){
                return;
            };
            _local_6.caption = ("" + _arg_4);
            moveChildrenToRow(_arg_2, ["reward_caption_txt", "reward_amount_txt", "currency_bitmap"], _local_5.x, 3);
            this.setupRewardImage(_arg_2, _arg_3);
        }
        public function update(_arg_1:uint):void
        {
            this._questController.update(_arg_1);
            this._achievementController.update(_arg_1);
        }
        public function getTwinkleAnimation(_arg_1:IWindowContainer):Animation
        {
            if (this._twinkleImages == null){
                this._twinkleImages = new TwinkleImages(this);
            };
            var _local_2:int = _SafeStr_12331;
            var _local_3:Animation = new Animation(IBitmapWrapperWindow(_arg_1.findChildByName("twinkle_bitmap")));
            var _local_4:int;
            while (_local_4 < _SafeStr_12332) {
                _local_3.addObject(new Twinkle(this._twinkleImages, _local_2));
                _local_2 = (_local_2 + _SafeStr_12333);
                _local_4++;
            };
            return (_local_3);
        }
        public function get currentlyInRoom():Boolean
        {
            return (this._currentlyInRoom);
        }
        public function set currentlyInRoom(_arg_1:Boolean):void
        {
            this._currentlyInRoom = _arg_1;
        }

    }
}//package com.sulake.habbo.quest

// IID = "_-3KV" (String#7712, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// notifications = "_-1zJ" (String#1789, DoABC#2)
// _HabboSoundManagerFlash10 = "_-ef" (String#940, DoABC#2)
// showAchievements = "_-1xg" (String#5986, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// HabboUserDefinedRoomEvents = "_-1hF" (String#443, DoABC#2)
// HabboSoundManagerFlash10 = "_-AF" (String#2065, DoABC#2)
// _SafeStr_11492 = "_-0aZ" (String#589, DoABC#2)
// questController = "_-1Hq" (String#17186, DoABC#2)
// currentlyInRoom = "_-15i" (String#16684, DoABC#2)
// achievementController = "_-0e" (String#15584, DoABC#2)
// onToolbarClick = "_-2UP" (String#6654, DoABC#2)
// questTracker = "_-Vi" (String#23481, DoABC#2)
// getProgress = "_-2qB" (String#21088, DoABC#2)
// getAchievementCategoryName = "_-3EV" (String#22055, DoABC#2)
// setupAchievementCategoryImage = "_-VS" (String#23470, DoABC#2)
// refreshReward = "_-13f" (String#16604, DoABC#2)
// getCampaignName = "_-24T" (String#19199, DoABC#2)
// setupCampaignImage = "_-Ux" (String#23445, DoABC#2)
// getQuestRowTitle = "_-2cY" (String#20547, DoABC#2)
// getQuestDesc = "_-0-A" (String#14017, DoABC#2)
// setupQuestImage = "_-1a5" (String#17898, DoABC#2)
// getTwinkleAnimation = "_-0MD" (String#14924, DoABC#2)
// isTrackerVisible = "_-0Mk" (String#4017, DoABC#2)
// showQuests = "_-2ba" (String#6784, DoABC#2)
// getActivityPointName = "_-wi" (String#24559, DoABC#2)
// _SafeStr_12330 = "_-39f" (String#21869, DoABC#2)
// _SafeStr_12331 = "_-3CJ" (String#21972, DoABC#2)
// _SafeStr_12332 = "_-0Ds" (String#14602, DoABC#2)
// _SafeStr_12333 = "_-34n" (String#21688, DoABC#2)
// _questController = "_-3-Q" (String#21479, DoABC#2)
// _achievementController = "_-0N" (String#14955, DoABC#2)
// _habboHelp = "_-0ms" (String#1548, DoABC#2)
// _currentlyInRoom = "_-ri" (String#24349, DoABC#2)
// onHabboHelpReady = "_-2ht" (String#6904, DoABC#2)
// onHabboNavigatorReady = "_-37r" (String#21800, DoABC#2)
// openNavigator = "_-2pV" (String#21057, DoABC#2)
// getQuestName = "_-0yL" (String#16365, DoABC#2)
// getQuestHint = "_-0EI" (String#14620, DoABC#2)
// isQuestWithPrompts = "_-1FF" (String#17082, DoABC#2)
// setupPromptFrameImage = "_-1n5" (String#18427, DoABC#2)
// setupRewardImage = "_-3Dm" (String#22025, DoABC#2)
// BadgeImageReadyEvent = "_-03M" (String#14177, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// QuestController = "_-BP" (String#7897, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// Twinkle = "_-i4" (String#23968, DoABC#2)
// AchievementController = "_-1XH" (String#5503, DoABC#2)
// TwinkleImages = "_-0vX" (String#4758, DoABC#2)
// QuestMessageData = "_-2Vr" (String#20275, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// IContext = "_-35P" (String#7415, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// BIRE_BADGE_IMAGE_READY = "_-38f" (String#21828, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// addObject = "_-0EW" (String#1435, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// habboHelp = "_-015" (String#3584, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// performTagSearch = "_-29O" (String#6238, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)
// openCatalog = "_-RM" (String#8233, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// IHabboQuestEngine = "_-2tn" (String#7154, DoABC#2)
// campaignCode = "_-DA" (String#22735, DoABC#2)
// localizationCode = "_-05w" (String#14279, DoABC#2)
// imageVersion = "_-0eu" (String#15623, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// waitPeriodSeconds = "_-376" (String#21771, DoABC#2)
// QuestMessageData = "_-02z" (String#14161, DoABC#2)
// QuestMessageData = "_-D-" (String#22728, DoABC#2)
// moveChildrenToRow = "_-0xS" (String#16331, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// onBadgeImageReady = "_-2f0" (String#1919, DoABC#2)
// hasKey = "_-0LB" (String#3985, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


