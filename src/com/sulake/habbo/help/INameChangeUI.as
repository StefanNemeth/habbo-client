
package com.sulake.habbo.help
{
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;

    public interface INameChangeUI 
    {

        function get localization():IHabboLocalizationManager;
        function get assets():IAssetLibrary;
        function get myName():String;
        function buildXmlWindow(_arg_1:String, _arg_2:uint=1):IWindow;
        function checkName(_arg_1:String):void;
        function changeName(_arg_1:String):void;
        function showView(_arg_1:String):void;

    }
}//package com.sulake.habbo.help

// changeName = "_-0uN" (String#4733, DoABC#2)
// checkName = "_-2Fe" (String#6356, DoABC#2)
// myName = "_-0Kp" (String#3971, DoABC#2)
// INameChangeUI = "_-34B" (String#7392, DoABC#2)
// showView = "_-1gE" (String#860, DoABC#2)


