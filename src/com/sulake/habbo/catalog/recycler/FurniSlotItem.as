
package com.sulake.habbo.catalog.recycler
{
    public class FurniSlotItem 
    {

        private var _id:int = 0;
        private var _category:int = 0;
        private var _typeId:int = 0;
        private var _xxxExtra:String = null;

        public function FurniSlotItem(_arg_1:int, _arg_2:int, _arg_3:int=0, _arg_4:String=null)
        {
            this._id = _arg_1;
            this._category = _arg_2;
            this._typeId = _arg_3;
            this._xxxExtra = _arg_4;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get typeId():int
        {
            return (this._typeId);
        }
        public function get xxxExtra():String
        {
            return (this._xxxExtra);
        }
        public function set id(_arg_1:int):void
        {
            this._id = _arg_1;
        }

    }
}//package com.sulake.habbo.catalog.recycler

// _typeId = "_-3LT" (String#2045, DoABC#2)
// _xxxExtra = "_-0qA" (String#16056, DoABC#2)
// FurniSlotItem = "_-19d" (String#5069, DoABC#2)


