
package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import com.sulake.core.utils.Map;
    import com.sulake.iid.IIDHabboCommunicationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.advertisement.RoomAdMessageEvent;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import flash.system.Security;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import flash.utils.getTimer;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.InterstitialMessageParser;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.loaders.IAssetLoader;
    import flash.display.Bitmap;
    import com.sulake.habbo.advertisement.events.InterstitialEvent;
    import com.sulake.habbo.communication.messages.outgoing.advertisement.GetRoomAdMessageComposer;
    import com.sulake.habbo.communication.messages.parser.advertisement.RoomAdMessageParser;
    import com.sulake.habbo.advertisement.events.AdEvent;
    import com.sulake.core.assets.IAsset;

    public class AdManager extends Component implements IAdManager 
    {

        private var _communicationManager:IHabboCommunicationManager;
        private var _connection:IConnection;
        private var _config:IHabboConfigurationManager;
        private var _SafeStr_9865:Boolean;
        private var _SafeStr_9866:String;
        private var _SafeStr_9867:String;
        private var _SafeStr_9868:int = 0;
        private var _SafeStr_9869:int = 0;
        private var _SafeStr_9870:int = 0;
        private var _SafeStr_9871:int = 0;
        private var _SafeStr_9872:int = 0;
        private var _SafeStr_9873:Timer;
        private var _SafeStr_9874:AdImageRequest;
        private var _SafeStr_9875:BitmapData = null;
        private var _SafeStr_9876:BitmapData = null;
        private var _SafeStr_9877:Map;

        public function AdManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            this._SafeStr_9877 = new Map();
            queueInterface(new IIDHabboCommunicationManager(), this.onCommunicationManagerReady);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationReady);
        }
        override public function dispose():void
        {
            super.dispose();
            this._connection = null;
            if (this._SafeStr_9877 != null){
                this._SafeStr_9877.dispose();
                this._SafeStr_9877 = null;
            };
            if (this._communicationManager != null){
                release(new IIDHabboCommunicationManager());
                this._communicationManager = null;
            };
            if (this._config != null){
                release(new IIDHabboConfigurationManager());
                this._config = null;
            };
            if (this._SafeStr_9875){
                this._SafeStr_9875.dispose();
                this._SafeStr_9875 = null;
            };
            if (this._SafeStr_9876){
                this._SafeStr_9876.dispose();
                this._SafeStr_9876 = null;
            };
        }
        private function onCommunicationManagerReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            this._communicationManager = (_arg_2 as IHabboCommunicationManager);
            if (this._communicationManager == null){
                return;
            };
            this._connection = this._communicationManager.HabboCommunicationManager(this.onConnectionReady);
            if (this._connection != null){
                this.onConnectionReady(this._connection);
            };
        }
        private function onConnectionReady(_arg_1:IConnection):void
        {
            if (((disposed) || ((_arg_1 == null)))){
                return;
            };
            this._connection = _arg_1;
            this._connection.addMessageEvent(new InterstitialMessageEvent(this.onInterstitial));
            this._connection.addMessageEvent(new RoomAdMessageEvent(this.onRoomAd));
        }
        private function onConfigurationReady(_arg_1:IID=null, _arg_2:IUnknown=null):void
        {
            var _local_7:URLRequest;
            var _local_8:AssetLoaderStruct;
            this._config = (_arg_2 as IHabboConfigurationManager);
            if (this._config == null){
                return;
            };
            this._SafeStr_9865 = (this._config.getKey("interstitial.enabled", "false") == "true");
            this._SafeStr_9868 = int(this._config.getKey("interstitial.interval", "30000"));
            this._SafeStr_9870 = int(this._config.getKey("interstitial.show.time", "5000"));
            this._SafeStr_9871 = int(this._config.getKey("interstitial.max.displays.flash", "-1"));
            var _local_3:String = this._config.getKey("ads.domain");
            if (_local_3 != ""){
                Security.loadPolicyFile((("http://" + _local_3) + "/crossdomain.xml"));
            };
            var _local_4:String = this._config.getKey("billboard.adwarning.left.url");
            var _local_5:String = this._config.getKey("billboard.adwarning.right.url");
            var _local_6:String = this._config.getKey("image.library.url");
            if (((!((_local_4 == ""))) && (!((_local_5 == ""))))){
                _local_4 = (_local_6 + _local_4);
                _local_5 = (_local_6 + _local_5);
                _local_7 = new URLRequest(_local_4);
                _local_8 = assets.loadAssetFromFile("adWarningL", _local_7, "image/png");
                _local_8.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.adWarningLeftReady);
                _local_7 = new URLRequest(_local_5);
                _local_8 = assets.loadAssetFromFile("adWarningRight", _local_7, "image/png");
                _local_8.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.adWarningRightReady);
            };
        }
        public function showInterstitial():Boolean
        {
            if (!this._SafeStr_9865){
                return (false);
            };
            if (((!((this._SafeStr_9873 == null))) && (this._SafeStr_9873.running))){
                this._SafeStr_9873.reset();
                return (false);
            };
            if (this._SafeStr_9869 == 0){
                this._SafeStr_9869 = getTimer();
                return (false);
            };
            if ((((this._SafeStr_9871 > 0)) && ((this._SafeStr_9872 >= this._SafeStr_9871)))){
                return (false);
            };
            var _local_1:int = (getTimer() - this._SafeStr_9869);
            if (_local_1 > this._SafeStr_9868){
                this._SafeStr_9872++;
                this._connection.send(new GetInterstitialMessageComposer());
                return (true);
            };
            return (false);
        }
        private function onInterstitial(_arg_1:InterstitialMessageEvent):void
        {
            var _local_3:String;
            var _local_4:URLRequest;
            var _local_5:AssetLoaderStruct;
            var _local_2:InterstitialMessageParser = _arg_1.getParser();
            this._SafeStr_9866 = _local_2.imageUrl;
            this._SafeStr_9867 = _local_2.clickUrl;
            this._SafeStr_9869 = getTimer();
            if (this._SafeStr_9866 != ""){
                _local_3 = this._SafeStr_9866;
                if (assets.hasAsset(_local_3)){
                    assets.removeAsset(assets.getAssetByName(_local_3));
                };
                if (this._SafeStr_9873 == null){
                    this._SafeStr_9873 = new Timer(this._SafeStr_9870, 1);
                    this._SafeStr_9873.addEventListener(TimerEvent.TIMER_COMPLETE, this.interstitialTimerComplete);
                };
                if (this._SafeStr_9873.running){
                    this._SafeStr_9873.reset();
                };
                this._SafeStr_9873.start();
                _local_4 = new URLRequest(this._SafeStr_9866);
                _local_5 = assets.loadAssetFromFile(_local_3, _local_4, "image/jpeg");
                _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.interstitialLoaderEventHandler);
                _local_5.addEventListener(AssetLoaderEvent._SafeStr_4221, this.interstitialLoaderEventHandler);
            }
            else {
                this.stopInterstitial();
            };
        }
        private function interstitialLoaderEventHandler(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct;
            var _local_3:IAssetLoader;
            var _local_4:Bitmap;
            if (_arg_1 == null){
                return;
            };
            switch (_arg_1.type){
                case AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE:
                    _local_2 = (_arg_1.target as AssetLoaderStruct);
                    if (_local_2 != null){
                        _local_3 = _local_2.assetLoader;
                        if (_local_3 != null){
                            _local_4 = (_local_3.content as Bitmap);
                            this.startInterstitial(_local_4);
                            return;
                        };
                    };
                    this.stopInterstitial();
                    return;
                case AssetLoaderEvent._SafeStr_4221:
                    this.stopInterstitial();
                    return;
            };
        }
        private function startInterstitial(_arg_1:Bitmap):void
        {
            if (((!((this._SafeStr_9873 == null))) && (!(this._SafeStr_9873.running)))){
                return;
            };
            if (this.isValidAdImage(_arg_1)){
                events.dispatchEvent(new InterstitialEvent(InterstitialEvent.AE_INTERSTITIAL_SHOW, _arg_1.bitmapData, this._SafeStr_9867));
                this._SafeStr_9869 = getTimer();
            }
            else {
                this.stopInterstitial();
            };
        }
        private function interstitialTimerComplete(_arg_1:TimerEvent):void
        {
            this.stopInterstitial();
        }
        private function stopInterstitial():void
        {
            if (((!((this._SafeStr_9873 == null))) && (this._SafeStr_9873.running))){
                this._SafeStr_9873.reset();
            };
            if (events != null){
                events.dispatchEvent(new InterstitialEvent(InterstitialEvent.AE_INTERSTITIAL_COMPLETE));
            };
        }
        public function RoomEngine(_arg_1:int, _arg_2:int):void
        {
            this._SafeStr_9874 = new AdImageRequest(_arg_1, _arg_2);
            this._connection.send(new GetRoomAdMessageComposer());
        }
        private function onRoomAd(_arg_1:RoomAdMessageEvent):void
        {
            var _local_3:String;
            var _local_4:URLRequest;
            var _local_5:AssetLoaderStruct;
            var _local_2:RoomAdMessageParser = _arg_1.getParser();
            if (((((!((this._SafeStr_9874 == null))) && (!((_local_2.imageUrl == ""))))) && (!((_local_2.clickUrl == ""))))){
                _local_3 = _local_2.imageUrl;
                if (assets.hasAsset(_local_3)){
                    assets.removeAsset(assets.getAssetByName(_local_3));
                };
                this._SafeStr_9874 = new AdImageRequest(this._SafeStr_9874.roomId, this._SafeStr_9874.roomCategory, _local_2.imageUrl, _local_2.clickUrl);
                _local_4 = new URLRequest(_local_2.imageUrl);
                _local_5 = assets.loadAssetFromFile(_local_3, _local_4, "image/jpeg");
                _local_5.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.roomAdImageReady);
            }
            else {
                this._SafeStr_9874 = null;
            };
        }
        private function roomAdImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:BitmapData;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:Bitmap = (_local_2.assetLoader.content as Bitmap);
            if (((this.isValidAdImage(_local_3)) && (!((this._SafeStr_9874 == null))))){
                _local_4 = this.emulateBackgroundTransparency(_local_3.bitmapData);
                events.dispatchEvent(new AdEvent(AdEvent.AE_ROOM_AD_SHOW, this._SafeStr_9874.roomId, this._SafeStr_9874.roomCategory, _local_4, _local_2.assetName, this._SafeStr_9874.clickURL, this._SafeStr_9875, this._SafeStr_9876));
                this._SafeStr_9874 = null;
            };
        }
        private function adWarningLeftReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:Bitmap = (_local_2.assetLoader.content as Bitmap);
            if (_local_3 != null){
                this._SafeStr_9875 = this.emulateBackgroundTransparency(_local_3.bitmapData);
            };
        }
        private function adWarningRightReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:Bitmap = (_local_2.assetLoader.content as Bitmap);
            if (_local_3 != null){
                this._SafeStr_9876 = this.emulateBackgroundTransparency(_local_3.bitmapData);
            };
        }
        private function emulateBackgroundTransparency(_arg_1:BitmapData):BitmapData
        {
            var _local_4:int;
            var _local_5:uint;
            if (_arg_1 == null){
                return (null);
            };
            var _local_2:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
            var _local_3:int;
            while (_local_3 < _local_2.height) {
                _local_4 = 0;
                while (_local_4 < _local_2.width) {
                    _local_5 = _arg_1.getPixel32(_local_4, _local_3);
                    if (_local_5 != 0xFFFFFFFF){
                        _local_2.setPixel32(_local_4, _local_3, _local_5);
                    };
                    _local_4++;
                };
                _local_3++;
            };
            return (_local_2);
        }
        private function isValidAdImage(_arg_1:Bitmap):Boolean
        {
            if (((!((_arg_1 == null))) && ((((_arg_1.width > 1)) || ((_arg_1.height > 1)))))){
                return (true);
            };
            return (false);
        }
        public function loadRoomAdImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String):void
        {
            var _local_11:IAsset;
            var _local_12:BitmapData;
            var _local_13:AdImageRequest;
            if ((((_arg_5 == null)) || ((_arg_5.length == 0)))){
                return;
            };
            var _local_7:String = _arg_5;
            if (assets.hasAsset(_local_7)){
                _local_11 = assets.getAssetByName(_local_7);
                if (_local_11 != null){
                    _local_12 = (_local_11.content as BitmapData);
                    if (_local_12 != null){
                        this.dispatchImageAsset(_local_12.clone(), _arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
                    };
                };
                return;
            };
            var _local_8:Array = this._SafeStr_9877.getValue(_local_7);
            if (_local_8 == null){
                _local_8 = new Array();
                this._SafeStr_9877.add(_local_7, _local_8);
            };
            if (_local_8.length > 0){
                for each (_local_13 in _local_8) {
                    if ((((((((_local_13.roomId == _arg_1)) && ((_local_13.roomCategory == _arg_2)))) && ((_local_13.objectId == _arg_3)))) && ((_local_13.objectCategory == _arg_4)))){
                        return;
                    };
                };
            };
            _local_8.push(new AdImageRequest(_arg_1, _arg_2, _arg_5, _arg_6, _arg_3, _arg_4));
            Logger.log(("trying to load billboard from url " + _local_7));
            var _local_9:URLRequest = new URLRequest(_local_7);
            var _local_10:AssetLoaderStruct = assets.loadAssetFromFile(_local_7, _local_9, "image/png");
            _local_10.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onBillboardImageReady);
            _local_10.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onBillboardImageLoadError);
        }
        private function onBillboardImageReady(_arg_1:AssetLoaderEvent):void
        {
            var _local_5:BitmapData;
            var _local_6:AdImageRequest;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:Bitmap = (_local_2.assetLoader.content as Bitmap);
            var _local_4:Array = this._SafeStr_9877.remove(_local_2.assetName);
            if ((((_local_4 == null)) || ((_local_4.length == 0)))){
                return;
            };
            Logger.log(("billboard image loaded from url " + _local_2.assetName));
            if (this.isValidAdImage(_local_3)){
                _local_5 = _local_3.bitmapData;
                if (_local_5 != null){
                    for each (_local_6 in _local_4) {
                        this.dispatchImageAsset(_local_5.clone(), _local_6.roomId, _local_6.roomCategory, _local_6.objectId, _local_6.objectCategory, _local_6.imageURL, _local_6.clickURL);
                    };
                };
            };
        }
        private function dispatchImageAsset(_arg_1:BitmapData, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:String, _arg_7:String):void
        {
            if (events != null){
                events.dispatchEvent(new AdEvent(AdEvent.AE_ROOM_AD_IMAGE_LOADED, _arg_2, _arg_3, _arg_1, _arg_6, _arg_7, null, null, _arg_4, _arg_5));
            };
        }
        private function onBillboardImageLoadError(_arg_1:AssetLoaderEvent):void
        {
            var _local_4:AdImageRequest;
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:Array = this._SafeStr_9877.remove(_local_2.assetName);
            if ((((_local_3 == null)) || ((_local_3.length == 0)))){
                return;
            };
            for each (_local_4 in _local_3) {
                Logger.log((("failed to load billboard image from url '" + _local_2.assetName) + "'"));
                this.dispatchImageAsset(null, _local_4.roomId, _local_4.roomCategory, _local_4.objectId, _local_4.objectCategory, _local_4.imageURL, _local_4.clickURL);
            };
        }

    }
}//package com.sulake.habbo.advertisement

// IID = "_-3KV" (String#7712, DoABC#2)
// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// InterstitialEvent = "_-2PZ" (String#6552, DoABC#2)
// GetInterstitialMessageComposer = "_-2gr" (String#20724, DoABC#2)
// RoomAdMessageEvent = "_-1vW" (String#18778, DoABC#2)
// InterstitialMessageParser = "_-154" (String#4980, DoABC#2)
// RoomAdMessageParser = "_-0w3" (String#4770, DoABC#2)
// AdImageRequest = "_-2tt" (String#7157, DoABC#2)
// GetRoomAdMessageComposer = "_-2H3" (String#19686, DoABC#2)
// InterstitialMessageEvent = "_-wD" (String#24539, DoABC#2)
// getParser = "_-0B0" (String#1418, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// AE_INTERSTITIAL_SHOW = "_-2Fx" (String#19641, DoABC#2)
// AE_INTERSTITIAL_COMPLETE = "_-7z" (String#22543, DoABC#2)
// clickURL = "_-0-5" (String#14015, DoABC#2)
// AE_ROOM_AD_IMAGE_LOADED = "_-1jE" (String#18253, DoABC#2)
// AE_ROOM_AD_SHOW = "_-18f" (String#16799, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IHabboCommunicationManager = "_-0ls" (String#4545, DoABC#2)
// AdEvent = "_-1xT" (String#18868, DoABC#2)
// IAdManager = "_-S5" (String#8249, DoABC#2)
// _communicationManager = "_-0-x" (String#432, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)
// imageURL = "_-1v5" (String#18759, DoABC#2)
// showInterstitial = "_-1Rf" (String#5389, DoABC#2)
// RoomEngine = "_-1ii" (String#1747, DoABC#2)
// loadRoomAdImage = "_-vu" (String#8803, DoABC#2)
// _SafeStr_9865 = "_-QP" (String#23264, DoABC#2)
// _SafeStr_9866 = "_-2rv" (String#21152, DoABC#2)
// _SafeStr_9867 = "_-k4" (String#24037, DoABC#2)
// _SafeStr_9868 = "_-YE" (String#23571, DoABC#2)
// _SafeStr_9869 = "_-JK" (String#22978, DoABC#2)
// _SafeStr_9870 = "_-0UD" (String#15214, DoABC#2)
// _SafeStr_9871 = "_-257" (String#19224, DoABC#2)
// _SafeStr_9872 = "_-3IM" (String#22215, DoABC#2)
// _SafeStr_9873 = "_-c1" (String#23715, DoABC#2)
// _SafeStr_9874 = "_-Oq" (String#23198, DoABC#2)
// _SafeStr_9875 = "_-1yg" (String#18915, DoABC#2)
// _SafeStr_9876 = "_-gH" (String#23905, DoABC#2)
// _SafeStr_9877 = "_-5R" (String#22442, DoABC#2)
// onCommunicationManagerReady = "_-3A0" (String#914, DoABC#2)
// onConfigurationReady = "_-x5" (String#190, DoABC#2)
// onConnectionReady = "_-0k8" (String#359, DoABC#2)
// onInterstitial = "_-1uZ" (String#18738, DoABC#2)
// onRoomAd = "_-0dI" (String#15559, DoABC#2)
// adWarningLeftReady = "_-OE" (String#23176, DoABC#2)
// adWarningRightReady = "_-29R" (String#19381, DoABC#2)
// interstitialTimerComplete = "_-0vI" (String#16248, DoABC#2)
// interstitialLoaderEventHandler = "_-2O" (String#19964, DoABC#2)
// stopInterstitial = "_-0NL" (String#14969, DoABC#2)
// startInterstitial = "_-zi" (String#24677, DoABC#2)
// isValidAdImage = "_-kG" (String#24046, DoABC#2)
// roomAdImageReady = "_-1ym" (String#18919, DoABC#2)
// emulateBackgroundTransparency = "_-0hv" (String#15744, DoABC#2)
// dispatchImageAsset = "_-1uw" (String#18753, DoABC#2)
// onBillboardImageReady = "_-2U5" (String#20204, DoABC#2)
// onBillboardImageLoadError = "_-39P" (String#21861, DoABC#2)


