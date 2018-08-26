
package com.sulake.habbo.avatar.animation
{
    public class CanvasDataContainer 
    {

        private var _id:String;
        private var _width:int;
        private var _height:int;

        public function CanvasDataContainer(_arg_1:XML)
        {
            this._id = String(_arg_1.@id);
            this._width = parseInt(_arg_1.@width);
            this._height = parseInt(_arg_1.@height);
        }
    }
}//package com.sulake.habbo.avatar.animation

// CanvasDataContainer = "_-1-d" (String#16452, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)


