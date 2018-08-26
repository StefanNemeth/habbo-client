
package com.sulake.habbo.avatar
{
    public interface IAvatarFigureContainer 
    {

        function getPartTypeIds():Array;
        function hasPartType(_arg_1:String):Boolean;
        function getPartSetId(_arg_1:String):int;
        function getPartColorIds(_arg_1:String):Array;
        function updatePart(_arg_1:String, _arg_2:int, _arg_3:Array):void;
        function removePart(_arg_1:String):void;
        function getFigureString():String;

    }
}//package com.sulake.habbo.avatar

// getPartTypeIds = "_-2ig" (String#6925, DoABC#2)
// hasPartType = "_-064" (String#3687, DoABC#2)
// getPartColorIds = "_-AZ" (String#7879, DoABC#2)
// removePart = "_-123" (String#4917, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// updatePart = "_-1C9" (String#5112, DoABC#2)


