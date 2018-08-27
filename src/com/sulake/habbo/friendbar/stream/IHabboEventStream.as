
package com.sulake.habbo.friendbar.stream
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboEventStream extends IUnknown 
    {

        function set visible(_arg_1:Boolean):void;
        function get visible():Boolean;
        function refreshEventStream():void;
        function likeStreamEvent(_arg_1:EventStreamEntity):void;

    }
}//package com.sulake.habbo.friendbar.stream

// refreshEventStream = "_-1Zw" (String#1711, DoABC#2)
// likeStreamEvent = "_-1tw" (String#5918, DoABC#2)
// IHabboEventStream = "_-2Uk" (String#6661, DoABC#2)


