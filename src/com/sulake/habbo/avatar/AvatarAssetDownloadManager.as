
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.utils.Timer;
    import com.sulake.core.assets.XmlAsset;
    import flash.net.URLRequest;
    import com.sulake.core.assets.IAsset;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.habbo.utils.HabboWebTools;
    import flash.events.Event;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.figure.FigurePart;
    import com.sulake.habbo.avatar.structure.IFigureData;

    public class AvatarAssetDownloadManager extends EventDispatcher 
    {

        private const _SafeStr_10105:int = 100;
        private const _SafeStr_9017:int = 2;

        private var _SafeStr_10106:Dictionary;
        private var _assets:IAssetLibrary;
        private var _SafeStr_10107:Dictionary;
        private var _SafeStr_8865:Dictionary;
        private var _structure:AvatarStructure;
        private var _SafeStr_10108:String;
        private var _SafeStr_10109:String;
        private var _SafeStr_10110:Boolean;
        private var _SafeStr_10111:int = 3;
        private var _SafeStr_10112:AssetLoaderStruct;
        private var _SafeStr_10113:Timer;
        private var _SafeStr_10114:Array;
        private var _SafeStr_10115:Array;
        private var _SafeStr_10116:Array;

        public function AvatarAssetDownloadManager(_arg_1:IAssetLibrary, _arg_2:String, _arg_3:String, _arg_4:AvatarStructure)
        {
            var _local_7:XmlAsset;
            var _local_8:XML;
            super();
            this._SafeStr_10106 = new Dictionary();
            this._assets = _arg_1;
            this._structure = _arg_4;
            this._SafeStr_10107 = new Dictionary();
            this._SafeStr_10108 = _arg_3;
            this._SafeStr_10109 = _arg_2;
            this._SafeStr_8865 = new Dictionary();
            this._SafeStr_10114 = [];
            this._SafeStr_10115 = [];
            this._SafeStr_10116 = [];
            var _local_5:URLRequest = new URLRequest(_arg_2);
            var _local_6:IAsset = this._assets.getAssetByName("figuremap");
            if (_local_6 == null){
                this._SafeStr_10112 = this._assets.loadAssetFromFile("figuremap", _local_5, "text/xml");
                this.addMapLoaderEventListeners();
            }
            else {
                _local_7 = (this._assets.getAssetByName("figuremap") as XmlAsset);
                _local_8 = (_local_7.content as XML).copy();
                this.loadFigureMapData(_local_8);
            };
            this._SafeStr_10113 = new Timer(this._SafeStr_10105, 1);
            this._SafeStr_10113.addEventListener(TimerEvent.TIMER_COMPLETE, this.onNextDownloadTimeout);
        }
        override public function dispose():void
        {
            super.dispose();
            this._SafeStr_10106 = null;
            this._assets = null;
            this._SafeStr_10107 = null;
            this._SafeStr_8865 = null;
            this._structure = null;
            this._SafeStr_10115 = null;
            this._SafeStr_10114 = null;
            if (this._SafeStr_10113){
                this._SafeStr_10113.stop();
                this._SafeStr_10113 = null;
            };
            if (this._SafeStr_10112){
                this.removeMapLoaderEventListeners();
                this._SafeStr_10112 = null;
            };
        }
        private function addMapLoaderEventListeners():void
        {
            if (this._SafeStr_10112){
                this._SafeStr_10112.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onConfigurationComplete);
                this._SafeStr_10112.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onConfigurationError);
            };
        }
        private function removeMapLoaderEventListeners():void
        {
            if (this._SafeStr_10112){
                this._SafeStr_10112.removeEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onConfigurationComplete);
                this._SafeStr_10112.removeEventListener(AssetLoaderEvent._SafeStr_4221, this.onConfigurationError);
            };
        }
        private function onConfigurationError(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_3:URLRequest;
            this._SafeStr_10111--;
            if (this._SafeStr_10111 <= 0){
                HabboWebTools.logEventLog(("Figuremap download error " + this._SafeStr_10109));
                Logger.log("AVATAR ASSET ERROR: Could not download figuremap.xml.");
            }
            else {
                Logger.log(("Could not download figuremap.xml. Retries left: " + this._SafeStr_10111));
                if (this._SafeStr_10109.indexOf("?") > 0){
                    _local_2 = ((this._SafeStr_10109 + "&retry=") + this._SafeStr_10111);
                }
                else {
                    _local_2 = ((this._SafeStr_10109 + "?retry=") + this._SafeStr_10111);
                };
                this.removeMapLoaderEventListeners();
                _local_3 = new URLRequest(_local_2);
                this._SafeStr_10112 = this._assets.loadAssetFromFile("figuremap", _local_3, "text/xml");
                this.addMapLoaderEventListeners();
            };
        }
        private function onConfigurationComplete(event:Event):void
        {
            var data:XML;
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if (loaderStruct == null){
                return;
            };
            try {
                data = new XML((loaderStruct.assetLoader.content as String));
            }
            catch(e:Error) {
                Logger.log(("[AvatarAssetDownloadManager] Error: " + e.message));
                return;
            };
            this.loadFigureMapData(data);
        }
        private function loadFigureMapData(_arg_1:XML):void
        {
            var _local_2:Array;
            if (_arg_1 == null){
                Logger.log((("[AvatarAssetDownloadManager] XML error: " + _arg_1) + " not valid XML"));
                return;
            };
            if (_arg_1.toString() == ""){
                Logger.log((("[AvatarAssetDownloadManager] XML error: " + _arg_1) + " is EMPTY!"));
                return;
            };
            this.generateMap(_arg_1);
            this._SafeStr_10110 = true;
            for each (_local_2 in this._SafeStr_10114) {
                this.loadFigureSetData(_local_2[0], _local_2[1]);
            };
            this._SafeStr_10114 = [];
            dispatchEvent(new Event(Event.COMPLETE));
        }
        private function generateMap(_arg_1:XML):void
        {
            var _local_2:XML;
            var _local_3:AvatarAssetDownloadLibrary;
            var _local_4:XML;
            var _local_5:String;
            var _local_6:Array;
            for each (_local_2 in _arg_1.lib) {
                _local_3 = new AvatarAssetDownloadLibrary(_local_2.@id, _local_2.@revision, this._SafeStr_10108, this._assets);
                _local_3.addEventListener(Event.COMPLETE, this.libraryComplete);
                for each (_local_4 in _local_2.part) {
                    _local_5 = ((_local_4.@type + ":") + _local_4.@id);
                    _local_6 = this._SafeStr_10106[_local_5];
                    if (_local_6 == null){
                        _local_6 = [];
                    };
                    _local_6.push(_local_3);
                    this._SafeStr_10106[_local_5] = _local_6;
                };
            };
        }
        public function isReady(_arg_1:IAvatarFigureContainer):Boolean
        {
            if (!this._SafeStr_10110){
                return (false);
            };
            var _local_2:Array = this.getLibsToDownload(_arg_1);
            return ((_local_2.length == 0));
        }
        public function loadFigureSetData(_arg_1:IAvatarFigureContainer, _arg_2:IAvatarImageListener):void
        {
            var _local_5:AvatarAssetDownloadLibrary;
            var _local_6:Array;
            if (!this._SafeStr_10110){
                this._SafeStr_10114.push([_arg_1, _arg_2]);
                return;
            };
            var _local_3:String = _arg_1.getFigureString();
            var _local_4:Array = this.getLibsToDownload(_arg_1);
            if (_local_4.length > 0){
                if (((_arg_2) && (!(_arg_2.disposed)))){
                    _local_6 = this._SafeStr_8865[_local_3];
                    if (_local_6 == null){
                        _local_6 = [];
                    };
                    _local_6.push(_arg_2);
                    this._SafeStr_8865[_local_3] = _local_6;
                };
                this._SafeStr_10107[_local_3] = _local_4;
                for each (_local_5 in _local_4) {
                    this.addToQueue(_local_5);
                };
            }
            else {
                if (((!((_arg_2 == null))) && (!(_arg_2.disposed)))){
                    _arg_2.avatarImageReady(_local_3);
                };
            };
        }
        private function libraryComplete(_arg_1:Event):void
        {
            var _local_3:String;
            var _local_4:Array;
            var _local_5:AvatarAssetDownloadLibrary;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:AvatarAssetDownloadLibrary;
            var _local_9:Array;
            var _local_10:IAvatarImageListener;
            var _local_2:Array = [];
            for (_local_3 in this._SafeStr_10107) {
                _local_7 = true;
                _local_4 = this._SafeStr_10107[_local_3];
                for each (_local_8 in _local_4) {
                    if (!_local_8.isReady){
                        _local_7 = false;
                        break;
                    };
                };
                if (_local_7){
                    _local_2.push(_local_3);
                    _local_9 = this._SafeStr_8865[_local_3];
                    for each (_local_10 in _local_9) {
                        if (((!((_local_10 == null))) && (!(_local_10.disposed)))){
                            _local_10.avatarImageReady(_local_3);
                        };
                    };
                    delete this._SafeStr_8865[_local_3];
                };
            };
            for each (_local_3 in _local_2) {
                delete this._SafeStr_10107[_local_3];
            };
            while (_local_6 < this._SafeStr_10116.length) {
                _local_5 = this._SafeStr_10116[_local_6];
                if (_local_5.libraryName == (_arg_1.target as AvatarAssetDownloadLibrary).libraryName){
                    this._SafeStr_10116.splice(_local_6, 1);
                };
                _local_6++;
            };
            this._SafeStr_10113.start();
        }
        private function getLibsToDownload(_arg_1:IAvatarFigureContainer):Array
        {
            var _local_5:String;
            var _local_6:ISetType;
            var _local_7:int;
            var _local_8:IFigurePartSet;
            var _local_9:FigurePart;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:AvatarAssetDownloadLibrary;
            var _local_2:Array = [];
            if (!this._structure){
                return (_local_2);
            };
            if (!_arg_1){
                return (_local_2);
            };
            var _local_3:IFigureData = this._structure.figureData;
            if (!_local_3){
                return (_local_2);
            };
            var _local_4:Array = _arg_1.getPartTypeIds();
            for each (_local_5 in _local_4) {
                _local_6 = _local_3.getSetType(_local_5);
                if (_local_6){
                    _local_7 = _arg_1.getPartSetId(_local_5);
                    _local_8 = _local_6.getPartSet(_local_7);
                    if (_local_8){
                        for each (_local_9 in _local_8.parts) {
                            _local_10 = ((_local_9.type + ":") + _local_9.id);
                            _local_11 = this._SafeStr_10106[_local_10];
                            if (_local_11 != null){
                                for each (_local_12 in _local_11) {
                                    if (_local_12 != null){
                                        if (!_local_12.isReady){
                                            if (_local_2.indexOf(_local_12) == -1){
                                                _local_2.push(_local_12);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }
        private function processPending():void
        {
            var _local_1:AvatarAssetDownloadLibrary;
            while ((((this._SafeStr_10115.length > 0)) && ((this._SafeStr_10116.length < this._SafeStr_9017)))) {
                _local_1 = this._SafeStr_10115[0];
                _local_1.startDownloading();
                this._SafeStr_10116.push(this._SafeStr_10115.shift());
            };
        }
        private function addToQueue(_arg_1:AvatarAssetDownloadLibrary):void
        {
            if (((((!(_arg_1.isReady)) && ((this._SafeStr_10115.indexOf(_arg_1) == -1)))) && ((this._SafeStr_10116.indexOf(_arg_1) == -1)))){
                this._SafeStr_10115.push(_arg_1);
                this.processPending();
            };
        }
        private function onNextDownloadTimeout(_arg_1:Event=null):void
        {
            this.processPending();
        }

    }
}//package com.sulake.habbo.avatar

// getSetType = "_-0CE" (String#3795, DoABC#2)
// getPartTypeIds = "_-2ig" (String#6925, DoABC#2)
// _SafeStr_10105 = "_-2-v" (String#19008, DoABC#2)
// _SafeStr_10106 = "_-u8" (String#24454, DoABC#2)
// _SafeStr_10107 = "_-0oQ" (String#15991, DoABC#2)
// _SafeStr_10108 = "_-IW" (String#22949, DoABC#2)
// _SafeStr_10109 = "_-2PX" (String#20025, DoABC#2)
// _SafeStr_10110 = "_-2Fr" (String#19637, DoABC#2)
// _SafeStr_10111 = "_-wF" (String#24541, DoABC#2)
// _SafeStr_10112 = "_-0NN" (String#14970, DoABC#2)
// _SafeStr_10113 = "_-0Nx" (String#14986, DoABC#2)
// _SafeStr_10114 = "_-03E" (String#14171, DoABC#2)
// _SafeStr_10115 = "_-0iK" (String#15765, DoABC#2)
// _SafeStr_10116 = "_-11h" (String#16525, DoABC#2)
// addMapLoaderEventListeners = "_-Ow" (String#23203, DoABC#2)
// loadFigureMapData = "_-Ik" (String#22956, DoABC#2)
// onNextDownloadTimeout = "_-WJ" (String#23502, DoABC#2)
// removeMapLoaderEventListeners = "_-33l" (String#21650, DoABC#2)
// onConfigurationComplete = "_-0vc" (String#16261, DoABC#2)
// onConfigurationError = "_-2n1" (String#7021, DoABC#2)
// generateMap = "_-23m" (String#19167, DoABC#2)
// loadFigureSetData = "_-2SQ" (String#20135, DoABC#2)
// libraryComplete = "_-2Sw" (String#20158, DoABC#2)
// getLibsToDownload = "_-1AE" (String#16868, DoABC#2)
// addToQueue = "_-07O" (String#14340, DoABC#2)
// libraryName = "_-3DA" (String#22002, DoABC#2)
// processPending = "_-2CP" (String#19500, DoABC#2)
// startDownloading = "_-vP" (String#24506, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// AvatarAssetDownloadManager = "_-1o1" (String#5817, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// FigurePart = "_-2tY" (String#7149, DoABC#2)
// AvatarAssetDownloadLibrary = "_-1wv" (String#5970, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// _SafeStr_8865 = "_-0RW" (String#1471, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// _SafeStr_9017 = "_-aZ" (String#2134, DoABC#2)


