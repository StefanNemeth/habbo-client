
package com.sulake.core.assets
{
    public class AssetTypeDeclaration 
    {

        private var _mimeType:String;
        private var _assetClass:Class;
        private var _loaderClass:Class;
        private var _fileTypes:Array;

        public function AssetTypeDeclaration(_arg_1:String, _arg_2:Class, _arg_3:Class, ... _args)
        {
            this._mimeType = _arg_1;
            this._assetClass = _arg_2;
            this._loaderClass = _arg_3;
            if (_args == null){
                this._fileTypes = new Array();
            }
            else {
                this._fileTypes = _args;
            };
        }
        public function get mimeType():String
        {
            return (this._mimeType);
        }
        public function get assetClass():Class
        {
            return (this._assetClass);
        }
        public function get loaderClass():Class
        {
            return (this._loaderClass);
        }
        public function get fileTypes():Array
        {
            return (this._fileTypes);
        }

    }
}//package com.sulake.core.assets

// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// _mimeType = "_-nQ" (String#24168, DoABC#2)
// _assetClass = "_-0p4" (String#16018, DoABC#2)
// _loaderClass = "_-n6" (String#24158, DoABC#2)
// _fileTypes = "_-1kh" (String#18317, DoABC#2)
// assetClass = "_-39W" (String#21863, DoABC#2)
// loaderClass = "_-0PF" (String#15033, DoABC#2)
// fileTypes = "_-xg" (String#24597, DoABC#2)


