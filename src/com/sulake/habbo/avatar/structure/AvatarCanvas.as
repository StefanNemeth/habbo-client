
package com.sulake.habbo.avatar.structure
{
    import flash.geom.Point;

    public class AvatarCanvas 
    {

        private var _id:String;
        private var _width:int;
        private var _height:int;
        private var _depth:int;
        private var _dy:int;
        private var _dx:int;
        private var _offset:Point;

        public function AvatarCanvas(_arg_1:XML)
        {
            this._id = String(_arg_1.@id);
            this._width = parseInt(_arg_1.@width);
            this._height = parseInt(_arg_1.@height);
            this._depth = parseInt(_arg_1.@depth);
            this._dx = parseInt(_arg_1.@dx);
            this._dy = parseInt(_arg_1.@dy);
            this._offset = new Point(this._dx, this._dy);
        }
        public function get width():int
        {
            return (this._width);
        }
        public function get height():int
        {
            return (this._height);
        }
        public function get offset():Point
        {
            return (this._offset);
        }
        public function get id():String
        {
            return (this._id);
        }

    }
}//package com.sulake.habbo.avatar.structure

// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// _depth = "_-XX" (String#935, DoABC#2)
// _dy = "_-2Hh" (String#1847, DoABC#2)


