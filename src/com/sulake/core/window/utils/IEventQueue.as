
package com.sulake.core.window.utils
{
    import flash.events.Event;

    public interface IEventQueue 
    {

        function get length():uint;
        function begin():void;
        function next():Event;
        function remove():void;
        function end():void;
        function flush():void;

    }
}//package com.sulake.core.window.utils

// IEventQueue = "_-cw" (String#8470, DoABC#2)


