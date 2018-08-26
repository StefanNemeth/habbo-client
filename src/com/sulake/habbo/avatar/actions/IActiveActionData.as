
package com.sulake.habbo.avatar.actions
{
    public interface IActiveActionData 
    {

        function get id():String;
        function get actionType():String;
        function get actionParameter():String;
        function set actionParameter(_arg_1:String):void;
        function get startFrame():int;
        function get definition():IActionDefinition;
        function set definition(_arg_1:IActionDefinition):void;
        function get overridingAction():String;
        function set overridingAction(_arg_1:String):void;

    }
}//package com.sulake.habbo.avatar.actions

// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// startFrame = "_-1Rg" (String#5390, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)


