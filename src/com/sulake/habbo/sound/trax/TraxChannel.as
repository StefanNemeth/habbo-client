
package com.sulake.habbo.sound.trax
{
    public class TraxChannel 
    {

        private var _id:int;
        private var _items:Array;

        public function TraxChannel(_arg_1:int)
        {
            this._id = _arg_1;
            this._items = [];
        }
        public function get itemCount():int
        {
            return (this._items.length);
        }
        public function addChannelItem(_arg_1:TraxChannelItem):void
        {
            this._items.push(_arg_1);
        }
        public function getItem(_arg_1:int):TraxChannelItem
        {
            return ((this._items[_arg_1] as TraxChannelItem));
        }

    }
}//package com.sulake.habbo.sound.trax

// TraxChannelItem = "_-0kh" (String#4515, DoABC#2)
// TraxChannel = "_-2yL" (String#7246, DoABC#2)
// getItem = "_-0un" (String#16229, DoABC#2)
// addChannelItem = "_-0xc" (String#16337, DoABC#2)
// itemCount = "_-1fH" (String#18108, DoABC#2)


