
package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.utils.LibraryLoader;
    import flash.net.URLRequest;

    public interface IAssetLibrary extends IDisposable 
    {

        function get url():String;
        function get name():String;
        function get isReady():Boolean;
        function get numAssets():uint;
        function get manifest():XML;
        function get nameArray():Array;
        function loadFromFile(_arg_1:LibraryLoader, _arg_2:Boolean=true):void;
        function loadFromResource(_arg_1:XML, _arg_2:Class):Boolean;
        function unload():void;
        function loadAssetFromFile(_arg_1:String, _arg_2:URLRequest, _arg_3:String=null):AssetLoaderStruct;
        function getAssetByName(_arg_1:String):IAsset;
        function getAssetByContent(_arg_1:Object):IAsset;
        function getAssetByIndex(_arg_1:uint):IAsset;
        function getAssetIndex(_arg_1:IAsset):int;
        function hasAsset(_arg_1:String):Boolean;
        function setAsset(_arg_1:String, _arg_2:IAsset, _arg_3:Boolean=true):Boolean;
        function createAsset(_arg_1:String, _arg_2:AssetTypeDeclaration):IAsset;
        function removeAsset(_arg_1:IAsset):IAsset;
        function registerAssetTypeDeclaration(_arg_1:AssetTypeDeclaration, _arg_2:Boolean=true):Boolean;
        function getAssetTypeDeclarationByMimeType(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByClass(_arg_1:Class, _arg_2:Boolean=true):AssetTypeDeclaration;
        function getAssetTypeDeclarationByFileName(_arg_1:String, _arg_2:Boolean=true):AssetTypeDeclaration;

    }
}//package com.sulake.core.assets

// IDisposable = "_-0dY" (String#4382, DoABC#2)
// LibraryLoader = "_-T1" (String#8267, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// isReady = "_-2Wr" (String#6698, DoABC#2)
// getAssetByContent = "_-2q5" (String#7080, DoABC#2)
// getAssetIndex = "_-38x" (String#7490, DoABC#2)
// setAsset = "_-08Y" (String#3730, DoABC#2)
// createAsset = "_-0rD" (String#1562, DoABC#2)
// registerAssetTypeDeclaration = "_-1PR" (String#5342, DoABC#2)
// getAssetTypeDeclarationByMimeType = "_-BD" (String#7892, DoABC#2)
// getAssetTypeDeclarationByClass = "_-5x" (String#7779, DoABC#2)
// getAssetTypeDeclarationByFileName = "_-0rv" (String#4683, DoABC#2)
// AssetLoaderStruct = "_-0R2" (String#4112, DoABC#2)


