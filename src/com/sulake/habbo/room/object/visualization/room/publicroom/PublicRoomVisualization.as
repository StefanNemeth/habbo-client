
package com.sulake.habbo.room.object.visualization.room.publicroom
{
    import com.sulake.habbo.room.object.visualization.room.RoomVisualization;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObject;

    public class PublicRoomVisualization extends RoomVisualization 
    {

        protected var _SafeStr_8497:int = 0;
        private var _SafeStr_8498:Boolean = false;

        override public function get floorRelativeDepth():Number
        {
            return (131);
        }
        override public function get wallRelativeDepth():Number
        {
            return (135);
        }
        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            if ((!(_arg_1) is PublicRoomVisualizationData)){
                return (false);
            };
            return (super.initialize(_arg_1));
        }
        private function PublicRoomVisualization(_arg_1:int):void
        {
            createSprites((this._SafeStr_8497 + _arg_1));
        }
        protected function get data():PublicRoomVisualizationData
        {
            return ((_data as PublicRoomVisualizationData));
        }
        private function PublicRoomVisualization(_arg_1:IRoomGeometry):void
        {
            var _local_2:IRoomObjectModel;
            var _local_3:String;
            var _local_4:int;
            if (this._SafeStr_8498){
                return;
            };
            if (this.data != null){
                this._SafeStr_8497 = spriteCount;
                _local_2 = object.getModel();
                _local_3 = _local_2.getString(RoomObjectVariableEnum._SafeStr_8503);
                this.data.layoutRasterizer.layout = _local_3;
                this.data.layoutRasterizer.initializeGeometry(_arg_1);
                this.PublicRoomVisualization(this.data.layoutRasterizer.elementCount());
                _local_4 = 0;
                while (_local_4 < this.data.layoutRasterizer.elementCount()) {
                    this.data.layoutRasterizer.setElementToSprite(_local_4, getSprite((_local_4 + this._SafeStr_8497)));
                    _local_4++;
                };
                this.data.layoutRasterizer.initializeAds(this._SafeStr_8497, this);
            };
            this._SafeStr_8498 = true;
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
            var _local_5:IRoomObject = object;
            if (_local_5 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            this.PublicRoomVisualization(_arg_1);
            var _local_6:IRoomObjectModel = object.getModel();
            var _local_7:String = _local_6.getString(RoomObjectVariableEnum._SafeStr_5316);
            var _local_8 = !(Boolean(_local_6.getNumber(RoomObjectVariableEnum._SafeStr_5318)));
            if (((!((_local_7 == ""))) && (!((this.data == null))))){
                this.data.layoutRasterizer.showAd(this, _local_7, _local_8);
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.publicroom

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectVisualizationData = "_-26A" (String#6167, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// PublicRoomVisualizationData = "_-Uv" (String#8302, DoABC#2)
// RoomVisualization = "_-0ky" (String#4520, DoABC#2)
// PublicRoomVisualization = "_-0TW" (String#4167, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// createSprites = "_-1Im" (String#17226, DoABC#2)
// _SafeStr_5316 = "_-1FV" (String#17095, DoABC#2)
// _SafeStr_5318 = "_-0zX" (String#16408, DoABC#2)
// initializeGeometry = "_-26d" (String#19277, DoABC#2)
// initializeAds = "_-U2" (String#23411, DoABC#2)
// showAd = "_-7u" (String#22539, DoABC#2)
// _SafeStr_8497 = "_-0K-" (String#14842, DoABC#2)
// _SafeStr_8498 = "_-qo" (String#24307, DoABC#2)
// floorRelativeDepth = "_-1De" (String#17009, DoABC#2)
// wallRelativeDepth = "_-61" (String#22467, DoABC#2)
// PublicRoomVisualization = "_-1QC" (String#17517, DoABC#2)
// PublicRoomVisualization = "_-J5" (String#22971, DoABC#2)
// _SafeStr_8503 = "_-Ri" (String#23311, DoABC#2)


