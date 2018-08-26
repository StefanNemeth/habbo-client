
package com.sulake.habbo.avatar.structure.animation
{
    import flash.utils.Dictionary;

    public class AnimationAction 
    {

        private var _id:String;
        private var _parts:Dictionary;

        public function AnimationAction(_arg_1:XML)
        {
            var _local_2:XML;
            super();
            this._id = String(_arg_1.@id);
            this._parts = new Dictionary();
            for each (_local_2 in _arg_1.part) {
                this._parts[String(_local_2.@["set-type"])] = new ActionPart(_local_2);
            };
        }
        public function getPart(_arg_1:String):ActionPart
        {
            return ((this._parts[_arg_1] as ActionPart));
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get parts():Dictionary
        {
            return (this._parts);
        }

    }
}//package com.sulake.habbo.avatar.structure.animation

// ActionPart = "_-1WB" (String#5476, DoABC#2)
// AnimationAction = "_-11k" (String#4910, DoABC#2)
// _parts = "_-SR" (String#23343, DoABC#2)
// getPart = "_-1hb" (String#5700, DoABC#2)


