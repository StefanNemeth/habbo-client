
package com.sulake.habbo.sound
{
    import flash.events.IEventDispatcher;

    public interface IHabboMusicController 
    {

        function getRoomItemPlaylist(_arg_1:int=-1):IPlayListController;
        function getSongDiskInventorySize():int;
        function getSongDiskInventoryDiskId(_arg_1:int):int;
        function getSongDiskInventorySongId(_arg_1:int):int;
        function getSongInfo(_arg_1:int):ISongInfo;
        function getSongIdPlayingAtPriority(_arg_1:int):int;
        function playSong(_arg_1:int, _arg_2:int, _arg_3:Number=0, _arg_4:Number=0, _arg_5:Number=0.5, _arg_6:Number=0.5):Boolean;
        function stop(_arg_1:int):void;
        function addSongInfoRequest(_arg_1:int):void;
        function requestSongInfoWithoutSamples(_arg_1:int):void;
        function requestUserSongDisks():void;
        function onSongLoaded(_arg_1:int):void;
        function updateVolume(_arg_1:Number):void;
        function samplesUnloaded(_arg_1:Array):void;
        function get samplesIdsInUse():Array;
        function get events():IEventDispatcher;
        function dispose():void;

    }
}//package com.sulake.habbo.sound

// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// getRoomItemPlaylist = "_-2Su" (String#6624, DoABC#2)
// getSongIdPlayingAtPriority = "_-u5" (String#8768, DoABC#2)
// getSongInfo = "_-0Fc" (String#3864, DoABC#2)
// playSong = "_-0VK" (String#4210, DoABC#2)
// requestUserSongDisks = "_-1qp" (String#5871, DoABC#2)
// getSongDiskInventorySize = "_-3Lf" (String#7732, DoABC#2)
// getSongDiskInventoryDiskId = "_-1eT" (String#5637, DoABC#2)
// getSongDiskInventorySongId = "_-23l" (String#6118, DoABC#2)
// addSongInfoRequest = "_-1QR" (String#5359, DoABC#2)
// updateVolume = "_-31S" (String#7334, DoABC#2)
// onSongLoaded = "_-1iX" (String#5723, DoABC#2)
// requestSongInfoWithoutSamples = "_-3CP" (String#7560, DoABC#2)
// samplesUnloaded = "_-1dU" (String#5623, DoABC#2)
// samplesIdsInUse = "_-0Sc" (String#4152, DoABC#2)


