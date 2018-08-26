
package com.sulake.core.assets
{
    import flash.media.Sound;
    import flash.utils.ByteArray;

    public class SoundAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var _content:Sound = null;
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function SoundAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
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
            return ((this._content as Object));
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
                this._disposed = true;
                this._content = null;
                this._declaration = null;
                this._url = null;
            };
        }
        public function setUnknownContent(_arg_1:Object):void
        {
            if ((_arg_1 is Sound)){
                if (this._content){
                    this._content.close();
                };
                this._content = (_arg_1 as Sound);
                return;
            };
            if ((_arg_1 is ByteArray)){
            };
            if ((_arg_1 is Class)){
                if (this._content){
                    this._content.close();
                };
                this._content = (new (_arg_1)() as Sound);
                return;
            };
            if ((_arg_1 is SoundAsset)){
                if (this._content){
                    this._content.close();
                };
                this._content = SoundAsset(_arg_1)._content;
                return;
            };
        }
        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is SoundAsset)){
                this._content = SoundAsset(_arg_1)._content;
            };
        }
        public function setParamsDesc(_arg_1:XMLList):void
        {
        }

    }
}//package com.sulake.core.assets

// _content = "_-o4" (String#96, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// _declaration = "_-23H" (String#447, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)


