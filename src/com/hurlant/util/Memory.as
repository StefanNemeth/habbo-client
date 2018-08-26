
package com.hurlant.util
{
    import flash.net.LocalConnection;
    import flash.system.System;

    public class Memory 
    {

        public static function gc():void
        {
            try {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            }
            catch(e) {
            };
        }
        public static function get used():uint
        {
            return (System.totalMemory);
        }

    }
}//package com.hurlant.util

// Memory = "_-2zI" (String#7273, DoABC#2)
// gc = "_-1mw" (String#5797, DoABC#2)
// used = "_-0tx" (String#16200, DoABC#2)


