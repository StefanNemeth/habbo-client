
package com.sulake.habbo.avatar.structure.parts
{
    public class ActivePartSet 
    {

        private var _id:String;
        private var _parts:Array;

        public function ActivePartSet(_arg_1:XML)
        {
            var _local_2:XML;
            super();
            this._id = String(_arg_1.@id);
            this._parts = new Array();
            for each (_local_2 in _arg_1.activePart) {
                this._parts.push(String(_local_2.@["set-type"]));
            };
        }
        public function get parts():Array
        {
            return (this._parts);
        }

    }
}//package com.sulake.habbo.avatar.structure.parts

// ActivePartSet = "_-kb" (String#8617, DoABC#2)


