
package com.sulake.habbo.avatar.common
{
    import com.sulake.core.window.IWindowContainer;

    public interface IAvatarEditorCategoryView 
    {

        function dispose():void;
        function init():void;
        function reset():void;
        function getWindowContainer():IWindowContainer;
        function switchCategory(_arg_1:String):void;
        function showPalettes(_arg_1:String, _arg_2:int):void;

    }
}//package com.sulake.habbo.avatar.common

// IAvatarEditorCategoryView = "_-0Au" (String#3774, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// showPalettes = "_-3AL" (String#7520, DoABC#2)


