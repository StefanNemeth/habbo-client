
package com.sulake.habbo.room.events
{
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.Event;

    public class RoomObjectRoomAdEvent extends RoomObjectEvent 
    {

        public static const RORAE_ROOM_AD_LOAD_IMAGE:String = "RORAE_ROOM_AD_LOAD_IMAGE";
        public static const RORAE_ROOM_AD_FURNI_CLICK:String = "RORAE_ROOM_AD_FURNI_CLICK";
        public static const RORAE_ROOM_AD_FURNI_DOUBLE_CLICK:String = "RORAE_ROOM_AD_FURNI_DOUBLE_CLICK";
        public static const RORAE_ROOM_AD_TOOLTIP_SHOW:String = "RORAE_ROOM_AD_TOOLTIP_SHOW";
        public static const RORAE_ROOM_AD_TOOLTIP_HIDE:String = "RORAE_ROOM_AD_TOOLTIP_HIDE";

        private var _imageUrl:String = "";
        private var _clickUrl:String = "";

        public function RoomObjectRoomAdEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String="", _arg_5:String="", _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_6, _arg_7);
            this._imageUrl = _arg_4;
            this._clickUrl = _arg_5;
        }
        public function get clickUrl():String
        {
            return (this._clickUrl);
        }
        public function get imageUrl():String
        {
            return (this._imageUrl);
        }
        override public function clone():Event
        {
            return (new RoomObjectRoomAdEvent(type, objectId, objectType, this.imageUrl, this.clickUrl, bubbles, cancelable));
        }

    }
}//package com.sulake.habbo.room.events

// _clickUrl = "_-2-C" (String#303, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)
// RORAE_ROOM_AD_FURNI_CLICK = "_-0v3" (String#16239, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_SHOW = "_-1bW" (String#17956, DoABC#2)
// RORAE_ROOM_AD_TOOLTIP_HIDE = "_-37a" (String#21790, DoABC#2)
// RORAE_ROOM_AD_LOAD_IMAGE = "_-0MN" (String#14928, DoABC#2)
// RORAE_ROOM_AD_FURNI_DOUBLE_CLICK = "_-2bv" (String#20520, DoABC#2)
// RoomObjectRoomAdEvent = "_-mk" (String#24139, DoABC#2)


