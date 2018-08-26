
package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.IAsset;

    public interface IGraphicAsset 
    {

        function get flipV():Boolean;
        function get flipH():Boolean;
        function get width():int;
        function get height():int;
        function get asset():IAsset;
        function get assetName():String;
        function get libraryAssetName():String;
        function get offsetX():int;
        function get offsetY():int;
        function get originalOffsetX():int;
        function get originalOffsetY():int;
        function get usesPalette():Boolean;

    }
}//package com.sulake.room.object.visualization.utils

// libraryAssetName = "_-1Pi" (String#5348, DoABC#2)
// originalOffsetX = "_-0og" (String#4607, DoABC#2)
// originalOffsetY = "_-312" (String#7329, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)


