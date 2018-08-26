
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWSDUE_STICKIE_DATA:String = "RWSDUE_STICKIE_DATA";

        private var _objectId:int = -1;
        private var _objectType:String;
        private var _text:String;
        private var _colorHex:String;
        private var _controller:Boolean;

        public function RoomWidgetStickieDataUpdateEvent(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:Boolean=false, _arg_8:Boolean=false)
        {
            super(_arg_1, _arg_7, _arg_8);
            this._objectId = _arg_2;
            this._objectType = _arg_3;
            this._text = _arg_4;
            this._colorHex = _arg_5;
            this._controller = _arg_6;
        }
        public function get objectId():int
        {
            return (this._objectId);
        }
        public function get objectType():String
        {
            return (this._objectType);
        }
        public function get text():String
        {
            return (this._text);
        }
        public function get colorHex():String
        {
            return (this._colorHex);
        }
        public function get controller():Boolean
        {
            return (this._controller);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetStickieDataUpdateEvent = "_-1X9" (String#5500, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// _colorHex = "_-0io" (String#821, DoABC#2)
// colorHex = "_-3I3" (String#22203, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// _objectType = "_-eP" (String#939, DoABC#2)
// RWSDUE_STICKIE_DATA = "_-0tT" (String#16178, DoABC#2)
// objectType = "_-23O" (String#19148, DoABC#2)


