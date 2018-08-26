
package com.sulake.core.assets
{
    import com.sulake.core.runtime.IDisposable;

    public interface IAsset extends IDisposable 
    {

        function get url():String;
        function get content():Object;
        function get declaration():AssetTypeDeclaration;
        function setUnknownContent(_arg_1:Object):void;
        function setFromOtherAsset(_arg_1:IAsset):void;
        function setParamsDesc(_arg_1:XMLList):void;

    }
}//package com.sulake.core.assets

// IDisposable = "_-0dY" (String#4382, DoABC#2)
// AssetTypeDeclaration = "_-1fO" (String#5653, DoABC#2)
// declaration = "_-0yc" (String#4820, DoABC#2)
// setUnknownContent = "_-2zE" (String#7271, DoABC#2)
// setFromOtherAsset = "_-0f6" (String#4409, DoABC#2)
// setParamsDesc = "_-0ro" (String#4682, DoABC#2)


