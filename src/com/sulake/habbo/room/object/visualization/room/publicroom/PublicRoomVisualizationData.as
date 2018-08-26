
package com.sulake.habbo.room.object.visualization.room.publicroom
{
    import com.sulake.habbo.room.object.visualization.room.RoomVisualizationData;
    import com.sulake.habbo.room.object.visualization.room.publicroom.rasterizer.LayoutRasterizer;
    import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;

    public class PublicRoomVisualizationData extends RoomVisualizationData 
    {

        private var _layoutRasterizer:LayoutRasterizer;
        private var _initialized:Boolean = false;

        public function PublicRoomVisualizationData()
        {
            this._layoutRasterizer = new LayoutRasterizer();
        }
        public function get layoutRasterizer():LayoutRasterizer
        {
            return (this._layoutRasterizer);
        }
        override public function dispose():void
        {
            super.dispose();
            if (this._layoutRasterizer != null){
                this._layoutRasterizer.dispose();
                this._layoutRasterizer = null;
            };
        }
        override public function initialize(_arg_1:XML):Boolean
        {
            var _local_4:XML;
            if (!super.initialize(_arg_1)){
                return (false);
            };
            if (_arg_1 == null){
                return (false);
            };
            var _local_2:XMLList = _arg_1.layoutData;
            var _local_3:int;
            while (_local_3 < _local_2.length()) {
                _local_4 = _local_2[_local_3];
                this._layoutRasterizer.initialize(_local_4);
                _local_3++;
            };
            return (true);
        }
        override public function initializeAssetCollection(_arg_1:IGraphicAssetCollection):void
        {
            if (initialized){
                return;
            };
            super.initializeAssetCollection(_arg_1);
            this._layoutRasterizer.initializeAssetCollection(_arg_1);
        }
        override protected function reset():void
        {
            super.reset();
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.publicroom

// IGraphicAssetCollection = "_-24o" (String#6134, DoABC#2)
// RoomVisualizationData = "_-0T2" (String#4161, DoABC#2)
// PublicRoomVisualizationData = "_-Uv" (String#8302, DoABC#2)
// LayoutRasterizer = "_-2Xe" (String#6716, DoABC#2)
// _initialized = "_-0EY" (String#214, DoABC#2)
// initializeAssetCollection = "_-24a" (String#19205, DoABC#2)
// initialized = "_-2r9" (String#21124, DoABC#2)


