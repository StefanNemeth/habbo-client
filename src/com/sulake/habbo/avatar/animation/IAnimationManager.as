
package com.sulake.habbo.avatar.animation
{
    import flash.utils.Dictionary;

    public interface IAnimationManager 
    {

        function get animations():Dictionary;
        function getAnimation(_arg_1:String):IAnimation;
        function getLayerData(_arg_1:String, _arg_2:int, _arg_3:String):IAnimationLayerData;

    }
}//package com.sulake.habbo.avatar.animation

// IAnimationManager = "_-271" (String#6183, DoABC#2)
// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// IAnimation = "_-2l8" (String#6983, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)


