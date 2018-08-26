
package com.sulake.core.assets
{
    import flash.text.Font;
    import com.sulake.core.utils.FontEnum;

    public class FontAsset implements IAsset 
    {

        protected var _declaration:AssetTypeDeclaration;
        protected var _content:Font;
        protected var _disposed:Boolean = false;

        public function FontAsset(_arg_1:AssetTypeDeclaration, _arg_2:String=null)
        {
            this._declaration = _arg_1;
        }
        public function get url():String
        {
            return (null);
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
                this._declaration = null;
                this._content = null;
                this._disposed = true;
            };
        }
        public function setUnknownContent(unknown:Object):void
        {
            try {
                if ((unknown is Class)){
                    this._content = Font(FontEnum.registerFont((unknown as Class)));
                };
            }
            catch(e:Error) {
                throw (new Error(("Failed to register font from resource: " + unknown.toString())));
            };
        }
        public function setFromOtherAsset(_arg_1:IAsset):void
        {
            if ((_arg_1 is FontAsset)){
                this._content = FontAsset(_arg_1)._content;
            }
            else {
                throw (new Error("Provided asset should be of type FontAsset!"));
            };
        }
        public function setParamsDesc(_arg_1:XMLList):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_2:uint;
            while (_local_2 < _arg_1.length()) {
                _local_3 = _arg_1[_local_2].attribute("key");
                _local_4 = _arg_1[_local_2].attribute("value");
                _local_2++;
            };
        }

    }
}//package com.sulake.core.assets

// FontEnum = "_-15T" (String#4985, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// _declaration = "_-23H" (String#447, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)


