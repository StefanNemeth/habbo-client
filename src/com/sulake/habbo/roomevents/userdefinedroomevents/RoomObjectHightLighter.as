
package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import flash.display.Shader;
    import flash.filters.ShaderFilter;
    import flash.filters.ColorMatrixFilter;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import flash.display.BlendMode;

    public class RoomObjectHightLighter 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _SafeStr_13548:Array;

        public function RoomObjectHightLighter(_arg_1:HabboUserDefinedRoomEvents)
        {
            var _local_2:Class;
            var _local_3:Shader;
            var _local_4:ShaderFilter;
            var _local_5:Array;
            var _local_6:ColorMatrixFilter;
            super();
            this._SafeStr_5221 = _arg_1;
            _local_2 = RoomObjectHightLighter_GrayscaleFilter;
            _local_3 = new Shader((new (_local_2)() as ByteArray));
            _local_4 = new ShaderFilter(_local_3);
            this._SafeStr_13548 = [_local_4];
            return;
            _local_5 = [3.5, 6.5, 1, 0, -1200, 3.5, 6.5, 1, 0, -1200, 3.5, 6.5, 1, 0, -1200, 0, 0, 0, 1, 0];
            _local_6 = new ColorMatrixFilter(_local_5);
            this._SafeStr_13548 = [_local_6];
        }
        public function hide(_arg_1:int):void
        {
            this.inactivateFurni(this.getFurni(_arg_1));
        }
        public function hideAll(_arg_1:Dictionary):void
        {
            var _local_2:String;
            for (_local_2 in _arg_1) {
                Logger.log(("Show furni as unselected: " + _local_2));
                this.inactivateFurni(this.getFurni(parseInt(_local_2)));
            };
        }
        public function show(_arg_1:int):void
        {
            this.activateFurni(this.getFurni(_arg_1));
        }
        public function showAll(_arg_1:Dictionary):void
        {
            var _local_2:String;
            for (_local_2 in _arg_1) {
                Logger.log(("Show furni as selected: " + _local_2));
                this.activateFurni(this.getFurni(parseInt(_local_2)));
            };
        }
        private function getFurni(_arg_1:int):IRoomObject
        {
            return (this._SafeStr_5221.roomEngine.getRoomObject(this._SafeStr_5221.roomId, this._SafeStr_5221.roomCategory, _arg_1, RoomObjectCategoryEnum._SafeStr_4329));
        }
        private function activateFurni(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_3:int;
            var _local_4:IRoomObjectSprite;
            if (_arg_1){
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _local_2));
                _local_3 = 0;
                while (_local_3 < _local_2.spriteCount) {
                    _local_4 = _local_2.getSprite(_local_3);
                    if (_local_4.blendMode != BlendMode.ADD){
                        _local_4.filters = this._SafeStr_13548;
                    };
                    _local_3++;
                };
            };
        }
        private function inactivateFurni(_arg_1:IRoomObject):void
        {
            var _local_2:IRoomObjectSpriteVisualization;
            var _local_3:int;
            var _local_4:IRoomObjectSprite;
            if (_arg_1){
                _local_2 = (_arg_1.getVisualization() as IRoomObjectSpriteVisualization);
                Logger.log(("Furni visualization: " + _local_2));
                _local_3 = 0;
                while (_local_3 < _local_2.spriteCount) {
                    _local_4 = _local_2.getSprite(_local_3);
                    _local_4.filters = [];
                    _local_3++;
                };
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents

// getVisualization = "_-1At" (String#5090, DoABC#2)
// _SafeStr_13548 = "_-0Ge" (String#14707, DoABC#2)
// inactivateFurni = "_-379" (String#21774, DoABC#2)
// hideAll = "_-0ei" (String#15614, DoABC#2)
// activateFurni = "_-3KN" (String#22298, DoABC#2)
// showAll = "_-al" (String#23662, DoABC#2)
// IRoomObjectSpriteVisualization = "_-2Xc" (String#6715, DoABC#2)
// RoomObjectHightLighter = "_-1Nm" (String#5306, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// RoomObjectHightLighter_GrayscaleFilter = "_-0a5" (String#4302, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// getFurni = "_-0B5" (String#3779, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)


