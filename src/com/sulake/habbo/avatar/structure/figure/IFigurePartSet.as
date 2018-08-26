
package com.sulake.habbo.avatar.structure.figure
{
    public interface IFigurePartSet 
    {

        function getPart(_arg_1:String, _arg_2:int):IFigurePart;
        function get type():String;
        function get id():int;
        function get gender():String;
        function get clubLevel():int;
        function get isColorable():Boolean;
        function get isSelectable():Boolean;
        function get parts():Array;
        function get hiddenLayers():Array;

    }
}//package com.sulake.habbo.avatar.structure.figure

// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// getPart = "_-1hb" (String#5700, DoABC#2)
// isColorable = "_-0df" (String#4384, DoABC#2)
// hiddenLayers = "_-3IA" (String#7671, DoABC#2)


