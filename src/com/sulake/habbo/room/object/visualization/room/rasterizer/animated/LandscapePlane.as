
package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.Plane;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
    import flash.display.BitmapData;
    import com.sulake.room.utils.Vector3d;
    import flash.geom.Point;
    import com.sulake.room.utils.IVector3d;

    public class LandscapePlane extends Plane 
    {

        public static const _SafeStr_4861:uint = 0xFFFFFF;
        public static const _SafeStr_4854:Number = 45;
        public static const _SafeStr_4855:Number = 30;

        private var _width:int = 0;
        private var _height:int = 0;

        override public function isStatic(_arg_1:int):Boolean
        {
            var _local_2:PlaneVisualization = getPlaneVisualization(_arg_1);
            if (_local_2 != null){
                return (!(_local_2.hasAnimationLayers));
            };
            return (super.isStatic(_arg_1));
        }
        public function initializeDimensions(_arg_1:int, _arg_2:int):void
        {
            if (_arg_1 < 0){
                _arg_1 = 0;
            };
            if (_arg_2 < 0){
                _arg_2 = 0;
            };
            if (((!((_arg_1 == this._width))) || (!((_arg_2 == this._height))))){
                this._width = _arg_1;
                this._height = _arg_2;
            };
        }
        public function render(_arg_1:BitmapData, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:IVector3d, _arg_6:Boolean, _arg_7:Number, _arg_8:Number, _arg_9:Number, _arg_10:Number, _arg_11:int):BitmapData
        {
            var _local_16:int;
            var _local_17:int;
            var _local_18:int;
            var _local_19:int;
            var _local_20:BitmapData;
            var _local_12:PlaneVisualization = getPlaneVisualization(_arg_4);
            if ((((_local_12 == null)) || ((_local_12.geometry == null)))){
                return (null);
            };
            var _local_13:Point = _local_12.geometry.getScreenPoint(new Vector3d(0, 0, 0));
            var _local_14:Point = _local_12.geometry.getScreenPoint(new Vector3d(0, 0, 1));
            var _local_15:Point = _local_12.geometry.getScreenPoint(new Vector3d(0, 1, 0));
            if (((((!((_local_13 == null))) && (!((_local_14 == null))))) && (!((_local_15 == null))))){
                _arg_2 = Math.round(Math.abs((((_local_13.x - _local_15.x) * _arg_2) / _local_12.geometry.scale)));
                _arg_3 = Math.round(Math.abs((((_local_13.y - _local_14.y) * _arg_3) / _local_12.geometry.scale)));
                _local_16 = (_arg_7 * Math.abs((_local_13.x - _local_15.x)));
                _local_17 = (_arg_8 * Math.abs((_local_13.y - _local_14.y)));
                _local_18 = (_arg_9 * Math.abs((_local_13.x - _local_15.x)));
                _local_19 = (_arg_10 * Math.abs((_local_13.y - _local_14.y)));
                return (_local_12.render(_arg_1, _arg_2, _arg_3, _arg_5, _arg_6, _local_16, _local_17, _local_18, _local_19, _arg_9, _arg_10, _arg_11));
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.rasterizer.animated

// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// Plane = "_-0S9" (String#4141, DoABC#2)
// LandscapePlane = "_-1vR" (String#18775, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// initializeDimensions = "_-1dY" (String#5624, DoABC#2)
// _SafeStr_4854 = "_-34T" (String#21676, DoABC#2)
// _SafeStr_4855 = "_-3AQ" (String#21897, DoABC#2)
// _SafeStr_4861 = "_-0CJ" (String#582, DoABC#2)
// isStatic = "_-2HT" (String#19704, DoABC#2)
// getScreenPoint = "_-34h" (String#7403, DoABC#2)


