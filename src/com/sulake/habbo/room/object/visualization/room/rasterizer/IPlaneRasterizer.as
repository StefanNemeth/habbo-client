
package com.sulake.habbo.room.object.visualization.room.rasterizer
{
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;

    public interface IPlaneRasterizer 
    {

        function initializeDimensions(_arg_1:int, _arg_2:int):Boolean;
        function render(_arg_1:BitmapData, _arg_2:String, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:IVector3d, _arg_7:Boolean, _arg_8:Number=0, _arg_9:Number=0, _arg_10:Number=0, _arg_11:Number=0, _arg_12:int=0):PlaneBitmapData;
        function getTextureIdentifier(_arg_1:Number, _arg_2:IVector3d):String;
        function reinitialize():void;

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer

// IVector3d = "_-hf" (String#8547, DoABC#2)
// IPlaneRasterizer = "_-2El" (String#6336, DoABC#2)
// PlaneBitmapData = "_-2Mg" (String#6493, DoABC#2)
// initializeDimensions = "_-1dY" (String#5624, DoABC#2)
// getTextureIdentifier = "_-0yx" (String#829, DoABC#2)
// reinitialize = "_-0gk" (String#4440, DoABC#2)


