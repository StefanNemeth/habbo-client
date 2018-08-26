
package com.sulake.habbo.avatar.structure.figure
{
    import com.sulake.core.utils.Map;

    public interface ISetType 
    {

        function getPartSet(_arg_1:int):IFigurePartSet;
        function isMandatory(_arg_1:String, _arg_2:int):Boolean;
        function get type():String;
        function get paletteID():int;
        function get partSets():Map;

    }
}//package com.sulake.habbo.avatar.structure.figure

// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// isMandatory = "_-0Zr" (String#4295, DoABC#2)
// paletteID = "_-0BG" (String#3784, DoABC#2)
// partSets = "_-0L3" (String#3979, DoABC#2)


