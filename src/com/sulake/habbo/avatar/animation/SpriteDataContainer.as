
package com.sulake.habbo.avatar.animation
{
    public class SpriteDataContainer implements ISpriteDataContainer 
    {

        private var _animation:IAnimation;
        private var _id:String;
        private var _ink:int;
        private var _member:String;
        private var _hasDirections:Boolean;
        private var _dx:Array;
        private var _dy:Array;
        private var _dz:Array;

        public function SpriteDataContainer(_arg_1:IAnimation, _arg_2:XML)
        {
            var _local_3:XML;
            var _local_4:int;
            super();
            this._animation = _arg_1;
            this._id = String(_arg_2.@id);
            this._ink = parseInt(_arg_2.@ink);
            this._member = String(_arg_2.@member);
            this._hasDirections = Boolean(parseInt(_arg_2.@directions));
            this._dx = [];
            this._dy = [];
            this._dz = [];
            for each (_local_3 in _arg_2.direction) {
                _local_4 = parseInt(_local_3.@id);
                this._dx[_local_4] = parseInt(_local_3.@dx);
                this._dy[_local_4] = parseInt(_local_3.@dy);
                this._dz[_local_4] = parseInt(_local_3.@dz);
            };
        }
        public function ISpriteDataContainer(_arg_1:int):int
        {
            if (_arg_1 < this._dx.length){
                return (this._dx[_arg_1]);
            };
            return (0);
        }
        public function ISpriteDataContainer(_arg_1:int):int
        {
            if (_arg_1 < this._dy.length){
                return (this._dy[_arg_1]);
            };
            return (0);
        }
        public function ISpriteDataContainer(_arg_1:int):int
        {
            if (_arg_1 < this._dz.length){
                return (this._dz[_arg_1]);
            };
            return (0);
        }
        public function get animation():IAnimation
        {
            return (this._animation);
        }
        public function get id():String
        {
            return (this._id);
        }
        public function get ink():int
        {
            return (this._ink);
        }
        public function get member():String
        {
            return (this._member);
        }
        public function get hasDirections():Boolean
        {
            return (this._hasDirections);
        }

    }
}//package com.sulake.habbo.avatar.animation

// ISpriteDataContainer = "_-2J5" (String#6422, DoABC#2)
// IAnimation = "_-2l8" (String#6983, DoABC#2)
// SpriteDataContainer = "_-0cR" (String#15532, DoABC#2)
// ISpriteDataContainer = "_-1Oo" (String#5331, DoABC#2)
// ISpriteDataContainer = "_-31k" (String#7340, DoABC#2)
// ISpriteDataContainer = "_-3HQ" (String#7657, DoABC#2)
// hasDirections = "_-1RM" (String#5383, DoABC#2)
// _ink = "_-23x" (String#874, DoABC#2)
// _dy = "_-2Hh" (String#1847, DoABC#2)
// _dz = "_-p8" (String#8693, DoABC#2)
// _animation = "_-jv" (String#8600, DoABC#2)
// _member = "_-Dc" (String#22754, DoABC#2)
// _hasDirections = "_-1JF" (String#17246, DoABC#2)


