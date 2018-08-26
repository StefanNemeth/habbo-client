
package com.sulake.habbo.ui.widget.events
{
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWULUE_USER_LOCATION_UPDATE:String = "RWULUE_USER_LOCATION_UPDATE";

        private var _userId:int;
        private var _rectangle:Rectangle;
        private var _screenLocation:Point;

        public function RoomWidgetUserLocationUpdateEvent(_arg_1:int, _arg_2:Rectangle, _arg_3:Point, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(RWULUE_USER_LOCATION_UPDATE, _arg_4, _arg_5);
            this._userId = _arg_1;
            this._rectangle = _arg_2;
            this._screenLocation = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get rectangle():Rectangle
        {
            return (this._rectangle);
        }
        public function get screenLocation():Point
        {
            return (this._screenLocation);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RWULUE_USER_LOCATION_UPDATE = "_-3GW" (String#22143, DoABC#2)
// _screenLocation = "_-0FT" (String#14664, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetUserLocationUpdateEvent = "_-2ox" (String#7058, DoABC#2)
// _rectangle = "_-1d7" (String#857, DoABC#2)
// screenLocation = "_-bK" (String#23684, DoABC#2)


