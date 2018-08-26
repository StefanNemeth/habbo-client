
package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;

    public interface IGraphicAssetCollection 
    {

        function dispose():void;
        function set assetLibrary(_arg_1:IAssetLibrary):void;
        function ExtendedBitmapData():void;
        function removeReference():void;
        function define(_arg_1:XML):Boolean;
        function getAsset(_arg_1:String):IGraphicAsset;
        function getAssetWithPalette(_arg_1:String, _arg_2:String):IGraphicAsset;
        function getPaletteNames():Array;
        function getPaletteColors(_arg_1:String):Array;
        function addAsset(_arg_1:String, _arg_2:BitmapData, _arg_3:Boolean, _arg_4:int=0, _arg_5:int=0, _arg_6:Boolean=false, _arg_7:Boolean=false):Boolean;
        function disposeAsset(_arg_1:String):void;

    }
}//package com.sulake.room.object.visualization.utils

// disposeAsset = "_-2uj" (String#7174, DoABC#2)
// getPaletteNames = "_-113" (String#4896, DoABC#2)
// getPaletteColors = "_-1mh" (String#5793, DoABC#2)
// define = "_-19s" (String#5075, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// IGraphicAsset = "_-1HF" (String#5195, DoABC#2)
// ExtendedBitmapData = "_-2F" (String#6343, DoABC#2)


