
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.inventory.IHabboInventory;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboInventory;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboCatalog;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.avatar.enum.AvatarRenderEvent;
    import flash.events.Event;
    import com.sulake.habbo.avatar.enum.AvatarEditorEvent;

    public class HabboAvatarEditorManager extends Component implements IHabboAvatarEditor 
    {

        private var _windowManager:IHabboWindowManager;
        private var _avatarRenderManager:IAvatarRenderManager;
        private var _inventory:IHabboInventory;
        private var _localization:IHabboLocalizationManager;
        private var _configuration:IHabboConfigurationManager;
        private var _communication:IHabboCommunicationManager;
        private var _catalog:IHabboCatalog;
        private var _sessionData:ISessionDataManager;
        private var _handler:AvatarEditorMessageHandler;
        private var _SafeStr_10236:Map;

        public function HabboAvatarEditorManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerReady);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRenderManagerReady);
            queueInterface(new IIDHabboInventory(), this.onInventoryReady);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationReady);
            queueInterface(new IIDHabboCatalog(), this.onCatalogReady);
            queueInterface(new IIDSessionDataManager(), this.onSessionDataManagerReady);
            this._SafeStr_10236 = new Map();
        }
        override public function dispose():void
        {
            var _local_1:HabboAvatarEditor;
            if (this._SafeStr_10236){
                for each (_local_1 in this._SafeStr_10236) {
                    _local_1.dispose();
                    _local_1 = null;
                };
                this._SafeStr_10236 = null;
            };
            if (this._configuration != null){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            if (this._communication != null){
                this._communication.release(new IIDHabboCommunicationManager());
                this._communication = null;
            };
            if (this._catalog != null){
                this._catalog.release(new IIDHabboCatalog());
                this._catalog = null;
            };
            if (this._localization != null){
                this._localization.release(new IIDHabboLocalizationManager());
                this._localization = null;
            };
            if (this._avatarRenderManager != null){
                this._avatarRenderManager.release(new IIDAvatarRenderManager());
                this._avatarRenderManager = null;
            };
            if (this._windowManager != null){
                this._windowManager.release(new IIDHabboWindowManager());
                this._windowManager = null;
            };
            if (this._inventory != null){
                this._inventory.release(new IIDHabboInventory());
                this._inventory = null;
            };
            if (this._handler != null){
                this._handler.dispose();
                this._handler = null;
            };
            super.dispose();
        }
        public function openEditor(_arg_1:uint, _arg_2:IHabboAvatarEditorDataSaver, _arg_3:Array=null, _arg_4:Boolean=false, _arg_5:String=null):IFrameWindow
        {
            var _local_6:HabboAvatarEditor = this._SafeStr_10236.getValue(_arg_1);
            if (!_local_6){
                _local_6 = new HabboAvatarEditor(_arg_1, this);
                this._SafeStr_10236.add(_arg_1, _local_6);
            };
            return (_local_6.openWindow(_arg_2, _arg_3, _arg_4, _arg_5));
        }
        public function embedEditorToContext(_arg_1:uint, _arg_2:IWindowContainer, _arg_3:IHabboAvatarEditorDataSaver=null, _arg_4:Array=null, _arg_5:Boolean=false):Boolean
        {
            var _local_6:HabboAvatarEditor = this._SafeStr_10236.getValue(_arg_1);
            if (_local_6){
                _local_6.dispose();
            };
            _local_6 = new HabboAvatarEditor(_arg_1, this);
            this._SafeStr_10236.add(_arg_1, _local_6);
            _local_6.embedToContext(_arg_2, _arg_3, _arg_4, _arg_5);
            return (true);
        }
        public function loadAvatarInEditor(_arg_1:uint, _arg_2:String, _arg_3:String, _arg_4:int=0):void
        {
            var _local_5:HabboAvatarEditor = (this._SafeStr_10236.getValue(_arg_1) as HabboAvatarEditor);
            if (_local_5){
                return (_local_5.loadAvatarInEditor(_arg_2, _arg_3, _arg_4));
            };
        }
        public function loadOwnAvatarInEditor(_arg_1:uint):void
        {
            var _local_2:HabboAvatarEditor = (this._SafeStr_10236.getValue(_arg_1) as HabboAvatarEditor);
            if (_local_2){
                return (_local_2.loadAvatarInEditor(this.sessionData.figure, this.sessionData.gender, this.sessionData.clubLevel));
            };
        }
        public function close(_arg_1:uint):void
        {
            var _local_2:HabboAvatarEditor = (this._SafeStr_10236.getValue(_arg_1) as HabboAvatarEditor);
            if (!_local_2){
                return;
            };
            switch (_arg_1){
                case AvatarEditorInstanceId._SafeStr_6812:
                    _local_2.hide();
                    return;
                case AvatarEditorInstanceId._SafeStr_7384:
                    _local_2.hide();
                    _local_2.dispose();
                    this._SafeStr_10236.remove(_arg_1);
                    return;
                default:
                    _local_2.dispose();
                    this._SafeStr_10236.remove(_arg_1);
            };
        }
        public function getEditor(_arg_1:uint):HabboAvatarEditor
        {
            return ((this._SafeStr_10236.getValue(_arg_1) as HabboAvatarEditor));
        }
        public function get localization():IHabboLocalizationManager
        {
            return (this._localization);
        }
        public function get configuration():IHabboConfigurationManager
        {
            return (this._configuration);
        }
        public function get windowManager():IHabboWindowManager
        {
            return (this._windowManager);
        }
        public function get avatarRenderManager():IAvatarRenderManager
        {
            return (this._avatarRenderManager);
        }
        private function onWindowManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        private function onCatalogReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._catalog = (_arg_2 as IHabboCatalog);
        }
        private function onSessionDataManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._sessionData = (_arg_2 as ISessionDataManager);
        }
        private function onAvatarRenderManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._avatarRenderManager = (_arg_2 as IAvatarRenderManager);
            (this._avatarRenderManager as Component).events.addEventListener(AvatarRenderEvent.AVATAR_RENDER_READY, this.onAvatarRendererReady);
        }
        private function onAvatarRendererReady(_arg_1:Event=null):void
        {
            this.events.dispatchEvent(new Event(AvatarEditorEvent.AVATAR_EDITOR_READY));
        }
        private function onInventoryReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._inventory = (_arg_2 as IHabboInventory);
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._configuration = (_arg_2 as IHabboConfigurationManager);
        }
        private function onCommunicationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._communication = (_arg_2 as IHabboCommunicationManager);
            this._handler = new AvatarEditorMessageHandler(this, this._communication);
        }
        private function onLocalizationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            if (disposed){
                return;
            };
            this._localization = (_arg_2 as IHabboLocalizationManager);
        }
        public function get communication():IHabboCommunicationManager
        {
            return (this._communication);
        }
        public function get handler():AvatarEditorMessageHandler
        {
            return (this._handler);
        }
        public function get catalog():IHabboCatalog
        {
            return (this._catalog);
        }
        public function get sessionData():ISessionDataManager
        {
            return (this._sessionData);
        }

    }
}//package com.sulake.habbo.avatar

// IID = "_-3KV" (String#7712, DoABC#2)
// embedEditorToContext = "_-1qC" (String#5860, DoABC#2)
// getEditor = "_-z1" (String#24651, DoABC#2)
// _sessionData = "_-2Bw" (String#1831, DoABC#2)
// _SafeStr_10236 = "_-C5" (String#22695, DoABC#2)
// onCommunicationReady = "_-3Ix" (String#372, DoABC#2)
// onSessionDataManagerReady = "_-0C-" (String#240, DoABC#2)
// onAvatarRendererReady = "_-27F" (String#19301, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// IHabboAvatarEditor = "_-N2" (String#8144, DoABC#2)
// AvatarRenderEvent = "_-2lI" (String#20894, DoABC#2)
// IHabboCatalog = "_-1fJ" (String#5651, DoABC#2)
// IHabboAvatarEditorDataSaver = "_-0EA" (String#3831, DoABC#2)
// AvatarEditorInstanceId = "_-3Bn" (String#21953, DoABC#2)
// AvatarEditorMessageHandler = "_-2jV" (String#6945, DoABC#2)
// AvatarEditorEvent = "_-0mu" (String#15934, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// _handler = "_-1Eb" (String#5153, DoABC#2)
// sessionData = "_-3Fb" (String#22101, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// _inventory = "_-1O" (String#113, DoABC#2)
// _avatarRenderManager = "_-2uU" (String#454, DoABC#2)
// IHabboInventory = "_-ud" (String#8776, DoABC#2)
// openEditor = "_-86" (String#2059, DoABC#2)
// _SafeStr_6812 = "_-2OT" (String#19984, DoABC#2)
// loadOwnAvatarInEditor = "_-ae" (String#2135, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _SafeStr_7384 = "_-J9" (String#22973, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// onWindowManagerReady = "_-34x" (String#94, DoABC#2)
// onLocalizationReady = "_-uK" (String#167, DoABC#2)
// onCatalogReady = "_-27M" (String#245, DoABC#2)
// onInventoryReady = "_-dE" (String#374, DoABC#2)
// openWindow = "_-1na" (String#18444, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)


