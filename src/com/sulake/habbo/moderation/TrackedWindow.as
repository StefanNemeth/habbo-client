
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;

    public interface TrackedWindow extends IDisposable 
    {

        function getType():int;
        function getId():String;
        function getFrame():IFrameWindow;
        function show():void;

    }
}//package com.sulake.habbo.moderation

// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)


