
package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboHelp extends IUnknown 
    {

        function get events():IEventDispatcher;
        function reportUser(_arg_1:int, _arg_2:String):void;
        function hasChangedName():Boolean;
        function startNameChange():void;
        function showWelcomeScreen(_arg_1:WelcomeNotification):void;

    }
}//package com.sulake.habbo.help

// showWelcomeScreen = "_-QV" (String#8213, DoABC#2)
// WelcomeNotification = "_-ka" (String#8616, DoABC#2)
// hasChangedName = "_-33G" (String#7371, DoABC#2)
// startNameChange = "_-1qU" (String#5864, DoABC#2)
// reportUser = "_-233" (String#6107, DoABC#2)
// IHabboHelp = "_-2o3" (String#7041, DoABC#2)


