
package com.sulake.habbo.room.object.visualization.room
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
    import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
    import com.sulake.habbo.room.object.visualization.room.rasterizer.IPlaneRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class RoomVisualizationData implements IRoomObjectVisualizationData 
    {

        private var _wallRasterizer:WallRasterizer;
        private var _floorRasterizer:FloorRasterizer;
        private var _wallAdRasterizr:WallAdRasterizer;
        private var _landscapeRasterizer:LandscapeRasterizer;
        private var _maskManager:PlaneMaskManager;
        private var _initialized:Boolean = false;

        public function RoomVisualizationData()
        {
            this._wallRasterizer = new WallRasterizer();
            this._floorRasterizer = new FloorRasterizer();
            this._wallAdRasterizr = new WallAdRasterizer();
            this._landscapeRasterizer = new LandscapeRasterizer();
            this._maskManager = new PlaneMaskManager();
        }
        public function get initialized():Boolean
        {
            return (this._initialized);
        }
        public function get floorRasterizer():IPlaneRasterizer
        {
            return (this._floorRasterizer);
        }
        public function get wallRasterizer():IPlaneRasterizer
        {
            return (this._wallRasterizer);
        }
        public function get wallAdRasterizr():WallAdRasterizer
        {
            return (this._wallAdRasterizr);
        }
        public function get landscapeRasterizer():IPlaneRasterizer
        {
            return (this._landscapeRasterizer);
        }
        public function get maskManager():PlaneMaskManager
        {
            return (this._maskManager);
        }
        public function dispose():void
        {
            if (this._wallRasterizer != null){
                this._wallRasterizer.dispose();
                this._wallRasterizer = null;
            };
            if (this._floorRasterizer != null){
                this._floorRasterizer.dispose();
                this._floorRasterizer = null;
            };
            if (this._wallAdRasterizr != null){
                this._wallAdRasterizr.dispose();
                this._wallAdRasterizr = null;
            };
            if (this._landscapeRasterizer != null){
                this._landscapeRasterizer.dispose();
                this._landscapeRasterizer = null;
            };
            if (this._maskManager != null){
                this._maskManager.dispose();
                this._maskManager = null;
            };
        }
        public function clearCache():void
        {
            if (this._wallRasterizer != null){
                this._wallRasterizer.clearCache();
            };
            if (this._floorRasterizer != null){
                this._floorRasterizer.clearCache();
            };
            if (this._landscapeRasterizer != null){
                this._landscapeRasterizer.clearCache();
            };
        }
        public function initialize(_arg_1:XML):Boolean
        {
            var _local_7:XML;
            var _local_8:XML;
            var _local_9:XML;
            var _local_10:XML;
            var _local_11:XML;
            this.reset();
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:XMLList = _arg_1.wallData;
            if (_local_2.length() > 0){
                _local_7 = _local_2[0];
                this._wallRasterizer.initialize(_local_7);
            };
            var _local_3:XMLList = _arg_1.floorData;
            if (_local_3.length() > 0){
                _local_8 = _local_3[0];
                this._floorRasterizer.initialize(_local_8);
            };
            var _local_4:XMLList = _arg_1.wallAdData;
            if (_local_4.length() > 0){
                _local_9 = _local_4[0];
                this._wallAdRasterizr.initialize(_local_9);
            };
            var _local_5:XMLList = _arg_1.landscapeData;
            if (_local_5.length() > 0){
                _local_10 = _local_5[0];
                this._landscapeRasterizer.initialize(_local_10);
            };
            var _local_6:XMLList = _arg_1.maskData;
            if (_local_6.length() > 0){
                _local_11 = _local_6[0];
                this._maskManager.initialize(_local_11);
            };
            return (true);
        }
        public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (this._initialized){
                return;
            };
            this._wallRasterizer.initializeAssetCollection(_arg_1);
            this._floorRasterizer.initializeAssetCollection(_arg_1);
            this._wallAdRasterizr.initializeAssetCollection(_arg_1);
            this._landscapeRasterizer.initializeAssetCollection(_arg_1);
            this._maskManager.initializeAssetCollection(_arg_1);
            this._initialized = true;
        }
        protected function reset():void
        {
        }

    }
}//package com.sulake.habbo.room.object.visualization.room

// _wallRasterizer = "_-Yi" (String#23587, DoABC#2)
// _floorRasterizer = "_-HU" (String#22913, DoABC#2)
// _wallAdRasterizr = "_-1JT" (String#17255, DoABC#2)
// _landscapeRasterizer = "_-15j" (String#16685, DoABC#2)
// _maskManager = "_-2lS" (String#6990, DoABC#2)
// floorRasterizer = "_-1ou" (String#18495, DoABC#2)
// wallRasterizer = "_-1Th" (String#17653, DoABC#2)
// wallAdRasterizr = "_-2od" (String#21029, DoABC#2)
// landscapeRasterizer = "_-Am" (String#22646, DoABC#2)
// maskManager = "_-2sw" (String#21196, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// RoomVisualizationData = "_-0T2" (String#4161, DoABC#2)
// IPlaneRasterizer = "_-2El" (String#6336, DoABC#2)
// FloorRasterizer = "_-0Pw" (String#4090, DoABC#2)
// LandscapeRasterizer = "_-3EP" (String#7601, DoABC#2)
// WallRasterizer = "_-17Y" (String#5028, DoABC#2)
// WallAdRasterizer = "_-0Al" (String#3772, DoABC#2)
// PlaneMaskManager = "_-Dt" (String#7949, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)
// initialized = "_-2r9" (String#21124, DoABC#2)


