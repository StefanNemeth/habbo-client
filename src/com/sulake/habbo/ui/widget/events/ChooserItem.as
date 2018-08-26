
package com.sulake.habbo.ui.widget.events
{
    public class ChooserItem 
    {

        private var _id:int;
        private var _category:int;
        private var _name:String;

        public function ChooserItem(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            this._id = _arg_1;
            this._category = _arg_2;
            this._name = _arg_3;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get category():int
        {
            return (this._category);
        }
        public function get name():String
        {
            return (this._name);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// ChooserItem = "_-2XQ" (String#6710, DoABC#2)


