
package 
{
    import flash.display.Sprite;
    import com.sulake.core.runtime.ICore;
    import flash.display.DisplayObjectContainer;
    import com.sulake.habbo.tracking.HabboTracking;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import com.sulake.core.Core;
    import flash.external.ExternalInterface;
    import com.sulake.core.runtime.Component;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.runtime.events.LibraryProgressEvent;

    public class HabboMain extends Sprite 
    {

        private static const _SafeStr_14556:Number = 0.71;

        private var _SafeStr_9663:ICore;
        private var _SafeStr_14557:Boolean = false;
        private var _SafeStr_3426:DisplayObjectContainer;
        private var _SafeStr_13789:HabboTracking;

        public function HabboMain(_arg_1:DisplayObjectContainer)
        {
            this._SafeStr_3426 = _arg_1;
            this._SafeStr_3426.addEventListener(Event.COMPLETE, this.onCompleteEvent);
            this._SafeStr_3426.addEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            Logger.log(("Core version: " + Core.version));
        }
        private function dispose():void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this._SafeStr_3426){
                this._SafeStr_3426.removeEventListener(Event.COMPLETE, this.onCompleteEvent);
                this._SafeStr_3426.removeEventListener(ProgressEvent.PROGRESS, this.onProgressEvent);
                this._SafeStr_3426 = null;
            };
            if (parent){
                parent.removeChild(this);
            };
        }
        private function initializeCore():void
        {
            try {
                this._SafeStr_9663.initialize();
                if (ExternalInterface.available){
                    ExternalInterface.addCallback("unloading", this.unloading);
                };
            }
            catch(error:Error) {
                Habbo.trackLoginStep(Habbo._SafeStr_3407);
                Core.crash(("Failed to initialize the core: " + error.message), Core._SafeStr_9854, error);
            };
        }
        public function unloading():void
        {
            if (((this._SafeStr_9663) && (!(this._SafeStr_9663.disposed)))){
                this._SafeStr_9663.events.dispatchEvent(new Event(Event.UNLOAD));
            };
        }
        protected function onAddedToStage(event:Event=null):void
        {
            try {
                this.prepareCore();
            }
            catch(error:Error) {
                Habbo.trackLoginStep(Habbo._SafeStr_3407);
                Habbo.reportCrash(("Failed to prepare the core: " + error.message), Core._SafeStr_9854, error);
                Core.dispose();
            };
        }
        private function prepareCore():void
        {
            Habbo.trackLoginStep(Habbo._SafeStr_3406);
            this._SafeStr_9663 = Core.instantiate(stage, Core._SafeStr_8923);
            this._SafeStr_9663.events.addEventListener(Component.COMPONENT_EVENT_ERROR, this.onCoreError);
            this._SafeStr_9663.prepareComponent(CoreCommunicationFrameworkLib);
            this._SafeStr_9663.prepareComponent(HabboRoomObjectLogicLib);
            this._SafeStr_9663.prepareComponent(HabboRoomObjectVisualizationLib);
            this._SafeStr_9663.prepareComponent(RoomManagerLib);
            this._SafeStr_9663.prepareComponent(RoomSpriteRendererLib);
            this._SafeStr_9663.prepareComponent(HabboRoomSessionManagerLib);
            this._SafeStr_9663.prepareComponent(HabboAvatarRenderLib);
            this._SafeStr_9663.prepareComponent(HabboSessionDataManagerLib);
            this._SafeStr_9663.prepareComponent(HabboTrackingLib);
            this._SafeStr_9663.prepareComponent(HabboConfigurationCom);
            this._SafeStr_9663.prepareComponent(HabboLocalizationCom);
            this._SafeStr_9663.prepareComponent(HabboWindowManagerCom);
            this._SafeStr_9663.prepareComponent(HabboCommunicationCom);
            this._SafeStr_9663.prepareComponent(HabboCommunicationDemoCom);
            this._SafeStr_9663.prepareComponent(HabboNavigatorCom);
            this._SafeStr_9663.prepareComponent(HabboFriendListCom);
            this._SafeStr_9663.prepareComponent(HabboMessengerCom);
            this._SafeStr_9663.prepareComponent(HabboInventoryCom);
            this._SafeStr_9663.prepareComponent(HabboToolbarCom);
            this._SafeStr_9663.prepareComponent(HabboCatalogCom);
            this._SafeStr_9663.prepareComponent(HabboRoomEngineCom);
            this._SafeStr_9663.prepareComponent(HabboRoomUICom);
            this._SafeStr_9663.prepareComponent(HabboAvatarEditorCom);
            this._SafeStr_9663.prepareComponent(HabboNotificationsCom);
            this._SafeStr_9663.prepareComponent(HabboHelpCom);
            this._SafeStr_9663.prepareComponent(HabboAdManagerCom);
            this._SafeStr_9663.prepareComponent(HabboModerationCom);
            this._SafeStr_9663.prepareComponent(HabboUserDefinedRoomEventsCom);
            this._SafeStr_9663.prepareComponent(HabboSoundManagerFlash10Com);
            this._SafeStr_9663.prepareComponent(HabboQuestEngineCom);
            this._SafeStr_9663.prepareComponent(HabboFriendBarCom);
            this._SafeStr_9663.prepareComponent(HabboGroupsCom);
            this._SafeStr_13789 = HabboTracking.getInstance();
            var _local_1:AssetLoaderStruct = this._SafeStr_9663.assets.loadAssetFromFile("config.xml", new URLRequest("config_habbo.xml"));
            if (_local_1.assetLoader.ready){
                this.setupCoreConfigFromLoader(_local_1);
            }
            else {
                _local_1.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
                _local_1.addEventListener(AssetLoaderEvent._SafeStr_4221, this.configLoadedHandler);
            };
        }
        private function configLoadedHandler(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            _local_2 = (_arg_1.target as AssetLoaderStruct);
            _local_2.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.configLoadedHandler);
            _local_2.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.configLoadedHandler);
            if (_arg_1.type == AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE){
                this.setupCoreConfigFromLoader(_local_2);
            }
            else {
                Habbo.reportCrash((("Failed to download external configuration document " + _local_2.assetLoader.url) + "!"), Core._SafeStr_8935, null);
            };
        }
        private function setupCoreConfigFromLoader(_arg_1:AssetLoaderStruct):void
        {
            var _local_2:XmlAsset = (this._SafeStr_9663.assets.getAssetByName(_arg_1.assetName) as XmlAsset);
            if (((!(_local_2)) || (!(_local_2.content)))){
                Habbo.reportCrash("Download external configuration document is null!", Core._SafeStr_8935, null);
            };
            if (this._SafeStr_9663){
                this._SafeStr_9663.readConfigDocument(XML(_local_2.content), this._SafeStr_3426);
            }
            else {
                Habbo.reportCrash("Core vanished while downloading config document!", Core._SafeStr_8935, null);
            };
        }
        private function onEnterFrame(_arg_1:Event):void
        {
            var _local_2:Sprite;
            if (this._SafeStr_3426){
                _local_2 = (this._SafeStr_3426.getChildByName("background") as Sprite);
                if (_local_2){
                    _local_2.alpha = (_local_2.alpha - 0.01);
                    if (_local_2.alpha <= 0){
                    };
                };
                if (this._SafeStr_14557){
                    if (this._SafeStr_3426.alpha <= 0){
                        this.dispose();
                        this._SafeStr_14557 = false;
                    }
                    else {
                        this._SafeStr_3426.alpha = (this._SafeStr_3426.alpha - 0.1);
                    };
                };
            };
        }
        private function onCompleteEvent(_arg_1:Event):void
        {
            this.updateLoadingBar(this._SafeStr_3426, 1);
            this.initializeCore();
            this._SafeStr_14557 = true;
        }
        private function onProgressEvent(_arg_1:ProgressEvent):void
        {
            var _local_2:Number;
            var _local_3:Sprite;
            var _local_4:LibraryProgressEvent;
            if (this._SafeStr_3426){
                _local_2 = (_arg_1.bytesLoaded / _arg_1.bytesTotal);
                this.updateLoadingBar(this._SafeStr_3426, _local_2);
                _local_3 = (this._SafeStr_3426.getChildByName("background") as Sprite);
                if (_local_3){
                    _local_3.alpha = Math.min((1 - _local_2), _local_3.alpha);
                };
                if ((_arg_1 is LibraryProgressEvent)){
                    _local_4 = (_arg_1 as LibraryProgressEvent);
                    if ((((_local_4.fileName == "hh_human_fx.swf")) || ((_local_4.fileName == "hh_human_body.swf")))){
                        if (((this._SafeStr_13789) && (!(this._SafeStr_13789.disposed)))){
                            this._SafeStr_13789.trackGoogle("libraryLoaded", _local_4.fileName, _local_4.elapsedTime);
                        };
                    };
                };
            };
        }
        private function updateLoadingBar(_arg_1:DisplayObjectContainer, _arg_2:Number):void
        {
            var _local_9:int;
            var _local_10:int;
            var _local_3 = 200;
            var _local_4:int = 20;
            var _local_5:int = 1;
            var _local_6:int = 1;
            var _local_7:Sprite = (_arg_1.getChildByName(Habbo._SafeStr_3417) as Sprite);
            var _local_8:Sprite = (_local_7.getChildByName(Habbo._SafeStr_3418) as Sprite);
            var _local_11:int = (this._SafeStr_9663.getNumberOfFilesPending() + this._SafeStr_9663.getNumberOfFilesLoaded());
            var _local_12:Number = ((1 - _SafeStr_14556) + ((this._SafeStr_9663.getNumberOfFilesLoaded() / _local_11) * _SafeStr_14556));
            _local_8.x = (_local_5 + _local_6);
            _local_8.y = (_local_5 + _local_6);
            _local_8.graphics.clear();
            _local_9 = ((_local_4 - (_local_5 * 2)) - (_local_6 * 2));
            _local_10 = (((_local_3 - (_local_5 * 2)) - (_local_6 * 2)) * _local_12);
            _local_8.graphics.beginFill(0xFF0000);
            _local_8.graphics.drawRect(0, 0, _local_10, (_local_9 / 2));
            _local_8.graphics.endFill();
            _local_8.graphics.beginFill(0xB30000);
            _local_8.graphics.drawRect(0, (_local_9 / 2), _local_10, ((_local_9 / 2) + 1));
            _local_8.graphics.endFill();
        }
        public function onCoreError(_arg_1:Event):void
        {
            Habbo.trackLoginStep(Habbo._SafeStr_3407);
        }

    }
}//package 

// _SafeStr_13789 = "_-2HY" (String#6395, DoABC#2)
// _SafeStr_14556 = "_-1vd" (String#18782, DoABC#2)
// _SafeStr_14557 = "_-35f" (String#21718, DoABC#2)
// onCompleteEvent = "_-0L1" (String#14878, DoABC#2)
// onProgressEvent = "_-1Be" (String#16926, DoABC#2)
// initializeCore = "_-2Rd" (String#20105, DoABC#2)
// prepareCore = "_-Zl" (String#23625, DoABC#2)
// onCoreError = "_-3Ee" (String#22060, DoABC#2)
// setupCoreConfigFromLoader = "_-j5" (String#24002, DoABC#2)
// configLoadedHandler = "_-1go" (String#18167, DoABC#2)
// _SafeStr_3406 = "_-fC" (String#23855, DoABC#2)
// _SafeStr_3407 = "_-2Kn" (String#19836, DoABC#2)
// _SafeStr_3417 = "_-2hE" (String#20738, DoABC#2)
// _SafeStr_3418 = "_-0wz" (String#16310, DoABC#2)
// _SafeStr_3426 = "_-2GU" (String#19660, DoABC#2)
// onAddedToStage = "_-0EB" (String#14614, DoABC#2)
// trackLoginStep = "_-2T-" (String#20162, DoABC#2)
// reportCrash = "_-lB" (String#24076, DoABC#2)
// onEnterFrame = "_-20T" (String#6057, DoABC#2)
// updateLoadingBar = "_-087" (String#14371, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// ICore = "_-2kX" (String#6966, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// LibraryProgressEvent = "_-26o" (String#19282, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)
// elapsedTime = "_-3Cm" (String#21986, DoABC#2)
// fileName = "_-1MC" (String#17367, DoABC#2)
// crash = "_-1--" (String#16429, DoABC#2)
// _SafeStr_8923 = "_-3J" (String#22237, DoABC#2)
// getNumberOfFilesPending = "_-2Yn" (String#6742, DoABC#2)
// getNumberOfFilesLoaded = "_-2cq" (String#6808, DoABC#2)
// readConfigDocument = "_-0ct" (String#4365, DoABC#2)
// _SafeStr_8935 = "_-0DA" (String#14575, DoABC#2)
// prepareComponent = "_-hI" (String#8541, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9663 = "_-2Gg" (String#6381, DoABC#2)
// _SafeStr_9854 = "_-1Pp" (String#17502, DoABC#2)
// instantiate = "_-Pb" (String#23231, DoABC#2)


