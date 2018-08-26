
package com.sulake.core.assets
{
    import flash.display.DisplayObject;

    public class DisplayAsset implements IAsset 
    {

        protected var _url:String;
        protected var _content:DisplayObject;
        protected var _disposed:Boolean = false;
        protected var _declaration:AssetTypeDeclaration;

        public function DisplayAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            this._declaration = _arg_1;
            this._url = _arg_2;
        }
        public function get url():String
        {
            return (this._url);
        }
        public function get content():Object
        {
            return (this._content);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get declaration():AssetTypeDeclaration
        {
            return (this._declaration);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._content.loaderInfo != null){
                    if (this._content.loaderInfo.loader != null){
                        this._content.loaderInfo.loader.unload();
                    };
                };
                this._content = null;
                this._declaration = null;
                this._disposed = true;
                this._url = null;
            };
        }
        public function setUnknownContent(_arg_1:Object):void
        {
            if ((_arg_1 is DisplayObject)){
                this._content = (_arg_1 as DisplayObject);
                if (this._content != null){
                    return;
                };
                throw (new Error("Failed to convert DisplayObject to DisplayAsset!"));
            };
            if ((_arg_1 is DisplayAsset)){
                this._content = DisplayAsset(_arg_1)._content;
                this._declaration = DisplayAsset(_arg_1)._declaration;
                if (this._content == null){
                    throw (new Error("Failed to read content from DisplayAsset!"));
                };
            };
        }
        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is DisplayAsset)){
                this._content = DisplayAsset(_arg_1)._content;
                this._declaration = DisplayAsset(_arg_1)._declaration;
            }
            else {
                throw (new Error("Provided asset should be of type DisplayAsset!"));
            };
        }
        public function setParamsDesc(_arg_1:XMLList):void
        {
        }

    }
}//package com.sulake.core.assets

// DisplayAsset = "_-wp" (String#24561, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)
// _declaration = "_-me" (String#24134, DoABC#2)


