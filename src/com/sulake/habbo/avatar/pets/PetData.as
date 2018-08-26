
package com.sulake.habbo.avatar.pets
{
    public class PetData implements IPetData 
    {

        private var _name:String;
        private var _species:int;
        private var _disableHeadTurn:Boolean = false;
        private var _scale:String;
        private var _colors:Array;
        private var _breeds:Array;
        private var _sellableBreeds:Array;

        public function PetData(_arg_1:XML)
        {
            var _local_2:XML;
            var _local_3:XML;
            var _local_4:XML;
            var _local_5:IBreed;
            super();
            this._name = _arg_1.@name;
            this._species = parseInt(_arg_1.@species);
            this._disableHeadTurn = Boolean(parseInt(_arg_1.@disableheadturn));
            this._scale = _arg_1.@scale;
            this._colors = new Array();
            this._breeds = new Array();
            this._sellableBreeds = new Array();
            Logger.log(("Found Pet Pack: " + this._name));
            for each (_local_2 in _arg_1.breeds.breed) {
                _local_5 = new Breed(_local_2);
                this._breeds.push(_local_5);
                if (_local_5.isSellable){
                    this._sellableBreeds.push(_local_5);
                };
            };
            for each (_local_3 in _arg_1.colors.color) {
                this._colors.push(new PetColor(_local_3));
            };
            for each (_local_4 in _arg_1.joints.joint) {
            };
        }
        public function findColor(_arg_1:uint):PetColor
        {
            var _local_2:PetColor;
            for each (var _local_5 in this._colors) {
                _local_2 = _local_5;
                _local_5;
                if (_local_2.rgb == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function findBreed(_arg_1:int):Breed
        {
            var _local_2:Breed;
            for each (var _local_5 in this._breeds) {
                _local_2 = _local_5;
                _local_5;
                if (_local_2.id == _arg_1){
                    return (_local_2);
                };
            };
            return (null);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get species():int
        {
            return (this._species);
        }
        public function get scale():String
        {
            return (this._scale);
        }
        public function get colors():Array
        {
            return (this._colors);
        }
        public function get breeds():Array
        {
            return (this._breeds);
        }
        public function get sellableBreeds():Array
        {
            return (this._sellableBreeds);
        }
        public function get disableHeadTurn():Boolean
        {
            return (this._disableHeadTurn);
        }

    }
}//package com.sulake.habbo.avatar.pets

// _species = "_-2BX" (String#6277, DoABC#2)
// _sellableBreeds = "_-15E" (String#1618, DoABC#2)
// findColor = "_-217" (String#19055, DoABC#2)
// findBreed = "_-pk" (String#24262, DoABC#2)
// sellableBreeds = "_-2ie" (String#6923, DoABC#2)
// disableHeadTurn = "_-0aA" (String#4304, DoABC#2)
// PetData = "_-01G" (String#1387, DoABC#2)
// IPetData = "_-0mZ" (String#4560, DoABC#2)
// PetColor = "_-2Cu" (String#6304, DoABC#2)
// IBreed = "_-14f" (String#4973, DoABC#2)
// Breed = "_-0vW" (String#4757, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// isSellable = "_-0aB" (String#4305, DoABC#2)


