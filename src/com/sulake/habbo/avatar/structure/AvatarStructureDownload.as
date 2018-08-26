
package com.sulake.habbo.avatar.structure
{
    import flash.events.EventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.loaders.AssetLoaderEvent;
    import com.sulake.core.Core;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class AvatarStructureDownload extends EventDispatcher 
    {

        public static const AVATAR_STRUCTURE_DONE:String = "AVATAR_STRUCTURE_DONE";

        private var _SafeStr_10056:IStructureData;
        private var _SafeStr_10057:XML;
        private var _assets:IAssetLibrary;

        public function AvatarStructureDownload(_arg_1:IAssetLibrary, _arg_2:String, _arg_3:IStructureData)
        {
            this._assets = _arg_1;
            this._SafeStr_10056 = _arg_3;
            var _local_4:String = _arg_2;
            if (this._assets.hasAsset(_local_4)){
                Logger.log(("[AvatarStructureDownload] reload data for url: " + _arg_2));
            };
            var _local_5:URLRequest = new URLRequest(_arg_2);
            var _local_6:AssetLoaderStruct = this._assets.loadAssetFromFile(_local_4, _local_5, "text/plain");
            _local_6.addEventListener(AssetLoaderEvent.ASSET_LOADER_EVENT_COMPLETE, this.onDataComplete);
            _local_6.addEventListener(AssetLoaderEvent._SafeStr_4221, this.onDataFailed);
        }
        private function onDataComplete(event:Event):void
        {
            var data:String;
            var loaderStruct:AssetLoaderStruct = (event.target as AssetLoaderStruct);
            if ((((loaderStruct == null)) || ((loaderStruct.assetLoader == null)))){
                return;
            };
            try {
                data = (loaderStruct.assetLoader.content as String);
                if ((((data == null)) || ((data.length == 0)))){
                    Core.error((((("Could not load avatar structure, got empty data from URL " + loaderStruct.assetLoader.url) + " data length = ") + data.length) + "."), false, Core._SafeStr_8935);
                };
                this._SafeStr_10057 = new XML(data);
            }
            catch(e:Error) {
                Logger.log(("[AvatarStructureDownload] Error: " + e.message));
                return;
            };
            if (this._SafeStr_10057 == null){
                Logger.log((("[AvatarStructureDownload] XML error: " + loaderStruct) + " not valid XML"));
                return;
            };
            this._SafeStr_10056.appendXML(this._SafeStr_10057);
            dispatchEvent(new Event(AvatarStructureDownload.AVATAR_STRUCTURE_DONE));
        }
        private function onDataFailed(_arg_1:Event):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:String = "";
            if (((!((_local_2 == null))) && (!((_local_2.assetLoader == null))))){
                _local_3 = _local_2.assetLoader.url;
            };
            HabboWebTools.logEventLog(("figurepartlist download error " + _local_3));
            Core.error(("Could not load avatar structure. Failed to get data from URL " + _local_3), false, Core._SafeStr_8935);
        }

    }
}//package com.sulake.habbo.avatar.structure

// appendXML = "_-3Hp" (String#7662, DoABC#2)
// AVATAR_STRUCTURE_DONE = "_-1tb" (String#18701, DoABC#2)
// _SafeStr_10056 = "_-2ik" (String#20796, DoABC#2)
// _SafeStr_10057 = "_-2Bx" (String#19480, DoABC#2)
// onDataComplete = "_-2ir" (String#20800, DoABC#2)
// onDataFailed = "_-06K" (String#14300, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// IStructureData = "_-fH" (String#8500, DoABC#2)
// AvatarStructureDownload = "_-11V" (String#4905, DoABC#2)
// _SafeStr_4221 = "_-0eh" (String#15613, DoABC#2)
// logEventLog = "_-1qw" (String#18578, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _SafeStr_8935 = "_-0DA" (String#14575, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


