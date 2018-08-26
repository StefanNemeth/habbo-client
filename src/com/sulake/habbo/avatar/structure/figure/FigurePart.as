
package com.sulake.habbo.avatar.structure.figure
{
    public class FigurePart implements IFigurePart 
    {

        private var _id:int;
        private var _type:String;
        private var _breed:int = -1;
        private var _colorLayerIndex:int;
        private var _index:int;
        private var _paletteMapId:int = -1;

        public function FigurePart(_arg_1:XML)
        {
            this._id = parseInt(_arg_1.@id);
            this._type = String(_arg_1.@type);
            this._index = parseInt(_arg_1.@index);
            this._colorLayerIndex = parseInt(_arg_1.@colorindex);
            var _local_2:String = _arg_1.@palettemapid;
            if (_local_2 != ""){
                this._paletteMapId = int(_local_2);
            };
            var _local_3:String = _arg_1.@breed;
            if (_local_3 != ""){
                this._breed = int(_local_3);
            };
        }
        public function dispose():void
        {
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get breed():int
        {
            return (this._breed);
        }
        public function get colorLayerIndex():int
        {
            return (this._colorLayerIndex);
        }
        public function get index():int
        {
            return (this._index);
        }
        public function get paletteMap():int
        {
            return (this._paletteMapId);
        }

    }
}//package com.sulake.habbo.avatar.structure.figure

// FigurePart = "_-2tY" (String#7149, DoABC#2)
// _breed = "_-0BH" (String#297, DoABC#2)
// _colorLayerIndex = "_-dK" (String#23772, DoABC#2)
// _paletteMapId = "_-05C" (String#3669, DoABC#2)
// colorLayerIndex = "_-05t" (String#3683, DoABC#2)


