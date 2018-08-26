
package com.sulake.room
{
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public interface IRoomContentLoader 
    {

        function dispose():void;
        function getPlaceHolderType(_arg_1:String):String;
        function getPlaceHolderTypes():Array;
        function getContentType(_arg_1:String):String;
        function hasInternalContent(_arg_1:String):Boolean;
        function loadObjectContent(_arg_1:String, _arg_2:IEventDispatcher):Boolean;
        function insertObjectContent(_arg_1:int, _arg_2:int, _arg_3:IAssetLibrary):Boolean;
        function getVisualizationType(_arg_1:String):String;
        function getLogicType(_arg_1:String):String;
        function getVisualizationXML(_arg_1:String):XML;
        function getAssetXML(_arg_1:String):XML;
        function getLogicXML(_arg_1:String):XML;
        function getGraphicAssetCollection(_arg_1:String):IGraphicAssetCollection;

    }
}//package com.sulake.room

// getPlaceHolderType = "_-0dn" (String#4388, DoABC#2)
// getContentType = "_-0mQ" (String#4557, DoABC#2)
// hasInternalContent = "_-21J" (String#6071, DoABC#2)
// insertObjectContent = "_-Vs" (String#8317, DoABC#2)
// loadObjectContent = "_-1ZT" (String#5553, DoABC#2)
// getVisualizationType = "_-1HN" (String#5197, DoABC#2)
// getGraphicAssetCollection = "_-0bl" (String#4341, DoABC#2)
// getVisualizationXML = "_-Np" (String#8161, DoABC#2)
// getLogicType = "_-3CB" (String#7555, DoABC#2)
// getLogicXML = "_-3P" (String#7733, DoABC#2)
// IRoomContentLoader = "_-6z" (String#7806, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// getAssetXML = "_-1XT" (String#364, DoABC#2)


