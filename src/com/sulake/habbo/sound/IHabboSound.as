
package com.sulake.habbo.sound
{
    public interface IHabboSound 
    {

        function play(_arg_1:Number=0):Boolean;
        function stop():Boolean;
        function set volume(_arg_1:Number):void;
        function set position(_arg_1:Number):void;
        function get volume():Number;
        function get position():Number;
        function get length():Number;
        function get ready():Boolean;
        function get finished():Boolean;
        function get fadeOutSeconds():Number;
        function set fadeOutSeconds(_arg_1:Number):void;
        function get fadeInSeconds():Number;
        function set fadeInSeconds(_arg_1:Number):void;

    }
}//package com.sulake.habbo.sound

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// finished = "_-28w" (String#6223, DoABC#2)
// fadeOutSeconds = "_-0GD" (String#3874, DoABC#2)
// fadeInSeconds = "_-2FB" (String#6346, DoABC#2)


