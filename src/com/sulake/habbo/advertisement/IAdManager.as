
package com.sulake.habbo.advertisement
{
    import com.sulake.core.runtime.IUnknown;
    import flash.events.IEventDispatcher;

    public interface IAdManager extends IUnknown 
    {

        function get events():IEventDispatcher;
        function showInterstitial():Boolean;
        function RoomEngine(_arg_1:int, _arg_2:int):void;
        function loadRoomAdImage(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:String, _arg_6:String):void;

    }
}//package com.sulake.habbo.advertisement

// IAdManager = "_-S5" (String#8249, DoABC#2)
// showInterstitial = "_-1Rf" (String#5389, DoABC#2)
// RoomEngine = "_-1ii" (String#1747, DoABC#2)
// loadRoomAdImage = "_-vu" (String#8803, DoABC#2)


