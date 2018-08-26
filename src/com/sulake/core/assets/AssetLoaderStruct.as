
package com.sulake.core.assets
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.loaders.IAssetLoader;

    public class AssetLoaderStruct extends EventDispatcher implements IDisposable 
    {

        private var _assetLoader:IAssetLoader;
        private var _assetName:String;

        public function AssetLoaderStruct(_arg_1:String, _arg_2:IAssetLoader)
        {
            this._assetName = _arg_1;
            this._assetLoader = _arg_2;
        }
        public function get assetName():String
        {
            return (this._assetName);
        }
        public function get assetLoader():IAssetLoader
        {
            return (this._assetLoader);
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._assetLoader != null){
                    if (!this._assetLoader.disposed){
                        this._assetLoader.dispose();
                        this._assetLoader = null;
                    };
                };
                super.dispose();
            };
        }

    }
}//package com.sulake.core.assets

// IAssetLoader = "_-0Nc" (String#4033, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// assetLoader = "_-1nR" (String#18439, DoABC#2)
// _assetName = "_-33u" (String#910, DoABC#2)
// _assetLoader = "_-Vn" (String#23484, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


