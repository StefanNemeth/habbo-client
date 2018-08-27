
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureGiftWrappedVisualization extends FurnitureVisualization 
    {

        private var _SafeStr_12678:int = 0;
        private var _SafeStr_12679:int = 0;

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            this.updateTypes();
            super.update(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        private function updateTypes():void
        {
            var _local_2:IRoomObjectModel;
            var _local_3:int;
            var _local_4:String;
            var _local_5:int;
            var _local_1:IRoomObject = object;
            if (_local_1 != null){
                _local_2 = _local_1.getModel();
                if (_local_2 != null){
                    _local_3 = 1000;
                    _local_4 = _local_2.getString(RoomObjectVariableEnum._SafeStr_7295);
                    _local_5 = parseInt(_local_4);
                    this._SafeStr_12678 = Math.floor((_local_5 / _local_3));
                    this._SafeStr_12679 = (_local_5 % _local_3);
                };
            };
        }
        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            if (_arg_2 <= 1){
                return (this._SafeStr_12678);
            };
            return (this._SafeStr_12679);
        }
        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:int = getSize(_arg_1);
            var _local_4:String = type;
            var _local_5:String = "";
            if (_arg_2 < (spriteCount - 1)){
                _local_5 = String.fromCharCode(("a".charCodeAt() + _arg_2));
            }
            else {
                _local_5 = "sd";
            };
            var _local_6:int = this.getFrameNumber(_arg_1, _arg_2);
            _local_4 = (_local_4 + ((((("_" + _local_3) + "_") + _local_5) + "_") + direction));
            return ((_local_4 + ("_" + _local_6)));
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// _SafeStr_12678 = "_-1HV" (String#17169, DoABC#2)
// _SafeStr_12679 = "_-377" (String#21772, DoABC#2)
// updateTypes = "_-2c" (String#20523, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// FurnitureVisualization = "_-1sy" (String#5900, DoABC#2)
// FurnitureGiftWrappedVisualization = "_-32z" (String#7365, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// getFrameNumber = "_-0XM" (String#436, DoABC#2)
// getSpriteAssetName = "_-0c-" (String#590, DoABC#2)
// getSize = "_-1GK" (String#5174, DoABC#2)
// _SafeStr_7295 = "_-2nE" (String#20969, DoABC#2)


