
package com.sulake.habbo.sound
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IHabboSoundManager extends IUnknown 
    {

        function set volume(_arg_1:Number):void;
        function set previewVolume(_arg_1:Number):void;
        function get volume():Number;
        function get musicController():IHabboMusicController;
        function playSound(_arg_1:String):void;
        function HabboSoundManagerFlash10(_arg_1:int, _arg_2:String):IHabboSound;
        function get events():IEventDispatcher;

    }
}//package com.sulake.habbo.sound

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// volume = "_-0SB" (String#1473, DoABC#2)
// IHabboSoundManager = "_-0vD" (String#4750, DoABC#2)
// musicController = "_-1Qk" (String#5366, DoABC#2)
// previewVolume = "_-1fh" (String#5660, DoABC#2)
// HabboSoundManagerFlash10 = "_-1OI" (String#5318, DoABC#2)


