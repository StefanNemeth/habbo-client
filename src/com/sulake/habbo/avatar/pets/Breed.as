
package com.sulake.habbo.avatar.pets
{
    public class Breed extends PetEditorInfo implements IBreed 
    {

        private var _id:int;
        private var _localizationKey:String = "";
        private var _gender:String;
        private var _isColorable:Boolean;
        private var _isSellable:Boolean = true;
        private var _patternId:int;
        private var _avatarFigureString:String;

        public function Breed(_arg_1:XML)
        {
            super(_arg_1);
            this._id = parseInt(_arg_1.@id);
            this._patternId = parseInt(_arg_1.@pattern);
            this._gender = String(_arg_1.@gender);
            this._isColorable = Boolean(parseInt(_arg_1.@colorable));
            this._localizationKey = String(_arg_1.@localizationKey);
            if (((Boolean(_arg_1.@sellable)) && ((_arg_1.@sellable == "0")))){
                this._isSellable = false;
            };
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function get isColorable():Boolean
        {
            return (this._isColorable);
        }
        public function get isSellable():Boolean
        {
            return (this._isSellable);
        }
        public function get patternId():int
        {
            return (this._patternId);
        }
        public function get avatarFigureString():String
        {
            return (this._avatarFigureString);
        }
        public function set avatarFigureString(_arg_1:String):void
        {
            this._avatarFigureString = _arg_1;
        }
        public function get localizationKey():String
        {
            return (this._localizationKey);
        }

    }
}//package com.sulake.habbo.avatar.pets

// _patternId = "_-3KF" (String#22291, DoABC#2)
// _avatarFigureString = "_-0BS" (String#14504, DoABC#2)
// PetEditorInfo = "_-13t" (String#4952, DoABC#2)
// IBreed = "_-14f" (String#4973, DoABC#2)
// Breed = "_-0vW" (String#4757, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _localizationKey = "_-09T" (String#1412, DoABC#2)
// isColorable = "_-0df" (String#4384, DoABC#2)
// _isColorable = "_-iV" (String#2165, DoABC#2)
// isSellable = "_-0aB" (String#4305, DoABC#2)
// _isSellable = "_-3JW" (String#7695, DoABC#2)


