
package com.sulake.habbo.avatar.actions
{
    public interface IActionDefinition 
    {

        function get id():String;
        function get state():String;
        function get precedence():int;
        function get activePartSet():String;
        function get isMain():Boolean;
        function get isDefault():Boolean;
        function get assetPartDefinition():String;
        function get lay():String;
        function get geometryType():String;
        function get isAnimation():Boolean;
        function isAnimated(_arg_1:String):Boolean;
        function getPrevents(_arg_1:String=""):Array;
        function getPreventHeadTurn(_arg_1:String=""):Boolean;
        function setOffsets(_arg_1:String, _arg_2:int, _arg_3:Array):void;
        function getOffsets(_arg_1:String, _arg_2:int):Array;

    }
}//package com.sulake.habbo.avatar.actions

// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// isMain = "_-00N" (String#3570, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// assetPartDefinition = "_-1ID" (String#5210, DoABC#2)
// isAnimated = "_-0q7" (String#4640, DoABC#2)
// setOffsets = "_-30r" (String#7323, DoABC#2)
// getOffsets = "_-336" (String#7368, DoABC#2)
// isDefault = "_-Dn" (String#7947, DoABC#2)
// getPrevents = "_-0Rn" (String#4130, DoABC#2)
// getPreventHeadTurn = "_-S-" (String#8246, DoABC#2)


