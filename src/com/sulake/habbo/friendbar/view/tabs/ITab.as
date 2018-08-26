
package com.sulake.habbo.friendbar.view.tabs
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;

    public interface ITab extends IDisposable 
    {

        function get window():IWindowContainer;
        function get selected():Boolean;
        function get recycled():Boolean;
        function select(_arg_1:Boolean):void;
        function ITab(_arg_1:Boolean):void;
        function recycle():void;

    }
}//package com.sulake.habbo.friendbar.view.tabs

// recycled = "_-0Zq" (String#4294, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// ITab = "_-05I" (String#3671, DoABC#2)


