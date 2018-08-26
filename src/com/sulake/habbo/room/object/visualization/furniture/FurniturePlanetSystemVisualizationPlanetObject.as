
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.utils.Vector3d;

    public class FurniturePlanetSystemVisualizationPlanetObject 
    {

        private static const _SafeStr_12815:Number = 30;

        private var _index:int;
        private var _name:String;
        private var _radius:Number;
        private var _SafeStr_12816:Number;
        private var _SafeStr_12817:Number;
        private var _height:Number;
        private var _position:Number;
        private var _FurniturePlanetSystemVisualizationPlanetObject:Vector3d;
        private var _children:Array;

        public function FurniturePlanetSystemVisualizationPlanetObject(_arg_1:String, _arg_2:int, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number)
        {
            this._FurniturePlanetSystemVisualizationPlanetObject = new Vector3d(0, 0, 0);
            this._children = new Array();
            super();
            this._name = _arg_1;
            this._index = _arg_2;
            this._radius = _arg_3;
            this._SafeStr_12816 = (((_arg_4 * Math.PI) * 2) / 360);
            this._SafeStr_12817 = (((_arg_5 * Math.PI) * 2) / 360);
            this._height = _arg_6;
            this._position = 0;
        }
        public function get name():String
        {
            return (this._name);
        }
        public function dispose():void
        {
            var _local_1:FurniturePlanetSystemVisualizationPlanetObject;
            while (this._children.length > 0) {
                _local_1 = this._children.shift();
                if (_local_1 != null){
                    _local_1.dispose();
                };
            };
        }
        public function update(_arg_1:Array, _arg_2:Vector3d, _arg_3:Number):void
        {
            var _local_4:FurniturePlanetSystemVisualizationPlanetObject;
            this._position = (this._position + (this._SafeStr_12816 / _SafeStr_12815));
            _arg_1[this._index] = this.FurniturePlanetSystemVisualizationPlanetObject(_arg_2, _arg_3);
            var _local_5:int;
            while (_local_5 < this._children.length) {
                _local_4 = this._children[_local_5];
                _local_4.update(_arg_1, this._FurniturePlanetSystemVisualizationPlanetObject, _arg_3);
                _local_5++;
            };
        }
        public function FurniturePlanetSystemVisualizationPlanetObject(_arg_1:Vector3d, _arg_2:Number):Vector3d
        {
            var _local_3:Number = (this._radius * Math.cos((this._position + this._SafeStr_12817)));
            var _local_4:Number = (this._radius * Math.sin((this._position + this._SafeStr_12817)));
            var _local_5:Number = this._height;
            this._FurniturePlanetSystemVisualizationPlanetObject.x = ((_local_3 - _local_4) * (_arg_2 / 2));
            this._FurniturePlanetSystemVisualizationPlanetObject.y = ((((_local_4 + _local_3) * (_arg_2 / 2)) * 0.5) - (this._height * (_arg_2 / 2)));
            this._FurniturePlanetSystemVisualizationPlanetObject.z = -(int(((4 * (_local_3 + _local_4)) - 0.7)));
            if (_arg_1 != null){
                this._FurniturePlanetSystemVisualizationPlanetObject.add(_arg_1);
            };
            return (this._FurniturePlanetSystemVisualizationPlanetObject);
        }
        public function addChild(_arg_1:FurniturePlanetSystemVisualizationPlanetObject):void
        {
            if (this._children.indexOf(_arg_1) < 0){
                this._children.push(_arg_1);
            };
        }
        public function hasChild(_arg_1:String):Boolean
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            while (_local_3 < this._children.length) {
                _local_2 = this._children[_local_3];
                if (_local_2.name == _arg_1){
                    return (true);
                };
                if (_local_2.hasChild(_arg_1)){
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }
        public function getChild(_arg_1:String):FurniturePlanetSystemVisualizationPlanetObject
        {
            var _local_2:FurniturePlanetSystemVisualizationPlanetObject;
            var _local_3:int;
            while (_local_3 < this._children.length) {
                _local_2 = this._children[_local_3];
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
// getChild = "_-33T" (String#21640, DoABC#2)
// _SafeStr_12815 = "_-mu" (String#24148, DoABC#2)
// _SafeStr_12816 = "_-05-" (String#14242, DoABC#2)
// _SafeStr_12817 = "_-oH" (String#24203, DoABC#2)
// _FurniturePlanetSystemVisualizationPlanetObject = "_-20i" (String#19040, DoABC#2)
// FurniturePlanetSystemVisualizationPlanetObject = "_-13-" (String#16580, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// _position = "_-0Pf" (String#433, DoABC#2)
// _radius = "_-3Fr" (String#2031, DoABC#2)


