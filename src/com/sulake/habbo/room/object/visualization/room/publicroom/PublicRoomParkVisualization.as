
package com.sulake.habbo.room.object.visualization.room.publicroom
{
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.utils.IRoomGeometry;

    public class PublicRoomParkVisualization extends PublicRoomVisualization 
    {

        private var _SafeStr_8504:Boolean;

        public function PublicRoomParkVisualization()
        {
            this._SafeStr_8504 = false;
        }
        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            var _local_9:String;
            var _local_10:int;
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
            var _local_5:IRoomObject = object;
            if (_local_5 == null){
                return;
            };
            if (_arg_1 == null){
                return;
            };
            var _local_6:IRoomObjectModel = object.getModel();
            var _local_7:int = _local_6.getNumber(RoomObjectVariableEnum._SafeStr_8505);
            var _local_8:Boolean = Boolean(_local_7);
            if (data != null){
                if (this._SafeStr_8504 != _local_8){
                    _local_9 = "";
                    if (_local_8){
                        data.layoutRasterizer.changeElementAlpha("bus", 0);
                        data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden", 0xFF);
                    }
                    else {
                        data.layoutRasterizer.changeElementAlpha("bus", 0xFF);
                        data.layoutRasterizer.changeElementAlpha("bus_oviopen_hidden", 0);
                    };
                    this._SafeStr_8504 = _local_8;
                };
                if (data.layoutRasterizer.graphicsChanged){
                    _local_10 = 0;
                    while (_local_10 < data.layoutRasterizer.elementCount()) {
                        data.layoutRasterizer.setElementToSprite(_local_10, getSprite((_local_10 + _SafeStr_8497)));
                        _local_10++;
                    };
                };
            };
        }

    }
}//package com.sulake.habbo.room.object.visualization.room.publicroom

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// PublicRoomVisualization = "_-0TW" (String#4167, DoABC#2)
// PublicRoomParkVisualization = "_-2vl" (String#7193, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// _SafeStr_8497 = "_-0K-" (String#14842, DoABC#2)
// _SafeStr_8504 = "_-0FG" (String#3857, DoABC#2)
// _SafeStr_8505 = "_-2k3" (String#20848, DoABC#2)


