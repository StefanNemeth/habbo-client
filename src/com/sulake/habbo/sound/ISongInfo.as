
package com.sulake.habbo.sound
{
    public interface ISongInfo 
    {

        function get loaded():Boolean;
        function get id():int;
        function get diskId():int;
        function get length():int;
        function get name():String;
        function get creator():String;
        function get songData():String;
        function get soundObject():IHabboSound;

    }
}//package com.sulake.habbo.sound

// IHabboSound = "_-tK" (String#8755, DoABC#2)
// ISongInfo = "_-2vd" (String#7190, DoABC#2)
// diskId = "_-0re" (String#4678, DoABC#2)
// creator = "_-1U2" (String#5433, DoABC#2)
// soundObject = "_-HA" (String#8022, DoABC#2)
// loaded = "_-31-" (String#7327, DoABC#2)


