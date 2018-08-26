
package com.sulake.core.assets
{
    import flash.utils.ByteArray;

    public class TextAsset implements IAsset 
    {

        private var _disposed:Boolean = false;
        private var _content:String = "";
        private var _declaration:AssetTypeDeclaration;
        private var _url:String;

        public function TextAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
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
                this._disposed = true;
                this._content = null;
                this._declaration = null;
                this._url = null;
            };
        }
        public function setUnknownContent(_arg_1:Object):void
        {
            var _local_2:ByteArray;
            if ((_arg_1 is String)){
                this._content = (_arg_1 as String);
                return;
            };
            if ((_arg_1 is Class)){
                _local_2 = (new (_arg_1)() as ByteArray);
                this._content = _local_2.readUTFBytes(_local_2.length);
                return;
            };
            if ((_arg_1 is ByteArray)){
                _local_2 = (_arg_1 as ByteArray);
                this._content = _local_2.readUTFBytes(_local_2.length);
                return;
            };
            if ((_arg_1 is TextAsset)){
                this._content = TextAsset(_arg_1)._content;
                return;
            };
            this._content = _arg_1.toString();
        }
        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is TextAsset)){
                this._content = TextAsset(_arg_1)._content;
            }
            else {
                throw (Error("Provided asset is not of type TextAsset!"));
            };
        }
        public function setParamsDesc(_arg_1:XMLList):void
        {
        }

    }
}//package com.sulake.core.assets

// TextAsset = "_-0HX" (String#14738, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// _url = "_-3Jl" (String#151, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// _declaration = "_-23H" (String#447, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)


