
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.habbo.communication.messages.parser.moderation.ModeratorInitData;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboNavigator;
    import com.sulake.iid.IIDHabboSoundManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.utils.HabboWebTools;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.IWindowContainer;

    public class ModerationManager extends Component implements IHabboModeration 
    {

        private var _windowManager:IHabboWindowManager;
        private var _communication:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _sessionDataManager:ISessionDataManager;
        private var _configuration:IHabboConfigurationManager;
        private var _navigator:IHabboNavigator;
        private var _soundManager:IHabboSoundManager;
        private var _messageHandler:ModerationMessageHandler;
        private var _issueManager:IssueManager;
        private var _startPanel:StartPanelCtrl;
        private var _windowTracker:WindowTracker;
        private var _initMsg:ModeratorInitData;
        private var _currentFlatId:int;

        public function ModerationManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboNavigator(), this.onNavigatorReady);
            queueInterface(new IIDHabboSoundManager(), this.onSoundManagerReady);
            this._startPanel = new StartPanelCtrl(this);
            this._windowTracker = new WindowTracker();
        }
        override public function dispose():void
        {
            if (this._startPanel){
                this._startPanel.dispose();
                this._startPanel = null;
            };
            if (this._windowManager){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._communication){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._sessionDataManager){
                this._sessionDataManager.release(new IIDSessionDataManager());
                this._sessionDataManager = null;
            };
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._navigator){
                this._navigator.release(new IIDHabboNavigator());
                this._navigator = null;
            };
            if (this._soundManager){
                this._soundManager.release(new IIDHabboSoundManager());
                this._soundManager = null;
            };
            this._connection = null;
            super.dispose();
        }
        public function userSelected(_arg_1:int, _arg_2:String):void
        {
            Logger.log(((("USER SELECTED: " + _arg_1) + ", ") + _arg_2));
            this._startPanel.userSelected(_arg_1, _arg_2);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get sessionDataManager():ISessionDataManager
        {
            return (this._sessionDataManager);
        }
        public function get issueManager():IssueManager
        {
            return (this._issueManager);
        }
        public function get connection():IConnection
        {
            return (this._connection);
        }
        public function get startPanel():StartPanelCtrl
        {
            return (this._startPanel);
        }
        public function get initMsg():ModeratorInitData
        {
            return (this._initMsg);
        }
        public function get messageHandler():ModerationMessageHandler
        {
            return (this._messageHandler);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function get windowTracker():WindowTracker
        {
            return (this._windowTracker);
        }
        public function get currentFlatId():int
        {
            return (this._currentFlatId);
        }
        public function get soundManager():IHabboSoundManager
        {
            return (this._soundManager);
        }
        public function set initMsg(_arg_1:ModeratorInitData):void
        {
            this._initMsg = _arg_1;
        }
        public function set currentFlatId(_arg_1:int):void
        {
            this._currentFlatId = _arg_1;
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._windowManager = (_arg_2 as IHabboWindowManager);
            this._issueManager = new IssueManager(this);
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._communication = (_arg_2 as IHabboCommunicationManager);
            if (this._communication != null){
                this._connection = this._communication.HabboCommunicationManager(this.onConnectionReady);
                if (this._connection != null){
                    this.onConnectionReady(this._connection);
                };
            };
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (disposed){
                return;
            };
            if (_arg_1 != null){
                this._connection = _arg_1;
                this._messageHandler = new ModerationMessageHandler(this);
            };
        }
        private function onSessionDataReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._configuration = (_arg_2 as IHabboConfigurationManager);
        }
        private function onNavigatorReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._navigator = IHabboNavigator(_arg_2);
        }
        private function onSoundManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._soundManager = (_arg_2 as IHabboSoundManager);
        }
        public function getXmlWindow(_arg_1:String):IWindow
        {
            var _local_2:IAsset = assets.getAssetByName((_arg_1 + "_xml"));
            var _local_3:XmlAsset = XmlAsset(_local_2);
            return (this._windowManager.buildFromXML(XML(_local_3.content)));
        }
        public function openHkPage(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String = this.configuration.getKey(_arg_1);
            var _local_4:String = (_local_3 + _arg_2);
            var _local_5:String = "housekeeping";
            HabboWebTools.navigateToURL(_local_4, _local_5);
        }
        public function disableButton(_arg_1:Boolean, _arg_2:IWindowContainer, _arg_3:String):void
        {
            var _local_4:IButtonWindow = IButtonWindow(_arg_2.findChildByName(_arg_3));
            if (!_arg_1){
                _local_4.disable();
                _local_4.toolTipCaption = "No permission";
            };
        }
        public function goToRoom(_arg_1:int):void
        {
            Logger.log(("MOD: GO TO ROOM: " + _arg_1));
            this._navigator.goToRoom(_arg_1, false);
        }

    }
}//package com.sulake.habbo.moderation

// IID = "_-3KV" (String#7712, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// onSessionDataReady = "_-0J8" (String#3937, DoABC#2)
// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// issueManager = "_-277" (String#19296, DoABC#2)
// startPanel = "_-2XW" (String#20343, DoABC#2)
// currentFlatId = "_-2HL" (String#19698, DoABC#2)
// messageHandler = "_-2T6" (String#20168, DoABC#2)
// openHkPage = "_-mj" (String#24138, DoABC#2)
// _messageHandler = "_-0VF" (String#15253, DoABC#2)
// _startPanel = "_-06b" (String#14310, DoABC#2)
// _windowTracker = "_-0m6" (String#15899, DoABC#2)
// _initMsg = "_-wL" (String#24547, DoABC#2)
// _currentFlatId = "_-3L0" (String#22324, DoABC#2)
// onNavigatorReady = "_-1uN" (String#1781, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// StartPanelCtrl = "_-0Ej" (String#3844, DoABC#2)
// ModerationMessageHandler = "_-0Cg" (String#3804, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// ModeratorInitData = "_-0W" (String#4229, DoABC#2)
// IHabboNavigator = "_-2rk" (String#7118, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// soundManager = "_-1sN" (String#5892, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onSoundManagerReady = "_-2hg" (String#369, DoABC#2)
// IHabboModeration = "_-1nO" (String#5806, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)


