
package com.sulake.habbo.avatar.structure.figure
{
    public class FigurePartSet implements IFigurePartSet 
    {

        private var _type:String;
        private var _id:int;
        private var _gender:String;
        private var _clubLevel:int;
        private var _isColorable:Boolean;
        private var _isSelectable:Boolean;
        private var _parts:Array;
        private var _hiddenLayers:Array;

        public function FigurePartSet(_arg_1:XML, _arg_2:String)
        {
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:FigurePart;
            var _local_6:int;
            super();
            this._type = _arg_2;
            this._id = parseInt(_arg_1.@id);
            this._gender = String(_arg_1.@gender);
            this._clubLevel = parseInt(_arg_1.@club);
            this._isColorable = Boolean(parseInt(_arg_1.@colorable));
            this._isSelectable = Boolean(parseInt(_arg_1.@selectable));
            this._parts = new Array();
            this._hiddenLayers = new Array();
            for each (_local_3 in _arg_1.part) {
                _local_5 = new FigurePart(_local_3);
                _local_6 = this.indexOfPartType(_local_5);
                if (_local_6 != -1){
                    this._parts.splice(_local_6, 0, _local_5);
                }
                else {
                    this._parts.push(_local_5);
                };
            };
            for each (_local_4 in _arg_1.hiddenlayers.layer) {
                this._hiddenLayers.push(String(_local_4.@parttype));
            };
        }
        public function dispose():void
        {
            var _local_1:FigurePart;
            for each (_local_1 in this._parts) {
                _local_1.dispose();
            };
            this._parts = null;
            this._hiddenLayers = null;
        }
        private function indexOfPartType(_arg_1:FigurePart):int
        {
            var _local_3:FigurePart;
            var _local_2:int;
            while (_local_2 < this._parts.length) {
                _local_3 = this._parts[_local_2];
                if ((((_local_3.type == _arg_1.type)) && ((_local_3.index < _arg_1.index)))){
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }
        public function getPart(_arg_1:String, _arg_2:int):IFigurePart
        {
            var _local_3:FigurePart;
            for each (_local_3 in this._parts) {
                if ((((_local_3.type == _arg_1)) && ((_local_3.id == _arg_2)))){
                    return (_local_3);
                };
            };
            return (null);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function get clubLevel():int
        {
            return (this._clubLevel);
        }
        public function get isColorable():Boolean
        {
            return (this._isColorable);
        }
        public function get isSelectable():Boolean
        {
            return (this._isSelectable);
        }
        public function get parts():Array
        {
            return (this._parts);
        }
        public function get hiddenLayers():Array
        {
            return (this._hiddenLayers);
        }

    }
}//package com.sulake.habbo.avatar.structure.figure

// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// FigurePart = "_-2tY" (String#7149, DoABC#2)
// FigurePartSet = "_-0fB" (String#4410, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _isSelectable = "_-t7" (String#947, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// getPart = "_-1hb" (String#5700, DoABC#2)
// isColorable = "_-0df" (String#4384, DoABC#2)
// hiddenLayers = "_-3IA" (String#7671, DoABC#2)
// _isColorable = "_-iV" (String#2165, DoABC#2)
// _hiddenLayers = "_-2qP" (String#21098, DoABC#2)


