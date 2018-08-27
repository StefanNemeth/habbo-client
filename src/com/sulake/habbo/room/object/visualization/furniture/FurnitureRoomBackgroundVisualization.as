
package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.utils.Dictionary;
    import com.sulake.room.object.IRoomObjectModel;
    import flash.display.BitmapData;
    import com.sulake.habbo.room.object.visualization.data.DirectionalOffsetData;

    public class FurnitureRoomBackgroundVisualization extends FurnitureRoomBrandingVisualization 
    {

        private var _SafeStr_12693:Dictionary;

        override public function dispose():void
        {
            super.dispose();
            this._SafeStr_12693 = null;
        }
        override protected function getAdClickUrl(_arg_1:IRoomObjectModel):String
        {
            return (null);
        }
        override protected function imageReady(_arg_1:BitmapData, _arg_2:String):void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            super.imageReady(_arg_1, _arg_2);
            if (_arg_1 != null){
                this._SafeStr_12693 = new Dictionary();
                _local_3 = 64;
                _local_4 = _arg_1.width;
                _local_5 = _arg_1.height;
                this._SafeStr_12694(_local_3, _local_5, _local_4);
                _local_3 = 32;
                _local_4 = (_local_4 / 2);
                _local_5 = (_local_5 / 2);
                this._SafeStr_12694(_local_3, _local_5, _local_4);
            };
        }
        private function _SafeStr_12694(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int = getSize(_arg_1);
            var _local_5:DirectionalOffsetData = new DirectionalOffsetData();
            _local_5.setOffset(1, 0, -(_arg_2));
            _local_5.setOffset(3, 0, 0);
            _local_5.setOffset(5, -(_arg_3), 0);
            _local_5.setOffset(7, -(_arg_3), -(_arg_2));
            _local_5.setOffset(4, (-(_arg_3) / 2), (-(_arg_2) / 2));
            this._SafeStr_12693[_local_4] = _local_5;
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            var _local_5:DirectionalOffsetData;
            if (this._SafeStr_12693 != null){
                _local_4 = getSize(_arg_1);
                _local_5 = this._SafeStr_12693[_local_4];
                if (_local_5 != null){
                    return ((_local_5.getOffsetX(_arg_2, 0) + _SafeStr_12659));
                };
            };
            return ((super.getSpriteXOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_12659));
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:int;
            var _local_5:DirectionalOffsetData;
            if (this._SafeStr_12693 != null){
                _local_4 = getSize(_arg_1);
                _local_5 = this._SafeStr_12693[_local_4];
                if (_local_5 != null){
                    return ((_local_5.getOffsetY(_arg_2, 0) + _SafeStr_12660));
                };
            };
            return ((super.getSpriteYOffset(_arg_1, _arg_2, _arg_3) + _SafeStr_12660));
        }
        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            return ((super.getSpriteZOffset(_arg_1, _arg_2, _arg_3) + (_paramOffsetZ * -1)));
        }
        override protected function getSpriteMouseCapture(_arg_1:int, _arg_2:int, _arg_3:int):Boolean
        {
            return (false);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// getAdClickUrl = "_-0z5" (String#438, DoABC#2)
// setOffset = "_-2O1" (String#19966, DoABC#2)
// getOffsetX = "_-7U" (String#22522, DoABC#2)
// getOffsetY = "_-1ox" (String#18498, DoABC#2)
// getSpriteMouseCapture = "_-1sk" (String#5897, DoABC#2)
// _SafeStr_12659 = "_-Hj" (String#22921, DoABC#2)
// _SafeStr_12660 = "_-1-i" (String#16455, DoABC#2)
// _SafeStr_12693 = "_-0j6" (String#15797, DoABC#2)
// _SafeStr_12694 = "switch" (String#46916, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureRoomBrandingVisualization = "_-1XC" (String#5501, DoABC#2)
// FurnitureRoomBackgroundVisualization = "_-0Jt" (String#3948, DoABC#2)
// DirectionalOffsetData = "_-0oK" (String#4599, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// getSpriteZOffset = "_-25C" (String#614, DoABC#2)
// getSize = "_-1GK" (String#5174, DoABC#2)


