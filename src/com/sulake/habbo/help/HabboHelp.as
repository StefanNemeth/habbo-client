
package com.sulake.habbo.help
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.help.help.data.FaqIndex;
    import com.sulake.habbo.help.help.HelpUI;
    import com.sulake.habbo.help.tutorial.TutorialUI;
    import com.sulake.habbo.help.hotelmerge.HotelMergeUI;
    import com.sulake.habbo.help.cfh.data.CallForHelpData;
    import com.sulake.habbo.help.cfh.data.UserRegistry;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.iid.IIDHabboToolbar;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.communication.messages.IMessageComposer;
    import flash.utils.Dictionary;
    import com.sulake.habbo.help.enum.HabboHelpViewEnum;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.iid.IIDHabboRoomSessionManager;
    import com.sulake.habbo.session.IRoomSessionManager;
    import com.sulake.habbo.session.events.RoomSessionEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;

    public class HabboHelp extends Component implements IHabboHelp 
    {

        private var _toolbar:IHabboToolbar;
        private var _assetLibrary:IAssetLibrary;
        private var _windowManager:IHabboWindowManager;
        private var _communicationManager:IHabboCommunicationManager;
        private var _localization:IHabboLocalizationManager;
        private var _SafeStr_10977:IHabboConfigurationManager;
        private var _sessionDataManager:ISessionDataManager;
        private var _SafeStr_11491:FaqIndex;
        private var _SafeStr_11492:IncomingMessages;
        private var _SafeStr_11493:HelpUI;
        private var _tutorialUI:TutorialUI;
        private var _hotelMergeUI:HotelMergeUI;
        private var _callForHelpData:CallForHelpData;
        private var _userRegistry:UserRegistry;
        private var _ownUserName:String = "";
        private var _SafeStr_11499:WelcomeScreenController;

        public function HabboHelp(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            this._callForHelpData = new CallForHelpData();
            this._userRegistry = new UserRegistry();
            super(_arg_1, _arg_2, _arg_3);
            this._assetLibrary = _arg_3;
            this._SafeStr_11491 = new FaqIndex();
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
        }
        public function set ownUserName(_arg_1:String):void
        {
            this._ownUserName = _arg_1;
        }
        public function get ownUserName():String
        {
            return (this._ownUserName);
        }
        public function get callForHelpData():CallForHelpData
        {
            return (this._callForHelpData);
        }
        public function get userRegistry():UserRegistry
        {
            return (this._userRegistry);
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get toolbar():IHabboToolbar
        {
            return (this._toolbar);
        }
        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function get tutorialUI():TutorialUI
        {
            return (this._tutorialUI);
        }
        public function get hotelMergeUI():HotelMergeUI
        {
            return (this._hotelMergeUI);
        }
        public function hasChangedName():Boolean
        {
            if (this._tutorialUI){
                return (this._tutorialUI.hasChangedName);
            };
            return (true);
        }
        override public function dispose():void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.dispose();
                this._SafeStr_11493 = null;
            };
            if (this._tutorialUI != null){
                this._tutorialUI.dispose();
                this._tutorialUI = null;
            };
            if (this._hotelMergeUI){
                this._hotelMergeUI.dispose();
                this._hotelMergeUI = null;
            };
            if (this._SafeStr_11491 != null){
                this._SafeStr_11491.dispose();
                this._SafeStr_11491 = null;
            };
            this._SafeStr_11492 = null;
            if (this._toolbar){
                this._toolbar.release(new IIDHabboToolbar());
                this._toolbar = null;
            };
            if (this._localization){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._communicationManager){
                this._communicationManager.release(new IIDHabboCommunicationManager());
                this._communicationManager = null;
            };
            if (this._SafeStr_10977){
                this._SafeStr_10977.release(new IIDHabboConfigurationManager());
                this._SafeStr_10977 = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._sessionDataManager != null){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._SafeStr_11499 != null){
                this._SafeStr_11499.dispose();
                this._SafeStr_11499 = null;
            };
            super.dispose();
        }
        public function showUI(_arg_1:String=null):void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.showUI(_arg_1);
            };
        }
        public function hideUI():void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.hideUI();
            };
        }
        public function tellUI(_arg_1:String, _arg_2:*=null):void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.tellUI(_arg_1, _arg_2);
            };
        }
        public function enableCallForGuideBotUI():void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.HelpUI(true);
            };
        }
        public function disableCallForGuideBotUI():void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.HelpUI(false);
            };
        }
        public function getFaq():FaqIndex
        {
            return (this._SafeStr_11491);
        }
        public function sendMessage(_arg_1:IMessageComposer):void
        {
            if (((!((this._communicationManager == null))) && (!((_arg_1 == null))))){
                this._communicationManager.HabboCommunicationManager(null).send(_arg_1);
            };
        }
        public function getConfigurationKey(_arg_1:String, _arg_2:String=null, _arg_3:Dictionary=null):String
        {
            if (this._SafeStr_10977 == null){
                return (_arg_1);
            };
            return (this._SafeStr_10977.getKey(_arg_1, _arg_2, _arg_3));
        }
        public function HelpUI(_arg_1:String):void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.HelpUI(_arg_1);
            };
        }
        public function HelpUI(_arg_1:String):void
        {
            if (this._SafeStr_11493 != null){
                this._SafeStr_11493.HelpUI(_arg_1);
            };
        }
        public function reportUser(_arg_1:int, _arg_2:String):void
        {
            this._callForHelpData.reportedUserId = _arg_1;
            this._callForHelpData.reportedUserName = _arg_2;
            this._SafeStr_11493.showUI(HabboHelpViewEnum.HHVE_CFG_TOPIC_SELECT);
        }
        private function toggleHelpUI():void
        {
            if (this._SafeStr_11493 == null){
                if (!this.createHelpUI()){
                    return;
                };
            };
            this._SafeStr_11493.toggleUI();
        }
        private function createHelpUI():Boolean
        {
            if ((((((this._SafeStr_11493 == null)) && (!((this._assetLibrary == null))))) && (!((this._windowManager == null))))){
                this._SafeStr_11493 = new HelpUI(this, this._assetLibrary, this._windowManager);
            };
            return (!((this._SafeStr_11493 == null)));
        }
        private function createTutorialUI():Boolean
        {
            var _local_1:Boolean;
            if ((((((this._tutorialUI == null)) && (!((this._assetLibrary == null))))) && (!((this._windowManager == null))))){
                _local_1 = (this.getConfigurationKey("avatar.widget.enabled", "0") == "0");
                this._tutorialUI = new TutorialUI(this, _local_1);
            };
            return (!((this._tutorialUI == null)));
        }
        public function removeTutorialUI():void
        {
            if (this._tutorialUI != null){
                this._tutorialUI.dispose();
                this._tutorialUI = null;
            };
        }
        public function initHotelMergeUI():void
        {
            if (!this._hotelMergeUI){
                this._hotelMergeUI = new HotelMergeUI(this);
            };
            this._hotelMergeUI.HotelMergeUI();
        }
        public function updateTutorial(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean):void
        {
            if (((((_arg_1) && (_arg_2))) && (_arg_3))){
                this.removeTutorialUI();
                return;
            };
            if (this._tutorialUI == null){
                if (!this.createTutorialUI()){
                    return;
                };
            };
            this._tutorialUI.update(_arg_1, _arg_2, _arg_3);
        }
        public function HotelMergeUI():void
        {
            if (this._tutorialUI){
                this._tutorialUI.HabboInventory(TutorialUI.TUI_NAME_VIEW);
            };
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._windowManager = IHabboWindowManager(_arg_2);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
        }
        private function onCommunicationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communicationManager = IHabboCommunicationManager(_arg_2);
            this._SafeStr_11492 = new IncomingMessages(this, this._communicationManager);
            queueInterface(new IIDHabboToolbar(), this.onToolbarReady);
        }
        private function onToolbarReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._toolbar = IHabboToolbar(_arg_2);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationManagerReady);
        }
        private function onLocalizationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._localization = IHabboLocalizationManager(_arg_2);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationManagerReady);
        }
        private function onConfigurationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._SafeStr_10977 = IHabboConfigurationManager(_arg_2);
            queueInterface(new IIDHabboRoomSessionManager(), this.onRoomSessionManagerReady);
        }
        private function onRoomSessionManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:IRoomSessionManager = IRoomSessionManager(_arg_2);
            _local_3.events.addEventListener(RoomSessionEvent.RSE_STARTED, this.RoomEngine);
            _local_3.events.addEventListener(RoomSessionEvent.RSE_ENDED, this.RoomEngine);
            this._toolbar.events.addEventListener(HabboToolbarEvent.HTE_TOOLBAR_CLICK, this.onHabboToolbarEvent);
            this.createHelpUI();
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
        }
        private function RoomEngine(_arg_1:RoomSessionEvent):void
        {
            switch (_arg_1.type){
                case RoomSessionEvent.RSE_STARTED:
                    if (this._SafeStr_11493 != null){
                        this._SafeStr_11493.setRoomSessionStatus(true);
                    };
                    if (this._tutorialUI != null){
                        this._tutorialUI.setRoomSessionStatus(true);
                    };
                    return;
                case RoomSessionEvent.RSE_ENDED:
                    if (this._SafeStr_11493 != null){
                        this._SafeStr_11493.setRoomSessionStatus(false);
                    };
                    if (this._tutorialUI != null){
                        this._tutorialUI.setRoomSessionStatus(false);
                    };
                    this.userRegistry.unregisterRoom();
                    return;
            };
        }
        public function showWelcomeScreen(_arg_1:WelcomeNotification):void
        {
            if (!this._SafeStr_11499){
                this._SafeStr_11499 = new WelcomeScreenController(this, this._windowManager);
            };
            this._SafeStr_11499.showWelcomeScreen(_arg_1);
        }
        private function onHabboToolbarEvent(_arg_1:HabboToolbarEvent):void
        {
            if (_arg_1.type == HabboToolbarEvent.HTE_TOOLBAR_CLICK){
                if (_arg_1.iconId == HabboToolbarIconEnum.HELP){
                    this.toggleHelpUI();
                };
            };
        }

    }
}//package com.sulake.habbo.help

// IID = "_-3KV" (String#7712, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// onToolbarReady = "_-3Ep" (String#218, DoABC#2)
// RoomEngine = "_-10q" (String#1603, DoABC#2)
// _localization = "_-07" (String#3703, DoABC#2)
// _SafeStr_10977 = "_-01o" (String#3598, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// toggleUI = "_-OI" (String#23180, DoABC#2)
// HelpUI = "_-1DY" (String#17005, DoABC#2)
// HelpUI = "_-0VS" (String#15260, DoABC#2)
// HelpUI = "_-Hv" (String#22926, DoABC#2)
// setRoomSessionStatus = "_-lP" (String#24084, DoABC#2)
// ownUserName = "_-19l" (String#16846, DoABC#2)
// TUI_NAME_VIEW = "_-146" (String#16621, DoABC#2)
// removeTutorialUI = "_-0JO" (String#14817, DoABC#2)
// enableCallForGuideBotUI = "_-0RC" (String#15111, DoABC#2)
// disableCallForGuideBotUI = "_-26s" (String#19286, DoABC#2)
// tutorialUI = "_-09R" (String#14427, DoABC#2)
// hotelMergeUI = "_-0WV" (String#15299, DoABC#2)
// updateTutorial = "_-3KM" (String#22297, DoABC#2)
// initHotelMergeUI = "_-2MZ" (String#19909, DoABC#2)
// showWelcomeScreen = "_-QV" (String#8213, DoABC#2)
// _SafeStr_11491 = "_-aK" (String#23646, DoABC#2)
// _SafeStr_11492 = "_-0aZ" (String#589, DoABC#2)
// _SafeStr_11493 = "_-1GE" (String#17125, DoABC#2)
// _tutorialUI = "_-25J" (String#19230, DoABC#2)
// _hotelMergeUI = "_-3Ja" (String#22267, DoABC#2)
// _callForHelpData = "_-09-" (String#14408, DoABC#2)
// _userRegistry = "_-0KV" (String#14860, DoABC#2)
// _ownUserName = "_-1nP" (String#5807, DoABC#2)
// _SafeStr_11499 = "_-1gv" (String#18173, DoABC#2)
// toggleHelpUI = "_-03n" (String#14193, DoABC#2)
// createHelpUI = "_-WF" (String#23500, DoABC#2)
// createTutorialUI = "_-08Q" (String#14381, DoABC#2)
// onLocalizationManagerReady = "_-Za" (String#936, DoABC#2)
// onConfigurationManagerReady = "_-1OV" (String#604, DoABC#2)
// IncomingMessages = "_-2Xb" (String#216, DoABC#2)
// WelcomeNotification = "_-ka" (String#8616, DoABC#2)
// UserRegistry = "_-1w-" (String#18798, DoABC#2)
// CallForHelpData = "_-4I" (String#22389, DoABC#2)
// FaqIndex = "_-3I0" (String#7667, DoABC#2)
// HotelMergeUI = "_-XE" (String#8353, DoABC#2)
// HabboHelpViewEnum = "_-1e7" (String#18062, DoABC#2)
// WelcomeScreenController = "_-08g" (String#3733, DoABC#2)
// TutorialUI = "_-38o" (String#7488, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// RSE_STARTED = "_-oj" (String#24224, DoABC#2)
// RSE_ENDED = "_-ar" (String#23665, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// unregisterRoom = "_-2Uo" (String#20230, DoABC#2)
// _toolbar = "_-1LG" (String#93, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// onHabboToolbarEvent = "_-0Ve" (String#435, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// HotelMergeUI = "_-1qU" (String#5864, DoABC#2)
// reportUser = "_-233" (String#6107, DoABC#2)
// HHVE_CFG_TOPIC_SELECT = "_-2-u" (String#19007, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// HabboInventory = "_-1gE" (String#860, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// IHabboToolbar = "_-0Wr" (String#4245, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// onCommunicationManagerReady = "_-3A0" (String#914, DoABC#2)


