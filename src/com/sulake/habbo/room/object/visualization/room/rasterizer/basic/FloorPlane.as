
package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import com.sulake.room.utils.IVector3d;

    public class FloorPlane extends Plane 
    {

        public static const _SafeStr_4861:uint = 0xFFFFFF;
        public static const _SafeStr_4854:Number = 45;
        public static const _SafeStr_4855:Number = 30;

        public function render(_arg_1:BitmapData, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:IVector3d, _arg_6:Boolean):BitmapData
        {
            var _local_7:PlaneVisualization = getPlaneVisualization(_arg_4);
            if ((((_local_7 == null)) || ((_local_7.geometry == null)))){
                return (null);
            };
            var _local_8:Point = _local_7.geometry.getScreenPoint(new Vector3d(0, 0, 0));
            var _local_9:Point = _local_7.geometry.getScreenPoint(new Vector3d(0, (_arg_3 / _local_7.geometry.scale), 0));
            var _local_10:Point = _local_7.geometry.getScreenPoint(new Vector3d((_arg_2 / _local_7.geometry.scale), 0, 0));
            if (((((!((_local_8 == null))) && (!((_local_9 == null))))) && (!((_local_10 == null))))){
                _arg_2 = Math.round(Math.abs((_local_8.x - _local_10.x)));
                _arg_3 = Math.round(Math.abs((_local_8.x - _local_9.x)));
            };
            return (_local_7.render(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6));
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.basic

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// Plane = "_-0S9" (String#4141, DoABC#2)
// FloorPlane = "_-1RS" (String#5386, DoABC#2)
// _SafeStr_4854 = "_-34T" (String#21676, DoABC#2)
// _SafeStr_4855 = "_-3AQ" (String#21897, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// getScreenPoint = "_-34h" (String#7403, DoABC#2)


