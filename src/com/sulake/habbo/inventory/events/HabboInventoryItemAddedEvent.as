
package com.sulake.habbo.inventory.events
{
    import flash.events.Event;

    public class HabboInventoryItemAddedEvent extends Event 
    {

        public static const HABBO_INVENTORY_ITEM_ADDED:String = "HABBO_INVENTORY_ITEM_ADDED";

        private var _classId:int;
        private var _stripId:int;
        private var _category:int;

        public function HabboInventoryItemAddedEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(HABBO_INVENTORY_ITEM_ADDED, _arg_4, _arg_5);
            this._classId = _arg_1;
            this._stripId = _arg_2;
            this._category = _arg_3;
        }
        public function get classId():int
        {
            return (this._classId);
        }
        public function get stripId():int
        {
            return (this._stripId);
        }
        public function get category():int
        {
            return (this._category);
        }

    }
}//package com.sulake.habbo.inventory.events

// HabboInventoryItemAddedEvent = "_-1m1" (String#18379, DoABC#2)
// _classId = "_-172" (String#597, DoABC#2)
// classId = "_-1mV" (String#18401, DoABC#2)
// stripId = "_-28E" (String#19340, DoABC#2)
// _stripId = "_-dH" (String#2144, DoABC#2)


