
package com.sulake.habbo.avatar.pets
{
    public class PetEditorInfo 
    {

        private var _isClub:Boolean;
        private var _isSelectable:Boolean;

        public function PetEditorInfo(_arg_1:XML)
        {
            this._isClub = Boolean(parseInt(_arg_1.@club));
            this._isSelectable = Boolean(parseInt(_arg_1.@selectable));
        }
        public function get isClub():Boolean
        {
            return (this._isClub);
        }
        public function get isSelectable():Boolean
        {
            return (this._isSelectable);
        }

    }
}//package com.sulake.habbo.avatar.pets

// _isClub = "_-hA" (String#23938, DoABC#2)
// isClub = "_-0k9" (String#15837, DoABC#2)
// PetEditorInfo = "_-13t" (String#4952, DoABC#2)
// _isSelectable = "_-t7" (String#947, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)


