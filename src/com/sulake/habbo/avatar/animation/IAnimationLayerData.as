
package com.sulake.habbo.avatar.animation
{
    import com.sulake.habbo.avatar.actions.IActiveActionData;

    public interface IAnimationLayerData 
    {

        function get id():String;
        function get action():IActiveActionData;
        function get animationFrame():int;
        function get dx():int;
        function get dy():int;
        function get dz():int;
        function get directionOffset():int;

    }
}//package com.sulake.habbo.avatar.animation

// IAnimationLayerData = "_-14E" (String#4961, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// animationFrame = "_-gS" (String#8520, DoABC#2)
// directionOffset = "_-25H" (String#6148, DoABC#2)


