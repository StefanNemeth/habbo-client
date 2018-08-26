
package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWRVUE_ROOM_VIEW_SIZE_CHANGED:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
        public static const RWRVUE_ROOM_VIEW_SCALE_CHANGED:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
        public static const RWRVUE_ROOM_VIEW_POSITION_CHANGED:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";

        private var _SafeStr_13886:Rectangle;
        private var _SafeStr_13887:Point;
        private var _scale:Number = 0;

        public function RoomWidgetRoomViewUpdateEvent(_arg_1:String, _arg_2:Rectangle=null, _arg_3:Point=null, _arg_4:Number=0, _arg_5:Boolean=false, _arg_6:Boolean=false)
        {
            super(_arg_1, _arg_5, _arg_6);
            this._SafeStr_13886 = _arg_2;
            this._SafeStr_13887 = _arg_3;
            this._scale = _arg_4;
        }
        public function get rect():Rectangle
        {
            if (this._SafeStr_13886 != null){
                return (this._SafeStr_13886.clone());
            };
            return (null);
        }
        public function get positionDelta():Point
        {
            if (this._SafeStr_13887 != null){
                return (this._SafeStr_13887.clone());
            };
            return (null);
        }
        public function get scale():Number
        {
            return (this._scale);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RWRVUE_ROOM_VIEW_SIZE_CHANGED = "_-0x5" (String#16316, DoABC#2)
// _SafeStr_13886 = "_-0Mp" (String#14945, DoABC#2)
// _SafeStr_13887 = "_-2dE" (String#20573, DoABC#2)
// positionDelta = "_-zM" (String#24667, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetRoomViewUpdateEvent = "_-xx" (String#24612, DoABC#2)
// RWRVUE_ROOM_VIEW_POSITION_CHANGED = "_-3Jp" (String#22277, DoABC#2)
// RWRVUE_ROOM_VIEW_SCALE_CHANGED = "_-2ZI" (String#20410, DoABC#2)


