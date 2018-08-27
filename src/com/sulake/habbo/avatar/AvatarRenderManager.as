
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.avatar.pets.PetDataManager;
    import com.sulake.habbo.avatar.palette.PaletteManager;
    import com.sulake.habbo.avatar.enum.RenderMode;
    import com.sulake.habbo.avatar.enum.AvatarType;
    import com.sulake.habbo.avatar.structure.parts.PartOffsetData;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.habbo.avatar.enum.AvatarRendererUpdateEvent;
    import com.sulake.habbo.avatar.structure.AvatarStructureDownload;
    import com.sulake.habbo.avatar.structure.IStructureData;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.avatar.enum.AvatarRenderEvent;
    import com.sulake.habbo.avatar.structure.IFigureData;
    import com.sulake.habbo.avatar.animation.IAnimationManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.avatar.pets.IPetDataManager;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.core.utils.ErrorReportStorage;
    import com.sulake.iid.*;

    public class AvatarRenderManager extends Component implements IAvatarRenderManager 
    {

        private const _SafeStr_10206:String = "hd-99999-99999";

        private var _aliasCollection:AssetAliasCollection;
        private var _SafeStr_10207:Map;
        private var _configuration:IHabboConfigurationManager;
        private var _SafeStr_10208:PetDataManager;
        private var _paletteManager:PaletteManager;
        private var _mode:String;
        private var _SafeStr_10210:Map;
        private var _SafeStr_10211:AvatarAssetDownloadManager;
        private var _SafeStr_10212:AvatarFigureContainer;
        private var _SafeStr_10213:Boolean = false;
        private var _SafeStr_10214:Boolean = false;
        private var _SafeStr_10215:Boolean = false;
        private var _isReady:Boolean = false;

        public function AvatarRenderManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            var _local_4:AvatarStructure;
            _arg_2 = (_arg_2 | _SafeStr_8979);
            super(_arg_1, _arg_2, _arg_3);
            this._mode = RenderMode._SafeStr_9976;
            this._SafeStr_10210 = new Map();
            this._SafeStr_10207 = new Map();
            _local_4 = new AvatarStructure(this, AvatarType._SafeStr_9974, PartOffsetData.getInstance(_arg_1.assets));
            _local_4.initGeometry((_arg_3.getAssetByName("HabboAvatarGeometry").content as XML));
            _local_4.initActions(_arg_3, (_arg_3.getAssetByName("HabboAvatarActions").content as XML));
            _local_4.initPartSets((_arg_3.getAssetByName("HabboAvatarPartSets").content as XML));
            _local_4.initAnimation((_arg_3.getAssetByName("HabboAvatarAnimation").content as XML));
            _local_4.initFigureData((_arg_3.getAssetByName("HabboAvatarFigure").content as XML));
            this._SafeStr_10207.add(AvatarType._SafeStr_9974, _local_4);
            _local_4 = new AvatarStructure(this, AvatarType._SafeStr_6769, PartOffsetData.getInstance(_arg_1.assets));
            _local_4.initGeometry((_arg_3.getAssetByName("HabboAvatarPetGeometry").content as XML));
            _local_4.initActions(_arg_3, (_arg_3.getAssetByName("HabboAvatarPetActions").content as XML));
            _local_4.initPartSets((_arg_3.getAssetByName("HabboAvatarPetPartSets").content as XML));
            _local_4.initAnimation((_arg_3.getAssetByName("HabboAvatarPetAnimation").content as XML));
            _local_4.initFigureData((_arg_3.getAssetByName("HabboAvatarPetFigure").content as XML));
            this._SafeStr_10207.add(AvatarType._SafeStr_6769, _local_4);
            this._aliasCollection = new AssetAliasCollection(this, (_arg_1.assets as AssetLibraryCollection));
            this._SafeStr_10208 = new PetDataManager(this, (_arg_1.assets as AssetLibraryCollection));
            this._paletteManager = new PaletteManager((_arg_1.assets as AssetLibraryCollection));
            var _local_5:XML = (_arg_3.getAssetByName("HabboAvatarPetFigure").content as XML);
            this._SafeStr_10208.populateFigureData(_local_5);
            _arg_1.events.addEventListener(Component.COMPONENT_EVENT_RUNNING, this.onAllModulesReadyAndRunning);
            queueInterface(new IIDHabboConfigurationManager(), this.onHabboConfigurationReady);
        }
        override public function dispose():void
        {
            var _local_1:AvatarStructure;
            if (this._configuration){
                this._configuration.release(new IIDHabboConfigurationManager());
                this._configuration = null;
            };
            super.dispose();
            if (this._SafeStr_10207 != null){
                for each (_local_1 in this._SafeStr_10207.getValues()) {
                    _local_1.dispose();
                };
                this._SafeStr_10207.dispose();
                this._SafeStr_10207 = null;
            };
            if (this._SafeStr_10208 != null){
                this._SafeStr_10208.dispose();
                this._SafeStr_10208 = null;
            };
            if (this._paletteManager != null){
                this._paletteManager.dispose();
                this._paletteManager = null;
            };
            if (this._aliasCollection != null){
                this._aliasCollection.dispose();
                this._aliasCollection = null;
            };
            if (this._SafeStr_10210){
                this._SafeStr_10210.dispose();
                this._SafeStr_10210 = null;
            };
            if (this._SafeStr_10211){
                this._SafeStr_10211.removeEventListener(Event.COMPLETE, this.onAvatarAssetsDownloadManagerReady);
                this._SafeStr_10211.dispose();
                this._SafeStr_10211 = null;
            };
            PartOffsetData.dispose();
        }
        private function onAllModulesReadyAndRunning(_arg_1:Event):void
        {
            var _local_2:AvatarStructure;
            this._aliasCollection.init();
            this._SafeStr_10208.init();
            this._paletteManager.init();
            _local_2 = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
            if (_local_2){
                _local_2.resetPartOffsets(context.assets);
                _local_2.registerAnimations((context.assets as AssetLibraryCollection), "fx", 500);
                _local_2.registerAnimations((context.assets as AssetLibraryCollection), "dance", 200);
            };
            _local_2 = (this._SafeStr_10207.getValue(AvatarType._SafeStr_6769) as AvatarStructure);
            if (_local_2){
                _local_2.resetPartOffsets(context.assets);
            };
            this._SafeStr_10213 = true;
            this.events.dispatchEvent(new Event(AvatarRendererUpdateEvent.AVATAR_RENDERER_ANIMATIONS_INITIALIZED_EVENT));
            this.checkIfReady();
        }
        private function onHabboConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_3:AvatarStructure;
            var _local_4:String;
            var _local_5:AvatarStructureDownload;
            var _local_6:String;
            var _local_7:String;
            if (_arg_2 != null){
                this._configuration = (_arg_2 as IHabboConfigurationManager);
                _local_3 = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
                if (_local_3 != null){
                    _local_4 = this._configuration.getKey("external.figurepartlist.txt", "figure.xml");
                    if (assets.hasAsset(_local_4)){
                        assets.removeAsset(assets.getAssetByName(_local_4));
                    };
                    _local_5 = new AvatarStructureDownload(assets, _local_4, (_local_3.figureData as IStructureData));
                    _local_5.addEventListener(AvatarStructureDownload.AVATAR_STRUCTURE_DONE, this.onFigureDataDownloadDone);
                    if (this._SafeStr_10211 == null){
                        Logger.log("[AvatarRenderManager] Init Avatar Assets Download Manager");
                        _local_6 = this._configuration.getKey("flash.dynamic.avatar.download.configuration", "figuremap.xml");
                        _local_7 = this._configuration.getKey("flash.dynamic.avatar.download.url", "");
                        this._SafeStr_10211 = new AvatarAssetDownloadManager(context.assets, _local_6, _local_7, _local_3);
                        this._SafeStr_10211.addEventListener(Event.COMPLETE, this.onAvatarAssetsDownloadManagerReady);
                    };
                };
            };
        }
        private function onFigureDataDownloadDone(_arg_1:Event=null):void
        {
            Logger.log((this + " Figure Data Download Done"));
            this._SafeStr_10215 = true;
            this.checkIfReady();
        }
        private function onAvatarAssetsDownloadManagerReady(_arg_1:Event=null):void
        {
            this._SafeStr_10214 = true;
            this.checkIfReady();
        }
        private function checkIfReady():void
        {
            if (!this._isReady){
                if (((((this._SafeStr_10213) && (this._SafeStr_10214))) && (this._SafeStr_10215))){
                    this._isReady = true;
                    this.events.dispatchEvent(new Event(AvatarRenderEvent.AVATAR_RENDER_READY));
                };
            };
        }
        public function createFigureContainer(_arg_1:String):IAvatarFigureContainer
        {
            return (new AvatarFigureContainer(_arg_1));
        }
        public function isFigureReady(_arg_1:IAvatarFigureContainer):Boolean
        {
            if (!this._SafeStr_10211){
                return (false);
            };
            return (this._SafeStr_10211.isReady(_arg_1));
        }
        public function downloadFigure(_arg_1:IAvatarFigureContainer, _arg_2:IAvatarImageListener):void
        {
            if (!this._SafeStr_10211){
                return;
            };
            this._SafeStr_10211.loadFigureSetData(_arg_1, _arg_2);
        }
        public function createAvatarImage(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:IAvatarImageListener=null):IAvatarImage
        {
            var _local_5:AvatarStructure = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
            if (_local_5 == null){
                return (null);
            };
            if (!this._SafeStr_10211){
                return (null);
            };
            var _local_6:AvatarFigureContainer = new AvatarFigureContainer(_arg_1);
            if (_arg_3){
                this.validateAvatarFigure(_local_6, _arg_3);
            };
            if (this._SafeStr_10211.isReady(_local_6)){
                return (new AvatarImage(_local_5, this._aliasCollection, _local_6, _arg_2));
            };
            if (!this._SafeStr_10212){
                this._SafeStr_10212 = new AvatarFigureContainer(this._SafeStr_10206);
            };
            this._SafeStr_10211.loadFigureSetData(_local_6, _arg_4);
            return (new PlaceholderAvatarImage(_local_5, this._aliasCollection, this._SafeStr_10212, _arg_2));
        }
        public function removePetImageListener(_arg_1:IPetImageListener):void
        {
            var _local_2:String;
            var _local_3:Array;
            var _local_4:int;
            if ((((_arg_1 == null)) || ((this._SafeStr_10210 == null)))){
                return;
            };
            for each (_local_2 in this._SafeStr_10210.getKeys()) {
                _local_3 = this._SafeStr_10210.getValue(_local_2);
                if (_local_3 != null){
                    _local_4 = _local_3.indexOf(_arg_1);
                    if (_local_4 != -1){
                        _local_3.splice(_local_4, 1);
                    };
                };
            };
        }
        public function createPetImageFromFigure(_arg_1:String, _arg_2:String, _arg_3:IPetImageListener=null):IAvatarImage
        {
            if (_arg_1.indexOf(" ") == -1){
                return (null);
            };
            var _local_4:Array = _arg_1.split(" ");
            if (_local_4.length == 0){
                return (null);
            };
            var _local_5:int = int(_local_4[0]);
            var _local_6:int = int(_local_4[1]);
            var _local_7:uint = parseInt(_local_4[2], 16);
            return (this.createPetImage(_local_5, _local_6, _local_7, _arg_2, _arg_3));
        }
        public function getPetFigureString(_arg_1:String):String
        {
            if (_arg_1.indexOf(" ") == -1){
                return (null);
            };
            var _local_2:Array = _arg_1.split(" ");
            if (_local_2.length == 0){
                return (null);
            };
            var _local_3:int = int(_local_2[0]);
            var _local_4:int = int(_local_2[1]);
            var _local_5:uint = parseInt(_local_2[2], 16);
            return (this._SafeStr_10208.createPetFigureString(_local_3, _local_4, _local_5));
        }
        public function createPetImage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:String, _arg_5:IPetImageListener=null):IAvatarImage
        {
            var _local_9:Array;
            var _local_6:Boolean;
            if (this.mode != RenderMode._SafeStr_9978){
                _local_6 = !(this._SafeStr_10208.assetsReady(_arg_1, _arg_4));
            };
            var _local_7:String = this._SafeStr_10208.createPetFigureString(_arg_1, _arg_2, _arg_3);
            var _local_8:AvatarStructure = (this._SafeStr_10207.getValue(AvatarType._SafeStr_6769) as AvatarStructure);
            if (_local_8 == null){
                return (null);
            };
            if (!_local_6){
                return (new PetImage(_local_8, this._aliasCollection, _local_7, _arg_4));
            };
            if (_arg_5 != null){
                _local_9 = this._SafeStr_10210[_local_7];
                if (!_local_9){
                    _local_9 = [];
                };
                if (_local_9.indexOf(_arg_5) == -1){
                    _local_9.push(_arg_5);
                };
                this._SafeStr_10210.add(_local_7, _local_9);
            };
            return (new PlaceholderPetImage(_local_8, this._aliasCollection, _local_7, _arg_4, assets));
        }
        public function resetPetData():void
        {
            var _local_3:IPetImageListener;
            var _local_4:Array;
            var _local_6:String;
            this._aliasCollection.reset();
            this._SafeStr_10208.reset();
            this._paletteManager.reset();
            var _local_1:XML = (assets.getAssetByName("HabboAvatarPetFigure").content as XML);
            this._SafeStr_10208.populateFigureData(_local_1);
            var _local_2:AvatarStructure = this._SafeStr_10207.getValue(AvatarType._SafeStr_6769);
            _local_2.initFigureData(_local_1);
            _local_2.resetPartOffsets(context.assets);
            var _local_5:Array = this._SafeStr_10210.getKeys();
            for each (_local_6 in _local_5) {
                _local_4 = this._SafeStr_10210.getValue(_local_6);
                if (_local_4){
                    for each (_local_3 in _local_4) {
                        if (((!((_local_3 == null))) && (!(_local_3.disposed)))){
                            _local_3.petImageReady(_local_6);
                        };
                    };
                };
            };
            this._SafeStr_10210.reset();
        }
        public function getFigureData(_arg_1:String):IFigureData
        {
            var _local_2:AvatarStructure = (this._SafeStr_10207.getValue(_arg_1) as AvatarStructure);
            if (_local_2 != null){
                return (_local_2.figureData);
            };
            return (null);
        }
        public function getAnimationManager(_arg_1:String):IAnimationManager
        {
            var _local_2:AvatarStructure = (this._SafeStr_10207.getValue(_arg_1) as AvatarStructure);
            if (_local_2 != null){
                return (_local_2.animationManager);
            };
            return (null);
        }
        public function getMandatoryAvatarPartSetIds(_arg_1:String, _arg_2:int):Array
        {
            var _local_3:AvatarStructure = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
            return (_local_3.getMandatorySetTypeIds(_arg_1, _arg_2));
        }
        public function getAssetByName(_arg_1:String):IAsset
        {
            return (this._aliasCollection.getAssetByName(_arg_1));
        }
        public function get petDataManager():IPetDataManager
        {
            return ((this._SafeStr_10208 as IPetDataManager));
        }
        public function get paletteManager():PaletteManager
        {
            return (this._paletteManager);
        }
        public function get mode():String
        {
            return (this._mode);
        }
        public function set mode(_arg_1:String):void
        {
            this._mode = _arg_1;
        }
        public function injectFigureData(_arg_1:String, _arg_2:XML):void
        {
            var _local_3:AvatarStructure;
            switch (_arg_1){
                case AvatarType._SafeStr_9974:
                    _local_3 = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
                    break;
                case AvatarType._SafeStr_6769:
                    _local_3 = (this._SafeStr_10207.getValue(AvatarType._SafeStr_6769) as AvatarStructure);
                    break;
                default:
                    Logger.log(("Uknown avatar type: " + _arg_1));
            };
            if (_local_3 != null){
                _local_3.injectFigureData(_arg_2);
            };
        }
        private function validateAvatarFigure(_arg_1:AvatarFigureContainer, _arg_2:String):Boolean
        {
            var _local_4:Boolean;
            var _local_7:IFigureData;
            var _local_8:String;
            var _local_9:IFigurePartSet;
            var _local_10:ISetType;
            var _local_11:IFigurePartSet;
            var _local_12:IFigurePartSet;
            if (!this._SafeStr_10207){
                ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: _structures is null!");
            };
            var _local_3:AvatarStructure = (this._SafeStr_10207.getValue(AvatarType._SafeStr_9974) as AvatarStructure);
            if (!_local_3){
                ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: structure is null!");
            };
            var _local_5:int = 2;
            var _local_6:Array = _local_3.getMandatorySetTypeIds(_arg_2, _local_5);
            if (_local_6){
                _local_7 = _local_3.figureData;
                if (!_local_7){
                    ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: figureData is null!");
                };
                for each (_local_8 in _local_6) {
                    if (!_arg_1.hasPartType(_local_8)){
                        _local_9 = _local_3.getDefaultPartSet(_local_8, _arg_2);
                        if (_local_9){
                            _arg_1.updatePart(_local_8, _local_9.id, [0]);
                            _local_4 = true;
                        };
                    }
                    else {
                        _local_10 = _local_7.getSetType(_local_8);
                        if (!_local_10){
                            ErrorReportStorage.addDebugData("AvatarRenderManager", "validateAvatarFigure: setType is null!");
                        };
                        _local_11 = _local_10.getPartSet(_arg_1.getPartSetId(_local_8));
                        if (!_local_11){
                            _local_12 = _local_3.getDefaultPartSet(_local_8, _arg_2);
                            if (_local_12){
                                _arg_1.updatePart(_local_8, _local_12.id, [0]);
                                _local_4 = true;
                            };
                        };
                    };
                };
            };
            return (!(_local_4));
        }
        public function resetAssetManager():void
        {
            this._aliasCollection.reset();
        }

    }
}//package com.sulake.habbo.avatar

// IID = "_-3KV" (String#7712, DoABC#2)
// assetsReady = "_-0jq" (String#15821, DoABC#2)
// createPetFigureString = "_-0Qm" (String#15092, DoABC#2)
// populateFigureData = "_-0OV" (String#15007, DoABC#2)
// resetPetData = "_-0tj" (String#16192, DoABC#2)
// getSetType = "_-0CE" (String#3795, DoABC#2)
// AVATAR_STRUCTURE_DONE = "_-1tb" (String#18701, DoABC#2)
// getMandatorySetTypeIds = "_-1Qh" (String#17541, DoABC#2)
// hasPartType = "_-064" (String#3687, DoABC#2)
// loadFigureSetData = "_-2SQ" (String#20135, DoABC#2)
// resetPartOffsets = "_-19j" (String#16845, DoABC#2)
// initGeometry = "_-3JM" (String#22258, DoABC#2)
// initActions = "_-0PK" (String#15036, DoABC#2)
// initPartSets = "_-2QC" (String#20054, DoABC#2)
// initAnimation = "_-2Ou" (String#19998, DoABC#2)
// initFigureData = "_-1xy" (String#18885, DoABC#2)
// injectFigureData = "_-2vT" (String#7186, DoABC#2)
// registerAnimations = "_-2dG" (String#20574, DoABC#2)
// animationManager = "_-Me" (String#23111, DoABC#2)
// getFigureData = "_-2tG" (String#7143, DoABC#2)
// getMandatoryAvatarPartSetIds = "_-1un" (String#5934, DoABC#2)
// getAnimationManager = "_-1Rm" (String#5394, DoABC#2)
// resetAssetManager = "_-2X6" (String#6702, DoABC#2)
// removePetImageListener = "_-1Uw" (String#5453, DoABC#2)
// _SafeStr_10206 = "_-1h2" (String#18177, DoABC#2)
// _SafeStr_10207 = "_-2xz" (String#21392, DoABC#2)
// _SafeStr_10208 = "_-0ZU" (String#15422, DoABC#2)
// _paletteManager = "_-2fV" (String#20669, DoABC#2)
// _SafeStr_10210 = "_-2dA" (String#20570, DoABC#2)
// _SafeStr_10211 = "_-0Bj" (String#14517, DoABC#2)
// _SafeStr_10212 = "_-1Cz" (String#16981, DoABC#2)
// _SafeStr_10213 = "_-1sa" (String#18658, DoABC#2)
// _SafeStr_10214 = "_-9b" (String#22603, DoABC#2)
// _SafeStr_10215 = "_-0-Z" (String#14034, DoABC#2)
// onAllModulesReadyAndRunning = "_-dl" (String#23790, DoABC#2)
// onAvatarAssetsDownloadManagerReady = "_-19q" (String#16850, DoABC#2)
// checkIfReady = "_-tR" (String#24424, DoABC#2)
// onFigureDataDownloadDone = "_-1sw" (String#18674, DoABC#2)
// validateAvatarFigure = "_-kg" (String#24056, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IPetDataManager = "_-03y" (String#3647, DoABC#2)
// IAnimationManager = "_-271" (String#6183, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// PetDataManager = "_-1Vw" (String#5470, DoABC#2)
// PetImage = "_-0in" (String#4477, DoABC#2)
// PlaceholderPetImage = "_-2mW" (String#7012, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// IStructureData = "_-fH" (String#8500, DoABC#2)
// AvatarStructureDownload = "_-11V" (String#4905, DoABC#2)
// AvatarFigureContainer = "_-04P" (String#14219, DoABC#2)
// AvatarType = "_-0ST" (String#15153, DoABC#2)
// RenderMode = "_-Hh" (String#22920, DoABC#2)
// AvatarAssetDownloadManager = "_-1o1" (String#5817, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// PaletteManager = "_-2kk" (String#6972, DoABC#2)
// AvatarImage = "_-as" (String#8437, DoABC#2)
// PlaceholderAvatarImage = "_-0dN" (String#4377, DoABC#2)
// AvatarRendererUpdateEvent = "_-0E7" (String#14612, DoABC#2)
// AvatarRenderEvent = "_-2lI" (String#20894, DoABC#2)
// PartOffsetData = "_-8B" (String#22548, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// getInstance = "_-n5" (String#24157, DoABC#2)
// addDebugData = "_-04r" (String#14235, DoABC#2)
// createPetImageFromFigure = "_-0Sk" (String#4153, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)
// getValues = "_-2U9" (String#20205, DoABC#2)
// mode = "_-3Cz" (String#2023, DoABC#2)
// _mode = "_-1kk" (String#611, DoABC#2)
// _SafeStr_6769 = "_-1Y9" (String#17821, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// getDefaultPartSet = "_-2J3" (String#19769, DoABC#2)
// petDataManager = "_-0y0" (String#4809, DoABC#2)
// createPetImage = "_-0Qk" (String#4105, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// getPetFigureString = "_-0DP" (String#1431, DoABC#2)
// paletteManager = "_-0SL" (String#15148, DoABC#2)
// onHabboConfigurationReady = "_-1P4" (String#1679, DoABC#2)
// ErrorReportStorage = "_-Yg" (String#8387, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// _isReady = "_-0tK" (String#4713, DoABC#2)
// _SafeStr_8979 = "_-0-o" (String#14046, DoABC#2)
// createFigureContainer = "_-vG" (String#8789, DoABC#2)
// isFigureReady = "_-1Ey" (String#5157, DoABC#2)
// downloadFigure = "_-20I" (String#6051, DoABC#2)
// updatePart = "_-1C9" (String#5112, DoABC#2)
// _SafeStr_9974 = "_-m7" (String#24114, DoABC#2)
// _SafeStr_9976 = "_-XW" (String#23544, DoABC#2)
// _SafeStr_9978 = "_-c0" (String#23714, DoABC#2)


