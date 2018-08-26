
package com.sulake.habbo.avatar.common
{
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.core.window.IWindowContainer;

    public interface ISideContentModel 
    {

        function dispose():void;
        function reset():void;
        function get controller():HabboAvatarEditor;
        function TradingModel():IWindowContainer;

    }
}//package com.sulake.habbo.avatar.common

// ISideContentModel = "_-29F" (String#6234, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)


