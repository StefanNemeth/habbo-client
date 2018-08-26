
package com.sulake.habbo.avatar.animation
{
    public class AddDataContainer 
    {

        private var _id:String;
        private var _align:String;
        private var _base:String;
        private var _ink:String;
        private var _blend:Number = 1;

        public function AddDataContainer(_arg_1:XML)
        {
            this._id = String(_arg_1.@id);
            this._align = String(_arg_1.@align);
            this._base = String(_arg_1.@base);
            this._ink = String(_arg_1.@ink);
            var _local_2:String = String(_arg_1.@blend);
            if (_local_2.length > 0){
                this._blend = Number(_local_2);
                if (this._blend > 1){
                    this._blend = (this._blend / 100);
                };
            };
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get align():String
        {
            return (this._align);
        }
        public function get base():String
        {
            return (this._base);
        }
        public function get ink():String
        {
            return (this._ink);
        }
        public function get blend():Number
        {
            return (this._blend);
        }
        public function get isBlended():Boolean
        {
            return (!((this._blend == 1)));
        }

    }
}//package com.sulake.habbo.avatar.animation

// AddDataContainer = "_-13k" (String#4948, DoABC#2)
// _blend = "_-2A2" (String#616, DoABC#2)
// _ink = "_-23x" (String#874, DoABC#2)
// isBlended = "_-1h4" (String#18179, DoABC#2)


