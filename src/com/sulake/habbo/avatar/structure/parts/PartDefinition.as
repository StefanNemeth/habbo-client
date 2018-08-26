
package com.sulake.habbo.avatar.structure.parts
{
    public class PartDefinition 
    {

        private var _setType:String;
        private var _flippedSetType:String;
        private var _removeSetType:String;
        private var _appendToFigure:Boolean;
        private var _staticId:int = -1;

        public function PartDefinition(_arg_1:XML)
        {
            this._setType = String(_arg_1.@["set-type"]);
            this._flippedSetType = String(_arg_1.@["flipped-set-type"]);
            this._removeSetType = String(_arg_1.@["remove-set-type"]);
            this._appendToFigure = false;
        }
        public function hasStaticId():Boolean
        {
            return ((this._staticId >= 0));
        }
        public function get staticId():int
        {
            return (this._staticId);
        }
        public function set staticId(_arg_1:int):void
        {
            this._staticId = _arg_1;
        }
        public function get setType():String
        {
            return (this._setType);
        }
        public function get flippedSetType():String
        {
            return (this._flippedSetType);
        }
        public function get removeSetType():String
        {
            return (this._removeSetType);
        }
        public function get appendToFigure():Boolean
        {
            return (this._appendToFigure);
        }
        public function set appendToFigure(_arg_1:Boolean):void
        {
            this._appendToFigure = _arg_1;
        }
        public function set flippedSetType(_arg_1:String):void
        {
            this._flippedSetType = _arg_1;
        }

    }
}//package com.sulake.habbo.avatar.structure.parts

// _setType = "_-3JN" (String#22259, DoABC#2)
// _flippedSetType = "_-2JN" (String#19783, DoABC#2)
// _removeSetType = "_-0lG" (String#15875, DoABC#2)
// _appendToFigure = "_-22a" (String#19114, DoABC#2)
// _staticId = "_-3DL" (String#22009, DoABC#2)
// hasStaticId = "_-89" (String#22547, DoABC#2)
// staticId = "_-b8" (String#23673, DoABC#2)
// setType = "_-2uA" (String#21246, DoABC#2)
// flippedSetType = "_-0gz" (String#15709, DoABC#2)
// removeSetType = "_-3Dy" (String#22032, DoABC#2)
// appendToFigure = "_-f8" (String#23851, DoABC#2)
// PartDefinition = "_-2TQ" (String#6632, DoABC#2)


