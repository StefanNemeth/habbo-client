
package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetChooserContentEvent extends RoomWidgetUpdateEvent 
    {

        public static const RWCCE_USER_CHOOSER_CONTENT:String = "RWCCE_USER_CHOOSER_CONTENT";
        public static const RWCCE_FURNI_CHOOSER_CONTENT:String = "RWCCE_FURNI_CHOOSER_CONTENT";

        private var _items:Array;
        private var _isAnyRoomController:Boolean;

        public function RoomWidgetChooserContentEvent(_arg_1:String, _arg_2:Array, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this._items = _arg_2.slice();
            this._isAnyRoomController = _arg_3;
        }
        public function get items():Array
        {
            return (this._items);
        }
        public function get isAnyRoomController():Boolean
        {
            return (this._isAnyRoomController);
        }

    }
}//package com.sulake.habbo.ui.widget.events

// _isAnyRoomController = "_-wS" (String#8810, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// RoomWidgetChooserContentEvent = "_-12l" (String#16570, DoABC#2)
// RWCCE_FURNI_CHOOSER_CONTENT = "_-2tc" (String#21225, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// RWCCE_USER_CHOOSER_CONTENT = "_-2YV" (String#20377, DoABC#2)


