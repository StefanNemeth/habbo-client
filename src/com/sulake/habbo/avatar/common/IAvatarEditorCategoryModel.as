
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;

    public interface IAvatarEditorCategoryModel 
    {

        function dispose():void;
        function reset():void;
        function get controller():HabboAvatarEditor;
        function TradingModel():IWindowContainer;
        function switchCategory(_arg_1:String):void;
        function getCategoryData(_arg_1:String):CategoryData;
        function _SafeStr_4847(_arg_1:String, _arg_2:int):void;
        function selectColor(_arg_1:String, _arg_2:int, _arg_3:int):void;
        function hasClubItemsOverLevel(_arg_1:int):Boolean;
        function stripClubItemsOverLevel(_arg_1:int):Boolean;

    }
}//package com.sulake.habbo.avatar.common

// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// getCategoryData = "_-2rW" (String#7114, DoABC#2)
// _SafeStr_4847 = "continue" (String#9328, DoABC#2)
// selectColor = "_-2lm" (String#6999, DoABC#2)
// hasClubItemsOverLevel = "_-0bi" (String#4340, DoABC#2)
// stripClubItemsOverLevel = "_-0C1" (String#3793, DoABC#2)


