
package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.IDisposable;

    public interface IPlayListController extends IDisposable 
    {

        function get priority():int;
        function get length():int;
        function get playPosition():int;
        function get nowPlayingSongId():int;
        function get isPlaying():Boolean;
        function getEntry(_arg_1:int):ISongInfo;
        function requestPlayList():void;

    }
}//package com.sulake.habbo.sound

// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getEntry = "_-ig" (String#2166, DoABC#2)
// requestPlayList = "_-0Vy" (String#817, DoABC#2)
// isPlaying = "_-2gK" (String#6876, DoABC#2)
// playPosition = "_-3Ip" (String#7686, DoABC#2)
// nowPlayingSongId = "_-2A0" (String#6248, DoABC#2)


