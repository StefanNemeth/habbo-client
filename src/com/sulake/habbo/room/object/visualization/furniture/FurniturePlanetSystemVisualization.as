
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurniturePlanetSystemVisualization extends AnimatedFurnitureVisualization 
    {

        private var _SafeStr_12647:Array;
        private var _planetNameIndex:Array;
        private var _offsetArray:Array;
        private var _SafeStr_12648:Vector3d;

        public function FurniturePlanetSystemVisualization()
        {
            this._offsetArray = new Array();
            this._SafeStr_12648 = new Vector3d(0, 0, 0);
            super();
        }
        override public function dispose():void
        {
            var _local_1:FurniturePlanetSystemVisualizationPlanetObject;
            if (this._SafeStr_12647 != null){
                while (this._SafeStr_12647.length > 0) {
                    _local_1 = this._SafeStr_12647.shift();
                    _local_1.dispose();
                };
            };
            this._SafeStr_12647 = null;
            this._planetNameIndex = null;
        }
        override protected function updateAnimation(_arg_1:Number):int
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            if ((((this._SafeStr_12647 == null)) && ((spriteCount > 0)))){
                if (!this.readDefinition()){
                    return (0);
                };
            };
            if (this._SafeStr_12647 != null){
                _local_3 = 0;
                while (_local_3 < this._SafeStr_12647.length) {
                    _local_2 = this._SafeStr_12647[_local_3];
                    _local_2.update(this._offsetArray, this._SafeStr_12648, _arg_1);
                    _local_3++;
                };
                return (super.updateAnimation(_arg_1));
            };
            return (0);
        }
        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_arg_3 < this._offsetArray.length){
                return (this._offsetArray[_arg_3].x);
            };
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3));
        }
        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            if (_arg_3 < this._offsetArray.length){
                return (this._offsetArray[_arg_3].y);
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
        }
        override protected function getSpriteZOffset(_arg_1:int, _arg_2:int, _arg_3:int):Number
        {
            if (_arg_3 < this._offsetArray.length){
                return (this._offsetArray[_arg_3].z);
            };
            return (super.getSpriteZOffset(_arg_1, _arg_2, _arg_3));
        }
        private function readDefinition():Boolean
        {
            var _local_7:IRoomObjectSprite;
            var _local_9:XML;
            var _local_1:IRoomObject = object;
            if (_local_1 == null){
                return (false);
            };
            var _local_2:IRoomObjectModel = _local_1.getModel();
            if (_local_2 == null){
                return (false);
            };
            var _local_3:String = _local_2.getString(RoomObjectVariableEnum._SafeStr_12495);
            var _local_4:XMLList = XMLList(_local_3);
            var _local_5:XMLList = _local_4.children();
            var _local_6:int = _local_5.length();
            this._SafeStr_12647 = new Array();
            this._planetNameIndex = new Array();
            var _local_8:int;
            while (_local_8 < _local_6) {
                _local_9 = _local_5[_local_8];
                _local_7 = getSprite(_local_8);
                if (_local_7 != null){
                    this.addPlanet(_local_9.@name, _local_8, _local_9.@parent, Number(_local_9.@radius), Number(_local_9.@arcspeed), Number(_local_9.@arcoffset), Number(_local_9.@height));
                };
                _local_8++;
            };
            return (true);
        }
        private function addPlanet(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):void
        {
            var _local_9:FurniturePlanetSystemVisualizationPlanetObject;
            if (this._SafeStr_12647 == null){
                return;
            };
            var _local_8:FurniturePlanetSystemVisualizationPlanetObject = new FurniturePlanetSystemVisualizationPlanetObject(_arg_1, _arg_2, _arg_4, _arg_5, _arg_6, _arg_7);
            _local_9 = this.getPlanet(_arg_3);
            if (_local_9 != null){
                _local_9.addChild(_local_8);
            }
            else {
                this._SafeStr_12647.push(_local_8);
                this._planetNameIndex.push(_arg_1);
            };
        }
        private function getPlanet(_arg_1:String):FurniturePlanetSystemVisualizationPlanetObject
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            while (_local_3 < this._SafeStr_12647.length) {
                _local_2 = this._SafeStr_12647[_local_3];
                if (_local_2.name == _arg_1){
                    return (_local_2);
                };
                if (_local_2.hasChild(_arg_1)){
                    return (_local_2.getChild(_arg_1));
                };
                _local_3++;
            };
            return (null);
        }

    }
}//package com.sulake.habbo.room.object.visualization.furniture

// hasChild = "_-1eH" (String#5633, DoABC#2)
// _SafeStr_12495 = "_-0uB" (String#16212, DoABC#2)
// _SafeStr_12647 = "_-1wa" (String#18825, DoABC#2)
// _SafeStr_12648 = "_-2hw" (String#20769, DoABC#2)
// readDefinition = "_-hC" (String#8539, DoABC#2)
// addPlanet = "_-0nr" (String#15971, DoABC#2)
// getPlanet = "_-2Ra" (String#20102, DoABC#2)
// getChild = "_-33T" (String#21640, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// AnimatedFurnitureVisualization = "_-0y2" (String#4811, DoABC#2)
// FurniturePlanetSystemVisualization = "_-1AX" (String#5085, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// updateAnimation = "_-XZ" (String#166, DoABC#2)
// getSprite = "_-sN" (String#2210, DoABC#2)
// spriteCount = "_-2A7" (String#6252, DoABC#2)
// getSpriteXOffset = "_-03Y" (String#354, DoABC#2)
// getSpriteYOffset = "_-3IZ" (String#251, DoABC#2)
// getSpriteZOffset = "_-25C" (String#614, DoABC#2)


