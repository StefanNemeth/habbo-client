
package com.sulake.habbo.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public interface IAlertDialog extends IDisposable 
    {

        function set title(_arg_1:String):void;
        function get title():String;
        function set summary(_arg_1:String):void;
        function get summary():String;
        function set callback(_arg_1:Function):void;
        function get callback():Function;
        function getButtonCaption(_arg_1:int):ICaption;
        function setButtonCaption(_arg_1:int, _arg_2:ICaption):void;

    }
}//package com.sulake.habbo.window.utils

// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// getButtonCaption = "_-3Dj" (String#7591, DoABC#2)
// setButtonCaption = "_-2YJ" (String#6733, DoABC#2)
// ICaption = "_-1ZX" (String#5555, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)


