
package com.sulake.habbo.avatar.structure.animation
{
    public class ActionPart 
    {

        private var _frames:Array;

        public function ActionPart(_arg_1:XML)
        {
            var _local_2:XML;
            super();
            this._frames = new Array();
            for each (_local_2 in _arg_1.frame) {
                this._frames.push(parseInt(_local_2.@number));
            };
        }
        public function hasFrame(_arg_1:int):Boolean
        {
            return ((this._frames.indexOf(_arg_1) > -1));
        }
        public function get frames():Array
        {
            return (this._frames);
        }

    }
}//package com.sulake.habbo.avatar.structure.animation

// ActionPart = "_-1WB" (String#5476, DoABC#2)
// hasFrame = "_-2hk" (String#20763, DoABC#2)


