
package com.sulake.habbo.avatar.structure.figure
{
    import flash.geom.ColorTransform;

    public interface IPartColor 
    {

        function get colorTransform():ColorTransform;
        function get redMultiplier():Number;
        function get greenMultiplier():Number;
        function get blueMultiplier():Number;
        function get rgb():uint;
        function get r():uint;
        function get g():uint;
        function get b():uint;
        function get id():int;
        function get index():int;
        function get clubLevel():int;
        function get isSelectable():Boolean;

    }
}//package com.sulake.habbo.avatar.structure.figure

// IPartColor = "_-1dO" (String#5620, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)


