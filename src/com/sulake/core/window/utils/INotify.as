
package com.sulake.core.window.utils
{
    import com.sulake.core.runtime.IDisposable;

    public interface INotify extends IDisposable 
    {

        function set title(_arg_1:String):void;
        function get title():String;
        function set summary(_arg_1:String):void;
        function get summary():String;
        function set callback(_arg_1:Function):void;
        function get callback():Function;

    }
}//package com.sulake.core.window.utils

// INotify = "_-3FZ" (String#7620, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// summary = "_-Vo" (String#2121, DoABC#2)


