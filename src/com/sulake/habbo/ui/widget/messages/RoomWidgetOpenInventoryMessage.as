
package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage 
    {

        public static const RWGOI_MESSAGE_OPEN_INVENTORY:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
        public static const _SafeStr_3550:String = "inventory_effects";
        public static const _SafeStr_3551:String = "inventory_badges";
        public static const _SafeStr_3552:String = "inventory_clothes";
        public static const _SafeStr_3553:String = "inventory_furniture";

        private var _inventoryType:String;

        public function RoomWidgetOpenInventoryMessage(_arg_1:String)
        {
            super(RWGOI_MESSAGE_OPEN_INVENTORY);
            this._inventoryType = _arg_1;
        }
        public function get inventoryType():String
        {
            return (this._inventoryType);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetOpenInventoryMessage = "_-1bT" (String#5586, DoABC#2)
// RWGOI_MESSAGE_OPEN_INVENTORY = "_-2J7" (String#19772, DoABC#2)
// _SafeStr_3550 = "_-13C" (String#16588, DoABC#2)
// _SafeStr_3551 = "_-2cL" (String#20537, DoABC#2)
// _SafeStr_3552 = "_-sk" (String#24390, DoABC#2)
// _SafeStr_3553 = "_-Hu" (String#22925, DoABC#2)
// _inventoryType = "_-Y1" (String#23562, DoABC#2)
// inventoryType = "_-0tH" (String#16170, DoABC#2)


